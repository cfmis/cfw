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
using Leyp.Components.Module;
using Leyp.Components;
using Leyp.Model.Sales;
public partial class Customer_SalesRecord_Add : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CreateDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        object SalesOrderIDs = Request.QueryString["SalesOrderID"];
        if (SalesOrderIDs != null)
        {
            SalesOrderID.Text = SalesOrderIDs.ToString();
            SalesOrderID.ReadOnly=true;

        }
    }
    protected void AddSubmit_Click(object sender, EventArgs e)
    {
        string str0 = CustomerID.Text.ToString();
        string str1 = CreateDate.Text.ToString();
        string str2 = SalesOrderID.Text.ToString();
        string str3 = Description.Value.ToString();

        SalesRecord s = new SalesRecord();
        s.CreateDate = str1;
        s.CustomerID = str0;
        s.Description = str3;
        s.SalesOrderID = str2;
        s.PlatformID = int.Parse(Platform.SelectedValue.ToString());
        s.UserName = getUserName();

        Leyp.SQLServerDAL.Sales.SalesRecordDAL bl = new Leyp.SQLServerDAL.Sales.SalesRecordDAL();
        bl.insertNewEntity(s);


        CustomerID.Text="";
        CreateDate.Text="";
        SalesOrderID.Text="";

        Jscript.CloseWindowReturnValues("顾客ID:" + str0);





    }
}
