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
using Leyp.Components.Module;
using Leyp.SQLServerDAL;

public partial class Products_ShowProductsList : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            dangBangDate();
            searchDand();
        }

    }




    protected void dangBangDate()
    {
        DropDownList0.Items.Add(new ListItem("请选择", "0"));
        ProductsTypeDAL dl = new ProductsTypeDAL();

       
        if (dl != null)
        {
            List<ProductsType> list = dl.getAllProductsTypeCanUser();
            foreach (ProductsType t in list)
            {
                if (t.State.Equals("Y"))
                {
                    DropDownList0.Items.Add(new ListItem(t.TypeName, t.TypeID.ToString()));
                }
            }

        }

        DropDownList1.Items.Add(new ListItem("请选择", ""));
        foreach (ProductsBrand t in Leyp.SQLServerDAL.Factory.getProductsBrandDAL().getAllProductsBrand())
        {
            if (t.State.Equals("Y"))
            {
                DropDownList1.Items.Add(new ListItem(t.BrandName, t.BrandID.ToString()));
            }
        }
    
    }




    protected void searchButton_Click(object sender, ImageClickEventArgs e)
    {

        string strType = "0";
        string strBrand = "0";
        string strKey = "";
        if (!DropDownList0.SelectedValue.ToString().Equals(""))
        {
            strType = DropDownList0.SelectedValue.ToString();
        }
        if (!DropDownList1.SelectedValue.ToString().Equals(""))
        {
            strBrand = DropDownList1.SelectedValue.ToString();
        }
        strKey = Key.Text.ToString();
         
        Response.Redirect(string.Format("ShowProductsList.aspx?TypeID={0}&BrandID={1}&Key={2}", strType, strBrand, strKey));

    }

    protected void searchDand()
    {
        if (Request.QueryString["Key"] != null)
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
            al = Leyp.SQLServerDAL.Factory.getVProductsDAL().searchProductsForAll(int.Parse(typeid), int.Parse(brandid), strKey);

            if (al.Count != 0)
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

            List<VProducts> el = new List<VProducts>();
            el = Leyp.SQLServerDAL.Factory.getVProductsDAL().searchProductsForAll(0, 0, "");

            if (el.Count != 0)
            {
                CollectionPager1.DataSource = el;
                CollectionPager1.BindToControl = SearchResult;
                SearchResult.DataSource = CollectionPager1.DataSourcePaged;
            }
            else
            {
                Label1.Visible = false;

            }
        
        }
       

    }


    public string getStringOfChar(string str)
    {
        if (str.Length > 50)
        {
           return StrHelper.StringOfChar(50, str) + "......";
        }
        else
        {
            return str;
        }
    }

}
