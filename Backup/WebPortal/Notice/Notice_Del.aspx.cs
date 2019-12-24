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
using Leyp.Components.Module;

public partial class Notice_Notice_Del : NoticeModule
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
            string id = Request.QueryString["NoticeID"].ToString();

            Leyp.SQLServerDAL.Factory.getNoticeDAL().deleteEitity(int.Parse(id));
            Response.Write("删除成功"); Response.End();

       


    }
}
