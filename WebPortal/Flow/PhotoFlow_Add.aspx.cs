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

public partial class Flow_PhotoFlow_Add : PhotoFlowModule
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        Jscript.AjaxAlert(this, "建设中");
        //PhotoFlow p = new PhotoFlow();
        //p.FlowTitle = txtTitle.Text.ToString();
        //p.UserName = getUserName();
        //p.Content = content.Value.ToString();
        //p.CreateDate = DateTime.Now.ToString("yyyy-MM-dd");
        //p.State = 0;

        //Leyp.SQLServerDAL.Factory.getPhotoFlowDAL().insertNewEntity(p);
        //Jscript.AjaxAlert(this, "添加成功");
        //return;



    }
}
