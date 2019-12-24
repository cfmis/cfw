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

public partial class Customer_SysServiceType : System.Web.UI.Page
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
            CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getServiceTypeDAL().getAll();//BLL项目中List数据源
            CollectionPager1.BindToControl = GridView1;
            GridView1.DataSource = CollectionPager1.DataSourcePaged;
            editPanel.Visible = false;

        }
        else if (action.Equals("edit"))
        {
            int TypeID = 0;
            try
            {
                TypeID = int.Parse(Request.QueryString["TypeID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }

            ServiceType s = new ServiceType();
            s = Leyp.SQLServerDAL.Factory.getServiceTypeDAL().getByID(TypeID);

            ShopName_edit.Text = s.ServiceName;
            EditID.Text = s.TypeID.ToString();//保存编辑ID
            Description_edit.Text = s.Description;
            editPanel.Visible = true;
            viewPanel.Visible = false;

        }
        else if (action.Equals("del"))
        {
            int TypeID = 0;
            try
            {
                TypeID = int.Parse(Request.QueryString["TypeID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }
            if (Leyp.SQLServerDAL.Factory.getServiceTypeDAL().deleteDelivery(TypeID))
            {
                Response.Write("删除成功");
                Response.End();
            }
            else
            {
                Response.Write("删除失败！可能已经使用");
                Response.End();
            }

        }

    }

    protected void updateButton_Click(object sender, EventArgs e)
    {

        string sName = ShopName_edit.Text.ToString();
        string Destr = Description_edit.Text.ToString();
        string id = EditID.Text.ToString();

        ServiceType s = new ServiceType();
        s.ServiceName = sName;
        s.Description = Destr;
        s.TypeID = int.Parse(id);

        if (Leyp.SQLServerDAL.Factory.getServiceTypeDAL().updateEitity(s))
        {
            HyperLink1.Visible = true;
            viewPanel.Visible = false;
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

        ServiceType s = new ServiceType();
        s.ServiceName = sName;
        s.Description = Destr;

        if (Leyp.SQLServerDAL.Factory.getServiceTypeDAL().insertNewEitity(s))
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
