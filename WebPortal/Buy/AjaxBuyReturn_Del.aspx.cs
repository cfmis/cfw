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
using Leyp.Model.Buy;
using Leyp.Components.Module.Buy;

public partial class Buy_AjaxBuyReturn_Del : ModuleBuyReturn
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            init();
        }
    }

    protected void init()
    {

        string str0 = Request.QueryString["BuyReturnID"].ToString();
        string username = getUserName();

        VBuyReturn b = new VBuyReturn();
        b = Leyp.SQLServerDAL.Buy.Factory.getBuyReturnDAL().getViewNodeByID(str0);
        if (b.UserName.Equals(username))
        {
            if (Leyp.SQLServerDAL.Buy.Factory.getBuyReturnDAL().deleteEitity(str0))
            {
                Panel1.Visible = true;
            }
            else
            {
                Response.Write("操作失败");
                Response.End();

            }
        }
        else
        {

            Response.Write("操作失败!没有权限");
            Response.End();


        }


    }
}
