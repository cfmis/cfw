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
using Leyp.Components.Module;
using Leyp.Components;

public partial class Customer_ServiceInfo_Detail :BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack) { init(); }
    }
    protected void init()
    {
        try
        {
            string id = Request.QueryString["ServiceID"].ToString();
            VServiceInfo n = Leyp.SQLServerDAL.Factory.getServiceInfoDAL().getByID(int.Parse(id));
            if (n == null)
            {
                Response.Write("没有数据！");
                Response.End();
                return;
            }




            IDS.Text = id;
            ServiceTitle.Text = n.ServiceTitle;
            CreateDate.Text = n.CreateDate;
            Content.Text = n.Content;
            ServiceName.Text = n.ServiceName;
            ReplyInfo.Text = n.ReplyInfo;
            AuditingUser.Text = n.AuditingUser;
            UserName.Text = n.UserName;
            State.Text = changString(n.State.ToString());
            RealName.Text = n.RealName;

          


        }
        catch
        {
            Response.Write("参数有误！");
        }


    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (!checkAuthority())
        {
            Jscript.AjaxAlert(this, "受理用户 和 提问者 方可留言");
            return;
        }
        int id = int.Parse(IDS.Text.ToString());
        string str = "<font color=\"#009900\">" + DateTime.Now.ToString("yyyy-MM-dd") + " " + getUserName() + " </font> :" + TextReplyInfo.Text.ToString() + " <br/>";

        Leyp.SQLServerDAL.Factory.getServiceInfoDAL().addReplyInfo(id, str);

        Jscript.JavaScriptLocationHref(Request.RawUrl);

       
    }


    /// <summary>
    /// 问题讨论权限判断
    /// </summary>
    /// <returns></returns>
    protected bool checkAuthority()
    { 
      if(UserName.Text.ToString().Equals(getUserName()))
      {
        return true;
      }
      if (AuditingUser.Text.ToString().Equals(getUserName()))
      {
          return true;
      }
      else

      {
          return false;
      
      }
    
    }


    /// <summary>
    /// 
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public string changString(string str)
    {

        if (str.Equals("1"))
        {
            return "<font color=\"#009933\">已受理</font>";
        }
        else if (str.Equals("0"))
        {
            return "<font color=\"#FF0000\">未受理</font>";
        }
        else if (str.Equals("2"))
        {
            return "<font color=\"#009933\">已解决</font>";
        }
        else if (str.Equals("3"))
        {
            return "<font color=\"#FF0000\">已过期/作废</font>";
        }

        else
        {
            return str;
        }

    }
}
