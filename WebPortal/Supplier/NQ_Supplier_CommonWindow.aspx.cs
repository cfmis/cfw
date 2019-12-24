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

public partial class Supplier_NQ_Supplier_CommonWindow : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        this.SubFrmSrc.Text = "NQ_Select_Supplier_Window.aspx";
        this.Title = "选择供应商";
    }
}
