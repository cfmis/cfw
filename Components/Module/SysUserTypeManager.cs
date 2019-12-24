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
   public class SysUserTypeManager:BasePage
    {

       protected override void OnInit(EventArgs e)
       {
           base.OnInit(e);
           validataAuthority("SysUserTypeManager");
       }
    }
}
