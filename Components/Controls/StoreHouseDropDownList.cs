using System;
using System.IO;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Configuration;
using Leyp.Model;

namespace Leyp.Components.Controls
{
    public class StoreHouseDropDownList : DropDownList
    {
       public StoreHouseDropDownList()
       {
           this.Items.Add(new ListItem("请选择库房", ""));
           foreach (StoreHouse t in Leyp.SQLServerDAL.Factory.getStoreHouseDAL().getAllStoreHouse())
           {
               this.Items.Add(new ListItem(t.HouseName, t.HouseID.ToString()));
           }
       }

    }
}
