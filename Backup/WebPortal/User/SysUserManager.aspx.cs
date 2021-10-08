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
using System.Collections.Generic;

public partial class User_SysUserManager : Leyp.Components.Module.SysUserManager
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            SubClassDatabang(0);
        }
        
     }
    ///// <summary>
    ///// 用户查询
    ///// </summary>
    ///// <param name="sender"></param>
    ///// <param name="e"></param>
    //protected void SearchButton_Click(object sender, EventArgs e)
    //{

    //    string strName = "";
    //    int strUserType =0;
    //    string strSubClass ="";
    //    Response.Redirect(string.Format("SysUserSearch.aspx?UserName={0}&UserTypeID={1}&SubClassID={2}", strName, strUserType, strSubClass));
    
    //}

    protected void Add_Submit_Click(object sender, EventArgs e)
    {
        string strName = UserName.Text.ToString();
        string strPwd = PassWord.Text.ToString();
        string strRname = RealName.Text.ToString();
        int typeid = int.Parse(TypeID.SelectedValue.ToString());

        string subClass = SubClassID.SelectedValue.ToString();

        if (subClass.Equals("-1"))
        {
            Jscript.AjaxAlert(this, "请 选择用户类型");
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
        u.Password = StrHelper.EncryptPassword(strPwd, StrHelper.PasswordType.MD5);//MD5加密
        u.Description = strDesc;
        u.Email = strEmail;
        u.GroupID = groupid;
        u.TypeID = typeid;
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
        u.SubClassID = int.Parse(SubClassID.SelectedValue.ToString());
        u.LatelyLogin = "";

        if (Leyp.SQLServerDAL.Factory.getUserDAL().insertNewUser(u))
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


    protected void TypeID_SelectedIndexChanged(object sender, EventArgs e)
    {
        int UserTypeID = int.Parse(TypeID.SelectedValue.ToString());

        SubClassDatabang(UserTypeID);

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
}
