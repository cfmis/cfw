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
using Leyp.Components;

public partial class User_NQ_Select_UserWindows : System.Web.UI.Page
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

        List<Vuser> list = new List<Vuser>();
        list = Leyp.SQLServerDAL.Factory.getVuserDAL().getSearchByUserTypeID(4);
        GridView1.DataSource = list;
        GridView1.DataBind();
    
    }

    protected void selUserType(object sender, EventArgs e)
    {
        string str = UserTypeDropDownList1.SelectedValue.ToString();
        if (str.Equals("") || str == null)
        {
            return;
        }
        else
        {
            List<Vuser> list = new List<Vuser>();
            list = Leyp.SQLServerDAL.Factory.getVuserDAL().getSearchByUserTypeID(int.Parse(str));
            GridView1.DataSource = list;
            GridView1.DataBind();

        }

    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string UserName = GridView1.DataKeys[e.RowIndex]["UserName"].ToString();
        Jscript.CloseWindowReturnValues(UserName);
        return;
    }
}
