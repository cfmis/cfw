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
using Leyp.Components;


public partial class Sales_SalesOrder_Add : SalesOrderModule
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }
    }

    public void init()
    {
        SalesOrderID.Text = "BY" + StrHelper.GetRamCode();
        CreateDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        if (getTypeID() != 0)
        { 
            CheckUserType.Value = "1";
          
        
        }

    
    }



    //protected void AddButton_Click(object sender, EventArgs e)
    //{
      
        
    //    string str0 = SalesOrderID.Text.ToString();
    //    string str1 = ClosingType.SelectedItem.Value.ToString();
    //          string str2 =CreateDate.Text.ToString();
    //           string str3 =DeliveryType.Text.ToString();
    //            string str4 =DeliveryPlace.Text.ToString();
    //             string str5 =ClosingDate.Text.ToString();
    //             string str6 = Description.Text.ToString();
    //             string str7 = AttachPay.Text.ToString();

        
    //    SalesOrder s = new SalesOrder();
    //    s.SalesOrderID = str0;
    //    s.ClosingType = str1;
    //    s.CreateDate = str2;
    //    s.DeliveryType = str3;
    //    s.DeliveryPlace = str4;
    //    s.ClosingDate = str5;
    //    s.Description = str6;
    //    s.UserName = getUserName();
    //    s.SalesType = getSubClassID();
    //    s.AttachPay = float.Parse(str7);

    //    if (getTypeID() == 0)
    //    {
    //        if (ShopID.SelectedValue.ToString().Equals(""))
    //        {

    //            s.ShopID = 0;//
    //        }
    //        else
    //        {

    //            s.ShopID = int.Parse(ShopID.SelectedValue.ToString());
    //        }

    //    }

    //    if (Leyp.SQLServerDAL.Sales.Factory.getSalesOrderDAL().insertNewEntity(s))
    //    {


    //        Response.Redirect("SalesOrder_Detail.aspx?SalesOrderID=" + str0, true);

    //    }
    //    else
    //    {

    //        Jscript.AjaxAlert(this, "添加失败！");
    //        return;

    //    }


    //}
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("SalesOrder_Detail.aspx?SalesOrderID=" + SalesOrderID .Text.ToString()+ "", true);
    }
}
