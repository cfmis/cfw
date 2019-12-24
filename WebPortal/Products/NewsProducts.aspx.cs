using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model.View;
using Leyp.Components.Module;

public partial class Products_NewsProducts : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        List<VProducts> list = new List<VProducts>();
        list = Leyp.SQLServerDAL.Factory.getVProductsDAL().getNewsProducts();
        SearchResult.DataSource = list;
        SearchResult.DataBind();

    }
}
