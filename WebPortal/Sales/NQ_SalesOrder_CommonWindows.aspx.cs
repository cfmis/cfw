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

public partial class Sales_NQ_SalesOrder_CommonWindows : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.SubFrmSrc.Text = "NQ_Select_SalesOrderWindows.aspx";
        this.Title = "选择销售订单";
    }
}
