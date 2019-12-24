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
public partial class Notice_Notice_Detail :BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) { init(); }
    }
    protected void init()
    {
        try
        {
            string id = Request.QueryString["NoticeID"].ToString();
            Notice n = Leyp.SQLServerDAL.Factory.getNoticeDAL().getByID(int.Parse(id));
            if (n == null)
            {
                Response.Write("没有数据！");
                return;
            }
            titles.Text = n.Title;
            CreateDate.Text = n.CreateDate;
            User.Text = n.UserName;
            Infos.Text = n.Info;
            HyperLink1.NavigateUrl = "Notice_Del.aspx?NoticeID=" + id + "";


        }
        catch
        {
            Response.Write("参数有误！");
        }

    
    }
}
