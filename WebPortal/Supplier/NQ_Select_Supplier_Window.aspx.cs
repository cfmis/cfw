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
using Leyp.Model;
using System.Collections.Generic;

public partial class Supplier_NQ_Select_Supplier_Window : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBand();
        }

    }
    /// <summary>
    /// 
    /// </summary>
    protected void DataBand()
    {
        CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getSupplierDAL().getAllSupplier();//List数据源
        CollectionPager1.BindToControl = SupplierList;
        SupplierList.DataSource = CollectionPager1.DataSourcePaged;
    
    }

    protected void SupplierList_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string SupplierName = SupplierList.DataKeys[e.RowIndex]["SupplierName"].ToString();
        string SupplierID = SupplierList.DataKeys[e.RowIndex]["SupplierID"].ToString();
        Jscript.CloseWindowReturnValues(SupplierID + "$$$" + SupplierName);
        return;
    }
   
    protected void SelectButton_Click(object sender, EventArgs e)
    {
        string Key = StrKey.Text.ToString();
        if(Key==null || Key.Equals(""))
        {
            Jscript.AjaxAlert(this, "请输入关键字！");
            return;
        
        }
        List<Supplier> list = new List<Supplier>();
        list = Leyp.SQLServerDAL.Factory.getSupplierDAL().getSearchListByKey(Key);
        if (list.Count == 0)
        {
            Label1.Visible = true;
        }
        else
        {
            SupplierList.DataSource = list;
            SupplierList.DataBind();
            
        }


    }


    protected void StrKey_TextChanged(object sender, EventArgs e)
    {
        Label1.Visible = false;
    }
}
