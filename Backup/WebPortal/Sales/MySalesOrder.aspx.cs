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
using Leyp.Components;
using System.IO;

public partial class Sales_MySalesOrder : SalesOrderModule
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
        object action = Request.QueryString["action"];
        object excel = Request.QueryString["excel"];
        
        if (action != null)
        {

            if (action.ToString().Equals("ByID"))
            {
                string bID = Request.QueryString["ID"].ToString();

                List<VSalesOrder> list = new List<VSalesOrder>();
                list = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getSearchListByID(bID);

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;
                if (excel != null)
                {
                    createExcel(list);
                }


            }
            else
            {
                string str0 = Request.QueryString["baginData"].ToString();
                string str1 = Request.QueryString["endData"].ToString();
                string str2 = Request.QueryString["side"].ToString();

                if (str0.Equals(""))
                {
                    str0 = "1000";
                }
                if (str1.Equals(""))
                {
                    str1 = "3000";
                }

                List<VSalesOrder> list = new List<VSalesOrder>();
                list = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getSearchListByUserName(str0, str1, int.Parse(str2),getUserName());

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;

                if (excel != null)
                {
                    createExcel(list);

                }
            }



        }
        else  //初始化页面
        {
            List<VSalesOrder> list = new List<VSalesOrder>();
            list = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getSearchListByUserName("2000", "2050", 1,getUserName());

            CollectionPager1.DataSource = list;
            CollectionPager1.BindToControl = OrderList;
            OrderList.DataSource = CollectionPager1.DataSourcePaged;

        }
    }
    protected void Select_Click(object sender, EventArgs e)
    {
        string str0 = OrderID.Text.ToString();
        string str1 = baginData.Text.ToString();
        string str2 = endData.Text.ToString();
        string str3 = side.SelectedValue.ToString();

        if (str0.Equals("") || str0 == null)
        {

            Response.Redirect(string.Format("MySalesOrder.aspx?action=no&baginData={0}&endData={1}&side={2}", str1, str2, str3), true);


        }
        else
        {
            Response.Redirect("MySalesOrder.aspx?action=ByID&ID=" + str0 + "", true);

        }
    }


    public string changString(string str)
    {

        if (str.Equals("1"))
        {
            return "<font color=\"#009933\">已审</font>";
        }
        else if (str.Equals("0"))
        {
            return "<font color=\"#FF0000\">未审</font>";
        }
        else if (str.Equals("-1"))
        {
            return "<font color=\"#FF0000\">未交款单</font>";
        }
        else if (str.Equals("2"))
        {
            return "已审/已成出库单";
        }
        
        else
        {
            return str;
        }

    }



    private void createExcel(List<VSalesOrder> list)
    {

        StringBuilder sb = new StringBuilder();
        sb.Append("<table width=350 border=0><tr><td>订单号</td><td>日期</td><td>交货方式</td><td>结算方式</td><td>顾客名称</td><td>合计金额</td> <td>状态</td></tr>");
         int len=list.Count;


         for (int i = 0; i < len; i++)
         {
             VSalesOrder vs = list[i];
             
             sb.Append(" <tr>");
             sb.Append("<td>"+vs.SalesOrderID+"</td>");
             sb.Append("<td>"+vs.CreateDate+"</td>");
             sb.Append("<td>" + vs.DeliveryType + "</td>");
             sb.Append("<td>" + vs.ClosingType + "</td>");
             sb.Append("<td>" + vs.CustomerName + "</td>");
             sb.Append("<td>" + vs.SalesIncome.ToString() + "</td>");
             sb.Append("<td>" + changString(vs.State.ToString()) + "</td>");
             sb.Append(" </tr>");
         }
         sb.Append("</table>");

         string sr = StrHelper.GetRamCode();

         string path = System.Web.HttpContext.Current.Server.MapPath("../UploadFiles/" + sr + ".xls");
         FileStream NewText = File.Create(path);
         NewText.Close();

         FileStream TextFile = File.Open(path, FileMode.Append);
        
         TextFile.Write((System.Text.Encoding.Default.GetBytes(sb.ToString().ToCharArray())), 0, System.Text.Encoding.Default.GetBytes(sb.ToString().ToCharArray()).Length);
         TextFile.Close();

         Response.Redirect("../UploadFiles/" + sr + ".xls");



    }


    protected void Button4_Click(object sender, EventArgs e)
    {
        string str0 = OrderID.Text.ToString();
        string str1 = baginData.Text.ToString();
        string str2 = endData.Text.ToString();
        string str3 = side.SelectedValue.ToString();

        if (str0.Equals("") || str0 == null)
        {

            Response.Redirect(string.Format("MySalesOrder.aspx?excel=ok&action=no&baginData={0}&endData={1}&side={2}", str1, str2, str3), true);


        }
        else
        {
            Response.Redirect("MySalesOrder.aspx?excel=ok&action=ByID&ID=" + str0 + "", true);

        }
    }
}
