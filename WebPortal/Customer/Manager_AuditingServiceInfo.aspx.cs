using System;
using System.Data;
using System.Text;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Components.Module;

/// <summary>
/// 问题服务件
/// </summary>
public partial class Customer_Manager_AuditingServiceInfo : ManagerServiceInfo
{
    protected void Page_Load(object sender, EventArgs e)
    {

    if (!IsPostBack)
        {
            init();
        }

    }
    /// <summary>
    /// 
    /// </summary>
    protected void init()
    {
        string action = Request.QueryString["action"].ToString();

        if (action.Equals("Auditing"))//受理
        {
            string AuditingId = Request.QueryString["AuditingId"].ToString();
            StringBuilder sb = new StringBuilder();
            string[] a = AuditingId.Split('#');
            Leyp.SQLServerDAL.ServiceInfoDAL bl = new Leyp.SQLServerDAL.ServiceInfoDAL();
            int num = 0;
            for (int i = 0; i < a.Length; i++)
            {

                if (bl.updateUserforAuditing(int.Parse(a[i]), getUserName()))//受理
                {
                    num++;
                }
                else
                {
                    sb.Append("编号：" + a[i] + " 已经受理不能再受理 <br/>");
                }

            }
            sb.Append("成功受理  " + num + "条");
            Response.Write(sb.ToString());
        }
        else if (action.Equals("Solve"))//解决
        {
            string AuditingId = Request.QueryString["AuditingId"].ToString();
            StringBuilder sb = new StringBuilder();
            string[] a = AuditingId.Split('#');
            Leyp.SQLServerDAL.ServiceInfoDAL bl = new Leyp.SQLServerDAL.ServiceInfoDAL();
            int num = 0;
            for (int i = 0; i < a.Length; i++)
            {

                if (bl.updateSolve(int.Parse(a[i]), getUserName()))//解决
                {
                    num++;
                }
                else
                {
                    sb.Append("编号：" + a[i] + " 可能受理他人处理，不能解决 <br/>");
                }

            }
            sb.Append("成功解决  " + num + "条");
            Response.Write(sb.ToString());
        }
        else if (action.Equals("Cancel"))//解决
        {
            string AuditingId = Request.QueryString["AuditingId"].ToString();
            StringBuilder sb = new StringBuilder();
            string[] a = AuditingId.Split('#');
            Leyp.SQLServerDAL.ServiceInfoDAL bl = new Leyp.SQLServerDAL.ServiceInfoDAL();
            int num = 0;
            for (int i = 0; i < a.Length; i++)
            {

                if (bl.updateCancel(int.Parse(a[i]), getUserName()))//解决
                {
                    num++;
                }
                else
                {
                    sb.Append("编号：" + a[i] + " 可能受理他人处理，您不能操作<br/>");
                }

            }
            sb.Append("成功操作  " + num + "条");
            Response.Write(sb.ToString());
        }
    }
}
