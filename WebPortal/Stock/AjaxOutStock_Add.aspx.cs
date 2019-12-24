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
using Leyp.Model.Stock;
using Leyp.Components.Module.Stock;

public partial class Stock_AjaxOutStock_Add : OutStockModule
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
        string action = Request.QueryString["action"].ToString();
        if (action.Equals("add"))
        {
            string str0 = Request.QueryString["OutID"].ToString();
            string str1 = Request.QueryString["CreateDate"].ToString();
            string str2 = Request.QueryString["StoreHouseID"].ToString();
            string str3 = Request.QueryString["HouseDetailID"].ToString();
            string str4 = Request.QueryString["OutType"].ToString();
            string str5 = Request.QueryString["AlreadyPay"].ToString();
            string str6 = Request.QueryString["TradeDate"].ToString();
            string str7 = Request.QueryString["Description"].ToString();

            OutStock a = new OutStock();
            a.AlreadyPay = float.Parse(str5);
            a.OutID = str0;
            a.OutType = int.Parse(str4);
            a.CreateDate = str1;
            a.Description = str7;
            a.HouseDetailID = int.Parse(str3);
            a.StoreHouseID = int.Parse(str2);
            a.TradeDate = str6;
            a.UserName = getUserName();

            Leyp.SQLServerDAL.Stock.Factory.getOutStockDAL().insertNewEntity(a);
            Response.Write("0");
            Response.End();

        }
        else if (action.Equals("delete"))
        {
            string str0 = Request.QueryString["OutID"].ToString();
            Leyp.SQLServerDAL.Stock.Factory.getOutStockDAL().deleteEitity(str0);
            Response.Write("成功删除单据" + str0);
            Response.End();


        }


    }
}

