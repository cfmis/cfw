using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Leyp.SQLServerDAL;
using Microsoft.Reporting.WebForms;
using Leyp.Components.Module;

namespace WebPortal.Stock
{
    public partial class St_GoodsTransferJxPrint : BasePage//System.Web.UI.Page
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
            //string dateFrom = Request.QueryString["dateFrom"].ToString();
            //string dateTo = Request.QueryString["dateTo"].ToString();
            //string ID = Request.QueryString["ID"];
            //this.ReportViewer1.Reset();
            //this.ReportViewer1.LocalReport.Dispose();
            //this.ReportViewer1.LocalReport.DataSources.Clear();
            //Microsoft.Reporting.WebForms.ReportDataSource reportDataSource = new Microsoft.Reporting.WebForms.ReportDataSource();
            //reportDataSource.Name = "DsSo";
            ////Dgsql2DBContext db = new Dgsql2DBContext();
            ////var model = new so_online_order_details();
            ////int id = 1023;
            ////List<so_online_order_details> lsModel = new List<so_online_order_details>();
            ////lsModel = db.so_online_order_details.ToList();
            //var lsModel = SoDAL.GetPrintSo(ID);
            //double TotalAmountUSD = 0;
            //for (int i = 0; i < lsModel.Count; i++)
            //{
            //    TotalAmountUSD += lsModel[i].AmountUSD;
            //}
            //reportDataSource.Value = lsModel;// Db.BaseUser.Find(id);
            //this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("../Reports/St_GoodsTransferJxDetails.rdlc");
            //this.ReportViewer1.LocalReport.DataSources.Add(reportDataSource);

            //ReportParameter rp = new ReportParameter("TotalAmount", TotalAmountUSD.ToString());
            //this.ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp });
            //this.ReportViewer1.LocalReport.Refresh();


            //ReportViewer1.LocalReport.ReportPath = AppDomain.CurrentDomain.BaseDirectory + "/Reports/sample_trace.rdlc";//
            //ReportViewer1.LocalReport.EnableExternalImages = true;

            //// 获取 MyHandler.jxd 的完整路径
            ////string barcode_url = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath + "file/image/" + "/MyHandler.jxd?data=";
            //string barcode_url = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath + "file/image/";
            ////+"file/image"

            ////-> "http://localhost:6344/HttpHandlerDemo/MyHandler.jxd?data="
            string prdDep = Request.QueryString["prdDep"].ToString();
            string moGroup = Request.QueryString["moGroup"].ToString();
            string prdMoFrom = Request.QueryString["prdMoFrom"].ToString();
            string prdMoTo = Request.QueryString["prdMoTo"].ToString();
            string prdItem = Request.QueryString["prdItem"].ToString();
            string dateFrom = Request.QueryString["dateFrom"].ToString();
            string dateTo = Request.QueryString["dateTo"].ToString();
            string transferFlag = Request.QueryString["transferFlag"].ToString();
            string strSql = "Select a.prd_dep,d.dep_cdesc AS prd_dep_cdesc,a.prd_mo,a.prd_item,b.name AS prd_item_cdesc" +
                    ",a.transfer_qty,a.transfer_weg,a.wip_id" +
                    ",a.transfer_date,c.flag_desc,a.to_dep,e.dep_cdesc AS to_dep_cdesc " +
                    " FROM dgcf_pad.dbo.product_transfer_jx_details a" +
                    " LEFT JOIN geo_it_goods b ON a.prd_item=b.id COLLATE chinese_taiwan_stroke_CI_AS" +
                    " LEFT JOIN bs_flag_desc c ON a.transfer_flag=c.flag_id COLLATE chinese_taiwan_stroke_CI_AS" +
                    " LEFT JOIN bs_dep d ON a.wip_id=d.dep_id COLLATE chinese_taiwan_stroke_CI_AS" +
                    " LEFT JOIN bs_dep e ON a.to_dep=e.dep_id COLLATE chinese_taiwan_stroke_CI_AS" +
                    " WHERE c.doc_type='goods_transfer_jx'";
            if (prdDep != "")
                strSql += " AND a.prd_dep='" + prdDep + "'";
            if (moGroup != "")
                strSql += " AND Substring(a.prd_mo,3,1)='" + moGroup + "'";
            if (prdMoFrom != "" && prdMoTo != "")
                strSql += " AND a.prd_mo>='" + prdMoFrom + "' AND a.prd_mo<='" + prdMoTo + "'";
            if (prdItem != "")
                strSql += " AND a.prd_item Like '" + "%" + prdItem + "%" + "'";
            if (dateFrom != "" && dateTo != "")
                strSql += " AND a.Transfer_date>='" + dateFrom + "' AND a.Transfer_date<='" + dateTo + "'";
            if (transferFlag.Trim() == "0" || transferFlag.Trim() == "1")
                strSql += " AND a.Transfer_flag='" + transferFlag + "'";
            strSql += " ORDER BY a.prd_dep,a.Transfer_flag,a.transfer_date,a.prd_item,a.prd_mo";
            DataTable dtPrint = sh.ExecuteSqlReturnDataTable(strSql);

            this.ReportViewer1.Reset();
            //this.ReportViewer1.LocalReport.Dispose();
            ReportViewer1.LocalReport.DataSources.Clear();
            this.ReportViewer1.LocalReport.ReportPath = Server.MapPath("../Reports/St_GoodsTransferJxDetails.rdlc");
            Microsoft.Reporting.WebForms.ReportDataSource rds = new Microsoft.Reporting.WebForms.ReportDataSource("DSDgsql2Dgcf_pad", dtPrint);
            //this.ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DSDgcf_pad", dtPrint));
            //ReportViewer1.LocalReport.DataSources.Add(
            //new Microsoft.Reporting.WebForms.ReportDataSource("DSDgcf_pad", dtPrint));

            //向報表傳遞多個參數
            List<ReportParameter> para = new List<ReportParameter>();            //这里是添加两个字段
            para.Add(new ReportParameter("userId", getUserName()));
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