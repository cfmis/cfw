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
using Leyp.SQLServerDAL;

namespace Leyp.Components.Controls
{
    public class ProductsBrandDropDownList : DropDownList 
    {
       public ProductsBrandDropDownList()
       {
           this.Items.Add(new ListItem("请选择", ""));
           foreach (ProductsBrand t in Leyp.SQLServerDAL.Factory.getProductsBrandDAL().getAllProductsBrand())
           {
               if (t.State.Equals("Y"))
               {
                   this.Items.Add(new ListItem(t.BrandName, t.BrandID.ToString()));
               }
           }
       }
    }
}
