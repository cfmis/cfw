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

public partial class Notice_NoticeList : BasePage
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

            if (action.ToString().Equals("ByType"))
            {
                string ID = Request.QueryString["Type"].ToString();

                List<Notice> list = new List<Notice>();
                list = Leyp.SQLServerDAL.Factory.getNoticeDAL().getSearchListByType(int.Parse(ID));

                CollectionPager1.DataSource = list;
                CollectionPager1.BindToControl = OrderList;
                OrderList.DataSource = CollectionPager1.DataSourcePaged;
            }

        }
        //else  //初始化页面
        //{
        //    List<Notice> list = new List<Notice>();
        //    list = Leyp.SQLServerDAL.Factory.getNoticeDAL().getAll();

        //    CollectionPager1.DataSource = list;
        //    CollectionPager1.BindToControl = OrderList;
        //    OrderList.DataSource = CollectionPager1.DataSourcePaged;

        //}


        if (getTypeID() != 0)//不是内部员工
        {
            NewType.Items.Remove(NewType.Items.FindByValue("2"));
        }

    }



   

    protected void Button1_Click(object sender, EventArgs e)
    {
        string str0 = NewType.SelectedValue.ToString();

        if (str0.Equals("a") || str0 == null)
        {

            Response.Redirect("NoticeList.aspx", true);


        }
        else
        {
            Response.Redirect("NoticeList.aspx?action=ByType&Type=" + str0 + "", true);

        }

    }
}
