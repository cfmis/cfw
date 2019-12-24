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
using Leyp.Model.View;
using Leyp.Components;
using System.Collections.Generic;


public partial class Stock_Detop_Select_Window1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dataInit();
        }
    }


    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        string HouseID = GridView1.DataKeys[e.RowIndex]["HouseID"].ToString();
        string ID = GridView1.DataKeys[e.RowIndex]["HouseDetailID"].ToString();
        Jscript.CloseWindowReturnValues(HouseID + "$$$" + ID);
        return;

    }

    private void dataInit()
    {
        int pid = int.Parse(Request.QueryString["ProductsID"].ToString());
        DataSet ds = Leyp.SQLServerDAL.Factory.getProductsStockDAL().getDataSetByProductsID(pid);
        
       GridView1.DataSource = ds.Tables[0];
       GridView1.DataBind();

    }
    

}
