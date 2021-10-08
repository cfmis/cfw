using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model;
using Leyp.Components;
using Leyp.Components.Module.Stock;
public partial class Stock_Stock_StockView : StockViewModule
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
        StoreHouseInit();
        int id = int.Parse(StoreHouseDropDownList.SelectedValue.ToString());
        SubareaNameInit(id);
      

       // StoreHouseInit();
        //DataSet ds = Leyp.SQLServerDAL.Factory.getProductsStockDAL().getDataSetByHouseDetailID(0);
    }

    protected void StoreHouseInit() {
        List<StoreHouse> list = new List<StoreHouse>();
        list = Leyp.SQLServerDAL.Factory.getStoreHouseDAL().getAllStoreHouse();
        StoreHouseDropDownList.DataTextField = "HouseName";
        StoreHouseDropDownList.DataValueField = "HouseID";
        StoreHouseDropDownList.DataSource = list;
        StoreHouseDropDownList.DataBind();
    }

    protected void SubareaNameInit(int id)
    {
        List<StoreHouseDetail> list0 = new List<StoreHouseDetail>();
        list0 = Leyp.SQLServerDAL.Factory.getStoreHouseDetailDAL().getListByHouseID(id);
        SubareaNameDropDownList.DataTextField = "SubareaName";
        SubareaNameDropDownList.DataValueField = "ID";
        SubareaNameDropDownList.DataSource = list0;
        SubareaNameDropDownList.DataBind();
        if (list0.Count < 1)
        {
            SubareaNameDropDownList.Items.Add(new ListItem("请选择","0" ));
        
        }

    }

    protected void DataSetBand()
    {
        int ids = int.Parse(SubareaNameDropDownList.SelectedValue.ToString());
        DataSet ds = new DataSet();

        ds = Leyp.SQLServerDAL.Factory.getProductsStockDAL().getDataSetByHouseDetailID(ids);
        OrderList.DataSource = ds.Tables["dd"].DefaultView;
        OrderList.DataBind();
    
    }

    protected void Select_Click(object sender, EventArgs e)
    {
        DataSetBand();
    }


    protected void StoreHouseDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int id0 = int.Parse(StoreHouseDropDownList.SelectedValue.ToString());
            SubareaNameInit(id0);
        }
        catch
        {
            Jscript.AjaxAlert(this, "请选择库区");
            return;
        }

    }
}
