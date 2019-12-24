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
    /// 用户类型管理模块
    /// </summary>
   public class SysUserType : BasePage
    {

       protected override void OnInit(EventArgs e)
       {

           base.OnInit(e);
       }

     
       /// <summary>
       ///  将  List"UserTypeSubClass"  List"UserType" 和成  List"UserSubClassView"
       /// </summary>
       /// <param name="list0">子级列表</param>
       /// <param name="list1">父类列表</param>
       /// <returns>视图列表</returns>
       public List<UserSubClassView> changeListForViewList(List<UserTypeSubClass> list0, List<UserType> list1)
       {
           List<UserSubClassView> al = new List<UserSubClassView>();
           for (int i = 0; i < list1.Count; i++)
           {
               UserType u = list1[i];
               for (int j = 0; j < list0.Count; j++)
               {
                   UserTypeSubClass us = list0[j];
                   if (u.TypeID == us.UserTypeID)
                   {
                       UserSubClassView vs = new UserSubClassView();
                       vs.SubClassID = us.SubClassID;
                       vs.SubClassName = us.SubClassName;
                       vs.State = us.State;
                       vs.UserTypeID = us.UserTypeID;
                       vs.TypeName = u.TypeName;
                       al.Add(vs);
                   }
               
               }


           }

           return al;

       }
   }
}
