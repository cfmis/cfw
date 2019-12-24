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
using Leyp.Model;
using Leyp.Components.Module.Sales;
using Leyp.Components;


public partial class Sales_NQ_Select_SalesOutWindows : System.Web.UI.Page
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
        if (action != null)
        {
            if (action.ToString().Equals("view"))
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

                List<VSalesOut> list = new List<VSalesOut>();
                list = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().getSearchList(str0, str1, int.Parse(str2));

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;
            }
            else if (action.ToString().Equals("sel"))
            {

                string id = Request.QueryString["ID"].ToString();
                VSalesOut o = new VSalesOut();
                o = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().getByID(id);
                VSalesOrder os = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getByID(o.SalesOrderID);

                Jscript.CloseWindowReturnValues(o.SalesOutID+"$$$"+os.DeliveryType);
                return;

            }




        }
        else  //初始化页面
        {
            List<VSalesOut> list = new List<VSalesOut>();
            list = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().getSearchList("1000", "2050", 2);

            CollectionPager1.DataSource = list;
            CollectionPager1.BindToControl = OrderList;
            OrderList.DataSource = CollectionPager1.DataSourcePaged;

        }
    }


    protected void Select_Click(object sender, EventArgs e)
    {

        string str1 = baginData.Text.ToString();
        string str2 = endData.Text.ToString();

        if (str1.Equals("") || str1 == null)
        {

            Response.Redirect(string.Format("NQ_Select_SalesOutWindows.aspx?action=view&baginData={0}&endData={1}&side=2", str1, str2), true);


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
        else if (str.Equals("2"))
        {
            return "已出库";
        }
        else
        {
            return str;
        }

    }



}
