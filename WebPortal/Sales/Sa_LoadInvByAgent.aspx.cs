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
    public partial class Sa_LoadInvByAgent : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = Base.lang_id;
        //private string user_id = DBUtility.user_id;
        private string within_code = Base.within_code;
        private bool start_search = false;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {

                InitControler();

            }
            else
                start_search = true;
            if (start_search == true)
            {
                BindData();
            }
        }

        protected void InitControler()
        {

            dateStart.Value = System.DateTime.Now.AddDays(-6).ToString("yyyy/MM/dd");
            dateEnd.Value = System.DateTime.Now.ToString("yyyy/MM/dd");

            txtAgent1.Text = "G009";
            txtAgent2.Text = "G009";
        }


        protected void btnFind_Click(object sender, EventArgs e)
        {
            BindData();
        }

        protected void BindData()
        {

            if (!validData())
                return;
            string dat1, dat2;
            string vatdat1, vatdat2;
            dat1 = dateStart.Value;
            dat2 = dateEnd.Value;
            vatdat1 = vatDateStart.Value;
            vatdat2 = vatDateEnd.Value;
            string Agent1 = txtAgent1.Text;
            string Agent2 = txtAgent2.Text;
            int doc_type = 1;
            if (chkShowVat.Checked == true)
                doc_type = 2;
            if (dat2 != "")
                dat2 = Convert.ToDateTime(dat2).AddDays(1).ToString("yyyy/MM/dd");
            if (vatdat2 != "")
                vatdat2 = Convert.ToDateTime(vatdat2).AddDays(1).ToString("yyyy/MM/dd");
            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
            string strSql = "usp_LoadInvByAgent";
            SqlParameter[] parameters = {new SqlParameter("@doc_type", doc_type)
                                        ,new SqlParameter("@brand1", txtBrand1.Text),new SqlParameter("@brand2", txtBrand2.Text)
                                        ,new SqlParameter("@Agent1", Agent1),new SqlParameter("@Agent2", Agent2)
                                        ,new SqlParameter("@dat1", dat1), new SqlParameter("@dat2", dat2)
                                        ,new SqlParameter("@vatdat1", vatdat1), new SqlParameter("@vatdat2", vatdat2)
                                        };


            DataTable dtStTr = sh.ExecuteProcedure(strSql, parameters);
            ps.DataSource = dtStTr.DefaultView;
            this.wpDetail.DataSource = ps;
            this.wpDetail.DataBind();

        }

        protected bool validData()
        {
            bool result = true;
            if (dateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(dateStart.Value.Trim()) == false)
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('發票日期格式不正確!');", true);
                //cls.clsPublic.WebMessageBox(this.Page, "訂單日期格式錯誤!");
                dateStart.Focus();
                result = false;
            }
            else
            {
                if (dateEnd.Value.Trim() != "" && StrHlp.CheckDateFormat(dateEnd.Value.Trim()) == false)
                {
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('發票日期格式不正確!');", true);
                    dateEnd.Focus();
                    result = false;
                }
            }
            //if (txtAgent1.Text == "" && txtAgent2.Text == "")
            //{
            //    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('請輸入洋行編號!');", true);
            //    txtAgent1.Focus();
            //    result = false;
            //}
            return result;
        }


    }
}