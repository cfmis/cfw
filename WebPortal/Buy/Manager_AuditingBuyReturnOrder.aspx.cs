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

public partial class Buy_Manager_AuditingBuyReturnOrder : System.Web.UI.Page
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
            Leyp.SQLServerDAL.Buy.BuyReturnDAL bl = new Leyp.SQLServerDAL.Buy.BuyReturnDAL();
            int num = 0;
            for (int i = 0; i < a.Length; i++)
            {
               
                if (bl.AuditingBuyReturnOrder(a[i]))//已经审核
                {
                  
                    num++;
                }
                else
                {
                    sb.Append("订单号：" + a[i] + " 已经审核不能再审核 <br/>");
                }

            }
            sb.Append("成功审核 " + num + "条 &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_BuyReturnOrder.aspx\">返回列表</a>");
            Response.Write(sb.ToString());
        }
        else if (action.Equals("delete"))
        {

            string AuditingId = Request.QueryString["AuditingId"].ToString();
            StringBuilder sb = new StringBuilder();
            string[] a = AuditingId.Split('#');
            Leyp.SQLServerDAL.Buy.BuyReturnDAL bl = new Leyp.SQLServerDAL.Buy.BuyReturnDAL();
            int num = 0;

            for (int i = 0; i < a.Length; i++)
            {
                if (bl.deleteEitity(a[i]))//已经审核
                {
                    num++;
                }
                else
                {
                  
                    sb.Append("订单号：" + a[i] + " 已经审核不能删除 <br/>");
                }

            }
            sb.Append("成功删除 " + num + "条 &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_BuyReturnOrder.aspx\">返回列表</a>");
            Response.Write(sb.ToString());

        }
    }
}
