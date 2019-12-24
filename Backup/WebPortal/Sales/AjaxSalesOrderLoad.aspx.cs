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
using Leyp.Model;
using Leyp.Components.Module.Sales;

public partial class Sales_AjaxSalesOrderLoad : SalesOrderModule
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

        string action = Request.Form["action"].ToString();
        if (action.Equals("addHeadTable"))//添加简明
        {
            #region 添加简明
            string str0 = Request.Form["SalesOrderID"].ToString();
            string str1 = Request.Form["ClosingDate"].ToString();
            string str2 = Request.Form["DeliveryType"].ToString();
            string str3 = Request.Form["CreateDate"].ToString();
            string str4 = Request.Form["DeliveryPlace"].ToString();
            string str5 = Request.Form["ClosingType"].ToString();
            string str6 = Request.Form["ShopID"].ToString();
            string str7 = Request.Form["AttachPay"].ToString();
            string str8 = Request.Form["Description"].ToString();
            string str9 = Request.Form["Discount"].ToString();

            string str10 = Request.Form["CustomerID"].ToString();
            string str11 = Request.Form["CustomerName"].ToString();
            string str12 = Request.Form["CustomerPost"].ToString();
            string str13 = Request.Form["CustomerTel"].ToString();
            string str14 = Request.Form["CustomerArea"].ToString();
            string str15 = Request.Form["PlatformID"].ToString();

            SalesOrder s = new SalesOrder();
            s.AttachPay = float.Parse(str7);
            s.ClosingDate = str1;
            s.ClosingType = str5;
            s.CreateDate = str3;
            s.DeliveryPlace = str4;
            s.DeliveryType = str2;
            s.SalesOrderID = str0;
            s.ShopID = int.Parse(str6);
            s.UserName = getUserName();
            s.SalesType = getSubClassID();
            s.Description = str8;
            s.Discount = float.Parse(str9);
            s.CustomerID = str10;
            s.CustomerName = str11;
            s.CustomerPost = str12;
            s.CustomerTel = str13;
            s.CustomerArea = str14;
            s.PlatformID = int.Parse(str15);

            Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().insertNewEntity(s);
            Response.Write("00");
            Response.End();
          #endregion

        }
       else if (action.Equals("addDetail"))//明细添加
        {
            string str0 = Request.Form["SalesOrderID"].ToString();
            string str1 = Request.Form["ProductsID"].ToString();
            string str2 = Request.Form["Price"].ToString();
            string str3 = Request.Form["Quantity"].ToString();
            string str4 = Request.Form["DiscountRate"].ToString();
            string str5 = Request.Form["Descriptions"].ToString();

            SalesDetail d = new SalesDetail();
            d.SalesOrderID = str0;
            d.ProductsID = int.Parse(str1);
            d.Price = float.Parse(str2);
            d.Quantity = int.Parse(str3);
            d.DiscountRate = float.Parse(str4);
            d.Description = str5;
            Leyp.SQLServerDAL.Sales.Factory.getSalesDetailDAL().insertNewEitity(d);
            Response.Write("00");
            Response.End();

        }
        else if (action.Equals("LoadDetail"))//加载明细BY  SalesOrderID
        {
            string str0 = Request.Form["SalesOrderID"].ToString();
            loadinit0(str0);

        }
        else if (action.Equals("LoadDetail_Detail"))//明细单加载detail全部
        {
            string str0 = Request.Form["SalesOrderID"].ToString();
            loadinit1(str0);

        }
        else if (action.Equals("delDetail"))//delete
        {
            string str0 = Request.Form["DetailID"].ToString();
            Leyp.SQLServerDAL.Sales.Factory.getSalesDetailDAL().deleteEitity(int.Parse(str0));
            Response.Write("00");
            Response.End();
        }
        else if (action.Equals("getQuantity"))//总的订购数量
        {
             string str0 = Request.Form["SalesOrderID"].ToString();
             getQuantity(str0);
        }
        else if (action.Equals("getProductsPrice"))//根据用户类型得到商品的价格
        {
            string str0 = Request.Form["ProductsID"].ToString();
            getProductsPrice(int.Parse(str0));

        }
        else if (action.Equals("getTotalPrice"))//得到订单总价
        {
            string str0 = Request.Form["SalesOrderID"].ToString();
            getTotalPrice(str0);

        }
        else if (action.Equals("updatePayInfo"))//更新付款信息
        {
            string str0 = Request.Form["SalesOrderID"].ToString();
            string payinfo = Request.Form["PayInfo"].ToString();
            updatePayInfo(str0, payinfo);

        }
        
    }

    /// <summary>
    /// 加载全部
    /// </summary>
    /// <param name="ReceiptOrderID"></param>
    protected void loadinit(string SalesOrderID)
    {
        List<VSalesDetail> list = new List<VSalesDetail>();
        list = Leyp.SQLServerDAL.Sales.Factory.getSalesDetailDAL().getBySalesOrderID(SalesOrderID);
        float tatal = float.Parse("0.00");
        StringBuilder sb = new StringBuilder();


        sb.Append("<table   class=\"flexme2\"><thead><tr><th width=\"80\">商品编号</th><th width=\"100\">商品名称</th><th width=\"80\">数量 </th><th width=\"80\">价格</th><th width=\"80\">折扣额 </th><th width=\"100\">金额 </th></tr>");
        sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
            VSalesDetail v = new VSalesDetail();
            v = list[i];
            sb.Append("<tr>");
            sb.Append("	<td>" + v.ProductsID + "</td>");
            sb.Append("	<td>" + v.ProductsName + "</td>");
            sb.Append("	<td>" + v.Quantity + "</td>");
            sb.Append("	<td>" + v.Price.ToString() + "</td>");
            sb.Append("	<td>" + v.DiscountRate.ToString() + "</td>");

            tatal =v.Quantity * v.Price  - (v.Quantity * v.Price * v.DiscountRate / 100);
            sb.Append("	<td>" + tatal.ToString() + "</td>");
            sb.Append("</tr>");

        }
        sb.Append("</tbody></table>");
        Response.Write(sb.ToString());
        Response.End();


    }



    /// <summary>
    /// 明细单加载detail全部
    /// </summary>
    /// <param name="ReceiptOrderID"></param>
    protected void loadinit1(string SalesOrderID)
    {
        List<VSalesDetail> list = new List<VSalesDetail>();
        list = Leyp.SQLServerDAL.Sales.Factory.getSalesDetailDAL().getBySalesOrderID(SalesOrderID);
        float tatal = float.Parse("0.00");
        StringBuilder sb = new StringBuilder();


        sb.Append("<TABLE id=MyDataGrid class=\"MyDataGrid\"borderColor=black cellSpacing=0 cellPadding=0 rules=all align=center border=1><TBODY><TR style=\"FONT-WEIGHT: bold; BACKGROUND-COLOR: #b9c6ff\" align=middle><TD>商品编号</TD><TD align=middle>商品名称</TD><TD align=middle> 数量</TD><TD align=middle>价格</TD><TD align=middle>折扣率</TD><TD align=middle>金额小计</TD></TR>");
        //sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
            VSalesDetail v = new VSalesDetail();
            v = list[i];
            sb.Append("<TR>");
            sb.Append("	<td>" + v.ProductsID + "</td>");
            sb.Append("	<td>" + v.ProductsName + "</td>");
            sb.Append("	<td>" + v.Quantity + "</td>");
            sb.Append("	<td>" + v.Price.ToString() + "</td>");
            sb.Append("	<td>" + v.DiscountRate.ToString() + "</td>");

            tatal = v.Quantity * v.Price - (v.Quantity * v.Price * v.DiscountRate / 100);
            sb.Append("	<td>" + tatal.ToString() + "</td>");
            sb.Append("</TR >");

        }
        sb.Append("</tbody></table>");
        Response.Write(sb.ToString());
        Response.End();


    }


    /// <summary>
    /// 加载全部
    /// </summary>
    /// <param name="ReceiptOrderID"></param>
    protected void loadinit0(string SalesOrderID)
    {
        List<VSalesDetail> list = new List<VSalesDetail>();
        list = Leyp.SQLServerDAL.Sales.Factory.getSalesDetailDAL().getBySalesOrderID(SalesOrderID);
        float tatal = float.Parse("0.00");
        StringBuilder sb = new StringBuilder();


        sb.Append("<TABLE id=MyDataGrid class=\"MyDataGrid\"borderColor=black cellSpacing=0 cellPadding=0 rules=all align=center border=1><TBODY><TR style=\"FONT-WEIGHT: bold; BACKGROUND-COLOR: #b9c6ff\" align=middle><TD>操作</TD><TD>商品编号</TD><TD align=middle>商品名称</TD><TD align=middle> 数量</TD><TD align=middle>价格</TD><TD align=middle>折扣率</TD><TD align=middle>金额小计</TD></TR>");
        //sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
            VSalesDetail v = new VSalesDetail();
            v = list[i];
            sb.Append("<TR onMouseOver=\"this.className='onmouseover'\" onmouseout=\"this.className=''\"><td > &nbsp;&nbsp;<img src=\"../images/tbtn_delete.gif\" onclick=\"javascript:if(!confirm('您确定要删除吗'))return  false;deleteDetail(" + v.DetailID + ")\";  /> </td>");
            sb.Append("	<td>" + v.ProductsID + "</td>");
            sb.Append("	<td>" + v.ProductsName + "</td>");
            sb.Append("	<td>" + v.Quantity + "</td>");
            sb.Append("	<td>" + v.Price.ToString() + "</td>");
            sb.Append("	<td>" + v.DiscountRate.ToString() + "</td>");

            tatal = v.Quantity * v.Price - (v.Quantity * v.Price * v.DiscountRate / 100);
            sb.Append("	<td>" + tatal.ToString() + "</td>");
            sb.Append("</TR >");

        }
        sb.Append("</tbody></table>");
        Response.Write(sb.ToString());
        Response.End();


    }



    /// <summary>
    /// 
    /// </summary>
    /// <param name="SalesOrderID"></param>
    private void getQuantity(string SalesOrderID)
    {
        int num = 0;
        List<VSalesDetail> list = Leyp.SQLServerDAL.Sales.Factory.getSalesDetailDAL().getBySalesOrderID(SalesOrderID);

        for (int i = 0; i < list.Count; i++)
        {
            VSalesDetail v = list[i];
            num = num + v.Quantity;
        }

        Response.Write(num.ToString());
        Response.End();
    }

    /// <summary>
    /// 根据用户类型得到商品的价格
    /// </summary>
    /// <param name="ProductsID"></param>
    private void getProductsPrice(int ProductsID)
    {
        int userType = getSubClassID();//用户类型

        ProductsUserType py = Leyp.SQLServerDAL.Factory.getProductsUserTypeDAL().getByProductsIDAndSubClassID(ProductsID, userType);

        Response.Write(py.Price.ToString());
        Response.End();

    }

    //得到订单总价
    private void getTotalPrice(string SalesOrderID)
    {
        float price = float.Parse("0.00");
        float tatal = float.Parse("0.00");
        List<VSalesDetail> list = Leyp.SQLServerDAL.Sales.Factory.getSalesDetailDAL().getBySalesOrderID(SalesOrderID);

        for (int i = 0; i < list.Count; i++)
        {
            VSalesDetail v = list[i];
            price = v.Quantity * v.Price - (v.Quantity * v.Price * v.DiscountRate / 100);
            tatal = tatal + price;
        }

        Response.Write(tatal.ToString());
        Response.End();
    }


    /// <summary>
    /// 
    /// </summary>
    private void updatePayInfo(string OrderID,string info)
    {
        if (Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().updatePayInfo(OrderID, info))
        {
            Response.Write("00");
            Response.End();
        }
        else
        {
            return;
        }
      
    }
}
