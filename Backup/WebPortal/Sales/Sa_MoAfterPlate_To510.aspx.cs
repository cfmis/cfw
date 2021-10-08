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
    public partial class Sa_MoAfterPlate_To510 : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        //private string user_id = DBUtility.user_id;
        private string within_code = DBUtility.within_code;
        /*保存当前要显示的页码,初始化为1*/
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
            txtDep.Text = "501";
            dateStart.Value = System.DateTime.Now.ToString("yyyy/MM/dd");
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

            try
            {
                /*实例化分页数据源*/
                System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
                /*建立业务层对象，执行查询，将记录集绑定到分页数据源上*/
                //HourseBLL hourseBll = new HourseBLL();
                //ps.DataSource = hourseBll.QueryHourseInfo(this.leixing.SelectedValue, xiaoqu.Text, lowprice.Text, highprice.Text).Tables[0].DefaultView;


                string dat1, dat2;
                string fdep;
                int type = 1;//從外發加工單中提取
                int no_set_oil = 0;
                dat1 = dateStart.Value;
                dat2 = Convert.ToDateTime(dateEnd.Value).AddDays(1).ToString("yyyy/MM/dd");
                fdep = txtDep.Text;
                if (chkAfter501.Checked == true)//電鍍部已申請大通，但噴油未申請的記錄
                    no_set_oil = 1;
                string strSql = "usp_MoAfterPlate_To510";
                SqlParameter[] parameters = {new SqlParameter("@type", type)
                        ,new SqlParameter("@no_set_oil", no_set_oil)
                        ,new SqlParameter("@fdep", fdep)
                        ,new SqlParameter("@dat1", dat1)
                        ,new SqlParameter("@dat2", dat2)
                        };


                DataTable dtTranRec = sh.ExecuteProcedure(strSql, parameters);

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
                this.rptDetail.DataSource = ps;
                //this.hourseDataList.DataKeyField = "hourseId";
                this.rptDetail.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }

        }

        protected bool validData()
        {
            bool result = true;

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