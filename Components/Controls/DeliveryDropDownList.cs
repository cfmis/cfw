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
   public class DeliveryDropDownList : DropDownList
    {
       public DeliveryDropDownList()
       {
           this.Items.Add(new ListItem("请选择配送方式", ""));
           foreach (Delivery t in Leyp.SQLServerDAL.Factory.getDeliveryDAL().getAllDelivery())
           {
               this.Items.Add(new ListItem(t.DeliveryName, t.DeliveryID.ToString()));
           }
       }

    }
}
