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
using Leyp.Model.Sales;
using Leyp.Components.Module;

public partial class Shop_SysShopManager : SysShopManager
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            initDataBand();
        }

    }
    
    /// <summary>
    /// 页面初始化
    /// </summary>
    public void initDataBand()
    {
        string action = Request.QueryString["action"];

        if (action == null)
        {
            CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getShopDAL().getAllShop();//BLL项目中List数据源
            CollectionPager1.BindToControl = GridView1;
            GridView1.DataSource = CollectionPager1.DataSourcePaged;
            editPanel.Visible = false;

        }
        else if (action.Equals("edit"))
        {
            int ShopID = 0;
            try
            {
                ShopID = int.Parse(Request.QueryString["ShopID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }

            List<SalesPlatform> list = Leyp.SQLServerDAL.Sales.Factory.getSalesPlatformDAL().getList();

            PlatformID_Edit.DataSource = list;
            PlatformID_Edit.DataBind();

            

            Shop s = new Shop();
            s = Leyp.SQLServerDAL.Factory.getShopDAL().getByShopID(ShopID);

            ShopName_edit.Text = s.ShopName;
            EditID.Text = s.ShopID.ToString();//保存编辑ID
            Description_edit.Text = s.Description;

            PlatformID_Edit.Items.FindByValue(s.PlatformID.ToString()).Selected = true;
            ShopUrl_Edit.Text = s.ShopUrl;


            editPanel.Visible = true;
            viewPanel.Visible = false;

        }
    
    }

    protected void updateButton_Click(object sender, EventArgs e)
    {

        string sName = ShopName_edit.Text.ToString();
        string Destr = Description_edit.Text.ToString();
        string id = EditID.Text.ToString();

        Shop s=new Shop();
        s.ShopName=sName;
        s.Description=Destr;
        s.ShopID=int.Parse(id);
        s.ShopUrl = ShopUrl_Edit.Text.ToString();
        s.PlatformID = int.Parse(PlatformID_Edit.SelectedValue.ToString());

        if (Leyp.SQLServerDAL.Factory.getShopDAL().updateShop(s))
        {
            HyperLink1.Visible = true;
            viewPanel.Visible = false;
            editPanel.Visible = false;
        }
        else
        {

            HyperLink1.Text = "失败！你可以返回重新试试";
            HyperLink1.Visible = true;
            viewPanel.Visible = false;
        }


    }
    protected void submit_Click(object sender, EventArgs e)
    {
        string sName = ShopName_New.Text.ToString();
        string Destr = Description_new.Text.ToString();


        Shop s=new Shop();
        s.ShopName=sName;
        s.Description=Destr;
        s.PlatformID = int.Parse(PlatformID.SelectedValue.ToString());
        s.ShopUrl = ShopUrl.Text.ToString();

        if(Leyp.SQLServerDAL.Factory.getShopDAL().insertNewShop(s))
        {
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
}
