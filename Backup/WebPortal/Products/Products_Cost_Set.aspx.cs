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
using Leyp.Model;
using Leyp.Components;
using Leyp.Components.Module;

public partial class Products_Products_Cost_Set : ProductsManager
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
        //int pid = int.Parse(Request.QueryString["ProductsID"].ToString());
        PID.Text = Request.QueryString["ProductsID"].ToString();
        DataBand();
    
    }
    protected void DataBand()
    {
        int ProductsID =int.Parse(PID.Text.ToString());
        DataSet ds = Leyp.SQLServerDAL.Factory.getProductsUserTypeDAL().getByProductsID(ProductsID);
        PriceList.DataSource = ds;
        PriceList.DataBind();
       
    }

    /// <summary>
    /// 取消 编辑
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void PriceList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        PriceList.EditIndex = -1;
        DataBand();

    }
    /// <summary>
    /// 编辑后
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void PriceList_RowEditing(object sender, GridViewEditEventArgs e)
    {
        PriceList.EditIndex = e.NewEditIndex;
        DataBand();



    }
    /// <summary>
    ///  更新时
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void PriceList_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

        string price = ((TextBox)PriceList.Rows[e.RowIndex].Cells[1].FindControl("TextBox1")).Text.ToString();
       // int typeid = int.Parse(PriceList.DataKeys[e.RowIndex]["SubClassID"].ToString());
        int subID=int.Parse(PriceList.DataKeys[e.RowIndex]["SubClassID"].ToString());
        int proID=int.Parse(PID.Text.ToString());
         double ps;
        try
        {
             ps = double.Parse(price);
        }
        catch
        {
            Jscript.AjaxAlert(this,"输入有误！");
            PriceList.EditIndex = -1;
            DataBand();
            return;
          
        }

        ProductsUserType p=new ProductsUserType();
        p.Price=ps;
        p.ProductsID=proID;
        p.SubClassID=subID;

        Leyp.SQLServerDAL.Factory.getProductsUserTypeDAL().updateNodeupdate(p);

        addSystemLog("商品ID:" + proID + " 调价成功");

        PriceList.EditIndex = -1;
        DataBand();
        
    }
}
