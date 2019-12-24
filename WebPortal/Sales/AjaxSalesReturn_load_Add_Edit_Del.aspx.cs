using System;
using System.Text;
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
using Leyp.Model.Sales;
using Leyp.Components.Module.Sales;

public partial class Sales_AjaxSalesReturn_load_Add_Edit_Del : System.Web.UI.Page
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
        if (action.Equals("addDetail"))//明细添加
        {
            string str0 = Request.Form["SalesReturnID"].ToString();
            string str1 = Request.Form["ProductsID"].ToString();
            string str2 = Request.Form["Price"].ToString();
            string str3 = Request.Form["Quantity"].ToString();
            string str4 = Request.Form["Descriptions"].ToString();

            SalesReturnDetail d = new SalesReturnDetail();
            d.SalesReturnID= str0;
            d.ProductsID = int.Parse(str1);
            d.Price = float.Parse(str2);
            d.Quantity = int.Parse(str3);
            d.Description = str4;
            Leyp.SQLServerDAL.Sales.Factory.getSalesReturnDetailDAL().insertNewEitity(d);
            Response.Write("00");
            Response.End();

        }
        else if (action.Equals("LoadDetail"))//加载明细BY  SalesOrderID
        {
            string str0 = Request.Form["SalesReturnID"].ToString();
            loadinit(str0);

        }
        else if (action.Equals("delDetail"))//delete
        {
            string str0 = Request.Form["DetailID"].ToString();
            Leyp.SQLServerDAL.Sales.Factory.getSalesReturnDetailDAL().deleteEitity(int.Parse(str0));
            Response.Write("00");
            Response.End();
        }
        else if (action.Equals("getNode"))//得到编辑节点
        {
            getNode();
        }
        else if (action.Equals("editDetail"))//编辑节点
        {

            string str0 = Request.Form["SalesReturnID"].ToString();
            string str1 = Request.Form["ProductsID"].ToString();
            string str2 = Request.Form["Price"].ToString();
            string str3 = Request.Form["Quantity"].ToString();
            string str4 = Request.Form["Descriptions"].ToString();
            string str5 = Request.Form["DetailID"].ToString();

            SalesReturnDetail d = new SalesReturnDetail();
            d.SalesReturnID = str0;
            d.ProductsID = int.Parse(str1);
            d.Price = float.Parse(str2);
            d.Quantity = int.Parse(str3);
  
            d.Description = str4;
            d.DetailID = int.Parse(str5);
            Leyp.SQLServerDAL.Sales.Factory.getSalesReturnDetailDAL().updateEitity(d);
            Response.Write("00");
            Response.End();


        }

    }



    /// <summary>
    /// 加载全部
    /// </summary>
    /// <param name="ReceiptOrderID"></param>
    protected void loadinit(string SalesReturnID)
    {
        List<VSalesReturnDetail> list = new List<VSalesReturnDetail>();
        list = Leyp.SQLServerDAL.Sales.Factory.getSalesReturnDetailDAL().getBySalesReturnID(SalesReturnID);
        float tatal = float.Parse("0.00");
        StringBuilder sb = new StringBuilder();


        sb.Append("<table   class=\"flexme2\"><thead><tr><th width=\"70\">操作</th><th width=\"80\">商品编号</th><th width=\"100\">商品名称</th><th width=\"80\">数量 </th><th width=\"80\">价格</th><th width=\"100\">金额 </th></tr>");
        sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
            VSalesReturnDetail v = new VSalesReturnDetail();
            v = list[i];
            sb.Append("<tr><td ><img src=\"../images/tbtn_amend.gif\" onclick=\"editDetail(" + v.DetailID + ")\";  /> &nbsp;&nbsp;<img src=\"../images/tbtn_delete.gif\" onclick=\"javascript:if(!confirm('您确定要删除吗'))return  false;deleteDetail(" + v.DetailID + ")\";  /> </td>");
            sb.Append("	<td>" + v.ProductsID + "</td>");
            sb.Append("	<td>" + v.ProductsName + "</td>");
            sb.Append("	<td>" + v.Quantity + "</td>");
            sb.Append("	<td>" + v.Price.ToString() + "</td>");

            tatal = v.Quantity * v.Price;
            sb.Append("	<td>" + tatal.ToString() + "</td>");
            sb.Append("</tr>");

        }
        sb.Append("</tbody></table>");
        Response.Write(sb.ToString());
        Response.End();
    }

    /// <summary>
    /// 输入一个实体节点
    /// </summary>
    public void getNode()
    {
        string str0 = Request.Form["DetailID"].ToString();

        VSalesReturnDetail s = new VSalesReturnDetail();
        s = Leyp.SQLServerDAL.Sales.Factory.getSalesReturnDetailDAL().getByID(int.Parse(str0));
        Response.Write(s.DetailID + "$" + s.ProductsID + "$" + s.ProductsName + "$" + s.Price + "$" + s.Quantity +"$" + s.Description);
        Response.End();


    }
}
