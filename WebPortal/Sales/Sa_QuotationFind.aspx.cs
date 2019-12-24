using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Leyp.SQLServerDAL;
using Leyp.Components;
using Leyp.Components.Module;
namespace WebPortal.Sales
{
    public partial class Sa_QuotationFind : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = Base.lang_id;
        private string user_id = "";//DBUtility.user_id;
        private string within_code = Base.within_code;
        private bool start_search = false;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {

                InitValues();

            }
            else
            {
                start_search = true;
            }
            if (start_search == true)
            {
                BindData();
            }
        }
        private void InitValues()
        {
            string strSql = "Select typ_code AS id,typ_desc From bs_type Where typ_group='3'";
            DataTable tbCp = sh.ExecuteSqlReturnDataTable(strSql);
            dlSales_group.DataSource = tbCp.DefaultView;
            dlSales_group.DataTextField = "typ_desc";
            dlSales_group.DataValueField = "id";
            dlSales_group.DataBind();
            dlSales_group.SelectedIndex = 0;

            //txtDate1.Text = "____/__/__";
            //txtDate2.Text = "____/__/__";
        }
        protected void btnFind_Click(object sender, EventArgs e)
        {
            BindData();
        }
        protected void BindData()
        {
            user_id = getUserName();
            string strDat1 = dateStart.Value;
            string strDat2 = dateEnd.Value;
            if (!StrHlp.CheckDateFormat(strDat1))
            {
                strDat1 = "";
            }
            if (!StrHlp.CheckDateFormat(strDat2))
            {
                strDat2 = "";
            }
            string sales_group = dlSales_group.SelectedValue.ToString();
            string brand = txtBrand.Text;
            string mat = txtMaterial.Text;
            string cust_code=txtCust_code.Text;
            string cust_color=txtCust_color.Text;
            string cf_code=txtCf_code.Text;
            string cf_color=txtCf_color.Text;
            string season=txtSeason.Text;
            string temp_code=txtTemp_code.Text;
            string size=txtSize.Text;
            string sub_mo_id = txtSubMo.Text;
            string product_desc = txtGood_desc.Text;
            string plm_code = "";
            string reason_edit = "";
            string remark = "";
            string other_remark = "";
            string remark_for_pdd = "";
            SqlParameter[] paras = new SqlParameter[] { 
                       new SqlParameter("@user_id",user_id),
                       new SqlParameter("@sales_group",sales_group),
                       new SqlParameter("@brand",brand),
                       new SqlParameter("@material",mat),
                       new SqlParameter("@cust_code",cust_code),
                       new SqlParameter("@cust_color",cust_color),
                       new SqlParameter("@cf_code",cf_code),
                       new SqlParameter("@cf_color",cf_color),
                       new SqlParameter("@season",season),
                       new SqlParameter("@temp_code",temp_code),
                       new SqlParameter("@size",size),
                       new SqlParameter("@dat1",strDat1), 
                       new SqlParameter("@dat2",strDat2),
                       new SqlParameter("@mo_id",txtMo_id.Text),
                       new SqlParameter("@sub_mo_id",sub_mo_id),
                       new SqlParameter("@plm_code",plm_code),
                       new SqlParameter("@product_desc",product_desc),
                       new SqlParameter("@reason_edit",reason_edit),
                       new SqlParameter("@remark",remark),
                       new SqlParameter("@other_remark",other_remark),
                       new SqlParameter("@remark_for_pdd",remark_for_pdd),
                       new SqlParameter("@crtim_s",""),
                       new SqlParameter("@crtim_e","")
                    };

            DataTable dtQuotation = sh.ExecuteProcedure("usp_qoutation_find", paras);
            if (dtQuotation.Rows.Count == 0)
                dtQuotation.Rows.Add();

            gvDetails.DataSource = dtQuotation.DefaultView;
            gvDetails.DataBind();

        }

        protected void gvDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDetails.PageIndex = e.NewPageIndex;
            gvDetails.DataBind();
        }

        protected void btnExpExcelNew_Click(object sender, EventArgs e)
        {
            string content = getExcelContent(gvDetails);
            string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
            string filename = "Quotation.xls";
            filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
            //clsPublic.daoruExce dre = new clsPublic.daoruExce();
            ExportToExcel(filename, content, css);

        }


        protected void gvDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //加以下這段為選擇行
            PostBackOptions myPostBackOptions = new PostBackOptions(this);
            myPostBackOptions.AutoPostBack = false;
            myPostBackOptions.RequiresJavaScriptProtocol = true;
            myPostBackOptions.PerformValidation = false;
            String evt = Page.ClientScript.GetPostBackClientHyperlink(sender as GridView, "Select$" + e.Row.RowIndex.ToString());
            e.Row.Attributes.Add("onclick", evt);

            e.Row.Attributes.Add("onMouseOver", "Color=this.style.backgroundColor;this.style.backgroundColor='lightBlue'");
            e.Row.Attributes.Add("onMouseOut", "this.style.backgroundColor=Color;");
        }
        protected void gvDetails_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        protected string getExcelContent(GridView gvDetails)
        {
            StringBuilder sb = new StringBuilder();
            string ex_str = "";

            sb.Append("<table borderColor='black' border='1' >");
            sb.Append("<tr>");
            for (int i = 0; i < gvDetails.Columns.Count; i++)
            {
                ex_str += "<th bgColor='#ccfefe'>" + gvDetails.Columns[i].HeaderText + "</th>";
            }

            sb.Append(ex_str);
            sb.Append("</tr></thead>");
            sb.Append("<tbody>");

            for (int i = 0; i < gvDetails.Rows.Count; i++)
            {
                GridViewRow row = gvDetails.Rows[i];
                sb.Append("<tr class='firstTR'>");

                for (int j = 0; j < gvDetails.Columns.Count; j++)
                {
                    if (j == 0 || j == 3)
                        sb.Append("<td>" + "=\"" + row.Cells[j].Text.ToString() + "\"" + "</td>");
                    else
                        sb.Append("<td>" + row.Cells[j].Text.ToString() + "</td>");
                }

                sb.Append("</tr>");
            }
            sb.Append("</tbody></table>");
            return sb.ToString();
        }

        //匯出到Excel
        protected void ExportToExcel(string filename, string content, string cssText)
        {
            var res = HttpContext.Current.Response;
            content = String.Format("<style type='text/css'>{0}</style>{1}", cssText, content);

            res.Clear();
            res.Buffer = true;
            res.Charset = "UTF-8";
            res.AddHeader("Content-Disposition", "attachment; filename=" + filename);
            //res.ContentEncoding = System.Text.Encoding.UTF8;// System.Text.Encoding.GetEncoding("GB2312");//簡體
            res.ContentEncoding = System.Text.Encoding.UTF8;// System.Text.Encoding//繁體
            res.ContentType = "application/ms-excel";//;charset=GB2312
            res.Write(content);
            res.Flush();
            res.End();
        }

    }
}