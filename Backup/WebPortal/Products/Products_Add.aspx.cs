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
using Leyp.Components.Module;


public partial class Products_Products_Add : ProductsManager
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void NextButton_Click(object sender, EventArgs e)
    {
        //Panel2.Visible = true;
       // Panel1.Visible = false;

        if (int.Parse(UpperLimit.Text.ToString()) < int.Parse(LowerLimit.Text.ToString()))
        {
            Jscript.AjaxAlert(this,"库存上限应该大于下限！");
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
            Jscript.AjaxAlert(this,"请正确选择 商品品牌 和 商品类型");
            return;
        }
        p.Color = getStrValue(Color.Text.ToString());
        p.Weight = getStrValue(Weight.Text.ToString());
        p.Spec = getStrValue(Spec.Text.ToString());
        p.Cost = float.Parse(Cost.Text.ToString());
        p.Price = float.Parse(Price.Text.ToString());
       
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
       
       
       
        if (addNewProducts(p))
        {
            addSystemLog("商品名" + ProductsName.Text.ToString() + " 添加成功");
            HyperLink1.Visible = true;
            Panel2.Visible = true;
            Panel1.Visible = false;
            

        }
        else
        {
            HyperLink1.Text = "添加失败！";
            HyperLink1.Visible = true;
            Panel2.Visible = true;
            Panel1.Visible = false;

        
        }

        
        //(float) int.Parse(Cost.Text.ToString());
       // Double d = new Double(Cost.Text.ToString());

       
        
    }


   


   


}
