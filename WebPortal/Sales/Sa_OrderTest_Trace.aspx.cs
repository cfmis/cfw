using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Leyp.Components;
using Leyp.Components.Module;
using Leyp.SQLServerDAL;
using System.Text;

namespace WebPortal.Sales
{
    public partial class Sa_OrderTest_Trace : System.Web.UI.Page
    {
        //private SQLHelp sh = new SQLHelp();
        //private StrHelper StrHlp = new StrHelper();
        //private string lang_id = DBUtility.lang_id;
        //private string within_code = DBUtility.within_code;
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        //protected void btnExpToExcel_Click(object sender, EventArgs e)
        //{
        //    //showMsg.Visible = true;
        //    //System.Threading.Thread.Sleep(10 * 1000);
        //    //showMsg.Visible = false;
        //    //return;
        //    string content = getExcelContent();
        //    string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
        //    string filename = "訂單測試記錄表.xls";
        //    filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
        //    clsPublic cl = new clsPublic();
        //    cl.ExportToExcel(filename, content, css);
        //    //ExportToExcel(filename, content, css);
        //}

        //private string getExcelContent()
        //{
        //    string mo_group = selMo_group.Value.ToString();
        //    string date_from = txtDate_from.Value.ToString();
        //    string date_to = txtDate_to.Value.ToString();
        //    if (date_to != "")
        //        date_to = Convert.ToDateTime(date_to).AddDays(1).ToString("yyyy/MM/dd");
        //    string mo_id = txtMo.Value.ToString();
        //    string ref_no = "", item = "", color = "";
        //    DataTable dt = Leyp.SQLServerDAL.Sales.Factory_New.SaOrderTestTraceDAL().getRecByMo(mo_group, date_from, date_to, mo_id, ref_no, item, color);
        //    StringBuilder sb = new StringBuilder();
        //    sb.Append("<table borderColor='black' border='1' >");
        //    //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");
        //    sb.Append("<tr>");
        //    sb.Append(
        //        "<th bgColor='#ccfefe'>Rec'd Test Form Date</th>" +
        //        "<th bgColor='#ccfefe'>Ref No.</th>" +
        //        "<th bgColor='#ccfefe'>Lab House</th>" +
        //        "<th bgColor='#ccfefe'>Material</th>" +
        //        "<th bgColor='#ccfefe'>Item</th>" +
        //        "<th bgColor='#ccfefe'>Size</th>" +
        //        "<th bgColor='#ccfefe'>Color</th>" +
        //        "<th bgColor='#ccfefe'>MO#</th>" +
        //        "<th bgColor='#ccfefe'>Season</th>" +
        //        "<th bgColor='#ccfefe'>Division</th>" +
        //        "<th bgColor='#ccfefe'>Test Method</th>" +
        //        "<th bgColor='#ccfefe'>Bulk Order MO#</th>" +
        //        "<th bgColor='#ccfefe'>SENT TO HK DATE </th>" +
        //        "<th bgColor='#ccfefe'>Pass to Lab Date</th>" +
        //        "<th bgColor='#ccfefe'>Test Results</th>" +
        //        "<th bgColor='#ccfefe'>RSL</th>" +
        //        "<th bgColor='#ccfefe'>Report Date</th>" +
        //        "<th bgColor='#ccfefe'>Appearance after washing</th>" +
        //        "<th bgColor='#ccfefe'>Report Date</th>" +
        //        "<th bgColor='#ccfefe'>Resist to water</th>" +
        //        "<th bgColor='#ccfefe'>Report Date</th>" +
        //        "<th bgColor='#ccfefe'>CF to Salvia</th>" +
        //        "<th bgColor='#ccfefe'>Report Date</th>" +
        //        "<th bgColor='#ccfefe'>Snap Action</th>" +
        //        "<th bgColor='#ccfefe'>Report Date</th>" +
        //        "<th bgColor='#ccfefe'>RSL Underpart</th>" +
        //        "<th bgColor='#ccfefe'>Report Date</th>"+
        //        "<th bgColor='#ccfefe'>FTC CMMTS</th>"
        //        );
        //    sb.Append("</tr></thead>");
        //    sb.Append("<tbody>");

        //    for (int i = 0; i < dt.Rows.Count; i++)
        //    {
        //        DataRow row = dt.Rows[i];

        //        sb.Append("<tr class='firstTR'>");
        //        sb.Append("<td>" + "=\"" + row["rt_from_date"] + "\"" + " </td>");
        //        sb.Append("<td>" + row["ref_no"] + "</td>");
        //        sb.Append("<td>" + row["lab_house"] + "</td>");
        //        sb.Append("<td>" + row["mat_desc"] + "</td>");
        //        sb.Append("<td>" + row["cust_item"] + "</td>");
        //        sb.Append("<td>" + row["cust_size"] + "</td>");
        //        sb.Append("<td>" + row["cust_color"] + "</td>");
        //        sb.Append("<td>" + row["mo_id"] + "</td>");
        //        sb.Append("<td>" + row["season"] + "</td>");
        //        sb.Append("<td>" + row["division"] + "</td>");
        //        sb.Append("<td>" + row["test_method"] + "</td>");
        //        sb.Append("<td>" + row["bulk_mo"] + "</td>");
        //        sb.Append("<td>" + "=\"" + row["sent_to_hk"] + "\"" + " </td>");
        //        sb.Append("<td>" + "=\"" + row["pass_to_lab"] + "\"" + " </td>");
        //        sb.Append("<td>" + row["test_results"] + "</td>");
        //        sb.Append("<td>" + row["rsl"] + "</td>");
        //        sb.Append("<td>" + "=\"" + row["rsl_rp_date"] + "\"" + " </td>");
        //        sb.Append("<td>" + row["appearance"] + "</td>");
        //        sb.Append("<td>" + "=\"" + row["appearance_rp_date"] + "\"" + " </td>");
        //        sb.Append("<td>" + row["resist"] + "</td>");
        //        sb.Append("<td>" + "=\"" + row["resist_rp_date"] + "\"" + " </td>");
        //        sb.Append("<td>" + row["salvia"] + "</td>");
        //        sb.Append("<td>" + "=\"" + row["salvia_rp_date"] + "\"" + " </td>");
        //        sb.Append("<td>" + row["snap"] + "</td>");
        //        sb.Append("<td>" + "=\"" + row["snap_rp_date"] + "\"" + " </td>");
        //        sb.Append("<td>" + row["underpart"] + "</td>");
        //        sb.Append("<td>" + "=\"" + row["underpart_rp_date"] + "\"" + " </td>");
        //        sb.Append("<td>" + row["ftc_cmmts"] + "</td>");

        //        sb.Append("</tr>");

        //    }
        //    sb.Append("</tbody></table>");
        //    return sb.ToString();
        //}


    }
}