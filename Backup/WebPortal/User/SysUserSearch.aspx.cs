using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Leyp.Model;
using Leyp.Model.View;
using Leyp.Components;

public partial class User_SysUserSearch : Leyp.Components.Module.SysUserManager
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
        if (action == null)
        {
            searchBand();
        }
        else if (action.ToString().Equals("del"))
        {
            string Username = Request.QueryString["UserName"].ToString();

            if (lockUser(Username))
            {
                Response.Write("操作成功！该用户已经停用    &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"SysUserSearch.aspx\">返回列表</a>  ");
                Response.End();
            }
            else
            {
                Response.Write("操作失败！");
                Response.End();
            }
        
        }
    
    }

    

    /// <summary>
    /// 
    /// </summary>
    protected void searchBand()
    {

             List<Vuser> al = null;
            al = Leyp.SQLServerDAL.Factory.getVuserDAL().getAllVuser();
            CollectionPager1.DataSource = al;
            CollectionPager1.BindToControl = SearchResult;
            SearchResult.DataSource = CollectionPager1.DataSourcePaged;
           
         
    
    }

   
    /// <summary>
    /// 暂停用户活动
    /// </summary>
    public bool lockUser(string UserName)
    {
       return Leyp.SQLServerDAL.Factory.getUserDAL().lockUser(UserName);
    
    }


    //protected void SearchResult_RowDeleting(object sender, GridViewDeleteEventArgs e)
    //{
    //    string username = SearchResult.DataKeys[e.RowIndex]["UserName"].ToString();
    //    Jscript.OpenWebFormSize("SysUserDetail.aspx?UserName=" + username + "", 600, 500, 10, 100);
    //   // return;
    //}
}
