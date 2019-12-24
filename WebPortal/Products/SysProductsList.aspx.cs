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

public partial class Products_SysProductsList : System.Web.UI.Page
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
        if (TypeCheckBox.Checked)
        {
            strType = proType.SelectedValue.ToString();
        }
        if (BrandCheckBox.Checked)
        {
            strBrand = proBrand.SelectedValue.ToString();
        }
        strKey = Key.Text.ToString();


        Response.Redirect(string.Format("SysProductsList.aspx?action=search&TypeID={0}&BrandID={1}&Key={2}", strType, strBrand, strKey));
       
    }

    protected void searchDand()
    {
        if (Request.QueryString["action"] != null)
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
                CollectionPager1.DataSource = al;
                CollectionPager1.BindToControl = SearchResult;
                SearchResult.DataSource = CollectionPager1.DataSourcePaged;
            }
            else
            {
                Label1.Visible = false;
            
            }
        }
        else
        { 
        
        }
    
    
    
    }
}
