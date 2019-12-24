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
   public class ServiceTypeDropDownList: DropDownList 
    {

        public ServiceTypeDropDownList()
       {
           this.Items.Add(new ListItem("请选择", ""));
           foreach (ServiceType t in Leyp.SQLServerDAL.Factory.getServiceTypeDAL().getAll())
           {
               
                   this.Items.Add(new ListItem(t.ServiceName, t.TypeID.ToString()));
               
           }
       
       }
    }
}
