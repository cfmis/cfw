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

public partial class Products_Products_Photo_Attach : System.Web.UI.Page
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
              PID.Text = ProductsID.ToString();
            
       if(Request.QueryString["action"].ToString().Equals("view"))
       {
            
            ListBand(int.Parse(ProductsID));
            
          
        }
        else if (Request.QueryString["action"].ToString().Equals("del"))
        {
            string ID = Request.QueryString["ID"].ToString();

            if(Leyp.SQLServerDAL.Factory.getProductsPhotoDAL().deleteNodeByID(int.Parse(ID)))
            {
               Jscript.AjaxAlert(this,"删除成功！");
               ListBand(int.Parse(ProductsID));
            }

 

        
        }

        }
        catch
        {
            Response.Write("输入有误");
            Response.End();

        }



    }

    /// <summary>
    /// 上传之后动作
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Imageuploader2_Uploaded(object sender, EventArgs e)
    {

        string pid = PID.Text.ToString();
        string purl = Imageuploader2.PicSavedName;

        ProductsPhoto p = new ProductsPhoto();
        p.ProductsID = int.Parse(pid);
        p.PhotoUrl = purl;

        if (Leyp.SQLServerDAL.Factory.getProductsPhotoDAL().insertNewNode(p))
        {
            Imageuploader2.DefaultPreviewImageURL = "";
            Jscript.AjaxAlert(this, "上传成功！");

            Response.Redirect("Products_Photo_Attach.aspx?action=view&ProductsID=" + PID.Text.ToString(), true);
            return;
        }
        else
        {
            Jscript.AjaxAlert(this, "操作失败！");
            return;

        }
    }

    protected void ListBand(int id)
    {
        List<ProductsPhoto> al = new List<ProductsPhoto>();
        al = Leyp.SQLServerDAL.Factory.getProductsPhotoDAL().getListByProductsID(id);
        PhotoList.DataSource = al;
        PhotoList.DataBind();
    
    }
}
