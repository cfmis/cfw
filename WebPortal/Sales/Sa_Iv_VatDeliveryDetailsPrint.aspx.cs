using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Leyp.SQLServerDAL;
using Microsoft.Reporting.WebForms;
using Leyp.Components;
using Leyp.Components.Module;

namespace WebPortal.Sales
{
    public partial class Sa_Iv_VatDeliveryDetailsPrint : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        protected void Page_Load(object sender, EventArgs e)
        {
            //Data_Binding();
            if (!Page.IsPostBack)
            {
                Data_Binding();
            }
        }

        private void Data_Binding()
        {
            string productMoFrom = Request.QueryString["productMoFrom"].ToString();
            string productMoTo = Request.QueryString["productMoTo"].ToString();
            string invFrom = Request.QueryString["invFrom"].ToString();
            string invTo = Request.QueryString["invTo"].ToString();
            string dateFrom = Request.QueryString["dateFrom"].ToString();
            string dateTo = Request.QueryString["dateTo"].ToString();
            string remote_db = DBUtility.remote_db;
            string within_code = DBUtility.within_code;
            string strSql = "Select b.mo_id,a.id,a.invoice_no,Convert(Varchar(20),a.invoice_date,111) AS invoice_date,c.name AS goods_cname " +
                ",b.issues_unit,Convert(INT,b.issues_qty) AS issues_qty,d.id AS order_id,d.unit_price,d.p_unit,f.rate" +
                ",Round((b.issues_qty/f.rate)*Convert(float,d.unit_price),2) AS order_amt" +
                ",a.linkman,d.table_head,e.m_id" +
                " From " + remote_db + "so_issues_mostly a" +
                " Inner Join " + remote_db + "so_issues_details b On a.within_code=b.within_code And a.id=b.id" +
                " Inner Join " + remote_db + "it_goods c On b.within_code=c.within_code And b.goods_id=c.id" +
                " Inner Join " + remote_db + "so_order_details d On b.within_code=d.within_code And b.mo_id=d.mo_id" +
                " Inner Join " + remote_db + "so_order_manage e On d.within_code=e.within_code And d.id=e.id And d.ver=e.ver" +
                " Inner Join " + remote_db + "it_coding f On d.within_code=f.within_code And d.p_unit=f.unit_code And b.issues_unit=f.basic_unit" +
                " Where a.within_code='" + within_code + "' And f.id='*'";
            if (dateFrom == "" && invFrom == "" && productMoFrom == "")
            {
                invFrom = "INV999999999";
                invTo = "INV999999999";
            }
            if (dateFrom != "" && dateTo != "")
            {
                dateTo = Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy/MM/dd");
                strSql += " And a.invoice_date>='" + dateFrom + "' And a.invoice_date<'" + dateTo + "'";
            }
            if (productMoFrom != "" && productMoTo != "")
                strSql += " And b.mo_id>='" + productMoFrom + "' And b.mo_id<='" + productMoTo + "'";
            if (invFrom != "" && invTo != "")
                strSql += " And a.invoice_no>='" + invFrom + "' And a.invoice_no<='" + invTo + "'";
            strSql += " Order By a.invoice_no,a.invoice_date,b.mo_id";
            DataTable dtPrint = sh.ExecuteSqlReturnDataTable(strSql);
            decimal totalAmt = 0;
            this.ReportViewer1.Reset();
            //this.ReportViewer1.LocalReport.Dispose();
            ReportViewer1.LocalReport.DataSources.Clear();
            this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("../Reports/Sa_Iv_VatDeliveryDetails.rdlc");
            Microsoft.Reporting.WebForms.ReportDataSource rds = new Microsoft.Reporting.WebForms.ReportDataSource("dsSa_Iv_VatDeliveryDetails", dtPrint);
            //this.ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DSDgcf_pad", dtPrint));
            //ReportViewer1.LocalReport.DataSources.Add(
            //new Microsoft.Reporting.WebForms.ReportDataSource("DSDgcf_pad", dtPrint));

            //向報表傳遞多個參數
            List<ReportParameter> para = new List<ReportParameter>();            //这里是添加两个字段
            para.Add(new ReportParameter("totalAmt", totalAmt.ToString()));
            //para.Add(new ReportParameter("userName", "aaa"));
            ReportViewer1.LocalReport.SetParameters(para);
            ReportViewer1.LocalReport.DataSources.Add(rds);
            this.ReportViewer1.ZoomMode = Microsoft.Reporting.WebForms.ZoomMode.Percent;
            this.ReportViewer1.ZoomPercent = 100;
            ReportViewer1.LocalReport.Refresh();

            //string doc_type_to = "相關制單";
            //string color = "N001";

            //ReportViewer1.LocalReport.ReportPath = "Reports\\sample_trace.rdlc";//Report1.rdlc;
            //ReportViewer1.LocalReport.EnableExternalImages = true;
            ////ReportViewer1.LocalReport.SetParameters(new ReportParameter(doc_type_to));//, Guid.NewGuid().ToString()

            ////向報表傳遞單個參數
            ////ReportParameter rp = new ReportParameter("doc_type_to", doc_type_to);
            ////ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp });
            ////向報表傳遞多個參數
            //ReportParameter[] para = new ReportParameter[3];
            //para[0] = new ReportParameter("Remark", txtRemark_head.Text);
            //para[1] = new ReportParameter("RouteDep", txtRouteDep.Text);
            //para[2] = new ReportParameter("barcode_url", barcode_url);
            //ReportViewer1.LocalReport.SetParameters(para);
            //ReportDataSource rds = new ReportDataSource("DataSet_Trace", dtPrint);
            //ReportViewer1.LocalReport.DataSources.Clear();
            //ReportViewer1.LocalReport.DataSources.Add(rds);
            //ReportViewer1.LocalReport.Refresh();
            //ReportViewer1.LocalReport.Refresh();


        }
    }
}