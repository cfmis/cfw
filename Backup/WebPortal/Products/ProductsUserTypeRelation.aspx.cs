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

public partial class Products_ProductsUserTypeRelation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    protected void RelationGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
　　　　　　　　//RelationGrid.EditIndex=e.NewEditIndex;

    }


    protected void RelationGrid_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {

    }
}
