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

public partial class Sales_SalesReturn_Detail : System.Web.UI.Page
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
        string str0 = Request.QueryString["SalesReturnID"].ToString();

        VSalesReturn vb = Leyp.SQLServerDAL.Sales.Factory.getSalesReturnDAL().getByID(str0);
        if (vb == null)
        {
            Response.Write("没有你要的数据");
            Response.End();
        }
        SalesReturnID.Text = vb.SalesReturnID;
        SalesOutID.Text = vb.SalesOutID;
        ReturnType.Text = vb.ReturnType;
        RealName.Text = vb.RealName;
        TradeDate.Text = vb.TradeDate;

        CreateDate.Text = vb.CreateDate;
        Description.Text = vb.Description;

        Deposits.Text = vb.Deposits.ToString();

        Label1.Text = vb.TotalPrice.ToString();
        State.Text = changString(vb.State.ToString());



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
