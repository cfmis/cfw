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
using Leyp.Model;
using Leyp.Components.Module.Sales;
using Leyp.Components;

public partial class Sales_SalesOut_Edit : ManagerSalesOut
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            initData();
            init();
        }

    }
    private void init()
    {
        object SalesID = Request.QueryString["SalesOutID"];
        if (SalesID == null)
        {
            Response.Write("没有您要的数据");
            Response.End();
            return;
        }

        VSalesOut vs = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().getByID(SalesID.ToString());
        if (vs == null)
        {
            Response.Write("没有您要的数据");
            Response.End();
            return;
        }
        if (vs.State > 0)
        {
            Response.Write("单据已经审核，不能修改");
            Response.End();
            return;
          
        }

        VSalesOrder vo = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getByID(vs.SalesOrderID);//
        if (vo == null)
        {
            Response.Write("没有您要的数据");
            Response.End();
            return;
        }

       

        SalesOutID.Text = vs.SalesOutID;
        CreateDate.Text = vs.CreateDate;
        SalesOrderID.Text = vs.SalesOrderID;
       
        TradeDate.Text = vs.TradeDate;
      
        Consignee.Text = vs.Consignee;
        Description.Text = vs.Description;

        CustomerName.Text = vo.CustomerName;
        CustomerPost.Text = vo.CustomerPost;
        CustomerTel.Text = vo.CustomerTel;
        CustomerArea.Items.FindByValue(vo.CustomerArea.ToString()).Selected = true;
        DeliveryIDh.Value = vs.DeliveryID.ToString();
        AccountsIDh.Value = vs.AccountsID;
        Platformh.Value = vo.PlatformID.ToString();
       
        string str = vo.CustomerID;
        string str0 = str.Substring(0, 2);

        CustomerIDTypeh.Value = str0;
        CustomerID.Text = str.Substring(2, str.Length - 2);
        CustomerIDType.Items.FindByValue(str0).Selected = true;

        AttachPay.Text = vo.AttachPay.ToString();
        Discount.Text = vo.Discount.ToString();



        DeliveryPlace.Text = vo.DeliveryPlace;
    
    }



    private void initData()
    {
        List<Delivery> list = Leyp.SQLServerDAL.Factory.getDeliveryDAL().getAllDelivery();
        List<SalesPlatform> list0 = Leyp.SQLServerDAL.Sales.Factory.getSalesPlatformDAL().getList();
        List<Accounts> list1 = Leyp.SQLServerDAL.Factory.getAccountsDAL().getAll();

        DeliveryID.DataSource = list;
        DeliveryID.DataBind();

        Platform.DataSource = list0;
        Platform.DataBind();


        AccountsID.DataSource = list1;
        AccountsID.DataBind();

         


    }



    protected void Button1_Click(object sender, EventArgs e)
    {
        SalesOut s = new SalesOut();
        SalesOrder so = new SalesOrder();


        s.Consignee = Consignee.Text.ToString();
        s.CreateDate = CreateDate.Text.ToString();
        s.DeliveryID = int.Parse(DeliveryID.SelectedValue.ToString());
        s.Description = Description.Text.ToString();
        s.SalesOutID = SalesOutID.Text.ToString();
        s.UserName = getUserName();
        s.TradeDate = TradeDate.Text.ToString();
        s.SalesOrderID = SalesOrderID.Text.ToString();

        so.CustomerArea = CustomerArea.Value.ToString();
        so.CustomerID = CustomerIDType.Value + CustomerID.Text.ToString();
        so.CustomerName = CustomerName.Text.ToString();
        so.CustomerPost = CustomerPost.Text.ToString();
        so.CustomerTel = CustomerTel.Text.ToString();
        so.Discount = float.Parse(Discount.Text.ToString());
        so.AttachPay = float.Parse(AttachPay.Text.ToString());
        so.SalesOrderID = SalesOrderID.Text.ToString();
        so.PlatformID = int.Parse(Platform.SelectedValue.ToString());

        if (Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().updateCustomerInfo(so)) { //顾客信息更新成功

            Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().updataEntity(s);
            Jscript.RefreshParent("Manager_SalesOutOrder.aspx");
            Jscript.CloseWindow();
        
        }


    }
}
