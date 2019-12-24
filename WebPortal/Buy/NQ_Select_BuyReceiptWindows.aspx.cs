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
using Leyp.Components;

public partial class Buy_NQ_Select_BuyReceiptWindows : System.Web.UI.Page
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
            if (action.ToString().Equals("date"))
            {
                string str0 = Request.QueryString["baginData"].ToString();
                string str1 = Request.QueryString["endData"].ToString();
                if (str0.Equals(""))
                {
                    str0 = "1000";
                }
                if (str1.Equals(""))
                {
                    str1 = "3000";
                }

                List<VBuyReceipt> list = new List<VBuyReceipt>();
                list = Leyp.SQLServerDAL.Buy.Factory.getBuyReceiptDAL().getAdminBuyReceiptOrderList(str0, str1, 2);

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;
            }
            else
            {
                string id = Request.QueryString["ID"].ToString();
                BuyReceipt o = new BuyReceipt();
                o = Leyp.SQLServerDAL.Buy.Factory.getBuyReceiptDAL().getByID(id);

                Jscript.CloseWindowReturnValues(o.ReceiptOrderID + "$$$" + o.StoreHouseID + "$$$" + o.HouseDetailID);
                return;

            }




        }
        else  //初始化页面
        {
            List<VBuyReceipt> list = new List<VBuyReceipt>();
            list = Leyp.SQLServerDAL.Buy.Factory.getBuyReceiptDAL().getAdminBuyReceiptOrderList("1000", "3000",2);

            CollectionPager1.DataSource = list;
            CollectionPager1.BindToControl = OrderList;
            OrderList.DataSource = CollectionPager1.DataSourcePaged;

        }
    }


    protected void Select_Click(object sender, EventArgs e)
    {

        string str1 = baginData.Text.ToString();
        string str2 = endData.Text.ToString();

        if (str1.Equals("") && str2.Equals(""))
        {

            Response.Redirect("NQ_Select_BuyReceiptWindows.aspx");

        }
        else
        {

            Response.Redirect(string.Format("NQ_Select_BuyReceiptWindows.aspx?action=date&baginData={0}&endData={1}", str1, str2), true);

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
}
