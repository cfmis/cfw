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

public partial class User_NQ_CheckUserName : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            checkUserName();
        }

    }

    protected void checkUserName()
    {
        string UserName = Request.QueryString["UserName"].ToString();
        if (UserName == null)
        {
            Response.Write(" <font color=\"#FF0000\" size=\"+2\">输入有误！</font>");
        }
        else if (UserName.Length < 6)
        {
            Response.Write("<font color=\"#FF0000\" size=\"+2\">输入有误！</font>");

        }

        else if (Leyp.SQLServerDAL.Factory.getUserDAL().isExistsUserName(UserName))
        {
            Response.Write("<font color=\"#FF0000\" size=\"+2\">用户名已经存在！</font>");
        }
        else
        {
            Response.Write("<font color=\"#009900\" size=\"+2\">用户名可以使用！</font>");
        }
    }
}
