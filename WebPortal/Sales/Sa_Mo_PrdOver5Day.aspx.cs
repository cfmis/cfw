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
    public partial class Sa_Mo_PrdOver5Day : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string user_id = "";//DBUtility.user_id;
        private string within_code = DBUtility.within_code;
        ///*保存当前要显示的页码,初始化为1*/
        //private static int curPage = 1;
        ///*总的页数*/
        //private int totalPage = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                InitControler();

            }
        }

        private void InitControler()
        {
            txtDep.Text = "501";
            dateStart.Value = Convert.ToDateTime("2017/01/01").ToString("yyyy/MM/dd");
            dateEnd.Value = System.DateTime.Now.AddDays(-1).ToString("yyyy/MM/dd");
        }
        protected void btnSetNoMo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Sa_Mo_PeriodOver5Day_No.aspx");
        }
        protected void Btn_Exp_All_Click(object sender, EventArgs e)
        {

            Btn_Query_Plan_Click(sender, e);
            Btn_Exp_OC_Click(sender, e);
            Btn_Exp_Plate_Out_Click(sender, e);
            Btn_Exp_Plate_In_Click(sender, e);
            Btn_Exp_Plate_Return_Click(sender, e);
            Btn_Exp_Mo_Redo_Click(sender, e);
            Btn_Exp_Mo_Wait_Color_Click(sender, e);
            Btn_Exp_Mo_Color_OK_Click(sender, e);
        }
        protected void Btn_Query_Plan_Click(object sender, EventArgs e)
        {
            loadData("Plan", "部門生產計劃單");
        }
        protected void Btn_Exp_OC_Click(object sender, EventArgs e)
        {
            loadData("OC", "銷售明細表");
        }
        protected void Btn_Exp_Plate_Out_Click(object sender, EventArgs e)
        {
            loadData("plate_out", "電鍍加工單");
        }
        protected void Btn_Exp_Plate_In_Click(object sender, EventArgs e)
        {
            loadData("plate_in", "電鍍入庫單");
        }
        protected void Btn_Exp_Plate_Return_Click(object sender, EventArgs e)
        {
            loadData("plate_return", "電鍍返電單");
        }
        protected void Btn_Exp_Mo_Redo_Click(object sender, EventArgs e)
        {
            loadData("mo_redo", "生產補單");
        }
        protected void Btn_Exp_Mo_Wait_Color_Click(object sender, EventArgs e)
        {
            loadData("wait_color", "待批色頁數");
        }
        protected void Btn_Exp_Mo_Color_OK_Click(object sender, EventArgs e)
        {
            loadData("color_ok", "批色OK頁數");
        }
        private void loadData(string print_type, string file_str)
        {
            if (txtDep.Text.Trim() == "")
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('部門不能為空!');", true);
                return;
            }
            user_id = getUserName();
            //System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
            string filename = file_str + ".xls";
            DataTable dt = new DataTable();
            if (print_type == "Plan")
            {
                string cdat1, cdat2;
                cdat1 = Convert.ToDateTime(dateStart.Value).ToString("yyyy/MM/dd");
                cdat2 = Convert.ToDateTime(dateEnd.Value).AddDays(1).ToString("yyyy/MM/dd");
                SqlParameter[] parameters1 = { new SqlParameter("@userid", user_id)
                                        ,new SqlParameter("@dep", txtDep.Text)
                                        ,new SqlParameter("@cdat1", cdat1)
                                        ,new SqlParameter("@cdat2", cdat2)
                                            };
                dt = sh.ExecuteProcedure("usp_MoPeriodOver5Day_Plan", parameters1);
            }
            else
            {
                SqlParameter[] parameters2 = {new SqlParameter("@userid", user_id)
                                        ,new SqlParameter("@dep", txtDep.Text)
                                        ,new SqlParameter("@print_type", print_type) };
                dt = sh.ExecuteProcedure("usp_MoPeriodOver5Day", parameters2);
            }


            //ps.DataSource = dtTranRec.DefaultView;
            //this.rptDetail.DataSource = ps;
            //this.rptDetail.DataBind();


            string content = getExcelContent(dt);
            string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";

            filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);//.Encoding.UTF8);//.UTF8
            //filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.GetEncoding("Big5"));//.Encoding.UTF8);//.UTF8
            ExportToExcel(filename, content, css);

        }


        protected string getExcelContent(DataTable dt)
        {
            StringBuilder sb = new StringBuilder();
            string ex_str = "";

            sb.Append("<table borderColor='black' border='1' >");
            sb.Append("<tr>");
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                ex_str += "<th bgColor='#ccfefe'>" + dt.Columns[i].ColumnName.ToString() + "</th>";
            }

            sb.Append(ex_str);
            sb.Append("</tr></thead>");
            sb.Append("<tbody>");
            string colName = "";
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow row = dt.Rows[i];
                sb.Append("<tr class='firstTR'>");

                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    colName = dt.Columns[j].ColumnName.ToString().Trim();
                    //if (colName == "complete_date" || colName == "create_date" || colName == "predept_rechange_date" || colName == "exp_date"
                    //    || colName == "issue_date" || colName == "入倉日期" || colName == "返電日期")//固定日期格式
                    //    sb.Append("<td>" + "=\"" + row[colName].ToString() + "\"" + "</td>");
                    //else
                    sb.Append("<td>" + row[colName].ToString() + "</td>");
                }

                sb.Append("</tr>");
            }
            sb.Append("</tbody></table>");
            return sb.ToString();
        }
        
        //匯出到Excel
        private void ExportToExcel(string filename, string content, string cssText)
        {
            var res = HttpContext.Current.Response;
            content = String.Format("<style type='text/css'>{0}</style>{1}", cssText, content);

            res.Clear();
            res.Buffer = true;
            res.Charset = "UTF-8";
            res.AddHeader("Content-Disposition", "attachment; filename=" + filename);
            //res.ContentEncoding = System.Text.Encoding.UTF8;// System.Text.Encoding.GetEncoding("GB2312");//簡體
            //res.ContentEncoding = System.Text.Encoding.UTF8;//System.Text.Encoding.GetEncoding("Big5");// 繁體
            res.ContentType = "application/ms-excel";//;charset=GB2312
            
            res.Write(content);
            res.Flush();
            res.End();
        }

    }
}