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
using Leyp.Model.View;
using Leyp.SQLServerDAL;
using Leyp.Components.Module;
namespace WebPortal
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            UserDAL bs = new UserDAL();
            string userName = StrHelper.ConvertSql(inputName.Value.ToString());
            string userPwd = inputPassword.Value.Trim();//string userPwd =  StrHelper.EncryptPassword(PassWord.Text.ToString(), StrHelper.PasswordType.MD5);
            //if (bs.isLoginValidate(userName, userPwd))
            //{

            //    Leyp.Model.User s = bs.getByUserName(userName);
            //    SessionUser ss = new SessionUser();
            //    ss.UserName = s.UserName;
            //    ss.TypeID = s.TypeID;
            //    ss.SubClassID = s.SubClassID;
            //    ss.GroupID = s.GroupID;
            //    Leyp.Components.Module.BaseLogin.SetSession(ss);//保存Session
            //    new BasePage().addSystemLog("登錄進入系統");
            //    Response.Redirect("Index.aspx");

            //}
            //else
            //{


            //    Jscript.AjaxAlert(this, "登录失败！请检查用户名和密码");
            //    return;
            //}

            if (bs.isLoginValid(userName, userPwd))
            {
                Leyp.Model.User s = bs.getUserInfo(userName);
                SessionUser ss = new SessionUser();
                ss.UserName = s.UserName;
                ss.TypeID = s.TypeID;
                ss.SubClassID = s.SubClassID;
                ss.GroupID = s.GroupID;
                Leyp.Components.Module.BaseLogin.SetSession(ss);//保存Session
                new BasePage().addSystemLog("登錄進入系統");
                Response.Redirect("Index.aspx");
            }
            else
            {
                Jscript.AjaxAlert(this, "登录失败！请检查用户名和密码");
                return;
            }

            //UserDAL bs = new UserDAL();
            //string userName = StrHelper.ConvertSql(UserName.Text.ToString());
            //string userPwd = StrHelper.EncryptPassword(PassWord.Text.ToString(), StrHelper.PasswordType.MD5);
            //if (bs.isLoginValidate(userName, userPwd))
            //{

            //    Leyp.Model.User s = bs.getByUserName(userName);
            //    SessionUser ss = new SessionUser();
            //    ss.UserName = s.UserName;
            //    ss.TypeID = s.TypeID;
            //    ss.SubClassID = s.SubClassID;
            //    ss.GroupID = s.GroupID;
            //    Leyp.Components.Module.BaseLogin.SetSession(ss);//保存Session
            //    new BasePage().addSystemLog("登錄進入系統");
            //    Response.Redirect("Index.aspx");

            //}
            //else
            //{


            //    Jscript.AjaxAlert(this, "登录失败！请检查用户名和密码");
            //    return;
            //}
        }
    }
}