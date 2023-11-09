using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Leyp.Components.Module;


namespace WebPortal.Products
{
    public partial class Pd_Mo_Arrange_Imput : BasePage//System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                init();
                //DataSetBand();
            }
        }

        protected void init()
        {

        }

    }
}