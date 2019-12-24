using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Components;
using Leyp.Model.Buy;
using Leyp.Components.Module.Buy;

public partial class Buy_BuyReceip_Add : ModuleBuyReceip
{
    protected void Page_Load(object sender, EventArgs e)
    {

            init();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);  
        

    }


    protected void init()
    {

        ReceiptOrderID.Text = "CR" + StrHelper.GetRamCode();
        ReceiptOrderDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

    }

}
