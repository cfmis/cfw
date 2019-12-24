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

public partial class Buy_MyBuyOrder : System.Web.UI.Page
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
        object action =Request.QueryString["action"];
        if (action != null)
        {

            if (action.ToString().Equals("Byorder"))
            {
                string buyOrderID = Request.QueryString["BuyOrderID"].ToString();

                List<VBuyOrder> list = new List<VBuyOrder>();
                list = Leyp.SQLServerDAL.Buy.Factory.getBuyOrderDAL().getUserBuyOrderByBuyOrderID("huhai123", buyOrderID);

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;
                

            }
            else
            {
                string str0 = Request.QueryString["baginData"].ToString();
                string str1 = Request.QueryString["endData"].ToString();
                string str2 = Request.QueryString["side"].ToString();

                if(str0.Equals(""))
                {
                  str0="1000";
                }
                if (str1.Equals(""))
                {
                    str1 = "3000";
                }

                List<VBuyOrder> list = new List<VBuyOrder>();
                list = Leyp.SQLServerDAL.Buy.Factory.getBuyOrderDAL().getUserOrderList("huhai123", str0, str1, int.Parse(str2), 0);

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;
            }
            
           

        }  
        else  //初始化页面
        {
            List<VBuyOrder> list = new List<VBuyOrder>();
            list = Leyp.SQLServerDAL.Buy.Factory.getBuyOrderDAL().getUserOrderList("huhai123", "2007", "2030", 0, 0);

            CollectionPager1.DataSource = list;
            CollectionPager1.BindToControl = OrderList;
            OrderList.DataSource = CollectionPager1.DataSourcePaged;

        }
    }



    
    /// <summary>
    /// 界面显示
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
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
        string str0 = BuyOrderID.Text.ToString();
        string str1 = baginData.Text.ToString();
        string str2 = endData.Text.ToString();
        string str3 = side.SelectedValue.ToString();

        if (str0.Equals("") || str0 == null)
        {

            Response.Redirect(string.Format("MyBuyOrder.aspx?action=no&baginData={0}&endData={1}&side={2}", str1, str2, str3), true);
          

        }
        else
        {
            Response.Redirect("MyBuyOrder.aspx?action=Byorder&BuyOrderID=" + str0 + "", true);
        
        }
    }
}
