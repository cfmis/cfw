using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model.Sales;
using Leyp.Components.Module.Sales;

public partial class Sales_AjaxSalesOutLoad : SalesOutModule
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

        string action = Request.Form["action"].ToString();
        if (action.Equals("add"))
        {
            string str0=Request.Form["SalesOutID"].ToString();
            string str1=Request.Form["SalesOrderID"].ToString();
            string str2=Request.Form["CreateDate"].ToString();
            string str3=Request.Form["Consignee"].ToString();
           // string str4=Request.Form["TradePlace"].ToString();
            string str5 = Request.Form["DeliveryID"].ToString();
            string str6 = Request.Form["AccountsID"].ToString();

            string str7=Request.Form["TradeDate"].ToString();
            string str8=Request.Form["Deposits"].ToString();
            string str9=Request.Form["Description"].ToString();
            SalesOut s = new SalesOut();
            s.Consignee = str3;
            s.CreateDate = str2;
           // s.TradePlace = str4;
            s.DeliveryID = int.Parse(str5);
            s.TradeDate = str7;
            s.Deposits = float.Parse(str8);
            s.Description = str9;
            s.UserName = getUserName();
            s.State = 0;
            s.SalesOutID = str0;
            s.SalesOrderID = str1;
            s.AccountsID = str6;
            
            Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().insertNewEntity(s);
            Response.Write("00");
            Response.End();


        }
        else if (action.Equals("delete"))
        {
            string str0 = Request.Form["SalesOutID"].ToString();
            VSalesOut v = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().getByID(str0);
            if(v.UserName.Equals(getUserName()))
            { 

              Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().deleteEitity(str0);
              Response.Write("00");
              Response.End();


            }
        }
        else if (action.Equals("testAdd"))//临时添加详细
        {
            string str0 = Request.Form["SalesOutID"].ToString();
            string str1 = Request.Form["SalesOrderID"].ToString();
            Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().insertSalesDetailFrist(str1, str0);
            Response.Write("00");
            Response.End();

        }
        
    }
}
