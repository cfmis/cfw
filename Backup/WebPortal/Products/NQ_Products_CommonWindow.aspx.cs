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
using System.Collections.Generic;
using Leyp.Model;
using Leyp.Model.View;

public partial class Products_NQ_Products_CommonWindow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        this.SubFrmSrc.Text = "NQ_Select_Products_Window.aspx";
        this.Title = "选择商品";
    }
}
