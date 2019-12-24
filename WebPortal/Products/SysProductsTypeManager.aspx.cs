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

public partial class Products_SysProductsTypeManager : SysProductsTypeManager
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
            CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getProductsTypeDAL().getAllProductsType();//BLL项目中List数据源
            CollectionPager1.BindToControl = GridView1;
            GridView1.DataSource = CollectionPager1.DataSourcePaged;
            editPanel.Visible = false;

        }
        else if (action.Equals("edit"))
        {
            int typeID = 0;
            try
            {
                typeID = int.Parse(Request.QueryString["TypeID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }

            ProductsType pb = new ProductsType();
            pb = Leyp.SQLServerDAL.Factory.getProductsTypeDAL().getByTypeID(typeID);

            TypeName_edit.Text = pb.TypeName;
            TypeID.Text = pb.TypeID.ToString();//保存编辑ID
            Description_edit.Text = pb.Description;
            State_edit.Items.FindByValue(pb.State.ToString()).Selected = true;
            editPanel.Visible = true;
            viewPanel.Visible = false;

        }
        else if (action.Equals("del"))
        {
            int typeID = 0;
            try
            {
                typeID = int.Parse(Request.QueryString["TypeID"].ToString());
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }

            if (Leyp.SQLServerDAL.Factory.getProductsTypeDAL().deleteByTypeID(typeID))
            {
                Response.Write("删除成功！");
                Response.End();

            }
            else
            {

                Response.Write("失败！可能该类型已经在使用中");
                Response.End();
            
            }




        }
    }
    protected void submit_Click(object sender, EventArgs e)
    {
        string strName = TypeName_New.Text.ToString();
        string strState = State_new.Text.ToString();
        string strDesc = Description_new.Text.ToString();

        ProductsType pb = new ProductsType();
        pb.TypeName = strName;
        pb.Description = strDesc;
        pb.State = strState;

        if (Leyp.SQLServerDAL.Factory.getProductsTypeDAL().insertNewProductsType(pb))
        {

            addSystemLog("新添商品类型：" + strName);
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
        string strName = TypeName_edit.Text.ToString();
        string strState = State_edit.Text.ToString();
        string strDesc = Description_edit.Text.ToString();

        ProductsType pb = new ProductsType();
        pb.TypeName= strName;
        pb.Description = strDesc;
        pb.State = strState;
        pb.TypeID = int.Parse(TypeID.Text.ToString());

        if (Leyp.SQLServerDAL.Factory.getProductsTypeDAL().updateProductsType(pb))
        {

            addSystemLog("更新商品类型：" + strName);
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
