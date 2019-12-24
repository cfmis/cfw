using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Components;
using Leyp.Components.Module;

public partial class user_SysUser_Reset_PassWord :BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void submit_Click(object sender, EventArgs e)
    {
        string pwd0 = StrHelper.EncryptPassword(oldpwd.Text.ToString(), StrHelper.PasswordType.MD5);
        string pwd1 = StrHelper.EncryptPassword(newpwd.Text.ToString(), StrHelper.PasswordType.MD5); 

        string userName = getUserName();
        if (Leyp.SQLServerDAL.Factory.getUserDAL().resetPassWord(pwd0, pwd1, userName))
        {
            Panel1.Visible = false;
            Label1.Visible = true;
        }
        else
        {

            Panel1.Visible = false;
            Label1.Text = "操作失败！";
            Label1.Visible = true;
        
        }
        


    }
}
