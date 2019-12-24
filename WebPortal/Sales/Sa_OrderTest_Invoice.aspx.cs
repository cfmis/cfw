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
    public partial class Sa_OrderTest_Invoice : System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string within_code = DBUtility.within_code;
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void btnExpToExcel_Click(object sender, EventArgs e)
        {
            //showMsg.Visible = true;
            //System.Threading.Thread.Sleep(10 * 1000);
            //showMsg.Visible = false;
            //return;
            string content = getExcelContent();
            string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
            string filename = "訂單測試發票記錄表.xls";
            filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
            clsPublic cl = new clsPublic();
            cl.ExportToExcel(filename, content, css);
            //ExportToExcel(filename, content, css);
        }

        private string getExcelContent()
        {
            string date_from = txtDate_from.Value.ToString();
            string date_to = txtDate_to.Value.ToString();
            if (date_to != "")
                date_to = Convert.ToDateTime(date_to).AddDays(1).ToString("yyyy/MM/dd");
            string invoice_id = txtInvoice_Id.Value.ToString();
            string mo_id = txtMo_id.Value.ToString();
            string mo_group = "";
            string custcode = txtCustcode.Value.ToString();
            string brand = txtBrand.Value.ToString();
            DataTable dt = Leyp.SQLServerDAL.Sales.Factory_New.SaOrderTestTraceDAL().getInvoiceData(date_from, date_to, invoice_id,mo_id,custcode,mo_group,brand);
            StringBuilder sb = new StringBuilder();
            sb.Append("<table borderColor='black' border='1' >");
            //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");
            sb.Append("<tr>");
            sb.Append(
                "<th bgColor='#ccfefe'>Date</th>" +
                "<th bgColor='#ccfefe'>Invoice</th>" +
                "<th bgColor='#ccfefe'>Report No</th>" +
                "<th bgColor='#ccfefe'>Curr</th>" +
                "<th bgColor='#ccfefe'>Amount</th>" +
                "<th bgColor='#ccfefe'>Own Reference Report</th>"
                );
            sb.Append("</tr></thead>");
            sb.Append("<tbody>");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow row = dt.Rows[i];

                sb.Append("<tr class='firstTR'>");
                sb.Append("<td>" + "=\"" + row["invoice_date"] + "\"" + " </td>");
                sb.Append("<td>" + row["invoice_id"] + "</td>");
                sb.Append("<td>" + row["report_no"] + "</td>");
                sb.Append("<td>" + row["curr"] + "</td>");
                sb.Append("<td>" + row["amount"] + "</td>");

                sb.Append("</tr>");

            }
            sb.Append("</tbody></table>");
            return sb.ToString();
        }

    }
}