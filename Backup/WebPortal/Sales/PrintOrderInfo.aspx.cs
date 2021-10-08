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
using System.Collections.Generic;
using Leyp.Model.Sales;
using Leyp.Components.Module.Sales;
using Leyp.Components.Module;
using Leyp.Components;

public partial class Sales_PrintOrderInfo : SalesDispatchModule
{



    protected static string info = " 个单据等待打印";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
        }
    }

   
    private void init()
    {
        List<VSalesDispatch> listYT = Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().getByDeliveryType(Base.Delivery_YT, 0,0);

        List<VSalesDispatch> listPY = Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().getByDeliveryType(Base.Delivery_PY, 0,0);

        List<VSalesDispatch> listST = Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().getByDeliveryType(Base.Delivery_ST, 0,0);

        YTButton.Text = listYT.Count.ToString() + info;

        PYButton.Text = listPY.Count.ToString() + info;

        STButton.Text = listST.Count.ToString() + info;

        if (listYT.Count == 0)
        {
            YTButton.Enabled = false;
        }

        if (listPY.Count == 0)
        {
            PYButton.Enabled = false;
        }


        if (listST.Count == 0)
        {
           STButton.Enabled = false;
        }

    
    }
}
