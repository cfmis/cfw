using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace Leyp.Components.Module.Sales
{  
    /// <summary>
    /// 销售出库
    /// </summary>
   public class SalesOutModule : BasePage
    {

        protected override void OnInit(EventArgs e)
        {

            base.OnInit(e);
            validataAuthority("SalesOutModule");

        }
    }
}
