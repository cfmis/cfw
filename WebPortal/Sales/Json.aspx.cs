using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Leyp.Components;
using Leyp.SQLServerDAL;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebPortal.Sales
{
    public partial class Json : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clsPublic cls = new clsPublic();
            DataTable dt = new DataTable();
            dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_unit();
            var ReturnValue = cls.DataTableJsonReturnTable(dt);
            Response.Write(ReturnValue);
        }
    }
}