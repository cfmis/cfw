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
using Leyp.Model.Sales;
using Leyp.Components.Module.Sales;
using Leyp.Components.Module.Sales;
public partial class Sales_SalesReturn_Del : SalesReturnModule
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string str0 = Request.QueryString["SalesReturnID"].ToString();
        VSalesReturn v = new VSalesReturn();
        v = Leyp.SQLServerDAL.Sales.Factory.getSalesReturnDAL().getByID(str0);
        if (v.UserName.Equals(getUserName()))
        {

            Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().deleteEitity(str0);
            Response.Write("成功删除：" + str0);
            Response.End();


        }
    }
}
