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

public partial class Buy_BuyOrder_Detail_Photo : System.Web.UI.Page
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
        string ID = Request.QueryString["BuyOrderID"].ToString();
        DataSet dd = Leyp.SQLServerDAL.Buy.Factory.getBuyOrderDetailDAL().getOrderDetailPhoto(ID);

        PhotoList.DataSource = dd;
        PhotoList.DataBind();
        Label1.Text = ID;
    
    
    }
}
