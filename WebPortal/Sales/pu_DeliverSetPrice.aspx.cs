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

namespace WebPortal.Sales
{
    public partial class pu_DeliverSetPrice : BasePage//: System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private string struser_id = "";
        private string comp_type = DBUtility.comp_type;
        private string remote_db = DBUtility.remote_db;
        private string within_code = DBUtility.within_code;
        private bool start_search = false;
        private clsPublic clsPublic = new clsPublic();
        private StrHelper StrHlp = new StrHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["user"] == null)
            //{
            //    Response.Redirect("logout.aspx");
            //}

            if (!Page.IsPostBack)
            {
                initControls();
            }
            else
                start_search = true;
            if (start_search == true)
            {
                loadData();
            }
            
        }


        protected void initControls()
        {
            txtDoc_date1.Text = System.DateTime.Now.ToString("yyyy/MM/dd");
            txtDoc_date2.Text = txtDoc_date1.Text;

            txtDep.Text = "501";

            string strSql = "select id AS vend_id from " + remote_db +
                "it_vendor Where within_code='" + within_code + "' AND id>='CL' AND id<='CLZZZZZZ'";
            DataTable tbVend_id = sh.ExecuteSqlReturnDataTable(strSql);

            tbVend_id.Rows.Add();
            tbVend_id.DefaultView.Sort = "vend_id";
            dlVend_id.DataSource = tbVend_id.DefaultView;
            dlVend_id.DataTextField = "vend_id";
            dlVend_id.DataValueField = "vend_id";
            dlVend_id.DataBind();


            
            DataTable tbUnit = sh.ExecuteSqlReturnDataTable(strSql);

            dlSetPrice.Items.Add("全部");
            dlSetPrice.Items.Add("已設定單價");
            dlSetPrice.Items.Add("未設定單價");
            dlSetPrice.SelectedIndex = 0;
        }

        protected DataTable ddlBindPunit()
        {
            string strSql = "select id AS p_unit from " + remote_db + "cd_units where within_code='0000'";
            return sh.ExecuteSqlReturnDataTable(strSql);
        }

        protected void btnFind_Click(object sender, EventArgs e)
        {

            loadData();

        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveProcess();
        }

        protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
        {
            for (int i = 0; i < gvDetails.Rows.Count; i++)
            {
                CheckBox chk = (CheckBox)gvDetails.Rows[i].FindControl("chkRec");
                //TextBox txtAct_vend_in_qty = (TextBox)gvDetails.Rows[i].FindControl("txtAct_vend_in_qty");
                //TextBox txtAct_vend_in_weg = (TextBox)gvDetails.Rows[i].FindControl("txtAct_vend_in_weg");
                if (chkSelectAll.Checked == true)
                {
                    chk.Checked = true;
                }
                else
                {
                    chk.Checked = false;
                    //databind();

                }
            }
        }


        protected void gvDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDetails.PageIndex = e.NewPageIndex;
            gvDetails.DataBind();
            chkSelectAll.Checked = false;
        }

        protected void txtDoc_id1Changed(object sender, EventArgs e)
        {
            txtDoc_id2.Text = txtDoc_id1.Text;
        }

        protected void txtDoc_date1_TextChanged(object sender, EventArgs e)
        {
            txtDoc_date2.Text = txtDoc_date1.Text;
        }
        protected void txtMo1_TextChanged(object sender, EventArgs e)
        {
            txtMo2.Text = txtMo1.Text;
        }

        protected void loadData()
        {
            if (validData() == false)
            {
                return;
            }

            int show_details = 0;//顯示明細表記錄  1--匯總表記錄
            if (chkShowSum.Checked == true) //顯示匯總表記錄
                show_details = 1;
            int show_price = 0;
            string date1 = "";
            string date2 = "";
            string vend_id = "";
            if (dlVend_id.SelectedIndex != 0)
                vend_id = dlVend_id.Text.Trim();
            string doc_id1 = txtDoc_id1.Text.Trim();
            string doc_id2 = txtDoc_id2.Text.Trim();
            string mo1 = txtMo1.Text.Trim();
            string mo2 = txtMo2.Text.Trim();
            string dep = txtDep.Text.Trim();
            string prd_item = "";
            date1 = txtDoc_date1.Text;
            date2 = txtDoc_date2.Text;

            //if (dlDeliverFlag.SelectedIndex == 2)//從已發貨中提取
            //    select_tb = 2;
            //if (chkOut_type2.Checked == true)
            show_price = dlSetPrice.SelectedIndex;
            //if (vend_id == "")
            //{
            //    Response.Write("<script>alert('供應商不能為空!');<" + "/" + "script>");
            //    txtVend_id.Focus();
            //    return;
            //}
            if (date2 != "")
                date2 = Convert.ToDateTime(date2).AddDays(1).ToString("yyyy/MM/dd");
            string sqlstr = "pu_DeliverSetPrice_find";
            SqlParameter[] parameters = {new SqlParameter("@show_details", show_details),new SqlParameter("@show_price", show_price)
                                            ,new SqlParameter("@dep", dep),new SqlParameter("@vend_id", vend_id),new SqlParameter("@prd_item", prd_item)
                                            , new SqlParameter("@doc_id1", doc_id1), new SqlParameter("@doc_id2", doc_id2)
                                        ,new SqlParameter("@date1", date1),new SqlParameter("@date2", date2)};
            DataTable tbPu = sh.ExecuteProcedure(sqlstr, parameters);
            
            if (show_details == 0)//顯示明細表記錄
            {
                gvDetails.DataSource = tbPu.DefaultView;
                gvDetails.DataBind();
                lblTotalRec.Text = "    記錄數:  " + tbPu.Rows.Count.ToString();
            }
            else
            {
                lblTotalRec.Text = "匯總表";
                gvSum.DataSource = tbPu.DefaultView;
                gvSum.DataBind();
            }
        }

        protected bool validData()
        {
            bool result = true;
            if (txtDoc_date1.Text.Trim() != "" && StrHlp.CheckDateFormat(txtDoc_date1.Text.Trim()) == false)
            {
                StrHlp.WebMessageBox(this.Page, "日期格式錯誤!");
                txtDoc_date1.Focus();
                result = false;
            }
            else
            {
                if (txtDoc_date2.Text.Trim() != "" && StrHlp.CheckDateFormat(txtDoc_date2.Text.Trim()) == false)
                {
                    StrHlp.WebMessageBox(this.Page, "日期格式錯誤!");
                    txtDoc_date2.Focus();
                    result = false;
                }
            }
            return result;
        }

        protected void dlDeliverFlag_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (dlDeliverFlag.SelectedIndex == 2)
            //{
            //    btnSave.Enabled = false;
            //    btnDelete.Enabled = true;
            //}
            //else
            //{
            //    btnSave.Enabled = true;
            //    btnDelete.Enabled = false;
            //}
        }


        protected void SaveProcess()
        {
            if (validSaveData() != "")
                return;
            string strSql = "";
            string result = "";

            for (int i = 0; i < gvDetails.Rows.Count; i++)
            {
                CheckBox chk = (CheckBox)gvDetails.Rows[i].FindControl("chkRec");
                if (chk.Checked == true)
                {
                    string doc_id = gvDetails.Rows[i].Cells[1].Text.Trim();
                    string seq = gvDetails.Rows[i].Cells[2].Text.Trim();
                    double price, sec_price, mould_fee, former_free, qty, weg;
                    string process_request;
                    string p_unit, sec_p_unit;
                    TextBox tx = new TextBox();
                    DropDownList dl = new DropDownList();
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtPrice");
                    price = tx.Text != "" ? Convert.ToDouble(tx.Text) : 0;
                    dl = (DropDownList)gvDetails.Rows[i].FindControl("dlP_unit");
                    p_unit = dl.Text;
                    double rate = getUnitRate(p_unit);
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtSec_price");
                    sec_price = tx.Text != "" ? Convert.ToDouble(tx.Text) : 0;
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtMould_fee");
                    mould_fee = tx.Text != "" ? Convert.ToDouble(tx.Text) : 0;
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtFormer_free");
                    former_free = tx.Text != "" ? Convert.ToDouble(tx.Text) : 0;
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtProcess_request");
                    process_request = tx.Text;
                    dl = (DropDownList)gvDetails.Rows[i].FindControl("dlSec_p_unit");
                    sec_p_unit = dl.Text;
                    qty = Convert.ToDouble(gvDetails.Rows[i].Cells[14].Text);
                    weg = Convert.ToDouble(gvDetails.Rows[i].Cells[15].Text);
                    double total_prices = Math.Round(qty * (price / rate) + weg * sec_price + mould_fee + former_free, 2);
                    strSql += string.Format(@"UPDATE " + remote_db + "op_outpro_out_displace SET price='{0}',sec_price='{1}',mould_fee='{2}',former_free='{3}',process_request='{4}'" +
                            ",p_unit='{5}',sec_p_unit='{6}',total_prices='{7}'" +
                            " WHERE within_code='{8}' AND id='{9}' AND sequence_id='{10}' "
                            , price, sec_price, mould_fee, former_free, process_request, p_unit, sec_p_unit, total_prices, within_code, doc_id, seq);
//                    strSql += string.Format(@"UPDATE pu_deliver_details SET act_in_weg=act_in_weg+'{0}',act_in_qty=act_in_qty+'{1}',act_in_date='{2}'
//                                ,crusr='{3}',crtim=GETDATE()
//                                WHERE doc_id='{4}' AND seq='{5}' ", act_in_weg, act_in_qty, act_in_date, user_id, ref_doc_id, ref_seq);
                }
            }
            if (strSql != "")
            {
                result = sh.ExecuteSqlUpdate(strSql);
                if (result == "")
                {
                    chkSelectAll.Checked = false;
                    result = "更新單價成功!";
                }
            }
            StrHlp.WebMessageBox(this.Page, result);
            //Response.Write(String.Format("<script text='text/javascript'>alert('{0}')</script>", result));

            loadData();
        }
        private double getUnitRate(string unit)
        {
            double rate = 0;
            string strSql = "Select rate From " + remote_db + "it_coding Where unit_code='" + unit + "' And id='*'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            if (dt.Rows.Count > 0)
                rate = Convert.ToDouble(dt.Rows[0]["rate"]);
            if (rate == 0)
                rate = 1;
            return rate;
        }
        protected string validSaveData()
        {
            string result = "";
            //double chk_num;
            //double out_weg;
            for (int i = 0; i < gvDetails.Rows.Count; i++)//
            {
                string ci = (i + 1).ToString();
                CheckBox chk = (CheckBox)gvDetails.Rows[i].FindControl("chkRec");
                if (chk.Checked == true)
                {

                    TextBox tx = new TextBox();
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtPrice");
                    if (!StrHlp.IsNumeric(tx.Text))
                    {
                        result = "第" + ci + "行的價格不正確!";
                        break;
                    }

                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtSec_price");
                    if (!StrHlp.IsNumeric(tx.Text))
                    {
                        result = "第" + ci + "行的重量價格不正確!";
                        break;
                    }

                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtMould_fee");
                    if (!StrHlp.IsNumeric(tx.Text))
                    {
                        result = "第" + ci + "行的最低消費金額不正確!";
                        break;
                    }
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtFormer_free");
                    if (!StrHlp.IsNumeric(tx.Text))
                    {
                        result = "第" + ci + "行的版費不正確!";
                        break;
                    }
                    if (result != "")
                        break;
                }
            }

            if (result != "")
                StrHlp.WebMessageBox(this.Page, result);


            return result;
        }


        protected void btnExpExcelNew_Click(object sender, EventArgs e)
        {
            string content = getExcelContent();
            string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
            string filename = "外發記錄.xls";
            filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
            clsPublic.ExportToExcel(filename, content, css);

        }
        protected string getExcelContent()
        {
            StringBuilder sb = new StringBuilder();
            string ex_str = "";
            string val = "";
            sb.Append("<table borderColor='black' border='1' >");
            sb.Append("<tr>");

            if (chkShowSum.Checked == false)//匯出明細表
            {
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

                    string price, sec_price, mould_fee, former_free;
                    string process_request;
                    string p_unit, sec_p_unit;
                    TextBox tx = new TextBox();
                    DropDownList dl = new DropDownList();
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtPrice");
                    price = tx.Text;
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtSec_price");
                    sec_price = tx.Text;
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtMould_fee");
                    mould_fee = tx.Text;
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtFormer_free");
                    former_free = tx.Text;
                    tx = (TextBox)gvDetails.Rows[i].FindControl("txtProcess_request");
                    process_request = tx.Text;
                    dl = (DropDownList)row.FindControl("dlP_unit");
                    p_unit = dl.Text;
                    dl = (DropDownList)row.FindControl("dlSec_p_unit");
                    sec_p_unit = dl.Text;
                    for (int j = 0; j < gvDetails.Columns.Count; j++)
                    {
                        val = row.Cells[j].Text.ToString();
                        if (j == 5)//單價
                            val = price;
                        else
                            if (j == 6)//單價單位
                                val = p_unit;
                            else
                                if (j == 7)//重量單價
                                    val = sec_price;
                                else
                                    if (j == 8)//單價單位
                                        val = sec_p_unit;
                                    else
                                        if (j == 9)//單價備註
                                            val = process_request;
                                        else
                                            if (j == 10)//最低消費金額
                                                val = mould_fee;
                                            else
                                                if (j == 11)//版費
                                                    val = former_free;

                        if (j == 16)//固定日期格式
                            sb.Append("<td>" + "=\"" + val + "\"" + "</td>");
                        else
                            sb.Append("<td>" + val + "</td>");
                    }
                }

                    sb.Append("</tr>");
                }
            else//匯出匯總表
            {
                for (int i = 0; i < gvSum.Columns.Count; i++)
                {
                    ex_str += "<th bgColor='#ccfefe'>" + gvSum.Columns[i].HeaderText + "</th>";
                }

                sb.Append(ex_str);
                sb.Append("</tr></thead>");
                sb.Append("<tbody>");

                for (int i = 0; i < gvSum.Rows.Count; i++)
                {
                    GridViewRow row = gvSum.Rows[i];
                    sb.Append("<tr class='firstTR'>");

                    
                    for (int j = 0; j < gvSum.Columns.Count; j++)
                    {
                        val = row.Cells[j].Text.ToString();
                        if (j == 1)//固定日期格式
                            sb.Append("<td>" + "=\"" + val + "\"" + "</td>");
                        else
                            sb.Append("<td>" + val + "</td>");
                    }

                    sb.Append("</tr>");
                }
            }
            sb.Append("</tbody></table>");
            return sb.ToString();
        }

    }
}