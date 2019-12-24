using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebPortal.Products
{
    public partial class Pd_Mo_Plan_Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //txtPrd_dep.Value = Request.QueryString["prd_dep"];
            //txtDep_cdesc.Value = Request.QueryString["dep_cdesc"];
            txtPrd_mo.Value = Request.QueryString["prd_mo"];
            txtPrd_item.Value = Request.QueryString["prd_item"];
            //txtNow_date.Value = Request.QueryString["now_date"];

        }
    }
}