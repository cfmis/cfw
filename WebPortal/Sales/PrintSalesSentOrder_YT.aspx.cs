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
using Leyp.SQLServerDAL.Sales;

public partial class Sales_PrintSalesSentOrder_YT : System.Web.UI.Page
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
        string idstr = "";
        int num = 0;

        DataSet ds = Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().getDataForPrintByDeliveryID(Base.Delivery_YT);

        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            if (num == 0)
            {
                idstr = dr["DispatchID"].ToString();
            }
            else {

                idstr = idstr + "#" + dr["DispatchID"].ToString();
            }
            num++;
        }


        DataList1.DataSource = ds.Tables[0];
        DataList1.DataBind();
        Label1.Text = idstr;

        if (num == 0)
        {
            Button1.Visible = false;
        }
    
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string str = Label1.Text.ToString();
        string[] a = str.Split('#');
        SalesDispatchDAL sal = new SalesDispatchDAL();

        for (int i = 0; i < a.Length; i++)
        {
            sal.updataPrintFlag(int.Parse(a[i].ToString()));
        }

        Button1.Text = "已经处理完成";
        Button1.Enabled = false;
    }
}
