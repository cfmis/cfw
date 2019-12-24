using System;
using System.IO;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Configuration;
using Leyp.Model.View;

namespace Leyp.Components.Controls
{
     public class DeliveryUserDropList : DropDownList
    {
         public DeliveryUserDropList()
         {
             this.Items.Add(new ListItem("«Î—°‘Ò≈‰ÀÕ»À‘±", ""));
             foreach (Vuser t in Leyp.SQLServerDAL.Factory.getVuserDAL().getSearchByUserTypeID(4))
             {
                 this.Items.Add(new ListItem(t.RealName, t.UserName.ToString()));
             }
         
         }
    }
}
