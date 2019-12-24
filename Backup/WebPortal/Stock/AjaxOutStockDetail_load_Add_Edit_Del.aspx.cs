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
using Leyp.Model.Stock;
using System.Text;
using Leyp.Components.Module.Stock;

public partial class Stock_AjaxOutStockDetail_load_Add_Edit_Del : System.Web.UI.Page
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
        if (action.Equals("load"))
        {
            string str0 = Request.Form["OutID"].ToString();
            loadinit(str0);


        }
        else if (action.Equals("del"))
        {
            string str1 = Request.Form["DetailID"].ToString();
            deleteNode(int.Parse(str1));

        }
        else if (action.Equals("add"))
        {

            #region add
            string str0 = Request.Form["OutID"].ToString();
            string str1 = Request.Form["ProductsID"].ToString();
            string str3 = Request.Form["Quantity"].ToString();

            string str6 = Request.Form["Descriptions"].ToString();
            string str7 = Request.Form["Price"].ToString();
            OutStockDetail b = new OutStockDetail();
            b.OutID = str0;
            b.ProductsID = int.Parse(str1);
            b.Quantity = int.Parse(str3);
            b.Description = str6;
            b.Price = float.Parse(str7);
            if (Leyp.SQLServerDAL.Stock.Factory.getOutStockDetailDAL().insertNewEitity(b))
            {
                Response.Write("添加成功");
                Response.End();
            }
            else
            {
                Response.Write("添加失败");
                Response.End();
            }
            #endregion

        }





    }

    /// <summary>
    /// 删除一个实体
    /// </summary>
    /// <param name="id"></param>
    protected void deleteNode(int id)
    {
        Leyp.SQLServerDAL.Stock.Factory.getOutStockDetailDAL().deleteEitity(id);
        Response.Write("删除成功");
        Response.End();

    }


    /// <summary>
    /// 加载全部
    /// </summary>
    /// <param name="ReceiptOrderID"></param>
    protected void loadinit(string OutID)
    {
        List<VOutStockDetail> list = new List<VOutStockDetail>();
        list = Leyp.SQLServerDAL.Stock.Factory.getOutStockDetailDAL().getListByOutID(OutID);

        StringBuilder sb = new StringBuilder();


        sb.Append("<table   class=\"flexme2\"><thead><tr><th width=\"70\">操作</th><th width=\"80\">商品编号</th><th width=\"100\">商品名称</th><th width=\"80\">数量 </th><th width=\"80\">价格</th><th width=\"100\">金额 </th></tr>");
        sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
            VOutStockDetail v = new VOutStockDetail();
            v = list[i];
            sb.Append("<tr><td > &nbsp;&nbsp;<img src=\"../images/tbtn_delete.gif\" onclick=\"javascript:if(!confirm('您确定要删除吗'))return  false;deleteDetail(" + v.DetailID + ")\";  /> </td>");
            sb.Append("	<td>" + v.ProductsID + "</td>");
            sb.Append("	<td>" + v.ProductsName + "</td>");
            sb.Append("	<td>" + v.Quantity + "</td>");
            sb.Append("	<td>" + v.Price.ToString() + "</td>");
            sb.Append("	<td>" + v.Quantity * v.Price + "</td>");
            sb.Append("</tr>");

        }
        sb.Append("</tbody></table>");
        Response.Write(sb.ToString());
        Response.End();


    }

}
