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
using Leyp.Components;
using Leyp.Components.Module;
using System.IO;

namespace WebPortal.Sales
{
    public partial class Sa_Mo_FindByBrand : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = Base.lang_id;
        private string within_code = Base.within_code;
        private bool start_search = false;
        private string remote_db=Base.remote_db;
        /*保存当前要显示的页码,初始化为1*/
        private static int curPage = 1;
        /*总的页数*/
        private int totalPage = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {

                InitControler();

            }
        }
        protected void InitControler()
        {

            dateStart.Value = System.DateTime.Now.AddDays(-1).ToString("yyyy/MM/dd");
            dateEnd.Value = dateStart.Value;

            txtBrand1.Value = "MICH-05";
            txtBrand2.Value = txtBrand1.Value;
            string strSql = "";
            strSql = "select id from "+remote_db+"cd_season order by id ";
            DataTable tbSeason = sh.ExecuteSqlReturnDataTable(strSql);
            tbSeason.Rows.Add();
            dlSeason.DataSource = tbSeason.DefaultView;
            dlSeason.DataTextField = "id";
            dlSeason.DataValueField = "id";
            dlSeason.Text = "";
            dlSeason.DataBind();

            strSql = "select mo_group from bs_group order by mo_group ";
            DataTable tbMo_group = sh.ExecuteSqlReturnDataTable(strSql);
            tbMo_group.Rows.Add();
            dlMo_group.DataSource = tbMo_group.DefaultView;
            dlMo_group.DataTextField = "mo_group";
            dlMo_group.DataValueField = "mo_group";
            dlMo_group.Text = "";
            dlMo_group.DataBind();

        }
        protected void Btn_Query_Click(object sender, EventArgs e)
        {
            loadData(1);
        }
        protected void Btn_ExpDetails_Click(object sender, EventArgs e)
        {
            loadData(2);
        }
        protected void loadData(int rpt_type)
        {
            if (!validData())
                return;

            try
            {
                /*实例化分页数据源*/
                System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
                /*建立业务层对象，执行查询，将记录集绑定到分页数据源上*/
                //HourseBLL hourseBll = new HourseBLL();
                //ps.DataSource = hourseBll.QueryHourseInfo(this.leixing.SelectedValue, xiaoqu.Text, lowprice.Text, highprice.Text).Tables[0].DefaultView;


                string dat1, dat2;
                string season;
                string mo_group = dlMo_group.Text;
                string brand1 = txtBrand1.Value;
                string brand2 = txtBrand2.Value;
                string userid = getUserName();
                dat1 = dateStart.Value;
                dat2 = dateEnd.Value;
                season = dlSeason.Text;

                dat2=Convert.ToDateTime(dat2).AddDays(1).ToString("yyyy/MM/dd");
                string strSql = "usp_mo_find_brand";
                SqlParameter[] parameters = {new SqlParameter("@usr", userid)
                        ,new SqlParameter("@rpt_type", rpt_type)
                        ,new SqlParameter("@sea", season)
                        ,new SqlParameter("@mo_group", mo_group)
                        ,new SqlParameter("@dat1", dat1)
                        ,new SqlParameter("@dat2", dat2)
                        ,new SqlParameter("@brand1", brand1)
                        ,new SqlParameter("@brand2", brand2)
                        };


                DataTable dtTranRec = sh.ExecuteProcedure(strSql, parameters);
                
                //if (rpt_type == 1)
                //{
                //    ps.DataSource = dtTranRec.DefaultView;
                //    ps.AllowPaging = true;
                //    ps.PageSize = 1000000;//每页显示几条记录
                //    ps.CurrentPageIndex = curPage - 1;//设置当前页的索引(当前页码减1就是)

                //    //this.firstBtn.Enabled = true;
                //    //this.nextBtn.Enabled = true;
                //    //this.prevBtn.Enabled = true;
                //    //this.lastBtn.Enabled = true;

                //    //this.CurrentPage.Text = curPage.ToString();
                //    //this.TotalPage.Text = totalPage.ToString();

                //    //if (curPage == 1)//当是第一页是.上一页和首页的按钮不可用
                //    //{
                //    //    this.prevBtn.Enabled = false;
                //    //    this.firstBtn.Enabled = false;

                //    //}
                //    //if (curPage == ps.PageCount)//当是最后一页时下一页和最后一页的按钮不可用
                //    //{
                //    //    this.nextBtn.Enabled = false;
                //    //    this.lastBtn.Enabled = false;
                //    //}

                //    this.wpDetail.DataSource = ps;
                //    //this.hourseDataList.DataKeyField = "hourseId";
                //    this.wpDetail.DataBind();
                //}
                expData(rpt_type, dtTranRec);
            }
            catch (Exception ex)
            {
                //Console.WriteLine(ex.Message.Replace("\r\n", "").Replace("'", ""));
                //顯示錯誤信息，原來畫面不會清除
                StrHlp.WebMessageBox(this.Page, ex.Message.Replace("\r\n", "").Replace("'", ""));
                //以下兩個都會顯示信息，但原來畫面會空白的閃一下
                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('" + ex.Message.Replace("\r\n", "").Replace("'", "") + "');", true);
                //Response.Write("<script language='javascript'>alert(\"" + ex.Message.Replace("\r\n", "").Replace("'", "") + "\");</script>");

            }

        }

        protected bool validData()
        {
            bool result = true;


            if (dateStart.Value.Trim() != "" && StrHlp.CheckDateFormat(dateStart.Value.Trim()) == false)
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "alert", " alert('訂單日期格式不正確!');", true);
                //cls.clsPublic.WebMessageBox(this.Page, "訂單日期格式錯誤!");
                dateStart.Focus();
                result = false;
            }
            else
            {
                if (dateEnd.Value.Trim() != "" && StrHlp.CheckDateFormat(dateEnd.Value.Trim()) == false)
                {
                    StrHlp.WebMessageBox(this.Page, "訂單日期格式錯誤!");
                    dateEnd.Focus();
                    result = false;
                }
            }


            return result;
        }

        private void expData(int rpt_type,DataTable dt)
        {
            string content = getExcelContent(rpt_type,dt);
            string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
            string filename = "訂單記錄總表.xls";
            if(rpt_type==2)
                filename = "訂單記錄明細表.xls";
            filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
            clsPublic cl = new clsPublic();
            cl.ExportToExcel(filename, content, css);


        }


        private string getExcelContent(int rpt_type,DataTable dt)
        {

            StringBuilder sb = new StringBuilder();
            sb.Append("<table borderColor='black' border='1' >");
            //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");
            sb.Append("<tr>");
            if (rpt_type == 1)//總表
                sb.Append(
                "<th bgColor='#ccfefe'>Season</th>" +
                "<th bgColor='#ccfefe'>Division</th>" +
                "<th bgColor='#ccfefe'>HB Vendors</th>" +
                "<th bgColor='#ccfefe'>Hardware Fty</th>" +
                "<th bgColor='#ccfefe'>PO date</th>" +
                "<th bgColor='#ccfefe'>PO #</th>" +
                "<th bgColor='#ccfefe'>Supplier code</th>" +
                "<th bgColor='#ccfefe'>PLM Code</th>" +
                "<th bgColor='#ccfefe'>BOM Material Name</th>" +
                "<th bgColor='#ccfefe'>Hardware type</th>" +
                "<th bgColor='#ccfefe'>Description</th>" +
                "<th bgColor='#ccfefe'>Color/Finish</th>" +
                "<th bgColor='#ccfefe'>QTY (Set)</th>"+
                "<th bgColor='#ccfefe'>FOB HK Price (USD)</th>" +
                "<th bgColor='#ccfefe'>Amount USD</th>" +
                "<th bgColor='#ccfefe'>Supplier updated ETD</th>" +
                "<th bgColor='#ccfefe'>HB fty request ETD</th>" +
                "<th bgColor='#ccfefe'>D1/D2/D3</th>" +
                "<th bgColor='#ccfefe'>actual shipped date</th>"
                );
            else//明細表
                sb.Append(
                    "<th bgColor='#ccfefe'>制單編號</th>" +
                    "<th bgColor='#ccfefe'>訂單日期</th>" +
                    "<th bgColor='#ccfefe'>版本號</th>" +
                    "<th bgColor='#ccfefe'>客人PO</th>" +
                    "<th bgColor='#ccfefe'>客戶編號</th>" +
                    "<th bgColor='#ccfefe'>客戶中文描述</th>" +
                    "<th bgColor='#ccfefe'>客戶英文描述</th>" +
                    "<th bgColor='#ccfefe'>序號</th>" +
                    "<th bgColor='#ccfefe'>產品編號</th>" +
                    "<th bgColor='#ccfefe'>產品描述</th>"+
                    "<th bgColor='#ccfefe'>訂單數量</th>"+
                    "<th bgColor='#ccfefe'>數量單位</th>" +
                    "<th bgColor='#ccfefe'>單價</th>" +
                    "<th bgColor='#ccfefe'>單價單位</th>" +
                    "<th bgColor='#ccfefe'>貨幣代號</th>" +
                    "<th bgColor='#ccfefe'>每PCS單價(USD)</th>" +
                    "<th bgColor='#ccfefe'>數量(PCS)</th>" +
                    "<th bgColor='#ccfefe'>金額(HKD)</th>" +
                    "<th bgColor='#ccfefe'>金額(USD)</th>"+
                    "<th bgColor='#ccfefe'>尺寸代號</th>" +
                    "<th bgColor='#ccfefe'>尺寸描述</th>" +
                    "<th bgColor='#ccfefe'>顏色代號</th>" +
                    "<th bgColor='#ccfefe'>顏色描述</th>" +
                    "<th bgColor='#ccfefe'>顏色做法</th>" +
                    "<th bgColor='#ccfefe'>季度</th>" +
                    "<th bgColor='#ccfefe'>牌子編號</th>" +
                    "<th bgColor='#ccfefe'>客戶產品編號</th>" +
                    "<th bgColor='#ccfefe'>Division</th>" +
                    "<th bgColor='#ccfefe'>客戶產品尺寸</th>" +
                    "<th bgColor='#ccfefe'>客戶產品顏色編號</th>" +
                    "<th bgColor='#ccfefe'>客人款號</th>" +
                    "<th bgColor='#ccfefe'>OC備註</th>" +
                    "<th bgColor='#ccfefe'>生產備註</th>" +
                    "<th bgColor='#ccfefe'>產品編號F0</th>" +
                    "<th bgColor='#ccfefe'>東莞D</th>"+
                    "<th bgColor='#ccfefe'>交貨日期</th>"

                    );
            sb.Append("</tr></thead>");
            sb.Append("<tbody>");
            if (rpt_type == 1)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow row = dt.Rows[i];

                    sb.Append("<tr class='firstTR'>");
                    sb.Append("<td>" + row["season"] + " </td>");
                    sb.Append("<td>" + row["division"] + "</td>");
                    sb.Append("<td>" + row["cust_name"] + "</td>");
                    sb.Append("<td>" + "ChingFung" + "</td>");
                    sb.Append("<td>" + "=\"" + row["order_date"] + "\"" + "</td>");
                    sb.Append("<td>" + row["contract_id"] + "</td>");
                    sb.Append("<td>" + row["blueprint_id"] + "</td>");
                    sb.Append("<td>" + "" + "</td>");
                    sb.Append("<td>" + "" + "</td>");
                    sb.Append("<td>" + "Snap" + "</td>");
                    sb.Append("<td>" + row["table_head"] + "</td>");
                    sb.Append("<td>" + row["customer_color_id"] + "</td>");
                    sb.Append("<td>" + row["qty_pcs"] + "</td>");
                    sb.Append("<td>" + row["price_pcs_usd"] + "</td>");
                    sb.Append("<td>" + row["amt_usd"] + "</td>");
                    sb.Append("<td>" + "" + "</td>");
                    sb.Append("<td>" + "" + "</td>");
                    sb.Append("<td>" + "" + "</td>");
                    sb.Append("<td>" + "=\"" + row["arrive_date"] + "\"" + "</td>");
                    sb.Append("</tr>");

                }
            }
            else
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow row = dt.Rows[i];

                    sb.Append("<tr class='firstTR'>");
                    sb.Append("<td>" + "=\"" + row["mo_id"] + "\"" + " </td>");
                    sb.Append("<td>" + row["order_date"] + "</td>");
                    sb.Append("<td>" + row["ver"] + "</td>");
                    sb.Append("<td>" + row["contract_id"] + "</td>");
                    sb.Append("<td>" + row["it_customer"] + "</td>");
                    sb.Append("<td>" + row["cust_cname"] + "</td>");
                    sb.Append("<td>" + row["cust_name"] + "</td>");
                    sb.Append("<td>" + row["sequence_id"] + "</td>");
                    sb.Append("<td>" + row["goods_id"] + "</td>");
                    sb.Append("<td>" + row["goods_name"] + "</td>");
                    sb.Append("<td>" + row["order_qty"] + "</td>");
                    sb.Append("<td>" + row["goods_unit"] + "</td>");
                    sb.Append("<td>" + row["unit_price"] + "</td>");
                    sb.Append("<td>" + row["p_unit"] + "</td>");
                    sb.Append("<td>" + row["m_id"] + "</td>");
                    sb.Append("<td>" + row["price_pcs_usd"] + "</td>");
                    sb.Append("<td>" + row["qty_pcs"] + "</td>");
                    sb.Append("<td>" + row["amt_hkd"] + "</td>");
                    sb.Append("<td>" + row["amt_usd"] + "</td>");
                    sb.Append("<td>" + row["size_id"] + "</td>");
                    sb.Append("<td>" + row["size_cdesc"] + "</td>");
                    sb.Append("<td>" + row["clr_id"] + "</td>");
                    sb.Append("<td>" + row["clr_cdesc"] + "</td>");
                    sb.Append("<td>" + row["do_color"] + "</td>");
                    sb.Append("<td>" + row["season"] + "</td>");
                    sb.Append("<td>" + row["brand_id"] + "</td>");
                    sb.Append("<td>" + row["customer_goods"] + "</td>");
                    sb.Append("<td>" + row["Division"] + "</td>");
                    sb.Append("<td>" + row["customer_size"] + "</td>");
                    sb.Append("<td>" + row["customer_color_id"] + "</td>");
                    sb.Append("<td>" + row["table_head"] + "</td>");
                    sb.Append("<td>" + row["add_remark"] + "</td>");
                    sb.Append("<td>" + row["production_remark"] + "</td>");
                    sb.Append("<td>" + row["goods_id_f0"] + "</td>");
                    sb.Append("<td>" + row["special_info_style"] + "</td>");
                    sb.Append("<td>" + row["arrive_date"] + "</td>");
                    sb.Append("</tr>");

                }
            }
            sb.Append("</tbody></table>");
            return sb.ToString();
        }
    }
}