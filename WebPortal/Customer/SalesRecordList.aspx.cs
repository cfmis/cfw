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

public partial class Customer_SalesRecordList : SalesRecordModule
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
        Response.Write("该模块作废");
        Response.End();
        return;
        object action = Request.QueryString["action"];
        if (action != null)
        {

            if (action.ToString().Equals("ByPlatform"))
            {
                string bID = Request.QueryString["Platform"].ToString();

                List<VSalesRecord> list = new List<VSalesRecord>();
                list = Leyp.SQLServerDAL.Sales.Factory.getSalesRecordDAL().getListByPlatformID(int.Parse(bID));
                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;


            }
            else if (action.ToString().Equals("ByPCID"))
            {
                string str0 = Request.QueryString["Platform"].ToString();
                string str1 = Request.QueryString["CustomerID"].ToString();
               

                if (str0.Equals(""))
                {
                    str0 = "1";
                }
                if (str1.Equals(""))
                {
                    str1 = "3000";
                }

                List<VSalesRecord> list = new List<VSalesRecord>();
                list = Leyp.SQLServerDAL.Sales.Factory.getSalesRecordDAL().getListByCustomerID(int.Parse(str0), str1);

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;
            }
            else if (action.ToString().Equals("All"))
            {

                List<VSalesRecord> list = new List<VSalesRecord>();
                list = Leyp.SQLServerDAL.Sales.Factory.getSalesRecordDAL().getAll();

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;

            }



        }
        else  //初始化页面
        {
            List<VSalesRecord> list = new List<VSalesRecord>();
            list = Leyp.SQLServerDAL.Sales.Factory.getSalesRecordDAL().getListByUserName(getUserName());

            CollectionPager1.DataSource = list;
            CollectionPager1.BindToControl = OrderList;
            OrderList.DataSource = CollectionPager1.DataSourcePaged;

        }
    }
    protected void Select_Click(object sender, EventArgs e)
    {
        string str0 = OrderID.Text.ToString();
        string str1 = PlatformIDDropDownList.SelectedValue.ToString();

        if (str0.Equals("") || str0 == null)
        {

            Response.Redirect(string.Format("SalesRecordList.aspx?action=ByPlatform&Platform={0}", str1), true);


        }
        else
        {
            Response.Redirect(string.Format("SalesRecordList.aspx?action=ByPCID&Platform={0}&CustomerID={1}", str1, str0), true);

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("SalesRecordList.aspx?action=All", true);

    }
}
