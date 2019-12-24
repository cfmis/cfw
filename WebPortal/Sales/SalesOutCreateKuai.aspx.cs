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

public partial class Sales_SalesOutCreateKuai : SalesOutModule 
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
        string DeliveryID = Request.QueryString["DeliveryID"].ToString();
        string[] a = AuditingId.Split('#');

        for (int b = 0; b < a.Length; b++)
        {
            buildNode(a[b],int.Parse(DeliveryID));
        
        }


        Response.Write(" <a href=\"Manager_SalesOrderList.aspx\">返回列表</a><br>");

    }



    /// <summary>
    /// 根据SalesOrderID 快速生成
    /// </summary>
    /// <param name="SalesOrderID"></param>

    private void buildNode(string SalesOrderID, int DeliveryID)
    {
        bool result = true;

        VSalesOrder vo = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getByID(SalesOrderID);

        if (vo == null)
        {
            Response.Write("订单号：" + SalesOrderID + " 有误<br>");
            return;
        }
        if (vo.State != 1)//订单没有审核
        {
            Response.Write("订单号：" + SalesOrderID + " 没有审核或已经处理<br>");
            return;
        }

        string SalesOutID = getSalesOutID();
       // int DeliveryID = Leyp.SQLServerDAL.Factory.getDeliveryDAL().getDefaultEitity().DeliveryID;//得到默认得
        SalesOut s = new SalesOut();
        s.Consignee = "未知";
        s.CreateDate = DateTime.Now.ToString("yyyy-MM-dd"); 
        s.DeliveryID = DeliveryID;
        s.TradeDate = DateTime.Now.ToString("yyyy-MM-dd");
        s.Deposits = float.Parse("0.00");
        s.Description = "无";
        s.UserName = getUserName();
        s.State = 0;
        s.SalesOutID = SalesOutID;
        s.SalesOrderID = SalesOrderID;
        s.AccountsID = "无";


        Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().insertSalesDetailFrist(SalesOrderID, SalesOutID);//临时添加详细

        List<VSalesOutDetail> list = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDetailDAL().getBySalesOutIDinit(SalesOutID);
        for (int i = 0; i < list.Count; i++)
        {
            if (result == false)
            {
                break;
            }



            VSalesOutDetail v = list[i];
            int ProductsID = v.ProductsID;
            List<VProductsStock> list0 = Leyp.SQLServerDAL.Factory.getProductsStockDAL().getStockList(ProductsID);//寻找库存

            if (list0 == null || list0.Count == 0)//没有库存
            {
                result = false;
                break;
            }

            VProductsStock vp = null;

            for (int j = 0; j < list0.Count; j++)
            {  
                VProductsStock vps=list0[j];
                if (vps.Num >= v.Quantity)//有库存 并且数量合理
                {
                    vp = vps;
                    break;
                }
            }

            if (vp == null)//没有库存 失败！
            {
                result = false;
                break;
            }


            SalesOutDetail d = new SalesOutDetail();
            d.SalesOutID = v.SalesOutID;
            d.ProductsID = v.ProductsID;
            d.Price = v.Price;
            d.Quantity = v.Quantity;
            d.DiscountRate = v.DiscountRate;
            d.Description = v.Description;
            d.DetailID = v.DetailID;
            d.StoreHouseID = vp.HouseID;
            d.HouseDetailID = vp.HouseDetailID;
            Leyp.SQLServerDAL.Sales.Factory.getSalesOutDetailDAL().updateEitity(d); 

       }

       if (result == true)
       {

           if (Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().insertNewEntity(s))
           {
               Response.Write("单号：" + SalesOrderID + "  --生成成功<br>");
           }
       }
       else
       {
           Response.Write("订单号：" + SalesOrderID+"  不能生成，可能库存不足<br>");
       
       }
    
    }


    /// <summary>
    /// 生成ID
    /// </summary>
    /// <returns></returns>
    private string getSalesOutID()
    {
        return "SO" + StrHelper.GetRamCode();
    }
}
