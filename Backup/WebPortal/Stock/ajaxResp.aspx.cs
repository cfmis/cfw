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
using Leyp.Model.View;

public partial class Stock_ajaxResp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
        }

    }


    private void init()
    {
        string action = Request.QueryString["action"].ToString();
        if (action == null)
        {
            return;
        }else if(action.Equals("loadProductsStock"))
        {
          string str0=Request.QueryString["ProductsID"].ToString();
          string str1=Request.QueryString["HouseDetailID"].ToString();
           VProductsStock p=new VProductsStock();
           p=Leyp.SQLServerDAL.Factory.getProductsStockDAL().getByProductsIDStockID(int.Parse(str0),int.Parse(str1));
           if (p == null)
           {
               Response.Write("0");
               Response.End();
           }
           else
           {
               Response.Write(p.Num);
               Response.End();
           }
        
        }
    
    }
}
