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

public partial class User_SysUserEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBand();
        
        }
    }
    protected void DataBand()
    {
        string username = Request.QueryString["UserName"];
        if (username == null)
        {
          Response.Write("参数有误");
          Response.End();
        }

        User u = new User();
        u = Leyp.SQLServerDAL.Factory.getUserDAL().getByUserName(username);

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
        usertypeLabel1.Text = u.TypeID.ToString();
        subclassLabel2.Text = u.SubClassID.ToString();
        groupLabel3.Text = u.GroupID.ToString();
        StateLabel4.Text = u.State;


        GroupID.Text = u.GroupID.ToString();
        GroupID1.Value = u.GroupID.ToString();

        SubClassDatabang(0);//初始化


    
    
    }


    /// <summary>
    /// 提交修改
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Add_Submit_Click(object sender, EventArgs e)
    {
        string strName = UserName.Text.ToString();
        string strRname = RealName.Text.ToString();
        int typeid ;
        int subClass;
        string strState;
        int groupid ;


        if (AuthorityBox.Checked)//如果选中要修改权限
        {
            typeid = int.Parse(TypeID.SelectedValue.ToString());
            subClass = int.Parse(SubClassID.SelectedValue.ToString());
            strState = State.SelectedValue.ToString();
            groupid= int.Parse(GroupID1.Value.ToString());

        }
        else
        {
            typeid = int.Parse(usertypeLabel1.Text.ToString());
            subClass = int.Parse(subclassLabel2.Text.ToString());
            groupid=int.Parse(groupLabel3.Text.ToString());
            strState = StateLabel4.Text.ToString();
        
        }

        if (subClass.Equals("-1"))
        {
            Jscript.AjaxAlert(this, "请选择用户类型");
            return;
        }

       
        string strDept = Dept.Text.ToString();
        string strQQ = QQ.Text.ToString();
        string strTaobao = WangWang.Text.ToString();
        string strTel = Tel.Text.ToString();
        string strEmail = Email.Text.ToString();
        string strDesc = Description.Text.ToString();

        string strSex = Sex.SelectedValue.ToString();
        Leyp.Model.User u = new Leyp.Model.User();

        u.UserName = strName;
        u.Description = strDesc;
        u.Email = strEmail;
        u.GroupID = groupid;
        u.TypeID = typeid;
        u.SubClassID = subClass;
        u.QQ = strQQ;
        u.RealName = strRname;
        u.Sex = strSex;
        u.State = strState;
        u.WangWang = strTaobao;
        u.Tel = strTel;
        u.Dept = strDept;

        if (Leyp.SQLServerDAL.Factory.getUserDAL().updateUser(u))
        {
            Panel1.Visible = false;
            Panel0.Visible = false;
            Panel2.Visible = false;
            HyperLink1.Visible = true;
        }
        else
        {
            Panel1.Visible = false;
            Panel0.Visible = false;
            Panel2.Visible = false;
            HyperLink1.Text = "操作失败！请重操作";
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


    protected void AuthorityBox_CheckedChanged(object sender, EventArgs e)
    {
        Panel1.Visible = true;
    }
}
