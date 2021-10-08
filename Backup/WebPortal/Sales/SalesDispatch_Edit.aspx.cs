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
using Leyp.Model.Sales;
using Leyp.Components.Module.Sales;

public partial class Sales_SalesDispatch_Edit : SalesDispatchModule
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
        }

    }
    protected void init()
    {
        
            string id = Request.QueryString["DispatchID"].ToString();
            VSalesDispatch sd=Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().getByID(int.Parse(id));
            if (sd.State !=0 )
            {
                Response.Write("已经完成发货！不能修改");
                Response.End();
                return;
            }

            SalesOutID.Text = sd.SalesOutID;
            CreateDate.Text = sd.CreateDate;
            DeliveryID.Text = sd.DeliveryType;
            DeliveryDate.Text = sd.DeliveryDate;
            SentDate.Text = sd.SentDate;
            Consignor.Text = sd.Consignor;
            Description.Text = sd.Description;
            StateDropDownList.Items.FindByValue(sd.State.ToString()).Selected = true;
            DispatchID.Value = sd.DispatchID.ToString();


       

    
    }

}
