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
using Leyp.Model.Buy;

public partial class Buy_BuyReceipt_Detail : System.Web.UI.Page
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
        string str0 = Request.QueryString["ReceiptOrderID"].ToString();

        VBuyReceipt vb = Leyp.SQLServerDAL.Buy.Factory.getBuyReceiptDAL().getViewByID(str0);
        if (vb == null)
        {
            Response.Write("没有你要的数据");
            Response.End();
        }
        ReceiptOrderID.Text = vb.ReceiptOrderID;
        ReceiptOrderDate.Text = vb.ReceiptOrderDate;
        RealName.Text = vb.RealName;
        HouseName.Text = vb.HouseName + "----" + vb.SubareaName;   
        TradeDate.Text = vb.TradeDate;
        Description.Text = vb.Description;
        State.Text = changString(vb.State.ToString());
        TotalPrice.Text = vb.TotalPrice.ToString();

    }

    /// <summary>
    /// 界面显示
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public string changString(string str)
    {
        if (str.Equals("0"))
        {
            return "<font color=\"#FF0000\">未审</font>";
        }
        else if (str.Equals("1"))
        {
            return "<font color=\"#009933\">已审</font>";
        }
        else if (str.Equals("2"))
        {
            return "<font color=\"#666666\">已入库</font>";
        }
        else
        {
            return str;
        }


    }
}
