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
//using cfoa.mdl;

namespace WebPortal.Sales
{
    public partial class Sa_Oc_ShowStatus : BasePage//System.Web.UI.Page//
    {
        //private SQLHelp sh = new SQLHelp();
        //private clsPublic clsPublic = new clsPublic();
        //private StrHelper StrHlp = new StrHelper();
        //private string lang_id = Base.lang_id;
        
        //private string within_code = Base.within_code;

        /*保存当前要显示的页码,初始化为1*/
        private static int curPage = 1;
        /*总的页数*/
        private int totalPage = 0;
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
        }
        protected void InitControler()
        {
            //SQLHelp sh = new SQLHelp();
            //StrHelper StrHlp = new StrHelper();
            //string strSql;
            //strSql = "select group_id,group_desc from bs_mo_group order by group_id ";
            //DataTable tbMo_group = sh.ExecuteSqlReturnDataTable(strSql);
            DataTable tbMo_group = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getMoGroup();
            dlMo_group.DataSource = tbMo_group.DefaultView;
            dlMo_group.DataTextField = "group_desc";
            dlMo_group.DataValueField = "group_id";
            dlMo_group.DataBind();

            //strSql = "select flag_id,flag_desc from bs_flag_desc Where doc_type='CP' AND flag0='Y' order by flag_id ";
            //DataTable tbCp = sh.ExecuteSqlReturnDataTable(strSql);
            DataTable tbCp = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getMoStatusFlag();
            dlComplete.DataSource = tbCp.DefaultView;
            dlComplete.DataTextField = "flag_desc";
            dlComplete.DataValueField = "flag_id";
            dlComplete.DataBind();
            dlComplete.SelectedIndex = 1;

            dateStart.Value = System.DateTime.Now.ToString("yyyy/MM/dd");
            dateEnd.Value = dateStart.Value;


        }
        protected void Select_Click(object sender, EventArgs e)
        {
            this.rpOcDetail.DataSource = null;
            loadData();
        }
        protected void setMoPrint_Click(object sender, EventArgs e)
        {
            Response.Redirect("Sa_Mo_BatchPrint.aspx");
        }
        
        protected void loadData()
        {
            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();

            if (!validData())
                return;


            string user_id = getUserName();
            int result = -1;
            string mo1 = txtMo1.Text.Trim().ToUpper();
            string mo2 = txtMo2.Text.Trim().ToUpper();
            string date1, date2;
            string crdate1, crdate2;
            string crby = txtCrBy.Text;
            string mo_group = "";
            string cp_state = "";
            string brand1, brand2;
            string cust1, cust2;
            string own1, own2;
            int source_type;
            string showapart = "";
            source_type = 1;
            if (chkBatchMo.Checked == true)
                source_type = 2;
            if (chkShowA_part.Checked == true)//只顯示A Part
                showapart = "1";
            brand1 = txtBrand1.Text;
            brand2 = txtBrand2.Text;
            cust1 = txtCust1.Text;
            cust2 = txtCust2.Text;
            date1 = orderDateStart.Value;
            date2 = orderDateEnd.Value;
            crdate1 = dateStart.Value;// dateStart.Value;
            crdate2 = dateEnd.Value;// dateEnd.Value;
            own1 = txtOwn1.Text;
            own2 = txtOwn2.Text;
            if (dlMo_group.SelectedIndex > 0)
                mo_group = dlMo_group.SelectedValue.ToString();
            if (dlComplete.SelectedIndex > 0)
                cp_state = dlComplete.SelectedValue.ToString();
            if (date2 != "")
                date2 = Convert.ToDateTime(date2).AddDays(1).ToString("yyyy/MM/dd");
            if (crdate2 != "")
                crdate2 = Convert.ToDateTime(crdate2).AddDays(1).ToString("yyyy/MM/dd");

            DataTable dtOc = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getOcStatus(source_type, user_id, cp_state, mo_group
                , crdate1, crdate2, crby, date1, date2, mo1, mo2, brand1, brand2, cust1, cust2,own1,own2, showapart);
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

        }

        protected bool validData()
        {
            bool result = true;
            StrHelper StrHlp = new StrHelper();
            if (orderDateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(orderDateStart.Value.Trim()) == false)
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('訂單日期格式不正確!');", true);
                //cls.clsPublic.WebMessageBox(this.Page, "訂單日期格式錯誤!");
                orderDateStart.Focus();
                result = false;
            }
            else
            {
                if (orderDateEnd.Value.Trim() != "" && StrHlp.CheckDateFormat(orderDateEnd.Value.Trim()) == false)
                {
                    StrHlp.WebMessageBox(this.Page, "訂單日期格式錯誤!");
                    orderDateEnd.Focus();
                    result = false;
                }
            }

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