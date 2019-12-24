using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Leyp.Components;
using Leyp.Components.Module;
using Leyp.SQLServerDAL;
using System.Text;

namespace WebPortal.Sales
{
    public partial class Sa_Order_Trace_New : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string within_code = DBUtility.within_code;
        private int curPage = 1;
        /*总的页数*/
        private int totalPage = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                setBtnEnabled();
                InitControler();
            }
        }
        protected void setBtnEnabled()
        {

            this.firstBtn.Enabled = false;
            this.nextBtn.Enabled = false;
            this.prevBtn.Enabled = false;
            this.lastBtn.Enabled = false;
        }
        protected void InitControler()
        {
            dateStart.Value = "";// "2017/01/01";
            dateEnd.Value = "";// "2019/12/31";
            txtMo1.Text = "";// "TBE009851";
            txtMo2.Text = "";// "TBE009852";

            DataTable tbMo_group = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getMoGroup();
            dlMo_group.DataSource = tbMo_group.DefaultView;
            dlMo_group.DataTextField = "group_desc";
            dlMo_group.DataValueField = "group_id";
            dlMo_group.DataBind();
            //制單狀態
            DataTable tbCp = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getOrderTraceFlag("CP");
            dlMo_status.DataSource = tbCp.DefaultView;
            dlMo_status.DataTextField = "flag_desc";
            dlMo_status.DataValueField = "flag_id";
            dlMo_status.DataBind();
            dlMo_status.SelectedIndex = 1;

            //生產狀態
            DataTable tbPrd = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getOrderTraceFlag("CP");
            dlPrd_state.DataSource = tbPrd.DefaultView;
            dlPrd_state.DataTextField = "flag_desc";
            dlPrd_state.DataValueField = "flag_id";
            dlPrd_state.DataBind();
            dlPrd_state.SelectedIndex = 0;

            //大貨回港情況
            DataTable tbRt_hk_status = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getOrderTraceFlag("RT");
            dlRet_hk_status.DataSource = tbRt_hk_status.DefaultView;
            dlRet_hk_status.DataTextField = "flag_desc";
            dlRet_hk_status.DataValueField = "flag_id";
            dlRet_hk_status.DataBind();
            dlRet_hk_status.SelectedIndex = 0;

            //大貨辦情況
            DataTable tbSample_hk_status = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getOrderTraceFlag("RT");
            dlSample_hk_status.DataSource = tbSample_hk_status.DefaultView;
            dlSample_hk_status.DataTextField = "flag_desc";
            dlSample_hk_status.DataValueField = "flag_id";
            dlSample_hk_status.DataBind();
            dlSample_hk_status.SelectedIndex = 0;

            //大貨批色情況
            DataTable tbChk_color_status = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getOrderTraceFlag("AL");
            dlChk_color_status.DataSource = tbChk_color_status.DefaultView;
            dlChk_color_status.DataTextField = "flag_desc";
            dlChk_color_status.DataValueField = "flag_id";
            dlChk_color_status.DataBind();
            dlChk_color_status.SelectedIndex = 0;

            dateStart.Value = System.DateTime.Now.ToString("yyyy/MM/dd");
            dateEnd.Value = dateStart.Value;


        }
        protected void btnFind_Click(object sender, EventArgs e)
        {
            curPage = 1;//將上次查詢的頁數恢復為1
            dlCurrentPage.Items.Clear();
            DataSetBand();
        }


        protected void DataSetBand()
        {
            DataTable dtOc = loadData();



            if (dtOc.Rows.Count == 0)
            {
                AlertMsgAndNoFlush(dateEnd, "沒有找到符合條件的記錄!");
            }
            this.OrderList.DataSource = null;
            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
            ps.DataSource = dtOc.DefaultView;
            ps.AllowPaging = true;
            ps.PageSize = 30;//每页显示几条记录
            ps.CurrentPageIndex = curPage - 1;//设置当前页的索引(当前页码减1就是)

            this.firstBtn.Enabled = true;
            this.nextBtn.Enabled = true;
            this.prevBtn.Enabled = true;
            this.lastBtn.Enabled = true;
            totalPage = ps.PageCount;
            setCurrentPage(totalPage);//設置下拉框頁數

            this.lTotalPage.Text = totalPage.ToString();

            if (curPage == 1)//当是第一页是.上一页和首页的按钮不可用
            {
                this.prevBtn.Enabled = false;
                this.firstBtn.Enabled = false;
            }
            if (curPage == ps.PageCount)//当是最后一页时下一页和最后一页的按钮不可用
            {
                this.nextBtn.Enabled = false;
                this.lastBtn.Enabled = false;
            }


            this.OrderList.DataSource = ps;
            //this.hourseDataList.DataKeyField = "hourseId";
            this.OrderList.DataBind();


            //如果有UpdatePanel就用如下代码调用前台js
            ScriptManager.RegisterStartupScript(UpdatePanel, this.Page.GetType(), "", "fixgrid();", true);


        }
        protected DataTable loadData()
        {
            DataTable dtOc = new DataTable();
            if (!validData())
                return dtOc;

            int no_trace_flag = 1;

            if (chkSelectExistRec.Checked == true)
                no_trace_flag = 2;
            string user_id = getUserName();

            string mo1 = txtMo1.Text.Trim().ToUpper();
            string mo2 = txtMo2.Text.Trim().ToUpper();
            string oc1 = txtOc1.Text.Trim().ToUpper();
            string oc2 = txtOc2.Text.Trim().ToUpper();
            string po1 = txtPo1.Text.Trim().ToUpper();
            string po2 = txtPo2.Text.Trim().ToUpper();

            string crdate1, crdate2;

            string sales_group = "";
            string mo_status = "";
            string prd_status = "";
            string ret_hk_status = "";
            string sample_hk_status = "";
            string chk_color_status = "";
            string job_no_status = "";

            string cust1, cust2;


            cust1 = txtCust1.Text;
            cust2 = txtCust2.Text;
            crdate1 = dateStart.Value;// dateStart.Value;
            crdate2 = dateEnd.Value;// dateEnd.Value;

            if (dlMo_group.SelectedIndex > 0)
                sales_group = dlMo_group.SelectedValue.ToString();

            if (chkSelectExistRec.Checked == true)//只有當加入追蹤表的記錄，才可以查詢以下條件
            {
                if (dlMo_status.SelectedIndex > 0)
                    mo_status = dlMo_status.SelectedValue.ToString();
                if (dlPrd_state.SelectedIndex > 0)
                    prd_status = dlPrd_state.SelectedValue.ToString();
                if (dlRet_hk_status.SelectedIndex > 0)
                    ret_hk_status = dlRet_hk_status.SelectedValue.ToString();
                if (dlSample_hk_status.SelectedIndex > 0)
                    sample_hk_status = dlSample_hk_status.SelectedValue.ToString();
                if (dlChk_color_status.SelectedIndex > 0)
                    chk_color_status = dlChk_color_status.SelectedValue.ToString();
                if (chkShowNoJobNo.Checked == true)
                    job_no_status = "Y";
            }
            if (crdate2 != "")
                crdate2 = Convert.ToDateTime(crdate2).AddDays(1).ToString("yyyy/MM/dd");

            dtOc = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getOrderTrace(no_trace_flag, user_id, sales_group
                , crdate1, crdate2, mo1, mo2, cust1, cust2, oc1, oc2,po1,po2, mo_status, prd_status, ret_hk_status, sample_hk_status, chk_color_status, job_no_status);
            return dtOc;
        }
        protected bool validData()
        {
            bool result = true;
            StrHelper StrHlp = new StrHelper();
            //if (orderDateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(orderDateStart.Value.Trim()) == false)
            //{
            //    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('訂單日期格式不正確!');", true);
            //    //cls.clsPublic.WebMessageBox(this.Page, "訂單日期格式錯誤!");
            //    orderDateStart.Focus();
            //    result = false;
            //}
            //else
            //{
            //    if (orderDateEnd.Value.Trim() != "" && StrHlp.CheckDateFormat(orderDateEnd.Value.Trim()) == false)
            //    {
            //        StrHlp.WebMessageBox(this.Page, "訂單日期格式錯誤!");
            //        orderDateEnd.Focus();
            //        result = false;
            //    }
            //}

            if (dateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(dateStart.Value.Trim()) == false)
            {
                AlertMsgAndNoFlush(dateStart, "開單日期格式錯誤!");
                dateStart.Focus();
                result = false;
            }
            else
            {
                if (dateEnd.Value.Trim() != "" && StrHlp.CheckDateFormat(dateEnd.Value.Trim()) == false)
                {
                    AlertMsgAndNoFlush(dateEnd, "開單日期格式錯誤!");
                    dateEnd.Focus();
                    result = false;
                }
            }
            return result;
        }

        protected void Btn_Query_Click(object sender, EventArgs e)
        {
            curPage = 1;
            this.DataSetBand();
        }
        protected void firstBtn_Click(object sender, EventArgs e)
        {
            curPage = 1;
            dlCurrentPage.SelectedValue = curPage.ToString();
            this.DataSetBand();
        }
        protected void prevBtn_Click(object sender, EventArgs e)
        {
            //curPage--;
            curPage = Convert.ToInt32(dlCurrentPage.SelectedValue) - 1;
            dlCurrentPage.SelectedValue = curPage.ToString();
            this.DataSetBand();
        }
        protected void nextBtn_Click(object sender, EventArgs e)
        {
            //curPage++;
            curPage = Convert.ToInt32(dlCurrentPage.SelectedValue) + 1;
            dlCurrentPage.SelectedValue = curPage.ToString();
            this.DataSetBand();
        }
        protected void lastBtn_Click(object sender, EventArgs e)
        {
            curPage = Convert.ToInt32(lTotalPage.Text);// totalPage;//
            dlCurrentPage.SelectedValue = curPage.ToString();
            this.DataSetBand();
        }
        protected void setCurrentPage(int totalPage)
        {
            curPage = (dlCurrentPage.SelectedValue.ToString() != "" ? Convert.ToInt32(dlCurrentPage.SelectedValue) : 1);
            dlCurrentPage.Items.Clear();
            for (int i = 1; i < totalPage + 1; i++)
            {
                dlCurrentPage.Items.Add(i.ToString());
            }
            dlCurrentPage.SelectedValue = curPage.ToString();
        }
        protected void dlCurrentPage_Click(object sender, EventArgs e)
        {
            curPage = Convert.ToInt32(dlCurrentPage.SelectedValue);
            this.DataSetBand();
        }

        protected void btnExpToExcel_Click(object sender, EventArgs e)
        {
            //showMsg.Visible = true;
            //System.Threading.Thread.Sleep(10 * 1000);
            //showMsg.Visible = false;
            //return;
            string content = getExcelContent();
            string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
            string filename = "制單追蹤表.xls";
            filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
            clsPublic cl = new clsPublic();
            cl.ExportToExcel(filename, content, css);
        }
      
        private string getExcelContent()
        {
            DataTable dtOc = loadData();
            StringBuilder sb = new StringBuilder();
            sb.Append("<table borderColor='black' border='1' >");
            //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");
            sb.Append("<tr>");
            sb.Append(
                "<th bgColor='#ccfefe'>選擇</th>" +
                "<th bgColor='#ccfefe'>訂單日期</th>" +
                "<th bgColor='#ccfefe'>客戶編號</th>" +
                "<th bgColor='#ccfefe'>客戶描述</th>" +
                "<th bgColor='#ccfefe'>客戶PO</th>" +
                "<th bgColor='#ccfefe'>OC編號</th>" +
                "<th bgColor='#ccfefe'>客戶產品編號</th>" +
                "<th bgColor='#ccfefe'>客戶顏色編號</th>" +
                "<th bgColor='#ccfefe'>制單編號</th>" +
                "<th bgColor='#ccfefe'>PI貨期</th>" +
                "<th bgColor='#ccfefe'>客人要求日期</th>" +
                "<th bgColor='#ccfefe'>生產情況</th>" +
                "<th bgColor='#ccfefe'>大貨回港情況</th>" +
                "<th bgColor='#ccfefe'>大貨回港日期</th>" +
                "<th bgColor='#ccfefe'>大貨辦情況</th>" +
                "<th bgColor='#ccfefe'>大貨批色情況</th>" +
                "<th bgColor='#ccfefe'>大貨批色說明</th>" +
                "<th bgColor='#ccfefe'>批復日期</th>" +
                "<th bgColor='#ccfefe'>Job No.</th>" +
                "<th bgColor='#ccfefe'>測試情況</th>" +
                "<th bgColor='#ccfefe'>測試情況其它</th>" +
                "<th bgColor='#ccfefe'>測試發票編號</th>" +
                "<th bgColor='#ccfefe'>測試發票日期</th>" +
                "<th bgColor='#ccfefe'>ShipMent</th>" +
                "<th bgColor='#ccfefe'>ShipMent其它</th>" +
                "<th bgColor='#ccfefe'>AWB No.</th>" +
                "<th bgColor='#ccfefe'>出貨日期</th>" +
                "<th bgColor='#ccfefe'>備註</th>" +
                "<th bgColor='#ccfefe'>制單狀態</th>" +
                "<th bgColor='#ccfefe'>測試狀況</th>" +
                "<th bgColor='#ccfefe'>發票編號</th>" +
                "<th bgColor='#ccfefe'>發票日期</th>" +
                "<th bgColor='#ccfefe'>發票數量(PCS)</th>" +
                "<th bgColor='#ccfefe'>訂單數量(PCS)</th>" +
                "<th bgColor='#ccfefe'>發貨狀態</th>" +

                "<th bgColor='#ccfefe'>發貨日期</th>" +
                "<th bgColor='#ccfefe'>運輸途徑</th>" +
                "<th bgColor='#ccfefe'>客人簽收</th>" +
                "<th bgColor='#ccfefe'>客人簽收日期</th>" +
                "<th bgColor='#ccfefe'>回單狀態</th>" +
                "<th bgColor='#ccfefe'>发票狀態</th>" +
                "<th bgColor='#ccfefe'>確認人</th>"
                );
            sb.Append("</tr></thead>");
            sb.Append("<tbody>");

            for (int i = 0; i < dtOc.Rows.Count; i++)
            {
                DataRow row = dtOc.Rows[i];

                sb.Append("<tr class='firstTR'>");
                sb.Append("<td>" + "" + "</td>");
                sb.Append("<td>" + "=\"" + row["order_date"] + "\"" + " </td>");
                sb.Append("<td>" + row["it_customer"] + "</td>");
                sb.Append("<td>" + row["cust_cname"] + "</td>");
                sb.Append("<td>" + row["contract_id"] + "</td>");
                sb.Append("<td>" + row["id"] + "</td>");
                sb.Append("<td>" + row["customer_goods"] + "</td>");
                sb.Append("<td>" + row["customer_color_id"] + "</td>");
                sb.Append("<td>" + row["mo_id"] + "</td>");
                sb.Append("<td>" + row["hk_req_date"] + "</td>");
                sb.Append("<td>" + "=\"" + row["cs_req_date"] + "\"" + "</td>");
                sb.Append("<td>" + row["prd_status_desc"] + "</td>");
                sb.Append("<td>" + row["ret_hk_status_desc"] + "</td>");
                sb.Append("<td>" + "=\"" + row["act_hk_date"] + "\"" + "</td>");
                sb.Append("<td>" + row["sample_hk_status_desc"] + "</td>");
                sb.Append("<td>" + row["chk_color_status_desc"] + "</td>");
                sb.Append("<td>" + row["chk_color_oth"] + "</td>");
                sb.Append("<td>" + row["chk_color_date"] + "</td>");
                sb.Append("<td>" + row["job_no"] + "</td>");
                sb.Append("<td>" + row["test_result_desc"] + "</td>");
                sb.Append("<td>" + row["test_status"] + "</td>");
                sb.Append("<td>" + row["test_inv_no"] + "</td>");
                sb.Append("<td>" + row["test_inv_date"] + "</td>");
                sb.Append("<td>" + row["shipment_desc"] + "</td>");
                sb.Append("<td>" + row["shipment_oth"] + "</td>");
                sb.Append("<td>" + row["awb_no"] + "</td>");
                sb.Append("<td>" + row["sent_date"] + "</td>");
                sb.Append("<td>" + row["remark"] + "</td>");
                sb.Append("<td>" + row["mo_status_desc"] + "</td>");
                sb.Append("<td>" + row["customer_test_id"] + "</td>");
                sb.Append("<td>" + row["inv_id"] + "</td>");
                sb.Append("<td>" + row["inv_date"] + "</td>");
                sb.Append("<td>" + row["inv_qty_pcs"] + "</td>");
                sb.Append("<td>" + row["order_qty_pcs"] + "</td>");
                sb.Append("<td>" + row["issues_state"] + "</td>");
                sb.Append("<td>" + row["consignment_date"] + "</td>");
                sb.Append("<td>" + row["transport_style"] + "</td>");
                sb.Append("<td>" + row["receipt_person"] + "</td>");
                sb.Append("<td>" + row["receipted_date"] + "</td>");
                sb.Append("<td>" + row["return_state"] + "</td>");
                sb.Append("<td>" + row["inv_state"] + "</td>");
                sb.Append("<td>" + row["check_by"] + "</td>");

                sb.Append("</tr>");

            }
            sb.Append("</tbody></table>");
            return sb.ToString();
        }



        //}

        /// <summary>  
        /// 弹出消息框  
        /// </summary>  
        /// <param name="controlName">控件名称</param>  
        /// <param name="message">消息内容</param>  
        protected static void AlertMsgAndNoFlush(Control controlName, string message)
        {
            //string sMessage = ErrMsg(message);  
            ScriptManager.RegisterClientScriptBlock(controlName, typeof(UpdatePanel), "提示", "alert('" + message + "');", true);
        }

        #region updatepanle下解决提示框不弹出的方法  
        /// <summary>  
        /// 弹出消息框并且转向到新的URL  
        /// </summary>  
        /// <param name="controlName">控件名称</param>  
        /// <param name="message">消息内容</param>  
        /// <param name="toURL">连接地址</param>  
        protected static void AlertAndRedirect(Control controlName, string message, string toURL)
        {

            ScriptManager.RegisterClientScriptBlock(controlName, typeof(UpdatePanel), "提示", "alert('" + message + "');location.href='" + toURL + "'", true);

        }
        #endregion


        



    }
}