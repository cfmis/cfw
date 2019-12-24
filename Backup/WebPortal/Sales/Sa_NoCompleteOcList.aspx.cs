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
    public partial class Sa_NoCompleteOcList : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private clsPublic clsPublic = new clsPublic();
        private StrHelper StrHlp = new StrHelper();
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
            strSql = "select group_id,group_desc from bs_mo_group order by group_id ";
            DataTable tbMo_group = sh.ExecuteSqlReturnDataTable(strSql);
            dlMo_group.DataSource = tbMo_group.DefaultView;
            dlMo_group.DataTextField = "group_desc";
            dlMo_group.DataValueField = "group_id";
            dlMo_group.DataBind();

            crDateStart.Value = System.DateTime.Now.ToString("yyyy/MM/dd");
            crDateEnd.Value = crDateStart.Value;

            dlShowPeriod.SelectedIndex = 1;

            lblShowPeriodInfo.Text = "(貨未到包裝部。若香港有存貨，N/W/V單若已入成品倉，都當作已完成；R單已交包裝部(因為不用回港))";
        }

        protected void btnFind_Click(object sender, EventArgs e)
        {

            LoadData();
        }

        protected void LoadData()
        {
            if (!validData())
                return;
            string user_id = "admin";// getUserName();
            string mo1 = txtMo1.Text.Trim().ToUpper();
            string mo2 = txtMo2.Text.Trim().ToUpper();
            string date1, date2;
            string crdate1, crdate2;
            string cs_date1, cs_date2;
            string crby = txtCrBy.Text;
            string mo_group = "";
            string brand1;
            string cust1;
            string agent1;
            string only_apart = "";
            int period_type = dlShowPeriod.SelectedIndex;//過期類型報表
            brand1 = txtBrand.Text;
            cust1 = txtCust.Text;
            date1 = orderDateStart.Value;
            date2 = orderDateEnd.Value;
            crdate1 = crDateStart.Value;
            crdate2 = crDateEnd.Value;
            cs_date1 = custReqDateStart.Value;
            cs_date2 = custReqDateEnd.Value;
            agent1 = txtAgent1.Text;
            if (chkShowA_part.Checked == true)
                only_apart = "1";
            if (dlMo_group.SelectedIndex > 0)
                mo_group = dlMo_group.SelectedValue.ToString();

            if (date2 != "")
                date2 = Convert.ToDateTime(date2).AddDays(1).ToString("yyyy/MM/dd");
            if (crdate2 != "")
                crdate2 = Convert.ToDateTime(crdate2).AddDays(1).ToString("yyyy/MM/dd");
            if (cs_date2 != "")
                cs_date2 = Convert.ToDateTime(cs_date2).AddDays(1).ToString("yyyy/MM/dd");
            string strSql = "usp_ShowOcList_prd";
            SqlParameter[] parameters = {new SqlParameter("@user_id", user_id)
                                        ,new SqlParameter("@period_type", period_type)
                                        ,new SqlParameter("@mo_group", mo_group)
                                        ,new SqlParameter("@only_apart", only_apart)
                                        ,new SqlParameter("@crdat1", crdate1), new SqlParameter("@crdat2", crdate2)
                                        ,new SqlParameter("@dat1", date1), new SqlParameter("@dat2", date2)
                                        ,new SqlParameter("@cs_dat1", cs_date1), new SqlParameter("@cs_dat2", cs_date2)
                                        ,new SqlParameter("@crby", crby)
                                        , new SqlParameter("@mo1", mo1), new SqlParameter("@mo2", mo2)
                                        , new SqlParameter("@brand1", brand1)
                                        , new SqlParameter("@cust1", cust1)
                                        , new SqlParameter("@agent1", agent1)
                                        , new SqlParameter("@cust_goods", txtCust_Goods.Text)
                                        , new SqlParameter("@cust_color", txtCust_Color.Text)
                                        , new SqlParameter("@cust_style", txtCust_Style.Text)
                                        , new SqlParameter("@season", txtSeason.Text)
                                        , new SqlParameter("@mat_code", txtMat.Text)
                                        , new SqlParameter("@prod_code", txtProd.Text)
                                        , new SqlParameter("@art_code", txtArt.Text)
                                        , new SqlParameter("@size_code", txtSize.Text)
                                        , new SqlParameter("@clr_code", txtClr.Text)
                                        , new SqlParameter("@pono", txtPoNo.Text)
                                        , new SqlParameter("@ocno", txtOcNo.Text)
                                        , new SqlParameter("@goods_id", txtGoods_id.Text)
                                        };

            DataTable dtOc = sh.ExecuteProcedure(strSql, parameters);

            BindData();

            //if (dtOc.Rows.Count == 0)
            //    dtOc.Rows.Add();
            //gvDetails.DataSource = dtOc.DefaultView;
            //gvDetails.DataBind();

        }

        protected void BindData()
        {
            string user_id = "admin";// getUserName();
            string strSql = "select * From rpt_showoclist_prd where within_code='0000'";// 
            if (user_id != "")
                strSql += " AND userid='" + user_id + "'";
            strSql += " ORDER BY create_date,cs_req_date,mo_id,create_by,period_day Desc";
            DataTable dtOc = sh.ExecuteSqlReturnDataTable(strSql);
            lblShowTotalRec.Text = "記錄數：" + dtOc.Rows.Count.ToString();
            if (dtOc.Rows.Count == 0)
                dtOc.Rows.Add();

            //gvDetails.DataSource = dtOc.DefaultView;
            //gvDetails.DataBind();

            OrderList.DataSource = dtOc.DefaultView;
            OrderList.DataBind();

        }

        protected bool validData()
        {
            bool result = true;
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
            if (custReqDateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(custReqDateStart.Value.Trim()) == false)
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('客人要求交貨期格式不正確!');", true);
                //cls.clsPublic.WebMessageBox(this.Page, "訂單日期格式錯誤!");
                custReqDateStart.Focus();
                result = false;
            }
            else
            {
                if (custReqDateEnd.Value.Trim() != "" && StrHlp.CheckDateFormat(custReqDateEnd.Value.Trim()) == false)
                {
                    StrHlp.WebMessageBox(this.Page, "客人要求交貨期格式錯誤!");
                    custReqDateEnd.Focus();
                    result = false;
                }
            }



            if (crDateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(crDateStart.Value.Trim()) == false)
            {
                StrHlp.WebMessageBox(this.Page, "開單日期格式錯誤!");
                crDateStart.Focus();
                result = false;
            }
            else
            {
                if (crDateEnd.Value.Trim() != "" && StrHlp.CheckDateFormat(crDateEnd.Value.Trim()) == false)
                {
                    StrHlp.WebMessageBox(this.Page, "開單日期格式錯誤!");
                    crDateEnd.Focus();
                    result = false;
                }
            }
            return result;
        }
    }
}