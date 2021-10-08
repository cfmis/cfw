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
using Leyp.Components.Module;
using Leyp.Model.View;

public partial class Sales_AjaxSalesOutDetail_load_Add_Edit_Del : BasePage
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
            string str0 = Request.Form["SalesOutID"].ToString();
            string str1 = Request.Form["ProductsID"].ToString();
            string str2 = Request.Form["Price"].ToString();
            string str3 = Request.Form["Quantity"].ToString();
            string str4 = Request.Form["DiscountRate"].ToString();
            string str5 = Request.Form["Descriptions"].ToString();

            SalesOutDetail d = new SalesOutDetail();
            d.SalesOutID = str0;
            d.ProductsID = int.Parse(str1);
            d.Price = float.Parse(str2);
            d.Quantity = int.Parse(str3);
            d.DiscountRate = float.Parse(str4);
            d.Description = str5;
            Leyp.SQLServerDAL.Sales.Factory.getSalesOutDetailDAL().insertNewEitity(d);
            Response.Write("00");
            Response.End();

        }
        else if (action.Equals("LoadDetail"))//加载明细BY  SalesOrderID
        {
            string str0 = Request.Form["SalesOutID"].ToString();
            loadinit(str0);

        }
        else if (action.Equals("delDetail"))//delete
        {
            string str0 = Request.Form["DetailID"].ToString();
            Leyp.SQLServerDAL.Sales.Factory.getSalesOutDetailDAL().deleteEitity(int.Parse(str0));
            Response.Write("00");
            Response.End();
        }
        else if (action.Equals("getNode"))//得到编辑节点
        {
            getNode();
        }
        else if (action.Equals("editDetail"))//编辑节点
        {

            string str0 = Request.Form["SalesOutID"].ToString();
            string str1 = Request.Form["ProductsID"].ToString();
            string str2 = Request.Form["Price"].ToString();
            string str3 = Request.Form["Quantity"].ToString();
            string str4 = Request.Form["DiscountRate"].ToString();
            string str5 = Request.Form["Descriptions"].ToString();
            string str6 = Request.Form["DetailID"].ToString();

            string str7 = Request.Form["StoreHouseID"].ToString();
            string str8 = Request.Form["HouseDetailID"].ToString();

            SalesOutDetail d = new SalesOutDetail();
            d.SalesOutID = str0;
            d.ProductsID = int.Parse(str1);
            d.Price = float.Parse(str2);
            d.Quantity = int.Parse(str3);
            d.DiscountRate = float.Parse(str4);
            d.Description = str5;
            d.DetailID = int.Parse(str6);
            d.StoreHouseID = int.Parse(str7);
            d.HouseDetailID = int.Parse(str8);
            Leyp.SQLServerDAL.Sales.Factory.getSalesOutDetailDAL().updateEitity(d);
            Response.Write("00");
            Response.End();


        }
        else if (action.Equals("LoadDetailEdit"))//编辑节点
        {
            string str0 = Request.Form["SalesOutID"].ToString();
            loadinitEdit(str0);
        }
        else if (action.Equals("checkEdit"))//检查仓库编辑完成了没有
        {
            string str0 = Request.Form["SalesOutID"].ToString();
            checkEdit(str0);

        }
        else if (action.Equals("LoadDetailPrint"))//快递单打印
        {
            string str0 = Request.Form["SalesOutID"].ToString();
            LoadDetailPrint(str0);

        }
        else if (action.Equals("checkProductsNum"))//得到一个库区一个商品数量
        {
            string PID = Request.Form["ProductsID"].ToString();
            string HID = Request.Form["HouseDetailID"].ToString();
            Response.Clear();
            checkProductsNum(int.Parse(HID),int.Parse(PID));

        }



        
    }



    /// <summary>
    /// 加载全部
    /// </summary>
    /// <param name="ReceiptOrderID"></param>
    protected void loadinit(string SalesOutID)
    {
        #region
        List<VSalesOutDetail> list = new List<VSalesOutDetail>();
        list = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDetailDAL().getBySalesOutID(SalesOutID);
        float tatal = float.Parse("0.00");
        StringBuilder sb = new StringBuilder();


        sb.Append("<table   class=\"flexme2\"><thead><tr><th width=\"70\">操作</th><th width=\"80\">商品编号</th><th width=\"100\">商品名称</th><th width=\"80\">数量 </th><th width=\"80\">价格</th><th width=\"80\">折扣额 </th><th width=\"100\">金额 </th></tr>");
        sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
            VSalesOutDetail v = new VSalesOutDetail();
            v = list[i];
            sb.Append("<tr><td ><img src=\"../images/tbtn_amend.gif\" onclick=\"editDetail(" + v.DetailID + ")\";  /> &nbsp;&nbsp;<img src=\"../images/tbtn_delete.gif\" onclick=\"javascript:if(!confirm('您确定要删除吗'))return  false;deleteDetail(" + v.DetailID + ")\";  /> </td>");
            sb.Append("	<td>" + v.ProductsID + "</td>");
            sb.Append("	<td>" + v.ProductsName + "</td>");
            sb.Append("	<td>" + v.Quantity + "</td>");
            sb.Append("	<td>" + v.Price.ToString() + "</td>");
            sb.Append("	<td>" + v.DiscountRate.ToString() + "</td>");

            tatal = v.Quantity * v.Price - (v.Quantity * v.Price * v.DiscountRate / 100);
            sb.Append("	<td>" + tatal.ToString() + "</td>");
            sb.Append("</tr>");

        }
        sb.Append("</tbody></table>");
        Response.Write(sb.ToString());
        Response.End();
        #endregion
    }


    /// <summary>
    /// 加载全部没有编辑仓库 
    /// </summary>
    /// <param name="ReceiptOrderID"></param>
    protected void loadinitEdit(string SalesOutID)
    {
        #region

        List<VSalesOutDetail> list = new List<VSalesOutDetail>();
        list = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDetailDAL().getBySalesOutIDinit(SalesOutID);
        float tatal = float.Parse("0.00");
        StringBuilder sb = new StringBuilder();


        sb.Append("<table class=\"flexme2\"><thead><tr><th width=\"50\">操作</th><th width=\"60\">商品编号</th><th width=\"100\">商品名称</th><th width=\"80\">数量</th><th width=\"80\">库房号 </th><th width=\"80\">库区号 </th><th width=\"80\">价格</th><th width=\"80\">折扣额 </th><th width=\"100\">金额 </th></tr>");
        sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
            VSalesOutDetail v = new VSalesOutDetail();
            v = list[i];
            sb.Append("<tr><td ><img src=\"../images/tbtn_amend.gif\" onclick=\"editDetail(" + v.DetailID + ")\";  /> &nbsp;&nbsp; </td>");
            sb.Append("	<td>" + v.ProductsID + "</td>");
            sb.Append("	<td>" + v.ProductsName + "</td>");
            sb.Append("	<td>" + v.Quantity + "</td>");

           sb.Append(" <td>" + getcheckNode(v.StoreHouseID) + "</td>");

           sb.Append(" <td>" + getcheckNode(v.HouseDetailID) + "</td>");


            sb.Append("	<td>" + v.Price.ToString() + "</td>");
            sb.Append("	<td>" + v.DiscountRate.ToString() + "</td>");

            tatal = v.Quantity * v.Price - (v.Quantity * v.Price * v.DiscountRate / 100);
            sb.Append("	<td>" + tatal.ToString() + "</td>");
            sb.Append("</tr>");

        }
        sb.Append("</tbody></table>");
        Response.ClearContent();
        Response.Write(sb.ToString());
        Response.End();
        #endregion
    }

    /// <summary>
    /// 快递单打印
    /// </summary>
    /// <param name="ReceiptOrderID"></param>
    protected void LoadDetailPrint(string SalesOutID)
    {
        #region

        List<VSalesOutDetail> list = new List<VSalesOutDetail>();
        list = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDetailDAL().getBySalesOutIDinit(SalesOutID);
        float tatal = float.Parse("0.00");
        StringBuilder sb = new StringBuilder();


        sb.Append("<TABLE id=MyDataGrid class=\"MyDataGrid\"borderColor=black cellSpacing=0 cellPadding=0 rules=all align=center border=1><TBODY><TR style=\"FONT-WEIGHT: bold; BACKGROUND-COLOR: #b9c6ff\" align=middle><TD width=\"150\">商品编号</TD><TD width=\"250\" align=middle>商品名称</TD><TD width=\"100\" align=middle> 数量</TD><TD align=middle></TD></TR>");
        //sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
            VSalesOutDetail v = list[i];
            sb.Append("<TR onMouseOver=\"this.className='onmouseover'\" onmouseout=\"this.className=''\">");
            sb.Append("	<td>" + v.ProductsID + "</td>");
            sb.Append("	<td>" + v.ProductsName + "</td>");
            sb.Append("	<td>" + v.Quantity + "</td>");
            sb.Append("	<td></td>");
            sb.Append("</TR >");

        }
        sb.Append("</table>");
        Response.Write(sb.ToString());
        Response.End();
        #endregion
    }

    private string getcheckNode(int vla)
    {
        if (vla < 1)
            return "<font color=\"#FF0000\">请选择</font>";
        else
            return vla.ToString();
    }
    
    /// <summary>
    /// 输入一个实体节点
    /// </summary>
    public void getNode()
    {
        string str0 = Request.Form["DetailID"].ToString();
          
        VSalesOutDetail s =new VSalesOutDetail();
        s = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDetailDAL().getByID(int.Parse(str0));
        Response.Write(s.DetailID + "$" + s.ProductsID + "$" + s.ProductsName + "$" + s.Price + "$" + s.Quantity + "$" + s.DiscountRate + "$" + s.Description + "$" + s.StoreHouseID + "$" + s.HouseDetailID);
        Response.End();
    
    
    }

    private void checkEdit(string SalesOutID)
    {
        #region
        bool reslut = true;
        List<VSalesOutDetail> list = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDetailDAL().getBySalesOutIDinit(SalesOutID);
        for (int i = 0; i < list.Count; i++)
        {
            VSalesOutDetail v = list[i];
            if (v.HouseDetailID < 1)
            {
                reslut = false;
            }
        
        }
        if (reslut)
        {
            Response.Write("0");//编辑全部完成
            Response.End();
        }
        else
        {
            Response.Write("1");//编辑没有完
            Response.End();
        }
        #endregion

    }

    private void checkProductsNum(int HID,int PID)
    {

        VProductsStock v = Leyp.SQLServerDAL.Factory.getProductsStockDAL().getByProductsIDStockID(PID, HID);

        if (v == null)
        {
            Response.Write("0");
            Response.End();
        }
        else
        {
            Response.Write(v.Num);
            Response.End();
        }
 
    }
}
