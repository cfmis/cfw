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
using Leyp.Components;

public partial class Flow_PhotoFlow_Detail : System.Web.UI.Page
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
        string FlowID = Request.QueryString["FlowID"].ToString();

        PhotoFlow p = new PhotoFlow();
        p=Leyp.SQLServerDAL.Factory.getPhotoFlowDAL().getByID(int.Parse(FlowID));
        Label1.Text=p.Content;
        Label2.Text=p.FlowID.ToString();


    }
}
//该源码首发自www.51aspx.com(５１ａｓｐｘ．ｃｏｍ)
