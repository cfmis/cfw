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
    public partial class Sa_Mo_View_Test : BasePage//System.Web.UI.Page
    {
        private string get_mo_id = "";
        private StrHelper StrHlp = new StrHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["to_mo_id"] != null)
                {
                    get_mo_id = Request.QueryString["to_mo_id"];
                    txtMo.Value = get_mo_id;
                }
            }
            if (txtMo.Value != "")
                DataBind();
        }

        protected void btnFind_Click(object sender, EventArgs e)
        {
            if (txtMo.Value == "")
            {
                StrHlp.WebMessageBox(this.Page, "開單日期格式錯誤!");
                return;
            }
        }
        private void DataBind()
        {
            this.rpMoTestDetail.DataSource = null;
            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
            DataTable dtMoTest = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getMoTest(txtMo.Value);

            if (dtMoTest.Rows.Count > 0)
            {
                txtId.Value = dtMoTest.Rows[0]["customer_test_id"].ToString();
                txtBrand.Value = dtMoTest.Rows[0]["brand_cdesc"].ToString();
                txtCust_goods.Value = dtMoTest.Rows[0]["customer_goods"].ToString();
                txtCust_color.Value = dtMoTest.Rows[0]["customer_color_id"].ToString();
                txtColor_cdesc.Value = dtMoTest.Rows[0]["color_cdesc"].ToString();
                txtDatum_cdesc.Value = dtMoTest.Rows[0]["datum_cdesc"].ToString();
                txtPrd_cdesc.Value = dtMoTest.Rows[0]["prd_cdesc"].ToString();
                txtArt.Value = dtMoTest.Rows[0]["art"].ToString();
                txtRemark.Value = dtMoTest.Rows[0]["h_remark"].ToString();

                ps.DataSource = dtMoTest.DefaultView;
                ps.AllowPaging = true;

                this.rpMoTestDetail.DataSource = ps;
                this.rpMoTestDetail.DataBind();
            }
        }
        private void CleanText()
        {
            txtId.Value = "";
        }
    }
}