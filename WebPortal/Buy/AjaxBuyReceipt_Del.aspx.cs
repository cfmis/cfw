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

public partial class Buy_AjaxBuyReceipt_Del : System.Web.UI.Page
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

        string str0 = Request.QueryString["ReceiptOrderID"].ToString();
        string username = "huhai123";///////////////////////////////////////////////？？？

        BuyReceipt b = new BuyReceipt();
        b = Leyp.SQLServerDAL.Buy.Factory.getBuyReceiptDAL().getByID(str0);
        if (b.UserName.Equals(username))
        {
            if (Leyp.SQLServerDAL.Buy.Factory.getBuyReceiptDAL().deleteEitity(str0))
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
