using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Leyp.Components.Module;

namespace WebPortal.Sales
{
    public partial class Sa_Oc_NoCompleteOc : BasePage//System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                InitControler();

            }
        }
        protected void InitControler()
        {

            txtDate_from.Value = System.DateTime.Now.AddDays(-1).ToString("yyyy/MM/dd");
            txtDate_to.Value = txtDate_from.Value;
        }


    }
}