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
using Leyp.Components;
using Leyp.Components.Module.Stock;
using Leyp.Model.Stock;

public partial class Stock_TransferringOrder_Add : TransferringModule
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }


    }


    protected void init()
    {

        TransferringOrderID.Text = "TB" + StrHelper.GetRamCode();
        Date.Text = DateTime.Now.ToString("yyyy-MM-dd");

    }
    protected void AddSubmit_Click(object sender, EventArgs e)
    {
        string str0=TransferringOrderID.Text.ToString();
        string str1=Date.Text.ToString();
        string str2=Operator.Text.ToString();
        string str3 = TradeDate.Text.ToString();
        string str4 = Ticket.Text.ToString();
        string str5 = Description.Text.ToString();
        int n1 = int.Parse(OutHouseID.Text.ToString());
        int n2 = int.Parse(InHouseID.Text.ToString());
        int n3 = int.Parse(ProductsID.Text.ToString());
        int n4 = int.Parse(Quantity.Text.ToString());

        TransferringOrder t = new TransferringOrder();
        t.Date = str1;
        t.Description = str5;
        t.ID = str0;
        t.InHouseID = n2;
        t.Operator = str2;
        t.OutHouseID = n1;
        t.ProductsID = n3;
        t.Quantity = n4;
        t.State = 0;
        t.Ticket = str4;
        t.TradeDate = str3;
        t.UserName = getUserName();

        if (Leyp.SQLServerDAL.Stock.Factory.gerTransferringOrderDAL().insertNewEntity(t))
        {

            Panel1.Visible = false;
            Panel2.Visible = true;
        }
        else {


            Panel1.Visible = false;
            Panel2.Visible = true; HyperLink1.Text = "操作失败！返回列表";
        
        }


    }
}
