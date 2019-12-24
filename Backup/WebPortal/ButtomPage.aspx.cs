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
using Leyp.SQLServerDAL;
using Leyp.Model.View;
using System.Collections.Generic;
using Leyp.Components.Module;
public partial class ButtomPage : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
    }

    public int getNotRealIssue()
    {
        if (getTypeID() == 0)
        {
            ServiceInfoDAL sdal = new ServiceInfoDAL();
            List<VServiceInfo> list = sdal.getSearchListByDate("2007", "2020", 0);
            return list.Count;
        }
        else
        {
            return 0;
        }
    }
}
