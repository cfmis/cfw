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
using Leyp.Model;
public partial class Buy_Manager_AuditingBuyOrder : System.Web.UI.Page
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
            string[] a = AuditingId.Split('#');
            int num = 0;

            Leyp.SQLServerDAL.Buy.BuyOrderDAL bl = new Leyp.SQLServerDAL.Buy.BuyOrderDAL();

            for (int i = 0; i < a.Length; i++)
            {
                if (bl.auditingBuyOrderByID(a[i]))
                {
                    num++;
                }

            }

            Response.Write(getviewStr("成功审核 " + num + "条 &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_BuyOrder.aspx\">返回列表</a>"));
        }
        else if (action.Equals("delete"))
        {
            string AuditingId = Request.QueryString["AuditingId"].ToString();
            string[] a = AuditingId.Split('#');
            int num = 0;

            Leyp.SQLServerDAL.Buy.BuyOrderDAL bl = new Leyp.SQLServerDAL.Buy.BuyOrderDAL();

            for (int i = 0; i < a.Length; i++)
            {
                if (bl.deleteBuyOrder(a[i]))
                {
                    num++;
                }

            }

            Response.Write(getviewStr("成功删除 " + num + "条　 &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_BuyOrder.aspx\">返回列表</a>"));
        
        }
        else if (action.Equals("rshenhe"))//反审核
        { 
           string AuditingId = Request.QueryString["AuditingId"].ToString();
            string[] a = AuditingId.Split('#');
            int num = 0;

            Leyp.SQLServerDAL.Buy.BuyOrderDAL bl = new Leyp.SQLServerDAL.Buy.BuyOrderDAL();

            for (int i = 0; i < a.Length; i++)
            {
                if (bl.rAuditingBuyOrderByID(a[i]))
                {
                    num++;
                }

            }

            Response.Write(getviewStr("成功反审核 " + num + "条 &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_BuyOrder.aspx\">返回列表</a>"));
            
        }
    
    
    }


    private string getviewStr(string s)
    {

        string str = "<div style=\"border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 329px;border-bottom: #a4d5e3 1px solid;\">";
           str=str+"<h2 style=\"padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;border-bottom: #a4d5e3 1px solid\">处理结果</h2>";
             str=str+"<table width=\"300\" border=\"0\"> <TR><TH>&nbsp;</th> <TD>"+s+" </td> </tr></table><div style=\"margin: 5px\"></div></div>";
             return str;
    }
}
