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

namespace WebPortal.Products
{
    public partial class Pd_QueryProductStatus : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string user_id = "";//DBUtility.user_id;
        private string within_code = DBUtility.within_code;
        private int curPage = 1;
        /*总的页数*/
        private int totalPage = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                init();
                //DataSetBand();
            }
        }

        protected void init()
        {
            datePrd.Value = System.DateTime.Now.AddDays(-1).ToString("yyyy/MM/dd");
            //txtPrd_mo.Value = "GBE029520";
            DataTable tbMo_group = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getDep();
            dlDep.DataSource = tbMo_group.DefaultView;
            dlDep.DataTextField = "dep_cdesc";
            dlDep.DataValueField = "dep_id";
            dlDep.DataBind();

            this.firstBtn.Enabled = false;
            this.nextBtn.Enabled = false;
            this.prevBtn.Enabled = false;
            this.lastBtn.Enabled = false;
        }

        protected void Select_Click(object sender, EventArgs e)
        {
            curPage = 1;//將上次查詢的頁數恢復為1
            dlCurrentPage.Items.Clear();
            DataSetBand();
        }

        protected void DataSetBand()
        {
            string prd_dep = dlDep.SelectedValue;
            string prd_date = datePrd.Value;
            string prd_mo = txtPrd_mo.Value;
            string prd_machine = txtPrd_machine.Value;
            string Prd_worker = txtPrd_worker.Value.Trim();
            if (Prd_worker != "")
                Prd_worker = Prd_worker.Trim().PadLeft(10, '0');
            this.OrderList.DataSource = null;
            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
            //CollectionPager1.DataSource = null;
            DataTable dtPrd = Leyp.SQLServerDAL.Factory_New.getProductsMoArrangeDAL().queryProductStatus(prd_date, prd_dep, prd_mo,prd_machine, Prd_worker);
            ////OrderList.DataSource = ds.Tables["dd"].DefaultView;
            ////OrderList.DataBind();

            //CollectionPager1.DataSource = dtMoArrange.DefaultView;// list;
            //CollectionPager1.BindToControl = OrderList;
            //OrderList.DataSource = CollectionPager1.DataSourcePaged;

            ps.DataSource = dtPrd.DefaultView;
            ps.AllowPaging = true;
            ps.PageSize = 30;//每页显示几条记录
            ps.CurrentPageIndex = curPage - 1;//设置当前页的索引(当前页码减1就是)
            //this.OrderList.DataSource = ps;
            ////this.hourseDataList.DataKeyField = "hourseId";
            //this.OrderList.DataBind();




            ////如果有UpdatePanel就用如下代码调用前台js

            //////this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "", "<script>fixgrid();</script>", true);
            //////ScriptManager.RegisterStartupScript(UpdatePanel, this.Page.GetType(), "", "fixgrid();", true);


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

    }
}