using System;
using System.IO;
using System.Drawing;
using System.Collections.Generic;
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
   public class ProductsTypeDropDownList : DropDownList 
    {
       public ProductsTypeDropDownList()
       {
           this.Items.Add(new ListItem("请选择", ""));

           List<ProductsType> list = Leyp.SQLServerDAL.Factory.getProductsTypeDAL().getAllProductsType();
           foreach (ProductsType t in list)
           {
               if (t.State.Equals("Y"))
               {
                   this.Items.Add(new ListItem(t.TypeName, t.TypeID.ToString()));
               }
           }
       
       }
    }
}
