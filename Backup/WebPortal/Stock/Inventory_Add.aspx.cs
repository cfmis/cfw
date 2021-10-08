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
using Leyp.Components.Module.Stock;
using Leyp.Components;
using Leyp.Model.Stock;

public partial class Stock_Inventory_Add : InventoryModule
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
        }

    }

    public void init()
    {
        object action = Request.Form["action"];
        if (action == null)
        {
            InventoryID.Text = StrHelper.GetRamCode();
            CreateDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

        }
        else 
        {
            string str0 = Request.Form["InventoryID"].ToString();
            string str1 = Request.Form["CreateDate"].ToString();
            string str2 = Request.Form["StoreHouseID"].ToString();
            string str3 = Request.Form["HouseDetailID"].ToString();
            string str4 = Request.Form["ProductsID"].ToString();
            string str5 = Request.Form["RealityNum"].ToString();
            string str6 = Request.Form["BillNum"].ToString();
            string str7 = Request.Form["AdjustNum"].ToString();
            string str8 = Request.Form["Operator"].ToString();
            string str9 = Request.Form["TradeDate"].ToString();
            string str10 = Request.Form["Description"].ToString();

            Inventory iv = new Inventory();
            iv.InventoryID = str0;
            iv.CreateDate = str1;
            iv.StoreHouseID = int.Parse(str2);
            iv.HouseDetailID = int.Parse(str3);
            iv.ProductsID = int.Parse(str4);
            iv.RealityNum = int.Parse(str5);
            iv.BillNum = int.Parse(str6);
            iv.AdjustNum = int.Parse(str7);
            iv.Operator = str8;
            iv.TradeDate = str9;
            iv.Description = str10;
            iv.UserName = getUserName();
            Leyp.SQLServerDAL.Stock.Factory.getInventoryDAL().insertNewEntity(iv);
            Response.Write("0");
            Response.End();
        }
    
    }
}
