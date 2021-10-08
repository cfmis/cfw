using System;
using System.Data;
using System.Text;
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

public partial class Sales_ManagerAuditingSalesOrder : ManagerSalesOrder
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { init(); }
    }


    private void init()
    {
        List<VSalesOrder> list = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getSearchList("1000", "3000", 0);

        if (list.Count == 0)
        {
            Response.Write("所有数据处理完成！没有需要审核的单据   &nbsp; &nbsp;&nbsp; &nbsp; <a href=\"Manager_SalesOrderList.aspx\">返回列表</a>");
            Response.End();
        }
        else
        {
            int index = new Random().Next(list.Count);
            VSalesOrder vb = list[index];
            SalesOrderID.Text = vb.SalesOrderID;

            RealName.Text = vb.RealName;
            ShopID.Text = vb.ShopID.ToString();
            DeliveryType.Text = vb.DeliveryType;
            ClosingType.Text = vb.ClosingType;
            CreateDate.Text = vb.CreateDate;
            Description.Text = vb.Description;
            Label2.Text = vb.AttachPay.ToString();
            Label1.Text = vb.SalesIncome.ToString();
            State.Text = changString(vb.State.ToString());
            DeliveryPlace.Text = vb.DeliveryPlace;
            Discount.Text = vb.Discount.ToString();

            setSalesTypeName(vb.SalesType);
            CustomerID.Text = vb.CustomerID;
            PlatformName.Text = vb.PlatformName;
            CustomerTel.Text = vb.CustomerTel;
            CustomerPost.Text = vb.CustomerPost;
            CustomerArea.Text = vb.CustomerArea;

            setShopName(vb.ShopID);
          
        }

    }
    protected void shenhe_Click(object sender, EventArgs e)
    {
        string AuditingId = SalesOrderID.Text.ToString();
       
        Leyp.SQLServerDAL.Sales.SalesOrderDAL bl = new Leyp.SQLServerDAL.Sales.SalesOrderDAL();
        if (bl.AuditingOrder(AuditingId, getUserName()))//审核
            {
                Response.Redirect("ManagerAuditingSalesOrder.aspx", true);
            }
            else
            {
                Jscript.AjaxAlert(this,"审核失败!");
                return;
              
            }

        
    }
    protected void deleteButton_Click(object sender, EventArgs e)
    {

        string AuditingId = SalesOrderID.Text.ToString();

        Leyp.SQLServerDAL.Sales.SalesOrderDAL bl = new Leyp.SQLServerDAL.Sales.SalesOrderDAL();
        if (bl.deleteEitity(AuditingId))//删除
        {
            Response.Redirect("ManagerAuditingSalesOrder.aspx", true);
        }
        else
        {
            Jscript.AjaxAlert(this, "删除失败!");
            return;

        }

    }



    /// <summary>
    /// 界面显示
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public string changString(string str)
    {
        if (str.Equals("0"))
        {
            return "<font color=\"#FF0000\">未审</font>";
        }
        else if (str.Equals("1"))
        {
            return "<font color=\"#009933\">已审</font>";
        }
        else if (str.Equals("2"))
        {
            return "已审/已成出库单";
        }
        else
        {
            return str;
        }


    }



    /// <summary>
    /// 显示单据类型
    /// </summary>
    /// <param name="id"></param>
    protected void setSalesTypeName(int id)
    {
        UserTypeSubClass u = new UserTypeSubClass();
        u = Leyp.SQLServerDAL.Factory.getUserTypeSubClassDAL().getByID(id);
        SalesTypeName.Text = u.SubClassName;

    }

    /// <summary>
    /// 店铺名称
    /// </summary>
    /// <param name="id"></param>
    protected void setShopName(int id)
    {
        if (id == 0)
        {
            ShopID.Text = "无记录";
        }
        else
        {
            Shop s = Leyp.SQLServerDAL.Factory.getShopDAL().getByShopID(id);
            ShopID.Text = s.ShopName;
        }
    }
}
