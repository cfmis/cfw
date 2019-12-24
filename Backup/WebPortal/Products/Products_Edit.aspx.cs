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
using Leyp.Model.View;
using Leyp.Components.Module;
using Leyp.Components;


public partial class Products_Products_Edit : ProductsManager
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            editBand();
        }
    }

    protected void editBand() {
        Products p = new Products();

        try
        {
            string productsID = Request.QueryString["ProductsID"].ToString();
           
            p = Leyp.SQLServerDAL.Factory.getProductsDAL().getByProductsID(int.Parse(productsID));
        }
        catch
        {
            Response.Write("没有你要的数据");
            Response.End();
        }

          Color.Text= p.Color;
          Weight.Text=p.Weight;
          Spec.Text= p.Spec ;
          Cost.Text= p.Cost.ToString();
          ProductsUints.Text=p.ProductsUints;
          Material.Text=p.Material;

          UpperLimit.Text=p.UpperLimit.ToString();
          LowerLimit.Text=p.LowerLimit.ToString();

          BeginEnterDate.Text=p.BeginEnterDate;
          FinalEnterDate.Text=p.FinalEnterDate;
          LatelyOFSDate.Text=p.LatelyOFSDate;
          LoadingDate.Text=p.LoadingDate ;
          UnshelveDate.Text=p.UnshelveDate;
          Description.Text=p.Description;
          PID.Text = p.ProductsID.ToString();
          ProductsName.Text = p.ProductsName;
          Price.Text = p.Price.ToString();
          ProductsBrandDropDownList1.Items.FindByValue(p.BrandID.ToString()).Selected=true;
          ProductsTypeDropDownList1.Items.FindByValue(p.TypeID.ToString()).Selected=true;




    
    }
    protected void NextButton_Click(object sender, EventArgs e)
    {

        if (int.Parse(UpperLimit.Text.ToString()) < int.Parse(LowerLimit.Text.ToString()))
        {
            Jscript.AjaxAlert(this, "库存上限应该大于下限！");
            return;


        }

        Products p = new Products();
        p.ProductsName = ProductsName.Text.ToString();
        try
        {
            p.TypeID = int.Parse(ProductsTypeDropDownList1.SelectedValue.ToString());
            p.BrandID = int.Parse(ProductsBrandDropDownList1.SelectedValue.ToString());
        }
        catch
        {
            Jscript.AjaxAlert(this, "请正确选择 商品品牌 和 商品类型");
            return;
        }

        p.Color = getStrValue(Color.Text.ToString());
        p.Weight = getStrValue(Weight.Text.ToString());
        p.Spec = getStrValue(Spec.Text.ToString());
        p.Cost = float.Parse(Cost.Text.ToString());
        p.ProductsUints = getStrValue(ProductsUints.Text.ToString());
        p.Material = getStrValue(Material.Text.ToString());

        p.UpperLimit = int.Parse(UpperLimit.Text.ToString());
        p.LowerLimit = int.Parse(LowerLimit.Text.ToString());
        p.BeginEnterDate = getStrValue(BeginEnterDate.Text.ToString());
        p.FinalEnterDate = getStrValue(FinalEnterDate.Text.ToString());
        p.LatelyOFSDate = getStrValue(LatelyOFSDate.Text.ToString());
        p.LoadingDate = getStrValue(LoadingDate.Text.ToString());
        p.UnshelveDate = getStrValue(UnshelveDate.Text.ToString());
        p.Description = getStrValue(Description.Text.ToString());
        p.ProductsID = int.Parse(PID.Text.ToString());

        p.Price = float.Parse(Price.Text.ToString());

        if (Leyp.SQLServerDAL.Factory.getProductsDAL().updateProducts(p))
        {

            addSystemLog("商品ID:" + PID.Text.ToString() + " 修改成功");
            
            HyperLink1.Visible = true;
            Panel2.Visible = true;
            Panel1.Visible = false;


        }
        else
        {
            HyperLink1.Text = "修改失败！";
            HyperLink1.Visible = true;
            Panel2.Visible = true;
            Panel1.Visible = false;


        }
       

    }
}
