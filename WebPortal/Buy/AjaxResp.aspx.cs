using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model.Buy;

public partial class Buy_AjaxResp : System.Web.UI.Page
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
        object action = Request.QueryString["action"].ToString();
        if (action == null)
        { 
        }
        else if (action.ToString().Equals("BuyPayLoad"))///在添加采购付款是使用
        {
            string str0 = Request.QueryString["BuyReceiptID"].ToString();
            float Total = float.Parse("0.00");
            List<VBuyPay> list = new List<VBuyPay>();
            BuyReceipt vb = new BuyReceipt();
            vb = Leyp.SQLServerDAL.Buy.Factory.getBuyReceiptDAL().getByID(str0);
            list = Leyp.SQLServerDAL.Buy.Factory.getBuyPayDAL().getByBuyReceiptID(str0);
            for (int i = 0; i < list.Count; i++)
            {
                VBuyPay b = list[i];
                Total = Total+b.RealPay;
            }

            Response.Write(vb.TotalPrice+"$$$"+Total.ToString());
            Response.End();
        
        }
        else if (action.ToString().Equals("BuyPayLoadAdd"))//添加一个采购单
        {
            string str0 = Request.QueryString["BuyReceiptID"].ToString();
            string str1 = Request.QueryString["Ticket"].ToString();
            string str2 = Request.QueryString["CreateDate"].ToString();
            string str3 = Request.QueryString["PayType"].ToString();
            string str4 = Request.QueryString["RealPay"].ToString();
            string str5 = Request.QueryString["AttachPay"].ToString();
            string str6 = Request.QueryString["Description"].ToString();

            BuyPay b = new BuyPay();
            b.BuyReceiptID = str0;
            b.Ticket = str1;
            b.CreateDate = str2;
            b.PayType = str3;
            b.RealPay = float.Parse(str4);
            b.AttachPay = float.Parse(str5);
            b.Description = str6;
            b.UserName = "huhai123";
            Leyp.SQLServerDAL.Buy.Factory.getBuyPayDAL().insertNewEntity(b);
            Response.Write("添加成功");
            Response.End();


        }

        

    
    }
}
