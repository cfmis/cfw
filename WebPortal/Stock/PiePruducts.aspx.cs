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

public partial class Stock_PiePruducts : System.Web.UI.Page
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

        string id = Request.QueryString["ProductsID"];
        if (id == null)
        {


            Response.End();
            return;
        
        }

        int ids = int.Parse(id);
      
        DataSet ds = new DataSet();

        ds = Leyp.SQLServerDAL.Factory.getProductsStockDAL().getDataSetByProductsID(ids);
        DataTable dd = ds.Tables["dd"];
        ArrayList XTitle = new ArrayList();
        ArrayList[] ChartData = new ArrayList[1];

        ChartData[0] = new ArrayList();

        if (dd!=null)
        {

            foreach (DataRow dr in dd.Rows)
            {


                XTitle.Add(dr[6].ToString().Substring(0,4)+"-" + dr[5].ToString());
                ChartData[0].Add(Int32.Parse(dr[4].ToString()));

            }


            Chartlet1.InitializeData(ChartData, XTitle, null);
            Chartlet1.ChartTitle = "商品分布图";
        
        
        }
    


    
    }



}
