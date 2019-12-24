using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Leyp.SQLServerDAL;
using Leyp.Components;
using Leyp.Components.Module;

namespace cfoa
{
    public partial class ShowMatCode : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private clsPublic clsPublic = new clsPublic();
        protected void Page_Load(object sender, EventArgs e)
        {

            SetBindData();
        }
        protected void SetBindData()
        {
            string strSql = "Select id,name,english_name,datum From cd_datum Order By id";
            DataTable tbMat = sh.ExecuteSqlReturnDataTableGeo(strSql);
            if (tbMat.Rows.Count == 0)
                tbMat.Rows.Add();

            gvDetails.DataSource = tbMat.DefaultView;
            gvDetails.DataBind();
        }
        protected void gvDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //加以下這段為選擇行
            PostBackOptions myPostBackOptions = new PostBackOptions(this);
            myPostBackOptions.AutoPostBack = false;
            myPostBackOptions.RequiresJavaScriptProtocol = true;
            myPostBackOptions.PerformValidation = false;

            //String evt = Page.ClientScript.GetPostBackClientHyperlink(sender as GridView, "Select$" + e.Row.RowIndex.ToString());
            //e.Row.Attributes.Add("onclick", evt);

            e.Row.Attributes.Add("onMouseOver", "Color=this.style.backgroundColor;this.style.backgroundColor='lightBlue'");
            e.Row.Attributes.Add("onMouseOut", "this.style.backgroundColor=Color;");

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onclick", "cc('" + e.Row.Cells[0].Text + "','" + e.Row.Cells[1].Text + "','" + e.Row.Cells[2].Text + "')");
            }
        }
        protected void gvDetails_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
        protected void gvDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDetails.PageIndex = e.NewPageIndex;
            gvDetails.DataBind();
        }
    }
}