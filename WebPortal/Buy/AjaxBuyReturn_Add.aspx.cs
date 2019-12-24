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

public partial class Buy_AjaxBuyReturn_Add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            init();
        }
    }

    //添加采购退货

    protected void init()
    {
        string str0 = Request.QueryString["BuyReturnID"].ToString();
        string str1 = Request.QueryString["BuyReturnDate"].ToString();
        string str2 = Request.QueryString["StoreHouseID"].ToString();
        string str3 = Request.QueryString["HouseDetailID"].ToString();
        string str4 = Request.QueryString["ReceiptOrderID"].ToString();
        string str5 = Request.QueryString["Identitys"].ToString();
        string str6 = Request.QueryString["TradeDate"].ToString();
        string str7 = Request.QueryString["Description"].ToString();

        BuyReturn b = new BuyReturn();
        b.BuyReturnID = str0;
        b.Description = str7;
        b.HouseDetailID = int.Parse(str3);
        b.Identitys = int.Parse(str5);
        b.BuyReturnDate = str1;
        b.ReceiptOrderID = str4;
        b.StoreHouseID = int.Parse(str2);
        b.TradeDate = str6;
        b.UserName = "huhai123";///////////////////////////////////////////////////////////?????????????????
        if (Leyp.SQLServerDAL.Buy.Factory.getBuyReturnDAL().insertNewEntity(b))
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
