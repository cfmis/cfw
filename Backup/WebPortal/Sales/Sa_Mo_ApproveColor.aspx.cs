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
using Leyp.SQLServerDAL.Sales;
using Leyp.Components;
using Leyp.Components.Module;

//using cfoa.cls;
//using sqloperate;

namespace WebPortal.Sales
{
    public partial class Sa_Mo_ApproveColor : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private clsPublic clsPublic = new clsPublic();
        private StrHelper StrHlp = new StrHelper();
        private string user_id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["user"] == null)
            //{
            //    Response.Redirect("logout.aspx");
            //}
            //else
            //    user_id = Session["user"].ToString();
            //((ScriptManager)Master.FindControl("ScriptManager1")).RegisterPostBackControl(btnExcel);  
            if (!Page.IsPostBack)
            {
                InitValue();
                
            }
            user_id = getUserName();
            LoadData();
        }

        protected void InitValue()
        {
            dlApproveColor.SelectedIndex = 1;
            txtMo.Focus();
        }
        protected void btnFind_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        protected void btnExcel_Click(object sender, EventArgs e)
        {
            string content = getExcelContent();
            string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
            string filename = "制單批色記錄表.xls";
            filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
            //clsPublic.daoruExce dre = new clsPublic.daoruExce();
            clsPublic.ExportToExcel(filename, content, css);
        }

        private string getExcelContent()
        {
            DropDownList dl = new DropDownList();
            StringBuilder sb = new StringBuilder();
            sb.Append("<table borderColor='black' border='1' >");
            sb.Append("<tr>");
            sb.Append(
                "<th bgColor='#ccfefe'>組別</th>" +
                "<th bgColor='#ccfefe'>制單編號</th>" +
                "<th bgColor='#ccfefe'>備註</th>" +
                "<th bgColor='#ccfefe'>建立人</th>" +
                "<th bgColor='#ccfefe'>建立日期</th>"
                );
            sb.Append("</tr></thead>");
            sb.Append("<tbody>");

            for (int i = 0; i < gvMo.Rows.Count; i++)
            {
                GridViewRow row = gvMo.Rows[i];
                sb.Append("<tr class='firstTR'>");
                sb.Append("<td>" + row.Cells[1].Text.ToString().Substring(2, 1) + "</td>");
                sb.Append("<td>" + row.Cells[1].Text.ToString() + "</td>");
                sb.Append("<td>" + row.Cells[2].Text.ToString() + "</td>");
                sb.Append("<td>" + row.Cells[3].Text.ToString() + "</td>");
                sb.Append("<td>" + "=\"" + row.Cells[4].Text.ToString() + "\"" + "</td>");
                sb.Append("</tr>");
            }
            sb.Append("</tbody></table>");
            return sb.ToString();
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveRec();
        }
        //查找記錄
        protected void LoadData()
        {
            int select_flag = 0;
            int id = 0;
            string approve_flag = "";
            select_flag = dlApproveColor.SelectedIndex;
            if (select_flag == 1)
                approve_flag = "0";
            else
                if (select_flag == 2)
                    approve_flag = "1";
            string strSql = "Select id,prd_mo,prd_rmk,crusr,Convert(Varchar(20),crtim,120) As crtim,approve_flag,approve_usr,Convert(Varchar(20),approve_tim,120) As approve_tim" +
                " From mo_approvecolor Where id>='" + id + "'";
            if (approve_flag != "")
                strSql = strSql + " AND approve_flag='" + approve_flag + "'";
            if (txtMo.Text != "")
                strSql = strSql + " AND prd_mo='" + txtMo.Text + "'";
            DataTable tbMoFind = sh.ExecuteSqlReturnDataTable(strSql);
            //if (tbMoFind.Rows.Count == 0)
            //    tbMoFind.Rows.Add();
            gvMo.DataSource = tbMoFind.DefaultView;
            gvMo.DataBind();
        }

        protected void gvDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (gvMo.Rows.Count > 0)
                DeleteMo(gvMo.Rows[e.RowIndex].Cells[0].Text);
            LoadData();
        }



        /// 儲存記錄
        private void SaveRec()
        {
            if (txtMo.Text == "")
            {
                StrHlp.WebMessageBox(this.Page, "制單編號不能為空!");
                txtMo.Focus();
                return;
            }
            string result_str = "";
            string strSql = "";
            string prd_mo = txtMo.Text.ToUpper();
            string prd_rmk = txtRmk.Text;
            string approve_flag = "0";
            

            strSql += string.Format(@"INSERT INTO mo_approvecolor (prd_mo,prd_rmk,crusr,crtim,approve_flag)
                    VALUES ('{0}','{1}','{2}',GETDATE(),'{3}')"
                , prd_mo, prd_rmk, user_id, approve_flag);
            result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
            if (result_str != "")
            {
                //Response.Write(String.Format("<script text='text/javascript'>alert('{0}')</script>", result_str));
                StrHlp.WebMessageBox(this.Page, result_str);
            }
            else
                LoadData();
        }


        /// 刪除記錄
        private void DeleteMo(string id)
        {
            string strSql = "";
            string result_str = "";
            strSql += string.Format(@"Delete From mo_approvecolor Where id='{0}'", id);
            result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
            if (result_str != "")
            {
                StrHlp.WebMessageBox(this.Page, result_str);
            }
            else
                LoadData();
        }


        protected void gvMo_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int row = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName.ToString() == "Approve_color")
            {
                Approve_Color(gvMo.Rows[row].Cells[0].Text);
                return;
            }

        }

        /// 批色確認
        private void Approve_Color(string id)
        {
            string strSql = "";
            string result_str = "";
            string approve_flag = "1";
            strSql += string.Format(@"Update mo_approvecolor Set approve_flag='{0}',approve_usr='{1}',approve_tim=GETDATE() Where id='{2}'"
                , approve_flag, user_id, id);
            result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
            if (result_str != "")
            {
                StrHlp.WebMessageBox(this.Page, result_str);
            }
            else
            {
                StrHlp.WebMessageBox(this.Page, "批色確認成功!");
                LoadData();
            }
        }


    }
}