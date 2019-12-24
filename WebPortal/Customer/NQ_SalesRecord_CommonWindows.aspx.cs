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

public partial class Customer_NQ_SalesRecord_CommonWindows : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string SalesOrderID = Request.QueryString["SalesOrderID"].ToString();
        this.SubFrmSrc.Text = "SalesRecord_Add.aspx?SalesOrderID=" + SalesOrderID + "";
        this.Title = "填写顾客信息";
    }
}
