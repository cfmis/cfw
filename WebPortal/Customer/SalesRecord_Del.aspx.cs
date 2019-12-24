using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Components.Module;
using Leyp.Components;
using Leyp.Model.Sales;

public partial class Customer_SalesRecord_Del : SalesRecordModule
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

        string AuditingId = Request.QueryString["AuditingId"].ToString();
        StringBuilder sb = new StringBuilder();
        string[] a = AuditingId.Split('#');
        Leyp.SQLServerDAL.Sales.SalesRecordDAL bl = new Leyp.SQLServerDAL.Sales.SalesRecordDAL();
        int num = 0;
        for (int i = 0; i < a.Length; i++)
        {

            if (bl.deleteEitity(int.Parse(a[i]),getUserName()))//删除成功
            {
                num++;
            }
            else
            {
                sb.Append("记录号：" + a[i] + " 可能不是您记的记录 <br/>");
            }

        }
        sb.Append("成功删除 " + num + "条");
        Response.Write(sb.ToString());
    
    }
}
