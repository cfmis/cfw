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
using Leyp.Model;
using Leyp.Components.Module;
using Leyp.Components;

public partial class Flow_PhotoFlow_List : PhotoFlowModule
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

          List<PhotoFlow> list = new List<PhotoFlow>();
          list = Leyp.SQLServerDAL.Factory.getPhotoFlowDAL().getSearchList();

            CollectionPager1.DataSource = list;
            CollectionPager1.BindToControl = OrderList;
            OrderList.DataSource = CollectionPager1.DataSourcePaged;

     
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
