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
using Leyp.Components;
using Leyp.Model;
using Leyp.Model.View;
using System.Collections.Generic;

public partial class User_SysUserManagerEdit : System.Web.UI.Page
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
    protected void DataBand()
    {
        string username = Request.QueryString["UserName"];
        if (username == null)
        {
            Response.Write("参数有误");
            Response.End();
        }

        Vuser u = new Vuser();
        u = Leyp.SQLServerDAL.Factory.getVuserDAL().getUserViewByID(username);

        if (u == null)
        {
            Response.Write("没有数据");
            Response.End();
        }

        UserName.Text = u.UserName;
        Dept.Text = u.Dept;
        QQ.Text = u.QQ;
        WangWang.Text = u.WangWang;
        Email.Text = u.Email;
        RealName.Text = u.RealName;
        Tel.Text = u.Tel;
        Description.Text = u.Description;


        BankAccount.Text = u.BankAccount;
        Bankname.Text = u.Bankname;
        Character.Text = u.Character;
        CompanyInfo.Text = u.CompanyInfo;
        CompanyName.Text = u.CompanyName;
        Address.Text = u.Address;
 

        GroupID.Text = u.GroupID.ToString();
        GroupID1.Value = u.GroupID.ToString();
        TypeName.Text = u.TypeName;
        SubClassName.Text = u.SubClassName;
        Label3.Text = u.GroupName;

       
        

        SubClassDatabang(0);//初始化


    }
   

    /// <summary>
    /// 绑定二级菜单
    /// </summary>
    /// <param name="UserTypeID">对应上级菜单</param>
    protected void SubClassDatabang(int UserTypeID)
    {
        List<UserTypeSubClass> list = new List<UserTypeSubClass>();
        list = Leyp.SQLServerDAL.Factory.getUserTypeSubClassDAL().getSubClassByUserTypeID(UserTypeID);

        SubClassID.DataSource = list;
        SubClassID.DataTextField = "SubClassName";
        SubClassID.DataValueField = "SubClassID";
        SubClassID.DataBind();


    }

    /// <summary>
    /// 菜单联动
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void TypeID_SelectedIndexChanged(object sender, EventArgs e)
    {
        int UserTypeID = int.Parse(TypeID.SelectedValue.ToString());

        SubClassDatabang(UserTypeID);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void edit_Submit_Click(object sender, ImageClickEventArgs e)
    {

        string strName = UserName.Text.ToString();
        string strRname = RealName.Text.ToString();
        int typeid = int.Parse(TypeID.SelectedValue.ToString());

        string subClass = SubClassID.SelectedValue.ToString();

        if (subClass.Equals("-1"))
        {
            Jscript.AjaxAlert(this, "请选择用户类型");
            return;
        }
        int groupid = int.Parse(GroupID1.Value.ToString());
        string strDept = Dept.Text.ToString();
        string strQQ = QQ.Text.ToString();
        string strTaobao = WangWang.Text.ToString();
        string strTel = Tel.Text.ToString();
        string strEmail = Email.Text.ToString();
        string strDesc = Description.Text.ToString();
        string strState = State.SelectedValue.ToString();
        string strSex = Sex.SelectedValue.ToString();
        Leyp.Model.User u = new Leyp.Model.User();

        u.UserName = strName;
        u.Description = strDesc;
        u.Email = strEmail;
        u.GroupID = groupid;
        u.TypeID = typeid;
        u.SubClassID = int.Parse(subClass);
        u.QQ = strQQ;
        u.RealName = strRname;
        u.Sex = strSex;
        u.State = strState;
        u.WangWang = strTaobao;
        u.Tel = strTel;
        u.Dept = strDept;
        u.BankAccount = BankAccount.Text.ToString();
        u.Bankname = Bankname.Text.ToString();
        u.Character = Character.Text.ToString();
        u.CompanyInfo = CompanyInfo.Text.ToString();
        u.CompanyName = CompanyName.Text.ToString();
        u.Address = Address.Text.ToString();

        if (Leyp.SQLServerDAL.Factory.getUserDAL().updateUser(u))
        {
            Panel1.Visible = false;
            HyperLink1.Visible = true;
        }
        else
        {
            Panel1.Visible = false;
            HyperLink1.Text = "添加失败！可能用户名已经存在！请重新注册";
            HyperLink1.Visible = true;
        }

    }
}
