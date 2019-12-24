using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model.Sales;
using Leyp.Components.Module.Sales;

public partial class Sales_MySalesOrderOp : SalesOrderModule
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            init();
        }

    }

    protected void init()
    {

      string action = Request.QueryString["action"].ToString();
      if (action.Equals("delMySalesOrder"))//用户删除自己的订单
        {
            string AuditingId = Request.QueryString["AuditingId"].ToString();
            StringBuilder sb = new StringBuilder();
            string[] a = AuditingId.Split('#');
            Leyp.SQLServerDAL.Sales.SalesOrderDAL bl = new Leyp.SQLServerDAL.Sales.SalesOrderDAL();
            int num = 0;
            for (int i = 0; i < a.Length; i++)
            {
                VSalesOrder v = new VSalesOrder();
                v=bl.getByID(a[i]);
                if (v != null)
                {
                    if (v.UserName.Equals(getUserName()))//如果是该用户的单据
                    {
                       if( bl.deleteEitity(a[i]))
                        num++;
                        else
                        sb.Append("订单号：" + a[i] + " 已经审核不能再审核 <br/>");
                    }
                    else
                    {
                        sb.Append("订单号：" + a[i] + " 无权删除 <br/>");
                    }
                }

            }
            sb.Append("成功删除 " + num + "条");
            Response.Write(sb.ToString());
        }
    
    }
}
