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
using Leyp.Model.View;
using Leyp.Components.Module;
public partial class Customer_My_ServiceInfoList : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            init();
        }


    }

    /// <summary>
    /// 
    /// </summary>
    protected void init()
    {
            List<VServiceInfo> list = new List<VServiceInfo>();
            list = Leyp.SQLServerDAL.Factory.getServiceInfoDAL().getMyTopic(getUserName());
            CollectionPager1.DataSource = list;
            CollectionPager1.BindToControl = OrderList;
            OrderList.DataSource = CollectionPager1.DataSourcePaged;
    }
   

    public string changString(string str)
    {

        if (str.Equals("1"))
        {
            return "<font color=\"#009933\">已受理</font>";
        }
        else if (str.Equals("0"))
        {
            return "<font color=\"#FF0000\">未受理</font>";
        }
        else if (str.Equals("2"))
        {
            return "<font color=\"#009933\">已解决</font>";
        }
        else if (str.Equals("3"))
        {
            return "<font color=\"#FF0000\">已过期/作废</font>";
        }

        else
        {
            return str;
        }

    }
}
