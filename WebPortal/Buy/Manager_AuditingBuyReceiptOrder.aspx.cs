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
using Leyp.Model.Buy;

public partial class Buy_Manager_AuditingBuyReceiptOrder : System.Web.UI.Page
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
            Leyp.SQLServerDAL.Buy.BuyReceiptDAL bl = new Leyp.SQLServerDAL.Buy.BuyReceiptDAL();
            int num = 0;
            for (int i = 0; i < a.Length; i++)
            {
                BuyReceipt b = new BuyReceipt();
                b = bl.getByID(a[i]);
                if (b.State == 1)//已经审核
                {
                    sb.Append("订单号：" + a[i] + " 已经审核不能再审核 <br/>");
                }
                else
                {
                    bl.AuditingBuyReceiptOrder(a[i]);
                    num++;
                }

            }
            sb.Append("成功审核入库 " + num + "条 &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_BuyReceipOrder.aspx\">返回列表</a>");
            Response.Write(sb.ToString());
        }
        else if (action.Equals("delete")) {

            string AuditingId = Request.QueryString["AuditingId"].ToString();
            StringBuilder sb = new StringBuilder();
            string[] a = AuditingId.Split('#');
            Leyp.SQLServerDAL.Buy.BuyReceiptDAL bl = new Leyp.SQLServerDAL.Buy.BuyReceiptDAL();
            int num = 0;

            for (int i = 0; i < a.Length; i++)
            {  
                 BuyReceipt b = new BuyReceipt();
                 b = bl.getByID(a[i]);
                 if (b.State == 1)//已经审核
                 {
                     sb.Append("订单号：" + a[i] + " 已经审核不能删除 <br/>");
                 }
                 else
                 {
                     bl.deleteEitity(a[i]);
                     num++;
                 }

            }
            sb.Append("成功删除 " + num + "条 &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_BuyReceipOrder.aspx\">返回列表</a>");
            Response.Write(sb.ToString());
        
        }
    }
}
