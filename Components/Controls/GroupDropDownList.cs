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
    public class GroupDropDownList : DropDownList
    {
       public GroupDropDownList()
       {
           this.Items.Add(new ListItem("请选择权限组", ""));
           foreach (Group t in Leyp.SQLServerDAL.Factory.getGroupDAL().getAllGroup())
           {
               this.Items.Add(new ListItem(t.GroupName, t.GroupID.ToString()));
           }
       }
    }
}
