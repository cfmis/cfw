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
using Leyp.Components.Module;
using Leyp.Model;

public partial class Notice_Notice_Add : NoticeModule
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string NewTypeid = NewType.SelectedValue.ToString();
        if (NewTypeid.Equals("a"))
        {
            Jscript.AjaxAlert(this, "请选择信息类型");
            return;
             
        }
        string Infos = contents.Text.Trim();
        string Titles = txtTitle.Text.ToString();
        Notice n = new Notice();
        n.CreateDate = DateTime.Now.ToString("yyyy-MM-dd");
        n.Info = Infos;
        n.Title = Titles;
        n.Type = int.Parse(NewTypeid);
        n.UserName = getUserName();

        Leyp.SQLServerDAL.Factory.getNoticeDAL().insertNewEntity(n);

        txtTitle.Text = "";
        contents.Text = "";


        Jscript.AjaxAlert(this, "添加成功");


    }
}
