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
using Leyp.SQLServerDAL.Sales;
using Leyp.Model;
using Leyp.Components.Module;
using Leyp.Components;
public partial class Sales_Issue_SalesDispatch : BasePage
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
        OrderID.Text = Request.QueryString["DispatchID"].ToString();


    }
    protected void Button1_Click(object sender, EventArgs e)
    {
         SalesDispatchDAL sdal=new SalesDispatchDAL();
        sdal.sentUpdate(int.Parse(OrderID.Text.ToString()), DateTime.Now.ToString("yyyy-MM-dd"),3," 问题描述："+issueInfo.Text.ToString(),float.Parse("0.00"));


        VSalesDispatch vs = Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().getByID(int.Parse(OrderID.Text.ToString()));

        //在接着得到销售订单

        VSalesOrder vso = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getByID(vs.SalesOrderID);

        //得到下单用户

        string username = vso.UserName;
           



        ServiceInfo s = new ServiceInfo();

        s.CreateDate = DateTime.Now.ToString("yyyy-MM-dd");
        s.Content ="订单号："+vs.SalesOrderID+"配送错误，请您查询。原因是："+ issueInfo.Text;
        s.ServiceTitle = "配送问题--" + DateTime.Now.ToString("yyyy-MM-dd");
        s.UserName = username;
        s.TypeID = 2;
        if (Leyp.SQLServerDAL.Factory.getServiceInfoDAL().insertNewEntity(s))
        {
            Jscript.RefreshParent("MySalesDispatch.aspx");
            Jscript.CloseWindow();

        }
        
    }
}
