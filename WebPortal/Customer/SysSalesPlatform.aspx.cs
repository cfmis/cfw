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
using Leyp.Components;
using Leyp.Components.Module;

public partial class Customer_SysSalesPlatform : SalesPlatformManager
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
            CollectionPager1.DataSource = Leyp.SQLServerDAL.Sales.Factory.getSalesPlatformDAL().getList();//BLL项目中List数据源
            CollectionPager1.BindToControl = GridView1;
            GridView1.DataSource = CollectionPager1.DataSourcePaged;
            editPanel.Visible = false;

        }
        else if (action.Equals("edit"))
        {
            int PlatformID = 0;
            try
            {
                PlatformID = int.Parse(Request.QueryString["PlatformID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }

            SalesPlatform s = new SalesPlatform();
            s = Leyp.SQLServerDAL.Sales.Factory.getSalesPlatformDAL().getByID(PlatformID);

            ShopName_edit.Text = s.PlatformName;
            EditID.Text = s.PlatformID.ToString();//保存编辑ID
            Description_edit.Text = s.Description;
            editPanel.Visible = true;
            viewPanel.Visible = false;

        }
        else if (action.Equals("del"))
        {
            int PlatformID = 0;
            try
            {
                PlatformID = int.Parse(Request.QueryString["PlatformID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }
            Leyp.SQLServerDAL.Sales.Factory.getSalesPlatformDAL().deleteEitity(PlatformID);
            Jscript.AjaxAlert(this, "删除成功");
            viewPanel.Visible = false;
        }

    }

    protected void updateButton_Click(object sender, EventArgs e)
    {

        string sName = ShopName_edit.Text.ToString();
        string Destr = Description_edit.Text.ToString();
        string id = EditID.Text.ToString();

        SalesPlatform s = new SalesPlatform();
        s.PlatformName = sName;
        s.Description = Destr;
        s.PlatformID = int.Parse(id);

        if (Leyp.SQLServerDAL.Sales.Factory.getSalesPlatformDAL().updateEitity(s))
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

        SalesPlatform s = new SalesPlatform();
        s.PlatformName = sName;
        s.Description = Destr;

        if (Leyp.SQLServerDAL.Sales.Factory.getSalesPlatformDAL().insertNewEntity(s))
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