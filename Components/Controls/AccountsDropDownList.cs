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
   public class AccountsDropDownList: DropDownList
    {
       public AccountsDropDownList()
       {
           this.Items.Add(new ListItem("请选择财务帐号", ""));
           foreach (Accounts t in Leyp.SQLServerDAL.Factory.getAccountsDAL().getAll())
           {
               this.Items.Add(new ListItem(t.AccountsName, t.AccountsID.ToString()));
           }
       }

    }
}
