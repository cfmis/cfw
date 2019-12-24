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

public partial class Buy_Manager_BuyPayOrder : System.Web.UI.Page
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

            if (action.ToString().Equals("ByID"))
            {
                string OrderID = Request.QueryString["ReceiptOrderID"].ToString();

                List<VBuyPay> list = new List<VBuyPay>();
                list = Leyp.SQLServerDAL.Buy.Factory.getBuyPayDAL().getByBuyReceiptID(OrderID);

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;


            }
            else
            {
                string str0 = Request.QueryString["baginData"].ToString();
                string str1 = Request.QueryString["endData"].ToString();
                string str2 = Request.QueryString["side"].ToString();

                if (str0.Equals("") || str0 == null)
                {
                    str0 = "1000";
                }
                if (str1.Equals("") || str1 == null)
                {
                    str1 = "3000";
                }

                List<VBuyPay> list = new List<VBuyPay>();
                list = Leyp.SQLServerDAL.Buy.Factory.getBuyPayDAL().getBuyPayOrderList(str0, str1, int.Parse(str2));

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;
            }



        }
        else  //初始化页面
        {
            List<VBuyPay> list = new List<VBuyPay>();
            list = Leyp.SQLServerDAL.Buy.Factory.getBuyPayDAL().getBuyPayOrderList("1000", "3000", 1);

            CollectionPager1.DataSource = list;
            CollectionPager1.BindToControl = OrderList;
            OrderList.DataSource = CollectionPager1.DataSourcePaged;

        }
    }

    public string changString(string str)
    {

        if (str.Equals("1"))
        {
            return "<font color=\"#009933\">已审</font>";
        }
        else
        {
            return "<font color=\"#FF0000\">未审</font>";
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

            Response.Redirect(string.Format("Manager_BuyPayOrder.aspx?action=no&baginData={0}&endData={1}&side={2}", str1, str2, str3), true);


        }
        else
        {
            Response.Redirect("Manager_BuyPayOrder.aspx?action=ByID&ReceiptOrderID=" + str0 + "", true);

        }
    }
}
