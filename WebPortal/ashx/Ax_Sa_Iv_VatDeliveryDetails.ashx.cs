using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Leyp.Components;
using Leyp.SQLServerDAL;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_Sa_Iv_VatDeliveryDetails
    /// </summary>
    public class Ax_Sa_Iv_VatDeliveryDetails : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private SQLHelp sh = new SQLHelp();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string type = context.Request["paraa"].ToString();
            getData(context);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public void getData(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            string ReturnValue = string.Empty;
            string remote_db = DBUtility.remote_db;
            string within_code = DBUtility.within_code;
            string dateFrom = "", dateTo = "";
            string productMoFrom = "", productMoTo = "";
            string invFrom = "", invTo = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                dateFrom = ja[0]["Date_from"].ToString().Trim();
                dateTo = ja[0]["Date_to"].ToString().Trim();
                productMoFrom = ja[0]["Prd_mo_from"].ToString().Trim();
                productMoTo = ja[0]["Prd_mo_to"].ToString().Trim();
                invFrom = ja[0]["invFrom"].ToString().Trim();
                invTo = ja[0]["invTo"].ToString().Trim();
            }
            else
            {
                dateFrom = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                dateTo = context.Request["Date_to"] != null ? context.Request["Date_to"] : "";
                productMoFrom = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                productMoTo = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                invFrom = context.Request["invFrom"] != null ? context.Request["invFrom"] : "";
                invTo = context.Request["invTo"] != null ? context.Request["invTo"] : "";
            }
            string strSql = "Select b.mo_id,a.id,a.invoice_no,Convert(Varchar(20),a.invoice_date,111) AS invoice_date,c.name AS goods_cname " +
                ",b.issues_unit,Convert(INT,b.issues_qty) AS issues_qty,d.id AS order_id,d.unit_price,d.p_unit,f.rate" +
                ",Round((b.issues_qty/f.rate)*Convert(float,d.unit_price),2) AS order_amt" +
                ",e.linkman,d.table_head,e.m_id" +
                " From " + remote_db + "so_issues_mostly a" +
                " Inner Join " + remote_db + "so_issues_details b On a.within_code=b.within_code And a.id=b.id" +
                " Inner Join " + remote_db + "it_goods c On b.within_code=c.within_code And b.goods_id=c.id" +
                " Inner Join " + remote_db + "so_order_details d On b.within_code=d.within_code And b.mo_id=d.mo_id" +
                " Inner Join " + remote_db + "so_order_manage e On d.within_code=e.within_code And d.id=e.id And d.ver=e.ver" +
                " Inner Join " + remote_db + "it_coding f On d.within_code=f.within_code And d.p_unit=f.unit_code And b.issues_unit=f.basic_unit" +
                " Where a.within_code='" + within_code + "' And f.id='*'";
            if(dateFrom==""&&invFrom==""&&productMoFrom=="")
            {
                invFrom = "INV999999999";
                invTo = "INV999999999";
            }
            if(dateFrom!=""&&dateTo!="")
            {
                dateTo = Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy/MM/dd");
                strSql += " And a.invoice_date>='" + dateFrom + "' And a.invoice_date<'" + dateTo + "'";
            }
            if (productMoFrom != "" && productMoTo != "")
                strSql += " And b.mo_id>='" + productMoFrom + "' And b.mo_id<='" + productMoTo + "'";
            if (invFrom != "" && invTo != "")
                strSql += " And a.invoice_no>='" + invFrom + "' And a.invoice_no<='" + invTo + "'";
            strSql += " Order By a.invoice_no,a.invoice_date,b.mo_id";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);


            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

    }
}