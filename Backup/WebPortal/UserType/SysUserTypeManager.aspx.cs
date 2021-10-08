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
using Leyp.Model.View;

using Leyp.Components;
using System.Collections.Generic;

public partial class UserType_SysUserTypeManager : Leyp.Components.Module.SysUserType
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            Databang();
        }
    }

    protected void Databang()
    {
        object action = Request.QueryString["action"];
        if (action != null)
        {
            if (action.ToString().Equals("edit"))
            {
                int SubClassID = Int16.Parse(Request.QueryString["SubClassID"].ToString());
                UserTypeSubClass s = new UserTypeSubClass();
                s = Leyp.SQLServerDAL.Factory.getUserTypeSubClassDAL().getByID(SubClassID);
                SubTypeName.Text = s.SubClassName;
                Pageaction.Text = "edit";
                editSubClassID.Text = SubClassID.ToString();
                UserTypeDropDownList.Visible = false;



            }
            else if (action.ToString().Equals("del"))
            {
                int SubClassID = Int16.Parse(Request.QueryString["SubClassID"].ToString());

                if (Leyp.SQLServerDAL.Factory.getUserTypeSubClassDAL().deleteNode(SubClassID))
                {
                    addSystemLog("成功删除用户类型ID" + SubClassID);
                    Jscript.AjaxAlert(this, " 删除成功");
                  
                }
                else
                {  
                  Jscript.AjaxAlert(this," 用户已经使用！不能删除!");
                 
                }

            
            }
        }

        listDatabang();
        userTypeBand();


    }



    protected void updateButton_Click(object sender, EventArgs e)
    {
        string str = SubTypeName.Text.ToString();
        string str1 = DropDownList1.SelectedValue.ToString();
        int UserTypeID = int.Parse(UserTypeDropDownList.SelectedValue.ToString());
        UserTypeSubClass s = new UserTypeSubClass();
        s.UserTypeID = UserTypeID;
        s.SubClassName = str;
        s.State = str1;
        if (Pageaction.Text.ToString().Equals("edit"))
        {
            s.SubClassID = int.Parse(editSubClassID.Text.ToString());

            if (Leyp.SQLServerDAL.Factory.getUserTypeSubClassDAL().updateUserTypeSubClass(s))
            {
                addSystemLog("成功更新用户类型ID" + editSubClassID.Text.ToString());
                Panel1.Visible = false;
                HyperLink1.Visible = true;
            }
            else
            {
                Panel1.Visible = false;
                HyperLink1.Text = "操作失败！返回列表";
                HyperLink1.Visible = true;
            }

              

        }
        else
        {
            if (Leyp.SQLServerDAL.Factory.getUserTypeSubClassDAL().insertNewUserTypeSubClass(s))
            {
                addSystemLog("成功添加用户类型" + str);
                Panel1.Visible = false;
                HyperLink1.Visible = true;
            }
            else
            {

                Panel1.Visible = false;
                HyperLink1.Text = "操作失败！可能系信息重复！返回列表";
                HyperLink1.Visible = true;

            }
        }



    }

    /// <summary>
    /// 绑定所有用户类型
    /// </summary>
    protected void listDatabang()
    {

        CollectionPager1.DataSource = changeListForViewList(Leyp.SQLServerDAL.Factory.getUserTypeSubClassDAL().getAllUserTypeSubClass(), Leyp.SQLServerDAL.Factory.getUserTypeDAL().getAllUserType()); 
        CollectionPager1.BindToControl = listType;
        listType.DataSource = CollectionPager1.DataSourcePaged;
       

    }
     
    /// <summary>
    /// 一级用户类型绑定
    /// </summary>
    protected void userTypeBand()
    {
        List<UserType> al = new List<UserType>();
        al=Leyp.SQLServerDAL.Factory.getUserTypeDAL().getAllUserType();
        UserTypeDropDownList.DataSource = al;
        UserTypeDropDownList.DataTextField = "TypeName";
        UserTypeDropDownList.DataValueField = "TypeID";
        UserTypeDropDownList.DataBind();
    
    }
}
