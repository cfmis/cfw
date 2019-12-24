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
    public partial class Sa_Order_Trace : BasePage//System.Web.UI.Page
    {

        private static int curPage = 1;
        /*总的页数*/
        private int totalPage = 0;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {

                InitControler();

            }
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
        protected void btnFindNoTrace_Click(object sender, EventArgs e)
        {
            chkSelectExistRec.Checked = false;
            lblShowInfo.Text = "查詢：未加入追蹤表的記錄";
            lblShowInfo.ForeColor = System.Drawing.Color.Red;
            loadData(1);
        }
        protected void btnFindHasTrace_Click(object sender, EventArgs e)
        {
            chkSelectExistRec.Checked = true;
            lblShowInfo.Text = "查詢：已加入追蹤表的記錄";
            lblShowInfo.ForeColor = System.Drawing.Color.Blue;
            loadData(2);
        }
        protected void setMoPrint_Click(object sender, EventArgs e)
        {
            //int row = saleTable.Rows.Count;
            //txtMo1.Text = row.ToString();
        }

        protected void loadData(int source_type)
        {
            this.rpOcDetail.DataSource = null;
            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();

            if (!validData())
                return;


            string user_id = getUserName();
            int result = -1;
            string mo1 = txtMo1.Text.Trim().ToUpper();
            string mo2 = txtMo2.Text.Trim().ToUpper();
            string oc1 = txtOc1.Text.Trim().ToUpper();
            string oc2 = txtOc2.Text.Trim().ToUpper();

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

            DataTable dtOc = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getOrderTrace(source_type, user_id, sales_group
                , crdate1, crdate2, mo1, mo2, cust1, cust2,oc1,oc2,mo_status,prd_status,ret_hk_status,sample_hk_status,chk_color_status,job_no_status);
            ps.DataSource = dtOc.DefaultView;
            ps.AllowPaging = true;
            ps.PageSize = 1000000;//每页显示几条记录
            ps.CurrentPageIndex = curPage - 1;//设置当前页的索引(当前页码减1就是)

            //this.firstBtn.Enabled = true;
            //this.nextBtn.Enabled = true;
            //this.prevBtn.Enabled = true;
            //this.lastBtn.Enabled = true;

            //this.CurrentPage.Text = curPage.ToString();
            //this.TotalPage.Text = totalPage.ToString();

            //if (curPage == 1)//当是第一页是.上一页和首页的按钮不可用
            //{
            //    this.prevBtn.Enabled = false;
            //    this.firstBtn.Enabled = false;

            //}
            //if (curPage == ps.PageCount)//当是最后一页时下一页和最后一页的按钮不可用
            //{
            //    this.nextBtn.Enabled = false;
            //    this.lastBtn.Enabled = false;
            //}

            this.rpOcDetail.DataSource = ps;
            //this.hourseDataList.DataKeyField = "hourseId";
            this.rpOcDetail.DataBind();

            //ClientScript.RegisterStartupScript(this.GetType(), "myscript", "<script>showDivSearch();</script>");



            //調用js的方法：
            //如果没有就如下代码
            //this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "", "<script>showDivSearch();</script>", true);

            

            //如果有UpdatePanel就用如下代码调用前台js
            ScriptManager.RegisterStartupScript(UpdatePanel, this.Page.GetType(), "", "showDivDetailsHeight();", true);

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
                StrHlp.WebMessageBox(this.Page, "開單日期格式錯誤!");
                dateStart.Focus();
                result = false;
            }
            else
            {
                if (dateEnd.Value.Trim() != "" && StrHlp.CheckDateFormat(dateEnd.Value.Trim()) == false)
                {
                    StrHlp.WebMessageBox(this.Page, "開單日期格式錯誤!");
                    dateEnd.Focus();
                    result = false;
                }
            }
            return result;
        }
    }
}