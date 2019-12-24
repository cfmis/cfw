using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model.Buy;
using System.Text;

public partial class Buy_AjaxBuyDetail_Add : System.Web.UI.Page
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
        string action = Request.Form["Action"].ToString();
        string str0 = Request.Form["BuyOrderID"].ToString();
        if (action.Equals("add"))
        {
            string str1 = Request.Form["ProductsID"].ToString();
            string str2 = Request.Form["SupplierID"].ToString();
            string str3 = Request.Form["Quantity"].ToString();
            string str4 = Request.Form["TaxRate"].ToString();
            string str5 = Request.Form["DiscountRate"].ToString();
            string str6 = Request.Form["Descriptions"].ToString();
            string str7 = Request.Form["Price"].ToString();


            BuyOrderDetail b = new BuyOrderDetail();
            b.BuyOrderID = str0;
            b.ProductsID = int.Parse(str1);
            b.SupplierID = int.Parse(str2);
            b.Quantity = int.Parse(str3);
            b.TaxRate = float.Parse(str4);
            b.DiscountRate = float.Parse(str5);
            b.Description = str6;
            b.Price = float.Parse(str7);
            if (Leyp.SQLServerDAL.Buy.Factory.getBuyOrderDetailDAL().insertNewEitity(b))
            {
                respAjax(str0);
            }
            else
            {

                respAjax(str0);
            }
        }
        else if (action.Equals("del"))
        {
            string detailid = Request.Form["DetailID"].ToString();

            Leyp.SQLServerDAL.Buy.Factory.getBuyOrderDetailDAL().deleteEitity(int.Parse(detailid));//delete

            respAjax(str0);
        }
        else if (action.Equals("load"))
        {
            string BuyOrderID = Request.Form["BuyOrderID"].ToString();
            respAjax(BuyOrderID);
        }
        else if (action.Equals("loadDetail"))
        {
            string BuyOrderID = Request.Form["BuyOrderID"].ToString();
            respAjaxforDetail(BuyOrderID);
        }




       

    }


    /// <summary>
    /// 
    /// </summary>
    /// <param name="BuyOrderID"></param>
    protected void respAjax(string BuyOrderID)
    { 
       List<VBuyOrderDetail> list = new List<VBuyOrderDetail>();
        list = Leyp.SQLServerDAL.Buy.Factory.getBuyOrderDetailDAL().getBuyOrderDetailforAjaxString(BuyOrderID);
        StringBuilder sb = new StringBuilder();
        float tatal = float.Parse("0.00");

        sb.Append("<table   class=\"flexme2\"><thead><tr><th width=\"70\">操作</th><th width=\"80\">商品编号</th><th width=\"100\">商品名称</th><th width=\"90\">供应商</th><th width=\"80\">数量 </th><th width=\"80\">采购额</th><th width=\"80\">折扣额 </th><th width=\"80\">税额</th><th width=\"100\">金额 </th></tr>");
        sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
           VBuyOrderDetail v=new VBuyOrderDetail();
            v=list[i];
            sb.Append("<tr><td ><img src=\"../images/tbtn_delete.gif\" onclick=\"javascript:if(!confirm('您确定要删除吗'))return  false;deleteDetail(" + v.DetailID + ")\";  /> </td>");
                sb.Append("	<td>"+v.ProductsID+"</td>");
               sb.Append("	<td>"+v.ProductsName+"</td>");
               sb.Append("	<td>"+v.SupplierName+"</td>");
               sb.Append("	<td>"+v.Quantity+"</td>");
               sb.Append("	<td>"+v.Price.ToString()+"</td>");
               sb.Append("	<td>"+v.DiscountRate.ToString()+"</td>");
               sb.Append("	<td>"+v.TaxRate.ToString()+"</td>");
               tatal = (v.Quantity * v.Price * (100 + v.TaxRate) / 100) - (v.Quantity * v.Price * v.DiscountRate / 100);
               sb.Append("	<td>" + tatal.ToString() + "</td>");
	         sb.Append("</tr>"); 
        
        }
        sb.Append("</tbody></table>");
        Response.Write(sb.ToString());
        Response.End();
    
    }

    
    /// <summary>
    /// 用于详细页面
    /// </summary>
    /// <param name="BuyOrderID"></param>
    protected void respAjaxforDetail(string BuyOrderID)
    {
        List<VBuyOrderDetail> list = new List<VBuyOrderDetail>();
        list = Leyp.SQLServerDAL.Buy.Factory.getBuyOrderDetailDAL().getBuyOrderDetailforAjaxString(BuyOrderID);
        StringBuilder sb = new StringBuilder();
       float tatal=float.Parse("0.00");

        sb.Append("<table   class=\"flexme2\"><thead><tr><th width=\"80\">商品编号</th><th width=\"100\">商品名称</th><th width=\"90\">供应商</th><th width=\"80\">数量 </th><th width=\"80\">采购额</th><th width=\"80\">折扣额 </th><th width=\"80\">税额</th><th width=\"100\">金额 </th></tr>");
        sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
            VBuyOrderDetail v = new VBuyOrderDetail();
            v = list[i];
            sb.Append("	<td>" + v.ProductsID + "</td>");
            sb.Append("	<td>" + v.ProductsName + "</td>");
            sb.Append("	<td>" + v.SupplierName + "</td>");
            sb.Append("	<td>" + v.Quantity + "</td>");
            sb.Append("	<td>" + v.Price.ToString() + "</td>");
            sb.Append("	<td>" + v.DiscountRate.ToString() + "</td>");
            sb.Append("	<td>" + v.TaxRate.ToString() + "</td>");
            tatal =( v.Quantity * v.Price * (100 + v.TaxRate) / 100) - (v.Quantity * v.Price * v.DiscountRate / 100);
            sb.Append("	<td>" + tatal.ToString()+ "</td>");
            sb.Append("</tr>");

        }
        sb.Append("</tbody></table>");
        Response.Write(sb.ToString());
        Response.End();

    }







}
