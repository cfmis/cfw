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

public partial class Stock_Manager_AppendStockOrder : System.Web.UI.Page
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
                string bID = Request.QueryString["AppendID"].ToString();

                List<VAppendStock> list = new List<VAppendStock>();
                list = Leyp.SQLServerDAL.Stock.Factory.getAppendStockDAL().getSearchListByID(bID);

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;


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

                List<VAppendStock> list = new List<VAppendStock>();
                list = Leyp.SQLServerDAL.Stock.Factory.getAppendStockDAL().getSearchList(str0, str1, int.Parse(str2));

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;
            }



        }
        else  //初始化页面
        {
            List<VAppendStock> list = new List<VAppendStock>();
            list = Leyp.SQLServerDAL.Stock.Factory.getAppendStockDAL().getSearchList("2000", "2050", 1);

            CollectionPager1.DataSource = list;
            CollectionPager1.BindToControl = OrderList;
            OrderList.DataSource = CollectionPager1.DataSourcePaged;

        }
    }




    protected void Select_Click(object sender, EventArgs e)
    {
        string str0 = TransferringOrderID.Text.ToString();
        string str1 = baginData.Text.ToString();
        string str2 = endData.Text.ToString();
        string str3 = side.SelectedValue.ToString();

        if (str0.Equals("") || str0 == null)
        {

            Response.Redirect(string.Format("Manager_AppendStockOrder.aspx?action=no&baginData={0}&endData={1}&side={2}", str1, str2, str3), true);


        }
        else
        {
            Response.Redirect("Manager_AppendStockOrder.aspx?action=ByID&AppendID=" + str0 + "", true);

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

    public string changString0(string str)
    {

        if (str.Equals("0"))
        {
            return "报溢";
        }
        else if (str.Equals("1"))
        {
            return "借入";
        }
        else if (str.Equals("2"))
        {
            return "借出还入";
        }
        else if (str.Equals("3"))
        {
            return "受赠";
        }
        else if (str.Equals("4"))
        {
            return "其他入仓";
        }
        else
        {
            return "";
        }

    }


}
