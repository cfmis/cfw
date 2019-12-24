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
            string approve_type = "Approve_color";
            if (e.CommandName.ToString() == "Approve_color")
            {
                //Approve_Color(gvMo.Rows[row].Cells[0].Text, gvMo.Rows[row].Cells[1].Text);

                //return;
            }
            else
            {
                if (e.CommandName.ToString() == "Approve_color_old")
                {

                    approve_type = "Approve_color_old";
                    //return;
                }
            }
            Approve_Color(approve_type,gvMo.Rows[row].Cells[0].Text, gvMo.Rows[row].Cells[1].Text);
        }

        /// 批色確認
        private void Approve_Color(string approve_type,string id,string mo_id)
        {
            if(txtAppClrDate.Value.ToString()=="")
            {
                StrHlp.WebMessageBox(this.Page, "批色日期不能為空!");
                return;
            }
            string strSql = "";
            string result_str = "";
            string approve_flag = "1";//jo_bill_goods_details  plate_remark
            
            if (approve_type == "Approve_color")//如果是要更新到Geo中的
            {
                string remote_db = DBUtility.remote_db;
                string within_code = DBUtility.within_code;
                string approve_date = "(" + txtAppClrDate.Value.ToString() + "已批色:" + txtAppMark.Text.Trim() + ")";
                //提取OC中的生產備註、噴油備註
                strSql = "Select a.id,a.ver,a.sequence_id,a.plate_remark,b.production_remark"
                    + " From "
                    + remote_db + "so_order_details a"
                    + " Left Join " + remote_db + "so_order_special_info b On a.within_code=b.within_code And a.id=b.id And a.ver=b.ver And a.sequence_id=b.upper_sequence"
                    + " Where a.within_code='" + within_code + "' And a.mo_id='" + mo_id + "'";
                DataTable dtOc = sh.ExecuteSqlReturnDataTable(strSql);
                string oc_id = dtOc.Rows[0]["id"].ToString();
                int ver = Convert.ToInt32(dtOc.Rows[0]["ver"].ToString());
                string sequence_id = dtOc.Rows[0]["sequence_id"].ToString();
                string plate_remark = dtOc.Rows[0]["plate_remark"].ToString().Trim() + approve_date;
                string production_remark = dtOc.Rows[0]["production_remark"].ToString().Trim() + approve_date;
                strSql = "Select id,ver From " + remote_db + "jo_bill_mostly Where within_code='" + within_code + "' And mo_id='" + mo_id + "'";
                DataTable dtWip = sh.ExecuteSqlReturnDataTable(strSql);
                string wp_id = dtWip.Rows[0]["id"].ToString();
                int wp_ver = Convert.ToInt32(dtWip.Rows[0]["ver"].ToString());

                strSql = "";
                //更新計劃的批色狀態
                strSql += string.Format(@"UPDATE " + remote_db + "jo_bill_goods_details SET shading_color_state = '{0}'"
                    + " WHERE within_code = '{1}' AND id = '{2}' AND ver='{3}' AND shading_color='{4}'"
                    , approve_flag, within_code, wp_id, wp_ver, approve_flag);
                //更新OC中的生產備註
                strSql += string.Format(@"UPDATE " + remote_db + "so_order_details Set plate_remark='{0}' "
                    + " Where within_code='{1}' And id='{2}' And ver='{3}' And sequence_id='{4}'"
                    , plate_remark, within_code, oc_id, ver, sequence_id);
                //更新OC中的電鍍備註
                strSql += string.Format(@"UPDATE " + remote_db + "so_order_special_info Set production_remark='{0}' "
                    + " Where within_code='{1}' And id='{2}' And ver='{3}' And upper_sequence='{4}'"
                    , production_remark, within_code, oc_id, ver, sequence_id);
            }
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