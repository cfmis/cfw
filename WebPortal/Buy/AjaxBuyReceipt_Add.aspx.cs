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

public partial class Buy_AjaxBuyReceipt_Add : System.Web.UI.Page
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
        string str1 = Request.QueryString["ReceiptOrderDate"].ToString();
        string str2 = Request.QueryString["StoreHouseID"].ToString();
        string str3 = Request.QueryString["HouseDetailID"].ToString();
        string str4 = Request.QueryString["BuyOrderID"].ToString();
        string str5 = Request.QueryString["Identitys"].ToString();
        string str6 = Request.QueryString["TradeDate"].ToString();
        string str7 = Request.QueryString["Description"].ToString();

        BuyReceipt b = new BuyReceipt();
        b.BuyOrderID = str4;
        b.Description = str7;
        b.HouseDetailID = int.Parse(str3);
        b.Identitys = int.Parse(str5);
        b.ReceiptOrderDate = str1;
        b.ReceiptOrderID = str0;
        b.StoreHouseID = int.Parse(str2);
        b.TradeDate = str6;
        b.UserName = "huhai123";
        if (Leyp.SQLServerDAL.Buy.Factory.getBuyReceiptDAL().insertNewEntity(b))
        {
            Response.Write("0");
            Response.End();
        }
        else
        {
            Response.Write("1");
            Response.End();
        }


    
    }
}
