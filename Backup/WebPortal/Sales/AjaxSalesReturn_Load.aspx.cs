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

public partial class Sales_AjaxSalesReturn_Load : SalesReturnModule
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
            string str0 = Request.Form["SalesReturnID"].ToString();
            string str1 = Request.Form["SalesOutID"].ToString();
            string str2 = Request.Form["CreateDate"].ToString();
            string str3 = Request.Form["ReturnType"].ToString();
            string str5 = Request.Form["StoreHouseID"].ToString();
            string str6 = Request.Form["HouseDetailID"].ToString();
            string str7 = Request.Form["TradeDate"].ToString();
            string str8 = Request.Form["Deposits"].ToString();
            string str9 = Request.Form["Description"].ToString();
            SalesReturn s = new SalesReturn();
            s.ReturnType = str3;
            s.CreateDate = str2;
            s.StoreHouseID = int.Parse(str5);
            s.HouseDetailID = int.Parse(str6);
            s.TradeDate = str7;
            s.Deposits = float.Parse(str8);
            s.Description = str9;
            s.UserName = getUserName();
            s.State = 0;
            s.SalesOutID = str1;
            s.SalesReturnID= str0;
            Leyp.SQLServerDAL.Sales.Factory.getSalesReturnDAL().insertNewEntity(s);
            Response.Write("00");
            Response.End();


        }
        else if (action.Equals("delete"))
        {
            string str0 = Request.Form["SalesReturnID"].ToString();
            VSalesReturn v = new VSalesReturn();
            v = Leyp.SQLServerDAL.Sales.Factory.getSalesReturnDAL().getByID(str0);
            if (v.UserName.Equals(getUserName()))
            {

                Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().deleteEitity(str0);
                Response.Write("00");
                Response.End();


            }
        }
    }
}
