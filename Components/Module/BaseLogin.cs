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
using Leyp.Model.View;

namespace Leyp.Components.Module
{


    /// <summary>
    /// 
    /// 
    /// 已经登录用户的相关信息检查操作
    /// 
    /// 注：Session 中保存（ Leyp.Model.View。SessionUser）类
    ///  Session 保存标志LoginUser
    /// </summary>
   public class BaseLogin
    {
       public BaseLogin() { }

        
       /// <summary>
       /// 当前是已经登录（即是否保存有Session)
       /// </summary>
       /// <returns></returns>
       public static bool isHaveLogin()
       {
           if (HttpContext.Current.Session["LoginUser"] != null)
               return true;
           else
               return false;
       
       }

       

       /// <summary>
       /// 从Session中得到 群组ID
       /// </summary>
       /// <returns></returns>
       public  int getGroupID()
       {
           SessionUser s = this.getSessionNode();
          
           return s.GroupID;
         
          
       
       }

       /// <summary>
       /// 从Session中得到 顶级用户类型ID
       /// </summary>
       /// <returns></returns>
       public int getTypeID()
       {
           SessionUser s = this.getSessionNode();
         
               return s.TypeID;
         


       }


       /// <summary>
       /// 从Session中得到二级用户类型 ID
       /// </summary>
       /// <returns></returns>
       public int getSubClassID()
       {
           SessionUser s = this.getSessionNode();
           
               return s.SubClassID;
       


       }


       /// <summary>
       /// 从Session中得到 用户身份标志UserName
       /// </summary>
       /// <returns></returns>
       public string getUserName()
       {
           SessionUser s = this.getSessionNode();
           
               return s.UserName;
       


       }
        /// <summary>
        /// 从Session中得到 用户語言Lang
        /// </summary>
        /// <returns></returns>
        public string getUserLang()
        {
            SessionUser s = this.getSessionNode();

            return s.Lang;



        }


        /// <summary>
        /// 得到Session 保存的（ Leyp.Model.View。SessionUser）类
        /// </summary>
        /// <returns></returns>
        public SessionUser getSessionNode()
       {

           if (HttpContext.Current.Session["LoginUser"] == null)
           {
               HttpContext.Current.Response.Redirect("~/Login.aspx", true);//没有登录
               return null;
           }
           else
               return (SessionUser)HttpContext.Current.Session["LoginUser"];
       
       }

       /// <summary>
       /// 把用户信息对保存到 Session
       /// </summary>
       /// <param name="info"></param>
       public static void SetSession(SessionUser info)
       {
           HttpContext.Current.Session["LoginUser"] = info;
       }

       
       /// <summary>
       /// 模块权限验证
       /// </summary>
       /// <param name="ModuleName"></param>
       /// <returns></returns>
       public static bool validataModule(string ModuleName)
       {

           return Leyp.SQLServerDAL.Factory.getGroupAuthorityDAL().validataAuthorityAndGroupID(ModuleName, new BaseLogin().getGroupID());
       }

    }
}
