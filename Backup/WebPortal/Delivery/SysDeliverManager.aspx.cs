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
using Leyp.Components;

public partial class Delivery_SysDeliverManager : ManagerDelivery
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
            CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getDeliveryDAL().getAllDelivery();//BLL项目中List数据源
            CollectionPager1.BindToControl = GridView1;
            GridView1.DataSource = CollectionPager1.DataSourcePaged;
            editPanel.Visible = false;

        }
        else if (action.Equals("edit"))
        {
            int DeliveryID = 0;
            try
            {
                DeliveryID = int.Parse(Request.QueryString["DeliveryID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }

            Delivery s = new Delivery();
            s = Leyp.SQLServerDAL.Factory.getDeliveryDAL().getByID(DeliveryID);

            ShopName_edit.Text = s.DeliveryName;
            EditID.Text = s.DeliveryID.ToString();//保存编辑ID
            Description_edit.Text = s.Description;
            editPanel.Visible = true;
            viewPanel.Visible = false;

        }else if (action.Equals("del"))
        {
             int DeliveryID = 0;
            try
            {
                DeliveryID = int.Parse(Request.QueryString["DeliveryID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }
            if(Leyp.SQLServerDAL.Factory.getDeliveryDAL().deleteDelivery(DeliveryID))
            {
               Response.Write("删除成功");
                Response.End();
            }else
            {
               Response.Write("删除失败！可能已经使用");
                Response.End();
            }

        }
        else if (action.Equals("updateDefault"))
        {

            viewPanel.Visible = false;
            updateDefaultPanel.Visible = true;
        }

    }

    protected void updateButton_Click(object sender, EventArgs e)
    {

        string sName = ShopName_edit.Text.ToString();
        string Destr = Description_edit.Text.ToString();
        string id = EditID.Text.ToString();

        Delivery s = new Delivery();
        s.DeliveryName = sName;
        s.Description = Destr;
        s.DeliveryID = int.Parse(id);

        if (Leyp.SQLServerDAL.Factory.getDeliveryDAL().updateDelivery(s))
        {
            HyperLink1.Visible = true;
            viewPanel.Visible = false;
        }
        else
        {

            HyperLink1.Text = "失败！你可以返回重新试试";
            HyperLink1.Visible = true;
            editPanel.Visible = false;
        }


    }
    protected void submit_Click(object sender, EventArgs e)
    {
        string sName = ShopName_New.Text.ToString();
        string Destr = Description_new.Text.ToString();

        Delivery s = new Delivery();
        s.DeliveryName = sName;
        s.Description = Destr;

        if (Leyp.SQLServerDAL.Factory.getDeliveryDAL().insertNewEitity(s))
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
    protected void Button2_Click(object sender, EventArgs e)
    {
        string idstring = DeliveryDropDownList1.SelectedValue.ToString();
        if (idstring == null || idstring.Equals(""))
        {
            Jscript.AjaxAlert(this, "请选择选项！");
            return;
        }
        if (Leyp.SQLServerDAL.Factory.getDeliveryDAL().updataDefault(int.Parse(idstring)))
        {

            HyperLink1.Visible = true;
            updateDefaultPanel.Visible = false;
        }
    }
}
