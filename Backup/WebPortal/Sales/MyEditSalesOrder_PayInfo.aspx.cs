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
using Leyp.Components;
using Leyp.Components.Module;

public partial class Sales_MyEditSalesOrder_PayInfo :BasePage
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
        string SalesOrderIDs = Request.QueryString["SalesOrderID"].ToString();
        

        VSalesOrder v = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getByID(SalesOrderIDs);
        if (v.SalesOrderID == "" || v.SalesOrderID == null)
        {
            Response.Write("没有数据");
            Response.End();
        }
        else if(!v.UserName.Equals(getUserName().ToString())) {
        
           Response.Write("操作失败");
           Response.End();
        }else
        {
            SalesOrderID.Text = SalesOrderIDs.ToString();
        
        
        }
    }

    
    
   


    protected void Button1_Click(object sender, EventArgs e)
    {
        string sid = SalesOrderID.Text.ToString();
        string sInfo = info.Text.ToString();
        if (Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().updatePayInfo(sid, sInfo))
        {

            Response.Redirect("MySalesOrder.aspx", true);
        }
        else
        {
            Jscript.AjaxAlert(this, "操作失败！");
            return;
        }

    }
}
