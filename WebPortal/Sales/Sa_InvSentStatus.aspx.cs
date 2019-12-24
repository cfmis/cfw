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
    public partial class Sa_InvSentStatus : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = Base.lang_id;
        //private string user_id = DBUtility.user_id;
        private string within_code = Base.within_code;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {

                InitControler();

            }

        }

        protected void InitControler()
        {

            dateStart.Value = System.DateTime.Now.ToString("yyyy/MM/dd");
            dateEnd.Value = dateStart.Value;

            dlShowDeliv.SelectedIndex = 2;

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

            string inv1 = txtInv1.Text;
            string inv2 = txtInv2.Text;

            int tr_type = dlShowDeliv.SelectedIndex;//過期類型報表

            dat1 = dateStart.Value;
            dat2 = dateEnd.Value;


            if (dat2 != "")
                dat2 = Convert.ToDateTime(dat2).AddDays(1).ToString("yyyy/MM/dd");

            if (dateStart.Value == "" && txtMo1.Text == "" && txtMo2.Text == ""
                && txtCust.Text == "" && txtInv1.Text == "" && txtInv2.Text == "")
            {
                inv1 = "ZZZZZZZZZ";
                inv2 = "ZZZZZZZZZ";
            }

            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
            string strSql = "usp_ShowInvStatus";
            SqlParameter[] parameters = {new SqlParameter("@tr_type", tr_type)
                                        ,new SqlParameter("@dat1", dat1), new SqlParameter("@dat2", dat2)
                                        ,new SqlParameter("@mo1", txtMo1.Text)
                                        ,new SqlParameter("@mo2", txtMo2.Text)
                                        ,new SqlParameter("@inv1", inv1)
                                        ,new SqlParameter("@inv2", inv2)
                                        ,new SqlParameter("@cust", txtCust.Text)
                                        };


            DataTable dtInv = sh.ExecuteProcedure(strSql, parameters);
            ps.DataSource = dtInv.DefaultView;
            this.wpDetail.DataSource = ps;
            this.wpDetail.DataBind();

            if (dtInv.Rows.Count > 0)
                lblShowInfo.Text = dlShowDeliv.SelectedValue+"  記錄數：" + dtInv.Rows.Count.ToString();
            else
                lblShowInfo.Text = "已開發票，未送貨記錄。";
        }

        protected bool validData()
        {
            bool result = true;
            if (dateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(dateStart.Value.Trim()) == false)
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('發票日期格式不正確!');", true);
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

            return result;
        }


    }
}