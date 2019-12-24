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
using Leyp.Model;
using Leyp.Components;

public partial class Sales_ManagerAuditingSalesOut : ManagerSalesOut
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



        List<VSalesOut> list = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().getSearchList("1000", "3000", 1);
        int count = list.Count;

        if (count == 0)
         {
             Response.Write("所有数据处理完成！没有需要审核的单据   &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_SalesOutOrder.aspx\">返回列表</a>");
             Response.End();
         }
         else
         {
            int index = new Random().Next(count);
            VSalesOut vb = list[index];

            AuditingCount.Text = count.ToString();
             
             SalesOutID.Text = vb.SalesOutID;
             SalesOrderID.Text = vb.SalesOrderID;
             //Consignee.Text = vb.Consignee;
             RealName.Text = vb.RealName;

            
             

             CreateDate.Text = vb.CreateDate;
             Description.Text = vb.Description;


             State.Text = changString(vb.State.ToString());
             DeliveryName0.Text = vb.DeliveryName;


             Accounts ac = Leyp.SQLServerDAL.Factory.getAccountsDAL().getByID(vb.AccountsID);
             AccountsName.Text = ac.AccountsName;//财务帐号


             VSalesOrder vo = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getByID(vb.SalesOrderID);

             ProductsPrice.Text = vb.TotalPrice.ToString();
             float p = float.Parse("0.00");
             p = vb.TotalPrice + vo.AttachPay - vo.Discount;
             TotalPrice.Text = p.ToString();

             CustomerID.Text = vo.CustomerID;
             CustomerTel.Text = vo.CustomerTel;
             CustomerPost.Text = vo.CustomerPost;
             CustomerArea.Text = vo.CustomerArea;

             TradePlace.Text = vo.DeliveryPlace;

             AttachPay.Text = vo.AttachPay.ToString();
             Discount.Text = vo.Discount.ToString();


             TradeDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
         }
        
      

        


       

    }




    /// <summary>
    /// 界面显示
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public string changString(string str)
    {
        if (str.Equals("1"))
        {
            return "<font color=\"#009933\">已审</font>";
        }
        else if (str.Equals("0"))
        {
            return "<font color=\"#FF0000\">未审</font>";
        }
        else if (str.Equals("2"))
        {
            return "<font color=\"#0000CC\">等待发货</font>";
        }
        else if (str.Equals("3"))
        {
            return "<font color=\"#009933\">已发货</font>";
        }
        else
        {
            return "未知单据";
        }



    }

    protected void shenhe_Click(object sender, EventArgs e)
    {
        string AuditingId = SalesOutID.Text.ToString();
        Leyp.SQLServerDAL.Sales.SalesOutDAL bl = new Leyp.SQLServerDAL.Sales.SalesOutDAL();
        if (bl.AuditingOrder(AuditingId, getUserName(), TradeDate.Text.ToString(), Consignee.Text.ToString()))//审核
        {
            Response.Redirect("ManagerAuditingSalesOut.aspx", true);
        }
        else
        {
            Jscript.AjaxAlert(this, "审核失败!");
            return;
        }

       
    }
    protected void deleteButton_Click(object sender, EventArgs e)
    {
        string AuditingId = SalesOutID.Text.ToString();

        Leyp.SQLServerDAL.Sales.SalesOutDAL bl = new Leyp.SQLServerDAL.Sales.SalesOutDAL();
        if (bl.deleteEitity(AuditingId))//删除
        {
            Response.Redirect("ManagerAuditingSalesOut.aspx", true);
        }
        else
        {
            Jscript.AjaxAlert(this, "删除失败!");
            return;

        }
    }
}
