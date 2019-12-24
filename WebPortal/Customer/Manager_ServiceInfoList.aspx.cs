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

public partial class Customer_Manager_ServiceInfoList : ManagerServiceInfo
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
            updateAotoCancel();
        }


    }

    /// <summary>
    /// 
    /// </summary>
    protected void init()
    {
     List<VServiceInfo> list = new List<VServiceInfo>();
    object action = Request.QueryString["action"];
    if (action != null)
    {
        if (action.ToString().Equals("ByDate"))
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
            
            list = Leyp.SQLServerDAL.Factory.getServiceInfoDAL().getSearchListByDate(str0, str1, int.Parse(str2));
           
        }
        else if(action.ToString().Equals("MyTopic"))
        {
            list = Leyp.SQLServerDAL.Factory.getServiceInfoDAL().getMyAuditingUserTopic(getUserName());
        }
    


    }
    else
    {
        list = Leyp.SQLServerDAL.Factory.getServiceInfoDAL().getSearchListByDate("1000", "3000", 0);
      
    }

    CollectionPager1.DataSource = list;
    CollectionPager1.BindToControl = OrderList;
    OrderList.DataSource = CollectionPager1.DataSourcePaged;
 }
    
    
    
    
    protected void Select_Click(object sender, EventArgs e)
    {
        string str1 = baginData.Text.ToString();
        string str2 = endData.Text.ToString();
        string str3 = side.SelectedValue.ToString();
        Response.Redirect(string.Format("Manager_ServiceInfoList.aspx?action=ByDate&baginData={0}&endData={1}&side={2}", str1, str2, str3), true);

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
   
    protected void MyOrder_Click(object sender, EventArgs e)
    {
        Response.Redirect("Manager_ServiceInfoList.aspx?action=MyTopic", true);
    }


    /// <summary>
    /// 检查三天内为受理 就自动过期
    /// </summary>
    protected void updateAotoCancel()
    {
        Leyp.SQLServerDAL.Factory.getServiceInfoDAL().updateAotoCancel(DateTime.Now.ToString("yyyy-MM-dd"));
    }
}
