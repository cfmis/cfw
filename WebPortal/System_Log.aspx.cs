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

public partial class System_Log : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Databang();
        }

    }

    /// <summary>
    /// 绑定日志数据源
    /// </summary>
    private void Databang()
    {

        CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getLogDAL().getAllLog();//BLL项目中List数据源
        CollectionPager1.BindToControl = DataList1;
        DataList1.DataSource = CollectionPager1.DataSourcePaged;


    }
}
