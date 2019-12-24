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
    public partial class Sa_MoMoveStatus_Spec : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private clsPublic clsPublic = new clsPublic();
        private string lang_id = Base.lang_id;
        //private string user_id = DBUtility.user_id;
        private string within_code = DBUtility.within_code;
        private bool start_search = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["user"] == null)
            //{
            //    Response.Redirect("logout.aspx");
            //}
            //else
            //    user_id = Session["user"].ToString();
            if (!Page.IsPostBack)
            {

                InitControler();

            }
            else
                start_search = true;
            if (start_search == true)
            {
                BindData();
            }
        }

        protected void InitControler()
        {

            txtDate1.Text = System.DateTime.Now.AddDays(-6).ToString("yyyy/MM/dd");
            txtDate2.Text = System.DateTime.Now.ToString("yyyy/MM/dd");

            txtDep.Text = "510";

        }
        protected void txtDate1_TextChanged(object sender, EventArgs e)
        {
            txtDate2.Text = txtDate1.Text;
        }

        protected void btnExpExcelNew_Click(object sender, EventArgs e)
        {
            string content = getExcelContent();
            string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
            string filename = "交易記錄.xls";
            filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
            clsPublic.ExportToExcel(filename, content, css);

        }

        protected void btnFind_Click(object sender, EventArgs e)
        {

            BindData();
        }

        protected void BindData()
        {

            if (!validData())
                return;
            string dat1, dat2;

            dat1 = txtDate1.Text;
            dat2 = txtDate2.Text;
            string dep = txtDep.Text;

            if (dat2 != "")
                dat2 = Convert.ToDateTime(dat2).AddDays(1).ToString("yyyy/MM/dd");

            if (txtDate2.Text == "" && txtDep.Text == "")
            {
                dep = "ZZZZZZZZZ";
            }


            string strSql = "mo_MoveStatus_Spec";
            SqlParameter[] parameters = {new SqlParameter("@dep", dep)
                                        ,new SqlParameter("@dat1", dat1), new SqlParameter("@dat2", dat2)
                                        };


            DataTable dtStTr = sh.ExecuteProcedure(strSql, parameters);

            gvDetails.DataSource = dtStTr.DefaultView;
            gvDetails.DataBind();
            if (dtStTr.Rows.Count > 0)
                lblShowInfo.Text = "  記錄數：" + dtStTr.Rows.Count.ToString();
            else
                lblShowInfo.Text = "查看外發記錄之移交狀態。";
        }

        protected void btnSetBatchMo_Click(object sender, EventArgs e)
        {
            Response.Redirect("mo_MoveStatus_Set.aspx");
        }

        protected bool validData()
        {
            bool result = true;
            if (txtDate1.Text.Trim() != "" && StrHlp.CheckDateFormat(txtDate1.Text.Trim()) == false)
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('統計日期格式不正確!');", true);
                //cls.clsPublic.WebMessageBox(this.Page, "訂單日期格式錯誤!");
                txtDate1.Focus();
                result = false;
            }
            else
            {
                if (txtDate2.Text.Trim() != "" && StrHlp.CheckDateFormat(txtDate2.Text.Trim()) == false)
                {
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('統計日期格式不正確!');", true);
                    txtDate2.Focus();
                    result = false;
                }
            }
            if (txtDep.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('請輸入部門編號!');", true);
                txtDep.Focus();
                result = false;
            }
            return result;
        }

        protected string getExcelContent()
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
                    if (j == 0 || j == 4)//固定日期格式
                        sb.Append("<td>" + "=\"" + row.Cells[j].Text.ToString() + "\"" + "</td>");
                    else
                        sb.Append("<td>" + row.Cells[j].Text.ToString() + "</td>");
                }

                sb.Append("</tr>");
            }
            sb.Append("</tbody></table>");
            return sb.ToString();
        }
    }
}