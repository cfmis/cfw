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
public partial class Customer_ServiceInfo_Add : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ServiceTypeDropDownList1.SelectedValue.ToString().Equals(""))
        {
            Jscript.AjaxAlert(this,"请选择类型");
            return;
        }
        
        ServiceInfo s = new ServiceInfo();

        s.CreateDate = DateTime.Now.ToString("yyyy-MM-dd");
        s.Content = Content.Text;
        s.ServiceTitle = ServiceTitle.Text;
        s.UserName = getUserName();
        s.TypeID = int.Parse(ServiceTypeDropDownList1.SelectedValue.ToString());
        if (SalesOrderID.Text.ToString().Equals(""))
        {
            s.SalesOrderID = "无";
        }
        else
        {
            s.SalesOrderID = SalesOrderID.Text.ToString();
        }

        if (Leyp.SQLServerDAL.Factory.getServiceInfoDAL().insertNewEntity(s))
        {
            Panel1.Visible = false;
            Panel2.Visible = true;
        
        }

    }
}
