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
using Leyp.Model.Sales;
using Leyp.Components.Module.Sales;

public partial class Sales_AjaxSalesDispatch : SalesDispatchModule
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
        if (action.Equals("add"))//添加
        {
            #region 单据添加
            string str0 = Request.Form["SalesOutID"].ToString();
            string str1 = Request.Form["CreateDate"].ToString();
            string str2 = Request.Form["DeliveryType"].ToString();
            string str3 = Request.Form["DeliveryDate"].ToString();
            string str4 = Request.Form["SentDate"].ToString();
            string str5 = Request.Form["Consignor"].ToString();
            string str6 = Request.Form["Description"].ToString();
            string str7 = Request.Form["State"].ToString();

            SalesDispatch d = new SalesDispatch();
            d.Consignor = str5;
            d.CreateDate = str1;
            d.DeliveryDate = str3;
            d.DeliveryType = str2;
            d.Description = str6;
            d.SalesOutID = str0;
            d.SentDate = str4;
            d.State = int.Parse(str7);
            d.UserName = getUserName();

            Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().insertNewEntity(d);
            Response.Write("00");
            Response.End();
            #endregion

        }
        else if (action.Equals("edit"))//加载明细BY  SalesOrderID
        {

            #region 单据修改提交

            string str0 = Request.Form["SalesOutID"].ToString();
            string str2 = Request.Form["DeliveryType"].ToString();
            string str3 = Request.Form["DeliveryDate"].ToString();
            string str4 = Request.Form["SentDate"].ToString();
            string str5 = Request.Form["Consignor"].ToString();
            string str6 = Request.Form["Description"].ToString();
            string str7 = Request.Form["State"].ToString();
            string str8 = Request.Form["DispatchID"].ToString();

            SalesDispatch d = new SalesDispatch();
            d.Consignor = str5;
            d.DeliveryDate = str3;
            d.DeliveryType = str2;
            d.Description = str6;
            d.SentDate = str4;
            d.State = int.Parse(str7);
            d.UserName = getUserName();
            d.DispatchID = int.Parse(str8);
            d.SalesOutID = str0;

            Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().updateEntity(d);
            Response.Write("00");
            Response.End();
            #endregion

        }
        else if (action.Equals("delDetail"))//delete
        {
           
        }

    }


}
