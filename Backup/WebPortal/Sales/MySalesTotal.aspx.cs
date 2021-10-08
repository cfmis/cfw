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
using Leyp.Model.Sales;
using Leyp.Components.Module.Sales;
using Leyp.Components.Module;

public partial class Sales_MySalesTotal : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Total_Click(object sender, EventArgs e)
    {
        string beginTime = baginData.Text.ToString();
        string endTime=endData.Text.ToString();

        List<VSalesOrder> list = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getSearchListByUserName(beginTime, endTime, 1, getUserName());

        int count = list.Count;
        float totalprice = float.Parse("0.00");

        for (int i = 0; i < count; i++)
        {
            VSalesOrder v = list[i];
            totalprice = totalprice + v.SalesIncome;

        }

        Btime.Text = beginTime;
        Etime.Text = endTime;
        OrderNum.Text = count.ToString();

        TotoalCost.Text = totalprice.ToString();

        Panel1.Visible = true;


    }
}