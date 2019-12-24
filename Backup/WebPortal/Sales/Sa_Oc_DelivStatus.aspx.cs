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
    public partial class Sa_Oc_DelivStatus : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string within_code = DBUtility.within_code;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {

                InitControler();

            }

        }
        protected void InitControler()
        {
            string strSql;

            strSql = "Select formname,show_name from v_dict_group where formname=" + "'" + "Mo_Group" + "'" +
                    " AND language_id =" + "'" + lang_id + "'" + " Order By tb_col_sort";

            DataTable tbMo_group = sh.ExecuteSqlReturnDataTable(strSql);
            dlMo_group.DataSource = tbMo_group.DefaultView;
            dlMo_group.DataTextField = "show_name";
            dlMo_group.DataValueField = "show_name";
            dlMo_group.DataBind();

            createDateStart.Value = System.DateTime.Now.ToString("yyyy/MM/dd");
            createDateEnd.Value = createDateStart.Value;

            dlShowPeriod.SelectedIndex = 2;

        }

        protected void btnFind_Click(object sender, EventArgs e)
        {

            LoadData();
        }


        protected void LoadData()
        {
            if (!validData())
                return;
            string dat1, dat2;
            string crdat1, crdat2;
            string mo_group = "";
            string user_id = "admin";
            int period_type = dlShowPeriod.SelectedIndex;//過期類型報表
            int f_type, mo_group_select;


            crdat1 = createDateStart.Value;
            crdat2 = createDateEnd.Value;

            dat1 = orderDateStart.Value;
            dat2 = orderDateEnd.Value;


            if (dat2 != "")
                dat2 = Convert.ToDateTime(dat2).AddDays(1).ToString("yyyy/MM/dd");

            if (crdat2 != "")
                crdat2 = Convert.ToDateTime(crdat2).AddDays(1).ToString("yyyy/MM/dd");

            
            mo_group_select = dlMo_group.SelectedIndex;

            mo_group = "ALL";

            f_type = dlShowPeriod.SelectedIndex;//訂單發貨：全部，已發貨，未發貨

            if (mo_group_select == -1 || dlMo_group.SelectedItem.ToString() == "" || mo_group_select == 0)
                mo_group = "ALL";
            else
            {
                if (mo_group_select <= 27)
                    mo_group = Convert.ToChar(64 + mo_group_select).ToString();
                else
                    if (mo_group_select == 28)//PDD
                        mo_group = "PDD";
            }
            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
            string strSql = "usp_OcDelivStatus1";
            SqlParameter[] parameters = {new SqlParameter("@f_type", f_type)
                                        ,new SqlParameter("@lang", lang_id)
                                        ,new SqlParameter("@mo_group", mo_group)
                                        ,new SqlParameter("@usr", user_id)
                                        ,new SqlParameter("@crdat1", crdat1), new SqlParameter("@crdat2", crdat2)
                                        ,new SqlParameter("@brand1", txtBrand.Text)
                                        ,new SqlParameter("@dat1", dat1), new SqlParameter("@dat2", dat2)
                                        ,new SqlParameter("@cust1", txtCust.Text)
                                        ,new SqlParameter("@po1", txtPoNo.Text)
                                        ,new SqlParameter("@mo1", txtMo1.Text)
                                        ,new SqlParameter("@mo2", txtMo2.Text)
                                        };

            DataTable dtOc = sh.ExecuteProcedure(strSql, parameters);
            ps.DataSource = dtOc.DefaultView;
            this.wpDetail.DataSource = ps;
            this.wpDetail.DataBind();

        }

        protected bool validData()
        {
            bool result = true;
            if (orderDateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(orderDateStart.Value.Trim()) == false)
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('訂單日期格式不正確!');", true);
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

            if (createDateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(createDateStart.Value.Trim()) == false)
            {
                StrHlp.WebMessageBox(this.Page, "開單日期格式錯誤!");
                createDateStart.Focus();
                result = false;
            }
            else
            {
                if (createDateEnd.Value.Trim() != "" && StrHlp.CheckDateFormat(createDateEnd.Value.Trim()) == false)
                {
                    StrHlp.WebMessageBox(this.Page, "開單日期格式錯誤!");
                    createDateEnd.Focus();
                    result = false;
                }
            }
            return result;
        }

    }
}