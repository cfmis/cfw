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
using Leyp.Model;
using Leyp.Components;
using Leyp.Components.Module.Stock;

public partial class Stock_Stock_ProductsView : StockViewModule
{
    protected void Page_Load(object sender, EventArgs e)
    {
        

    }
    protected void Select_Click(object sender, EventArgs e)
    {
        if (ProductsID.Text.ToString().Equals(""))
        {
            Jscript.AjaxAlert(this, "请输入商品编号");
        }

        DataBandinit(ProductsID.Text.ToString());
    }

    protected void DataBandinit(string ProductsIDs)
    {
        
        int ids = int.Parse(ProductsIDs);
      
        DataSet ds = new DataSet();

        ds = Leyp.SQLServerDAL.Factory.getProductsStockDAL().getDataSetByProductsID(ids);
        OrderList.DataSource = ds.Tables["dd"].DefaultView;
        OrderList.DataBind();

      
    
    }



    protected void Button1_Click(object sender, EventArgs e)
    {
        if (ProductsID.Text.ToString().Equals(""))
        {
            Jscript.AjaxAlert(this, "请输入商品编号");
            return;
        }

        Response.Redirect("PiePruducts.aspx?ProductsID=" + ProductsID.Text.ToString());
    }
}
