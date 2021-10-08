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
using Leyp.Components.Module.Stock;
using Leyp.Components;

public partial class Stock_OutStock_Add : OutStockModule
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            init();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }


    }
    protected void init()
    {

        OutID.Text = "OT" + StrHelper.GetRamCode();
        CreateDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

    }
}
