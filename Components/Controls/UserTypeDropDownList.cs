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
    public class UserTypeDropDownList : DropDownList 
    {
        public UserTypeDropDownList()
        {
            this.Items.Add(new ListItem("请选择", ""));
            foreach (UserType t in Leyp.SQLServerDAL.Factory.getUserTypeDAL().getAllUserType())
            {
                this.Items.Add(new ListItem(t.TypeName, t.TypeID.ToString()));
            }
        }
    }
}
