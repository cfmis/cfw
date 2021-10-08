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
using Leyp.Model.Sales;
using Leyp.Components.Module;

public partial class Sales_FindSalesOrder_DispatchState : BasePage
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
       List<VSalesDispatch> list = new List<VSalesDispatch>();
       Leyp.SQLServerDAL.Sales.SalesDispatchDAL dl = new Leyp.SQLServerDAL.Sales.SalesDispatchDAL();
        if (action == null)
        { 
        
        }else if(action.ToString().Equals("MyOrder"))
        {
        
                List<VSalesOrder> listOrder = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getSearchListByUserName("1000", "3000", 2, getUserName());
                for (int i = 0; i < listOrder.Count; i++)//通过已经审核的销售订单查找用户的单据发货情况
                {
                    VSalesOrder vo = listOrder[i];
                    VSalesDispatch vd = dl.getBySalesOrderID(vo.SalesOrderID);
                    if (vd != null)
                    {

                        list.Add(vd);
                    }          
                
                }

        }else if (action.ToString().Equals("OrderID"))
        {
            string OrderID = Request.QueryString["SalesOrderID"].ToString();
            VSalesDispatch ds = dl.getBySalesOrderID(OrderID);
            if (ds != null)
            {

             list.Add(ds);
            }  


        }

        CollectionPager1.DataSource = list;
        CollectionPager1.BindToControl = OrderList;
        OrderList.DataSource = CollectionPager1.DataSourcePaged;
             
    }


    //protected void myOrder_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("FindSalesOrder_DispatchState.aspx?action=MyOrder", true);
    //}


    protected void Select_Click(object sender, EventArgs e)
    {
        string str = SalesOrderID.Text.ToString();
        if (!"".Equals(str.ToString()))
        {
            Response.Redirect("FindSalesOrder_DispatchState.aspx?action=OrderID&SalesOrderID=" + str, true);
        }
        else
        {
            return;
        }
    }


    public string changString(string str)
    {

        if (str.Equals("1"))
        {
            return "<font color=\"#009933\">正常发货</font>";
        }
        else if (str.Equals("0"))
        {
            return "<font color=\"#FF0000\">未发货</font>";
        }
        else if (str.Equals("2"))
        {
            return "问题返回件";
        }
        else
        {
            return str;
        }

    }
}
