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
    public class ShopDropDownList : DropDownList 
    {

        public ShopDropDownList()
       {
           this.Items.Add(new ListItem("请选择", "0"));
           foreach (Shop t in Leyp.SQLServerDAL.Factory.getShopDAL().getAllShop())
           {
               
                   this.Items.Add(new ListItem(t.ShopName, t.ShopID.ToString()));
               
           }
       
       }
    }
}
