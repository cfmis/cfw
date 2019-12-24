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
using Leyp.Model.View;
using Leyp.Model;
using Leyp.Components.Module;
using Leyp.SQLServerDAL;
using Leyp.SQLServerDAL;

public partial class Products_ShowProductsInfo :BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBand();
        
        }

    }

    protected void DataBand()
    {
        object PID = Request.QueryString["ProductsID"];
        string ProductsID = PID.ToString();

        VProducts p = new VProducts();
        p = new VProductsDAL().getByID(int.Parse(ProductsID));

        if (p == null)
        {
            Response.Write("没有你要的数据");
            Response.End();
            return;
        }

        int typeid = p.TypeID;
        ProductsType pt = new ProductsTypeDAL().getByTypeID(typeid);
        if (getTypeID() != 0)
        {
            if (pt.State.Equals("NB"))
            {
                Response.Write("没有权限");
                Response.End();
                return;
            }
        
        }

        Label1.Text = p.BrandName;
        Label2.Text = p.TypeName;
        Label3.Text = p.ProductsUints;
        Label4.Text = p.Color;
        Label5.Text = p.Spec;
        Label6.Text = p.Weight;
        Label7.Text = p.Material;
        Label8.Text = ProductsID;
        Label9.Text = p.ProductsName;
        Image1.ImageUrl = "~/UploadFiles/Images/"+p.PhotoUrl+"";

        ProductsUserType pu = Leyp.SQLServerDAL.Factory.getProductsUserTypeDAL().getByProductsIDAndSubClassID(int.Parse(ProductsID), 1);//按用户类型给出一个商品的标价

        Label10.Text = pu.Price.ToString();
        ListBand(int.Parse(ProductsID));
    }
    
    /// <summary>
    /// 更多图片绑定
    /// </summary>
    /// <param name="id"></param>
    protected void ListBand(int id)
    {
        List<ProductsPhoto> al = new List<ProductsPhoto>();
        al = Leyp.SQLServerDAL.Factory.getProductsPhotoDAL().getListByProductsID(id);
        DataList1.DataSource = al;
        DataList1.DataBind();

    }

}
