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
using Leyp.Model;
using Leyp.Components.Module;

public partial class Products_SysProductsBrandManager : SysProductsBrandManager
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBand();
        }
    }
    /// <summary>
    /// 初始化
    /// </summary>
    public void DataBand()
    { 
       string action = Request.QueryString["action"];
      
        if (action == null)
        {
            CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getProductsBrandDAL().getAllProductsBrand();//BLL项目中List数据源
            CollectionPager1.BindToControl = GridView1;
            GridView1.DataSource = CollectionPager1.DataSourcePaged;
            editPanel.Visible = false;

        }
        else if (action.Equals("edit"))
        {
            int brandID=0;
            try
            {
                brandID = int.Parse(Request.QueryString["BrandID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }

            ProductsBrand pb = new ProductsBrand();
            pb = Leyp.SQLServerDAL.Factory.getProductsBrandDAL().getByBrandID(brandID);

            BrandName_edit.Text = pb.BrandName;
            BrandID.Text = pb.BrandID.ToString();//保存编辑ID
            Description_edit.Text = pb.Description;
            editPanel.Visible = true;
            viewPanel.Visible = false;

        }
        else if (action.Equals("del"))
        {

            int brandID = 0;
            try
            {
                brandID = int.Parse(Request.QueryString["BrandID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }

            if (Leyp.SQLServerDAL.Factory.getProductsBrandDAL().deleteByBrandID(brandID))
            {
                Response.Write("删除成功！");
                Response.End();

            }
            else
            {

                Response.Write("失败！可能该品牌已经在使用中");
                Response.End();

            }


        }
    }
    protected void submit_Click(object sender, EventArgs e)
    {
        string strName = BrandName_New.Text.ToString();
        string strState = State_new.Text.ToString();
        string strDesc = Description_new.Text.ToString();

        ProductsBrand pb = new ProductsBrand();
        pb.BrandName = strName;
        pb.Description = strDesc;
        pb.State = strState;

        if (Leyp.SQLServerDAL.Factory.getProductsBrandDAL().insertNewProductsBrand(pb))
        {
            addSystemLog("新加商品品牌：" + strName);
            HyperLink1.Visible = true;
            viewPanel.Visible = false;
        }
        else
        {

            HyperLink1.Text = "添加失败！可能是名称重复了!你可以返回重新试试";
            HyperLink1.Visible = true;
            viewPanel.Visible = false;
        }
    }
    protected void updateButton_Click(object sender, EventArgs e)
    {
        string strName = BrandName_edit.Text.ToString();
        string strState = State_edit.Text.ToString();
        string strDesc = Description_edit.Text.ToString();

        ProductsBrand pb = new ProductsBrand();
        pb.BrandName = strName;
        pb.Description = strDesc;
        pb.State = strState;
        pb.BrandID = int.Parse(BrandID.Text.ToString());

        if (Leyp.SQLServerDAL.Factory.getProductsBrandDAL().updataProductsBrand(pb))
        {
            addSystemLog("成功修改商品品牌：" + strName);
            HyperLink1.Visible = true;
            editPanel.Visible = false;
            viewPanel.Visible = false;
        }
        else
        {

            HyperLink1.Text = "添加失败！可能是名称重复了!你可以返回重新试试";
            HyperLink1.Visible = true;
            editPanel.Visible = false;
            viewPanel.Visible = false;
        }

    }
}
