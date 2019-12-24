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

public partial class Products_NQ_Select_Products_Window : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            searchDand();
        }

    }
    protected void searchButton_Click(object sender, ImageClickEventArgs e)
    {
        string strType = "0";
        string strBrand = "0";
        string strKey = "";
        if (!ProductsTypeDropDownList1.SelectedValue.ToString().Equals(""))
        {
            strType = ProductsTypeDropDownList1.SelectedValue.ToString();
        }
        if (!ProductsBrandDropDownList1.SelectedValue.ToString().Equals(""))
        {
            strBrand = ProductsBrandDropDownList1.SelectedValue.ToString();
        }
        strKey = Key.Text.ToString();

        //searchDand(strType, strBrand, strKey);
        Response.Redirect(string.Format("NQ_Select_Products_Window.aspx?action=search&TypeID={0}&BrandID={1}&Key={2}", strType, strBrand, strKey));


    }

    protected void searchDand()
    {
        object act = Request.QueryString["action"];

        if (act != null)
        {
            string typeid = Request.QueryString["TypeID"].ToString();
            string brandid = Request.QueryString["BrandID"].ToString();
            string key = Request.QueryString["Key"].ToString();
            string strKey = key;
            if (key == null)
            {
                strKey = "";
            }

            List<VProducts> al = new List<VProducts>();
            al = Leyp.SQLServerDAL.Factory.getVProductsDAL().searchProducts(int.Parse(typeid), int.Parse(brandid), strKey);

            if (al.Count > 0)
            {
                Label1.Visible =false;
                CollectionPager1.DataSource = al;
                CollectionPager1.BindToControl = SearchResult;
                SearchResult.DataSource = CollectionPager1.DataSourcePaged;
               
            }
            else
            {
                Label1.Visible = true;

            }
        }
        else
        {

        }


    }


    protected void SearchResult_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        string ProductsName = SearchResult.DataKeys[e.RowIndex]["ProductsName"].ToString();
        string ProductsID = SearchResult.DataKeys[e.RowIndex]["ProductsID"].ToString();
        Jscript.CloseWindowReturnValues(ProductsID + "$$$" + ProductsName);
        return;

    }

    protected void Key_TextChanged(object sender, EventArgs e)
    {


    }


   
}
