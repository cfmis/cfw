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
using System.Collections.Generic;
using Leyp.Model.Sales;
using Leyp.Components.Module.Sales;
using Leyp.Components;
using Leyp.Components.Module;

public partial class Sales_MySalesDispatchEditSent : SalesDispatchSent
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
        string DispatchID = Request.QueryString["DispatchID"].ToString();
        string fromUrl = Request.QueryString["fromUrl"].ToString();
        Label4.Text = fromUrl;

        VSalesDispatch vs = Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().getByID(int.Parse(DispatchID));
        if(vs==null)
        {
            Response.Write("没有数据");
            Response.End();
        }
        if (vs.State != 0)
        {
            Response.Write("已经处理过单号！不能再操作! ");
            Response.End();
        }
        if (!vs.Consignor.Equals(getUserName()))
        {
            Response.Write("单据已经交给帐号：" + vs.Consignor + "用户处理，不能再操作！<br>若要操作请先编辑修改");
            Response.End();
        }
        Label2.Text = vs.SalesOutID;
        Label3.Text = vs.DispatchID.ToString();

        SentDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        HyperLink1.NavigateUrl = "Issue_SalesDispatch.aspx?DispatchID=" + DispatchID;


    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        float cost = float.Parse("0.00");
        cost = float.Parse(Postage.Text.ToString());
        if (Leyp.SQLServerDAL.Sales.Factory.getSalesDispatchDAL().sentUpdate(int.Parse(Label3.Text.ToString()), SentDate.Text.ToString(), int.Parse(DropDownList1.SelectedValue.ToString())," 发货单号："+SentNum.Text.ToString(),cost))
        {
            Jscript.RefreshParent(Label4.Text.ToString());
            Jscript.CloseWindow();
        }
        else
        {
            Jscript.AjaxAlert(this, "操作失败！");
            return;
        }
    }
}
