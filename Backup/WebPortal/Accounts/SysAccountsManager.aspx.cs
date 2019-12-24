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

public partial class Accounts_SysAccountsManager : SysAccountsManager
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
            CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getAccountsDAL().getAll();//List数据源
            CollectionPager1.BindToControl = GridView1;
            GridView1.DataSource = CollectionPager1.DataSourcePaged;
            editPanel.Visible = false;

        }
        else if (action.Equals("edit"))
        {
            string AccountsID="" ;
            try
            {
                AccountsID = Request.QueryString["AccountsID"].ToString();
            }
            catch
            {
                Response.Write("参数有误");
                Response.End();
            }

            Accounts s = Leyp.SQLServerDAL.Factory.getAccountsDAL().getByID(AccountsID);

            AccountsName_Edit.Text = s.AccountsName;
            AccountsID_edit.Text = s.AccountsID;
            Description_edit.Text = s.Description;
            editPanel.Visible = true;
            viewPanel.Visible = false;

        }

    }

    protected void updateButton_Click(object sender, EventArgs e)
    {

        string sID = AccountsID_edit.Text.ToString();
        string sName = AccountsName_Edit.Text.ToString();
        string Destr = Description_edit.Text.ToString();

        Accounts s = new Accounts();
        s.AccountsID = sID;
        s.AccountsName = sName;
        s.Description = Destr;

        if (Leyp.SQLServerDAL.Factory.getAccountsDAL().updateEitity(s))
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
        string sID = AccountsID_New.Text.ToString();
        string sName = AccountsName_New.Text.ToString();
        string Destr = Description_new.Text.ToString();

        Accounts s = new Accounts();
        s.AccountsID = sID;
        s.AccountsName = sName;
        s.Description = Destr;

        if (Leyp.SQLServerDAL.Factory.getAccountsDAL().insertEitity(s))
        {
            HyperLink1.Visible = true;
            viewPanel.Visible = false;
        }
        else
        {

            HyperLink1.Text = "添加失败！可能是ID名称重复了!你可以返回重新试试";
            HyperLink1.Visible = true;
            viewPanel.Visible = false;
        }
    }
}
