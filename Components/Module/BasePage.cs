using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model;

namespace Leyp.Components.Module
{
    public class BasePage : System.Web.UI.Page
    {

       protected override void OnInit(EventArgs e)
       {

           //Response.Redirect("Login.aspx");

           if (!BaseLogin.isHaveLogin())
           {
               Response.Redirect("~/LoginFail.aspx", true);

           }
           base.OnInit(e);

          
       }


        /// <summary>
        /// 得到群ID
        /// </summary>
        /// <returns></returns>
        public int getGroupID()
        {
            return new BaseLogin().getGroupID();
        }
         /// <summary>
         /// 得到登录用户名
         /// </summary>
         /// <returns></returns>
        public string getUserName()
        {

            return new BaseLogin().getUserName();

        }
        /// <summary>
        /// 得到用户語言
        /// </summary>
        /// <returns></returns>
        public string getUserLang()
        {

            return new BaseLogin().getUserLang();

        }

        /// <summary>
        /// 用户类型
        /// </summary>
        /// <returns></returns>
        public int getTypeID()
        {
            return new BaseLogin().getTypeID();
        }


        /// <summary>
        /// 用户二级类型
        /// </summary>
        /// <returns></returns>
        public int getSubClassID()
        {
            return new BaseLogin().getSubClassID();
        }


        /// <summary>
        /// 模块权限判断
        /// </summary>
        /// <param name="ModuleName"></param>
        public void validataAuthority(string ModuleName)
        {
            if (!BaseLogin.validataModule(ModuleName))
            {
                Response.Write("没有权限");
                Response.End();
            }
          
        }

        
        /// <summary>
        /// 添加系统日志
        /// </summary>
        /// <param name="msg"></param>
        public void addSystemLog(string msg)
        {
            Log g = new Log();
            string datastr = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");
            g.LogTime = datastr;
            g.Description ="用户"+getUserName()+" ："+ msg;

            Leyp.SQLServerDAL.Factory.getLogDAL().addLog(g);

        
        }

    }
}
