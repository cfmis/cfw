using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Leyp.SQLServerDAL;
using Leyp.SQLServerDAL.Sales;
using Leyp.Components;
using Leyp.Components.Module;

namespace WebPortal.Sales
{
    public partial class Sa_Sample_Trace_View : BasePage//System.Web.UI.Page
    {
        private string comp_type = Base.comp_type;//DBUtility.comp_type;
        private string user_id = "";//DBUtility.user_id;//"leavy_lai";
        private string within_code = Base.within_code;//DBUtility.within_code;
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["user"] == null)
            //{
            //    Response.Redirect("logout.aspx");
            //}
            //else
            //{
            //    user_id = Session["user"].ToString();
            //    BindData(1);
            //}
            if (!Page.IsPostBack)
            {
                InitValue();
            }
            //BindData(1);
        }

        protected void InitValue()
        {
            dateStart.Value = System.DateTime.Now.ToString("yyyy/MM/dd HH:mm");
            dateEnd.Value = dateStart.Value;
            string strSql = "";
            strSql = "select convert(varchar(1),flag_id) AS flag_id,flag_desc from bs_flag_desc Where doc_type='AL' AND flag0='Y' order by flag_id ";
            DataTable tbA1 = sh.ExecuteSqlReturnDataTable(strSql);
            dlWaitSample.DataSource = tbA1.DefaultView;
            dlWaitSample.DataTextField = "flag_desc";
            dlWaitSample.DataValueField = "flag_id";
            dlWaitSample.DataBind();

            strSql = "select dep_id,dep_cdesc from sample_trace_dep order by sorting,dep_id ";
            DataTable tbDep = sh.ExecuteSqlReturnDataTable(strSql);
            dlOwnType.DataSource = tbDep.DefaultView;
            dlOwnType.DataTextField = "dep_cdesc";
            dlOwnType.DataValueField = "dep_id";
            dlOwnType.DataBind();
        }
        protected void btnFind_Click(object sender, EventArgs e)
        {
            BindData(1);
        }
        protected void btnFindSample_Click(object sender, EventArgs e)
        {
            BindData(2);
        }
        protected void BindData(int find_type)
        {
            if (!validData(find_type))
                return;
            string strSql = "";
            string strSql1 = "";
            string card_id = txtCard_id.Text;
            string prd_mo = txtMo.Text;
            string card_id_org = txtCard_id_org.Text;
            string wait_sample = "";
            string own_dep = "";
            string dat1, dat2;

            dat1 = Convert.ToDateTime(dateStart.Value).ToString("yyyy/MM/dd HH:mm");
            dat2 = Convert.ToDateTime(dateEnd.Value).ToString("yyyy/MM/dd HH:mm");
            //dat2 = dateEnd.Value;
            //if (dat2 != "")
            //    dat2 = Convert.ToDateTime(dat2).AddMinutes(1.0).ToString("yyyy/MM/dd HH:ss");

            if (dlWaitSample.SelectedIndex > 0)
                wait_sample = dlWaitSample.SelectedValue;
            if (dlOwnType.SelectedIndex > 0)
                own_dep = dlOwnType.SelectedValue;

            strSql = "Select a.doc_id,a.doc_date,a.prd_mo,a.prd_item,c.name AS item_cdesc,a.card_id" +
                ",a.remark AS remark_head,a.route_dep,a.own_type,d.dep_cdesc AS own_type_desc" +
                ",a.type_sample,a.color_sample,a.draw_sample,a.oth_sample,a.wait_sample"+
                ",CASE WHEN a.wait_sample='0' then '' else e.flag_desc END AS wait_sample_desc,a.color_desc,a.corr_mo,a.data_provide" +
                ",a.card_id_org,a.card_id  AS card_id_m" +
                " From sample_trace_head a" +
                " LEFT JOIN geo_it_goods c ON a.prd_item = c.id" +
                " LEFT JOIN sample_trace_dep d ON a.own_type=d.dep_id " +
                " LEFT JOIN bs_flag_desc e ON a.wait_sample=e.flag_id "+
                " WHERE a.comp_type='" + comp_type + "' AND e.doc_type='AL' ";
            if (find_type == 1)
                strSql1 = "Select a.doc_id,a.doc_date,a.prd_mo,a.prd_item,c.name AS item_cdesc,b.card_id" +
                    ",a.remark AS remark_head,a.route_dep,b.own_dep,d.dep_cdesc AS own_type_desc" +
                    ",a.type_sample,a.color_sample,a.draw_sample,a.oth_sample,a.wait_sample" +
                    ",CASE WHEN a.wait_sample='0' then '' else e.flag_desc END AS wait_sample_desc,a.color_desc,a.corr_mo,a.data_provide" +
                    ",a.card_id_org,a.card_id  AS card_id_m" +
                    " From sample_trace_head a" +
                    " INNER JOIN sample_trace_merge b ON a.doc_id=b.doc_id" +
                    " LEFT JOIN geo_it_goods c ON a.prd_item = c.id" +
                    " LEFT JOIN sample_trace_dep d ON b.own_dep=d.dep_id " +
                    " LEFT JOIN bs_flag_desc e ON a.wait_sample=e.flag_id " +
                    " WHERE a.comp_type='" + comp_type + "' AND e.doc_type='AL'";
            else
                strSql1 = "Select a.doc_id,a.doc_date,a.prd_mo,a.prd_item,c.name AS item_cdesc,a.card_id" +
                ",a.remark AS remark_head,a.route_dep,b.todep,d.dep_cdesc AS own_type_desc" +
                ",a.type_sample,a.color_sample,a.draw_sample,a.oth_sample,a.wait_sample" +
                ",CASE WHEN a.wait_sample='0' then '' else e.flag_desc END AS wait_sample_desc,a.color_desc,a.corr_mo,a.data_provide" +
                ",a.card_id_org,a.card_id  AS card_id_m" +
                " From sample_trace_head a" +
                " INNER JOIN sample_trace_details b ON a.comp_type=b.comp_type And a.doc_id=b.doc_id" +
                " LEFT JOIN geo_it_goods c ON a.prd_item = c.id" +
                " LEFT JOIN sample_trace_dep d ON b.todep=d.dep_id " +
                " LEFT JOIN bs_flag_desc e ON a.wait_sample=e.flag_id " +
                " WHERE a.comp_type='" + comp_type + "' AND e.doc_type='AL'";
            if (card_id != "")
            {
                strSql += " AND a.card_id Like " + "'%" + card_id + "%'";
                if (find_type == 1)
                    strSql1 += " AND b.card_id Like " + "'%" + card_id + "%'";
                else
                    strSql1 += " AND a.card_id Like " + "'%" + card_id + "%'";
            }
            if (prd_mo != "")
            {
                strSql += " AND a.corr_mo Like " + "'%" + prd_mo + "%'";
                strSql1 += " AND a.corr_mo Like " + "'%" + prd_mo + "%'";
            }
            if (card_id_org != "")
            {
                strSql += " AND a.card_id_org Like " + "'%" + card_id_org + "%'";
                strSql1 += " AND a.card_id_org Like " + "'%" + card_id_org + "%'";
            }
            if (wait_sample != "")
            {
                strSql += " AND a.wait_sample ='" + wait_sample + "'";
                strSql1 += " AND a.wait_sample ='" + wait_sample + "'";
            }
            if (own_dep != "")
            {
                strSql += " AND a.own_type ='" + own_dep + "'";
                if (find_type == 1)
                    strSql1 += " AND b.own_dep ='" + own_dep + "'";
                else
                    strSql1 += " AND b.todep ='" + own_dep + "'";
            }
            if (dat1 != "" && dat2 != "")
            {
                strSql += " AND a.doc_date >='" + dat1 + "'" + " AND a.doc_date <'" + dat2 + "'";
                if (find_type == 1)
                    strSql1 += " AND a.doc_date >='" + dat1 + "'" + " AND a.doc_date <='" + dat2 + "'";
                else
                    //strSql1 += " AND b.out_date >='" + dat1 + "'" + " AND b.out_date <='" + dat2 + "'";//發出日期
                    strSql1 += " AND b.out_date Between'" + dat1 + "'" + " AND '" + dat2 + "'";//發出日期
            }
            if (card_id == "" && prd_mo == "" && card_id_org == "" && wait_sample == "" && own_dep == "" && dat1 == "" && dat2=="")
            {
                strSql += " AND a.card_id ='999999999' ";
                strSql1 += " AND a.card_id ='999999999' ";
            }

            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
            //strSql += " ORDER BY a.corr_mo,a.doc_date DESC";
            //strSql1 += " ORDER BY a.corr_mo,a.doc_date DESC";
            strSql += " UNION " + strSql1;
            DataTable tbTrace = sh.ExecuteSqlReturnDataTable(strSql);
            if(tbTrace.Rows.Count==0)
                tbTrace.Rows.Add();
            ps.DataSource = tbTrace.DefaultView;

            this.trDetail.DataSource = ps;
            //this.hourseDataList.DataKeyField = "hourseId";
            this.trDetail.DataBind();
        }

        protected bool validData(int find_type)
        {
            bool result = true;
            if (find_type == 2 && dlOwnType.SelectedIndex==0)
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('查詢部門不能為空!');", true);
                return false;
            }
            //if (dateStart.Value.Trim() != "" && StrHlp.CheckDateTimeFormat(dateStart.Value.Trim()) == false)
            //{
            //    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('日期格式不正確!');", true);
            //    //cls.clsPublic.WebMessageBox(this.Page, "訂單日期格式錯誤!");
            //    dateStart.Focus();
            //    result = false;
            //}
            //else
            //{
            //    if (dateEnd.Value.Trim() != "" && StrHlp.CheckDateTimeFormat(dateEnd.Value.Trim()) == false)
            //    {
            //        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('日期格式不正確!');", true);
            //        dateEnd.Focus();
            //        result = false;
            //    }
            //}

            return result;
        }



        protected void gvDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //加以下這段為選擇行
            PostBackOptions myPostBackOptions = new PostBackOptions(this);
            myPostBackOptions.AutoPostBack = false;
            myPostBackOptions.RequiresJavaScriptProtocol = true;
            myPostBackOptions.PerformValidation = false;

            String evt = Page.ClientScript.GetPostBackClientHyperlink(sender as GridView, "Select$" + e.Row.RowIndex.ToString());
            e.Row.Attributes.Add("onclick", evt);

            e.Row.Attributes.Add("onMouseOver", "Color=this.style.backgroundColor;this.style.backgroundColor='lightBlue'");
            e.Row.Attributes.Add("onMouseOut", "this.style.backgroundColor=Color;");
        }
        protected void BindDataTree(string doc_id)
        {
            string strSql = "";
            strSql = "Select a.doc_id,a.doc_date,a.prd_mo,a.prd_item,c.name AS item_cdesc,a.card_id,b.seq,b.dep,d.dep_cdesc" +
                ",b.todep,e.dep_cdesc AS todep_cdesc,b.action_type,f.flag_desc AS action_desc,b.remark,b.crusr,a.remark AS remark_head" +
                ",route_dep,own_type,g.dep_cdesc AS own_type_cdesc,CONVERT(VARCHAR(20),b.crtim,120) AS crtim" +
                ",a.type_sample,a.color_sample,a.draw_sample,a.oth_sample,a.wait_sample,a.color_desc,a.corr_mo,a.data_provide" +
                " From sample_trace_head a" +
                " INNER JOIN sample_trace_details b ON a.comp_type=b.comp_type AND a.doc_id=b.doc_id" +
                " LEFT JOIN geo_it_goods c ON a.prd_item = c.id" +
                " LEFT JOIN sample_trace_dep d ON b.dep=d.dep_id " +
                " LEFT JOIN sample_trace_dep e ON b.todep=e.dep_id " +
                " LEFT JOIN bs_flag_desc f ON b.action_type=f.flag_id" +
                " LEFT JOIN sample_trace_dep g ON b.dep=g.dep_id " +
                " WHERE a.comp_type='" + comp_type + "'" + " AND f.doc_type='TR'";
            if (doc_id != "")
                strSql += " AND a.doc_id='" + doc_id + "'";
            strSql += " ORDER BY b.seq DESC";
            DataTable tbTrace = sh.ExecuteSqlReturnDataTable(strSql);
        }

    }
}