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
using Leyp.Model.View;

public partial class User_SysUserDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
        }

    }

    protected void init()
    {

        string Username = Request.QueryString["UserName"].ToString();
        Vuser u = new Vuser();
        u = Leyp.SQLServerDAL.Factory.getVuserDAL().getUserViewByID(Username);

        if (u != null)
        {
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


            State.Text = u.State;
            Sex.Text = u.Sex;
            UserType.Text = u.TypeName + "------>" + u.SubClassName;

            GroupID.Text = u.GroupName;
           
        
        
        
        }
        else
        {
            Response.Write("没有您要的数据");

            Response.End();
        
        
        }





    }
}
