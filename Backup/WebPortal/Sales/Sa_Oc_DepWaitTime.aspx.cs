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
    public partial class Sa_Oc_DepWaitTime : BasePage//System.Web.UI.Page
    {
        private string lang_id = Base.lang_id;
        
        private string within_code = Base.within_code;
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
            string user_id = "";//Base.user_id;
            user_id = getUserName();
            dateStart.Value = System.DateTime.Now.AddDays(-1).ToString("yyyy/MM/dd");
            dateEnd.Value = dateStart.Value;


        }
        protected void Btn_Query_Click(object sender, EventArgs e)
        {
            loadData();
        }

        protected void loadData()
        {
            if (!validData())
                return;

                /*实例化分页数据源*/
                System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
                /*建立业务层对象，执行查询，将记录集绑定到分页数据源上*/
                //HourseBLL hourseBll = new HourseBLL();
                //ps.DataSource = hourseBll.QueryHourseInfo(this.leixing.SelectedValue, xiaoqu.Text, lowprice.Text, highprice.Text).Tables[0].DefaultView;


                string dat1, dat2;
                string fdep;

                dat1 = dateStart.Value;
                dat2 = Convert.ToDateTime(dateEnd.Value).AddDays(1).ToString("yyyy/MM/dd");
                fdep = txtDep.Text; 


                DataTable dtTranRec = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getOcDepWaitTime(fdep, dat1, dat2);
                ps.DataSource = dtTranRec.DefaultView;
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

                this.wpDetail.DataSource = ps;
                //this.hourseDataList.DataKeyField = "hourseId";
                this.wpDetail.DataBind();
        }

        protected bool validData()
        {
            bool result = true;
            StrHelper StrHlp = new StrHelper();
            if (txtDep.Text == "")
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('查詢明細表時，部門編號不能為空!');", true);
                txtDep.Focus();
                result = false;
            }

            if (dateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(dateStart.Value.Trim()) == false)
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('批準日期格式不正確!');", true);
                //cls.clsPublic.WebMessageBox(this.Page, "訂單日期格式錯誤!");
                dateStart.Focus();
                result = false;
            }
            else
            {
                if (dateEnd.Value.Trim() != "" && StrHlp.CheckDateFormat(dateEnd.Value.Trim()) == false)
                {
                    StrHlp.WebMessageBox(this.Page, "批準日期格式錯誤!");
                    dateEnd.Focus();
                    result = false;
                }
            }


            return result;
        }
    }
}