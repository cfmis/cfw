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
using Leyp.SQLServerDAL;

public partial class Test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        //X坐标轴标识数组
        //Labels on X Axis
        ArrayList XTitle = new ArrayList();
        XTitle.Add("East");
        XTitle.Add("South");
        XTitle.Add("West");
        XTitle.Add("North");
        XTitle.Add("NorthEast");
        XTitle.Add("SouthWest");
        XTitle.Add("NorthWest");

        //图表数据（1组）
        //Chart Data
        ArrayList[] ChartData = new ArrayList[1];

        ChartData[0] = new ArrayList();
        ChartData[0].Add(80);
        ChartData[0].Add(40);
        ChartData[0].Add(30);
        ChartData[0].Add(24);
        ChartData[0].Add(22);
        ChartData[0].Add(20);
        ChartData[0].Add(16);


        Chartlet1.InitializeData(ChartData, XTitle, null);
        Chartlet1.ChartTitle = "nihao";

     
    }
}
