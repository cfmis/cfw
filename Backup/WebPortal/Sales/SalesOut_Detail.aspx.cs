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
using Leyp.Model.Sales;
using Leyp.Components.Module.Sales;
using Leyp.Model;

public partial class Sales_SalesOut_Detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            init();
        }
    }
    public void init()
    {
        string str0 = Request.QueryString["SalesOutID"].ToString();

        VSalesOut vb = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().getByID(str0);
        if (vb == null)
        {
            Response.Write("没有你要的数据");
            Response.End();
        }
        SalesOutID.Text = vb.SalesOutID;
        SalesOrderID.Text = vb.SalesOrderID;
        Consignee.Text = vb.Consignee;
        RealName.Text = vb.RealName;

        TradeDate.Text = vb.TradeDate;
        //TradePlace.Text = vb.TradePlace;
       
        CreateDate.Text = vb.CreateDate;
        Description.Text = vb.Description;

       
        State.Text = changString(vb.State.ToString());
        DeliveryName0.Text = vb.DeliveryName;


        Accounts ac = Leyp.SQLServerDAL.Factory.getAccountsDAL().getByID(vb.AccountsID);
        AccountsName.Text = ac.AccountsName;//财务帐号


        VSalesOrder vo = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getByID(vb.SalesOrderID);

        ProductsPrice.Text = vb.TotalPrice.ToString();
        float p = float.Parse("0.00");
        p= vb.TotalPrice + vo.AttachPay - vo.Discount;
        TotalPrice.Text = p.ToString();

        CustomerID.Text = vo.CustomerID;
        CustomerTel.Text = vo.CustomerTel;
        CustomerPost.Text = vo.CustomerPost;
        CustomerArea.Text = vo.CustomerArea;

        TradePlace.Text = vo.DeliveryPlace;

        AttachPay.Text = vo.AttachPay.ToString();
        Discount.Text = vo.Discount.ToString();


        if (vb.State == 3) //表示已经发货
        {
            Panel1.Visible = true;
            VSalesDispatch vs = Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().getBySalesOutID(str0);

            DeliveryDate.Text = vs.DeliveryDate;
            SentDate.Text = vs.SentDate;
            ConsignorName.Text = vs.RealName;
            DeliveryName.Text = vs.DeliveryType;
            Description1.Text = vs.Description;

           

        }
       

    }




    /// <summary>
    /// 界面显示
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public string changString(string str)
    {
        if (str.Equals("1"))
        {
            return "<font color=\"#009933\">已审</font>";
        }
        else if (str.Equals("0"))
        {
            return "<font color=\"#FF0000\">未审</font>";
        }
        else if (str.Equals("2"))
        {
            return "<font color=\"#0000CC\">等待发货</font>";
        }
        else if (str.Equals("3"))
        {
            return "<font color=\"#009933\">已发货</font>";
        }
        else
        {
            return "未知单据";
        }



    }


}
