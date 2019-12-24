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
using Leyp.Model;
using Leyp.Components;
using Leyp.Components.Module;


public partial class Products_Products_Photo : ProductsManager
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            initDataBand();
        
        }

    }

    protected void initDataBand()
    {
        try
        {
            string ProductsID = Request.QueryString["ProductsID"].ToString();

            //List<ProductsPhoto> al = new List<ProductsPhoto>();
            //al = Leyp.SQLServerDAL.Factory.getProductsPhotoDAL().getListByProductsID(int.Parse(ProductsID));
            //PhotoList.DataSource = al;
            //PhotoList.DataBind();

            PID.Text = ProductsID.ToString();
            HyperLink2.NavigateUrl = "Products_Photo_Attach.aspx?action=view&ProductsID=" + ProductsID + "";
        }
        catch
        {
            Response.Write("输入有误");
            Response.End();
        
        }


    
    }
    protected void ImageUploader1_Uploaded(object sender, EventArgs e)
    {

        string PhotoUrl = ImageUploader1.PicSavedName;
        int pid = int.Parse(PID.Text.ToString());

        if (Leyp.SQLServerDAL.Factory.getProductsDAL().updateProductsPhoto(pid, PhotoUrl))
        {
            addSystemLog("商品ID：" + PID.Text.ToString() + "修改图片成功");
            ImageUploader1.Visible = false;
            Jscript.AjaxAlert(this, "上传成功！");
            return;
        }
        else
        {

            Jscript.AjaxAlert(this, "操作失败！");
            return;
        
        
        }



    }

    ///// <summary>
    ///// 上传之后动作
    ///// </summary>
    ///// <param name="sender"></param>
    ///// <param name="e"></param>
    //protected void Imageuploader2_Uploaded(object sender, EventArgs e)
    //{

    //    string pid = PID.Text.ToString();
    //    string purl = Imageuploader2.PicThumbSavedName;

    //    ProductsPhoto p=new ProductsPhoto();
    //    p.ProductsID=int.Parse(pid);
    //    p.PhotoUrl=purl;

    //    if (Leyp.SQLServerDAL.Factory.getProductsPhotoDAL().insertNewNode(p))
    //    {
    //        Jscript.AjaxAlert(this, "上传成功！");
    //        return;
    //    }
    //    else
    //    {
    //        Jscript.AjaxAlert(this, "操作失败！");
    //        return;
        
    //    }


    //}
}
