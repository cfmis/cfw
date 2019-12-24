using System;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model.Sales;
using Leyp.Model.View;
using Leyp.Components.Module.Sales;
using Leyp.Components;
using Leyp.SQLServerDAL.Sales;

public partial class Sales_SalesDispatchCreateKuai : SalesDispatchModule
{
    protected void Page_Load(object sender, EventArgs e)
    {

        
        if (!IsPostBack)
        {
            init();
        }

    }

    private void init()
    {
        string AuditingId = Request.QueryString["AuditingId"].ToString();
        string Consignor= Request.QueryString["Consignor"].ToString();
        string[] a = AuditingId.Split('#');

        for (int b = 0; b < a.Length; b++)
        {
            buildNode(a[b].ToString(), Consignor);

        }


        Response.Write(" <a href=\"Manager_SalesOutOrder.aspx\">返回列表</a><br>");

    }

    private void buildNode(string SalesOutID, string ConsignorId)
    {
        
        
            SalesOutDAL sdal = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL();
            VSalesOut vs = sdal.getByID(SalesOutID);
            if (vs.State == 1)
            {
            SalesDispatch d = new SalesDispatch();
            d.Consignor = ConsignorId;
            d.CreateDate = DateTime.Now.ToString("yyyy-MM-dd"); ;
            d.DeliveryDate = DateTime.Now.ToString("yyyy-MM-dd"); ;
            d.DeliveryType = vs.DeliveryName;
            d.Description = "无";
            d.SalesOutID = SalesOutID;
            d.SentDate = DateTime.Now.ToString("yyyy-MM-dd"); ;
            d.State = 0;
            d.UserName = getUserName();

            Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().insertNewEntity(d);
            Response.Write("单号：" + SalesOutID + "  成功生成<br>");
         
            }
        else {

            Response.Write("单号：" + SalesOutID+" 没有审核 或已经处理了 <br>");
        }
    }


    /// <summary>
    /// 检查已经审核了吗
    /// </summary>
    /// <param name="SalesOutID"></param>
    /// <returns></returns>
    private bool checkSalesOutID(string SalesOutID)
    {
        bool reslut = false;

        SalesOutDAL sdal=Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL();
        VSalesOut vs = sdal.getByID(SalesOutID);

        if (vs.State == 1)
        {

            reslut = true;
        }

        return reslut;
      
    }



}
