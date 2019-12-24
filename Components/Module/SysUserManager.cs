using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Leyp.Model;
using Leyp.Model.View;
using Leyp.SQLServerDAL;

namespace Leyp.Components.Module
{

    /// <summary>
    /// 用户管理模块 基类
    /// </summary>
   public class SysUserManager : BasePage
    {
       protected override void OnInit(EventArgs e)
       {

           base.OnInit(e);
           validataAuthority("SysUserManager");
       }

       /// <summary>
       /// 搜索
       /// </summary>
       /// <param name="UserTypeID"></param>
       /// <returns></returns>
       public List<Vuser> getSearchByUserTypeID(int UserTypeID)
       {
           return Leyp.SQLServerDAL.Factory.getVuserDAL().getSearchByUserTypeID(UserTypeID);
       }


       /// <summary>
       /// 全变量搜索
       /// </summary>
       /// <param name="key"></param>
       /// <param name="UserTypeID"></param>
       /// <param name="SubClassID"></param>
       /// <returns></returns>
       public List<Vuser> getSearchList(string key, int UserTypeID, int SubClassID)
       {
           return Leyp.SQLServerDAL.Factory.getVuserDAL().getSearchUser(key, UserTypeID, SubClassID);
       }

       



    }
}
