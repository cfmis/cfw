using System;
using System.Text;
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
using Leyp.Components;

public partial class Sales_Manager_AuditingSalesOrder : ManagerSalesOrder
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

        if (action.Equals("shenhe"))
        {
            string AuditingId = Request.QueryString["AuditingId"].ToString();
            StringBuilder sb = new StringBuilder();
            string[] a = AuditingId.Split('#');
            Leyp.SQLServerDAL.Sales.SalesOrderDAL bl = new Leyp.SQLServerDAL.Sales.SalesOrderDAL();
            int num = 0;
            for (int i = 0; i < a.Length; i++)
            {

                if (bl.AuditingOrder(a[i], getUserName()))//审核
                {
                    num++;
                }
                else
                {
                    sb.Append("订单号：" + a[i] + " 已经审核不能再审核 <br/>");
                }

            }
            sb.Append("成功审核 " + num + "条    &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_SalesOrderList.aspx\">返回列表</a>");
            Response.Write(sb.ToString());
        }
        else if (action.Equals("delete"))
        {
            string AuditingId = Request.QueryString["AuditingId"].ToString();
            StringBuilder sb = new StringBuilder();
            string[] a = AuditingId.Split('#');
            Leyp.SQLServerDAL.Sales.SalesOrderDAL bl = new Leyp.SQLServerDAL.Sales.SalesOrderDAL();
            int num = 0;
            for (int i = 0; i < a.Length; i++)
            {

                if (bl.deleteEitity(a[i]))//删除成功
                {
                    num++;
                }
                else
                {
                    sb.Append("订单号：" + a[i] + " 可能已经审核不能删除 <br/>");
                }

            }
            sb.Append("成功删除 " + num + "条    &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_SalesOrderList.aspx\">返回列表</a>");
            Response.Write(sb.ToString());

        }
        else if (action.Equals("rshenhe"))//反审核
        {
            string AuditingId = Request.QueryString["AuditingId"].ToString();
            StringBuilder sb = new StringBuilder();
            string[] a = AuditingId.Split('#');
            Leyp.SQLServerDAL.Sales.SalesOrderDAL bl = new Leyp.SQLServerDAL.Sales.SalesOrderDAL();
            int num = 0;
            for (int i = 0; i < a.Length; i++)
            {

                if (bl.rAuditingOrder(a[i]))//删除成功
                {
                    num++;
                }
                else
                {
                    sb.Append("订单号：" + a[i] + " 不能反审核 <br/>");
                }

            }
            sb.Append("成功反审核 " + num + "条    &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_SalesOrderList.aspx\">返回列表</a>");
            Response.Write(sb.ToString());
        }
        else if (action.Equals("Kuaishenhe"))//审核且生成销售开单
        {

        }


    }

    /// <summary>
    /// 
    /// </summary>
   private void kuaiShenhe(string SalesOrderID)
    {
        VSalesOrder vs = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getByID(SalesOrderID);
        if (vs == null)
        {
            return;
        }
        SalesOut s = new SalesOut();
        s.UserName = getUserName();
        s.Consignee = "未知";
        s.CreateDate = DateTime.Now.ToString("yyyy-MM-dd");
        s.SalesOrderID = vs.SalesOrderID;
        s.SalesOutID = "SO" + StrHelper.GetRamCode();
        s.Description = "无";
        s.DeliveryID = Leyp.SQLServerDAL.Sales.Factory.getSalesPlatformDAL().getList()[0].PlatformID;
    }
}
