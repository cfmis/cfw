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
using System.Collections.Generic;

public partial class Stock_Detop_Select_Window : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        string HouseID = GridView1.DataKeys[e.RowIndex]["HouseID"].ToString();
        string ID = GridView1.DataKeys[e.RowIndex]["ID"].ToString();
        Jscript.CloseWindowReturnValues(HouseID + "$$$" + ID);
        return;

    }
    protected void StoreHouse_SelectedIndexChanged(object sender, EventArgs e)
    {
        string str = StoreHouse.SelectedValue.ToString();
        if (str.Equals("") || str == null)
        {
            return;
        }
        else
        {
            List<StoreHouseDetail> list = new List<StoreHouseDetail>();
            list = Leyp.SQLServerDAL.Factory.getStoreHouseDetailDAL().getListByHouseID(int.Parse(str));
            GridView1.DataSource = list;
            GridView1.DataBind();
        
        }

    }
   
}
