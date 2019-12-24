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

public partial class Sales_SalesDispatch_Add : SalesDispatchModule
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
        string strID = Request.QueryString["SalesOutID"].ToString();

        VSalesOut vs = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().getByID(strID);
        if (vs == null)
        {
            Response.Write("没有您要的数据");
            Response.End();
        }

        if (vs.State != 1)//已审核状态有效
        {
            Response.Write("只能受理已经审核的单据");
            Response.End();
        }



        SalesOutID.Text = vs.SalesOutID;

       DeliveryID.Text = vs.DeliveryName;
       CreateDate.Text= DateTime.Now.ToString("yyyy-MM-dd");
       DeliveryDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
       SentDate.Text = DateTime.Now.ToString("yyyy-MM-dd");


    }


    protected void AddSubmit_Click(object sender, EventArgs e)
    {
        string str = SalesOutID.Text.ToString();
        Jscript.AjaxAlert(this, str);
        return;
        

    }



    protected void gotoList_Click(object sender, EventArgs e)
    {
        Jscript.RefreshParent(string.Format("Manager_SalesOutOrder.aspx?action=no&baginData={0}&endData={1}&side={2}", "1000", "3000", 2));
        Jscript.CloseWindow();
    }
}
