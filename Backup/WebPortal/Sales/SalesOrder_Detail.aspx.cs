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
using Leyp.Components.Module.Sales;
using Leyp.Model;

public partial class Sales_SalesOrder_Detail : SalesOrderModule
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
        string str0 = Request.QueryString["SalesOrderID"].ToString();

        VSalesOrder vb = Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().getByID(str0);
        if (vb == null)
        {
            Response.Write("没有你要的数据");
            Response.End();
        }
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
        Discount.Text=vb.Discount.ToString();
        
        setSalesTypeName(vb.SalesType);
        CustomerID.Text = vb.CustomerID;
        PlatformName.Text = vb.PlatformName;
        CustomerTel.Text = vb.CustomerTel;
        CustomerPost.Text = vb.CustomerPost;
        CustomerArea.Text = vb.CustomerArea;

        setShopName(vb.ShopID);
        
      

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
