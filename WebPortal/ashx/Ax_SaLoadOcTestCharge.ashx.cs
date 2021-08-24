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
using Leyp.Components.Module;//獲取登錄的用戶名
using System.Web.Script.Serialization;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_SaLoadOcTestCharge
    /// </summary>
    public class Ax_SaLoadOcTestCharge : IHttpHandler, System.Web.SessionState.IRequiresSessionState//: IHttpHandler
    {
        private string remote_db = DBUtility.remote_db;
        private string within_code = DBUtility.within_code;
        private SQLHelp sh = new SQLHelp();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            GetItem(context);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private void GetItem(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            //BasePage bp = new BasePage();

            string ReturnValue = string.Empty;
            string fee_type = "";
            string dateFrom = "", dateTo = "", dateTo1 = "";
            string idFrom = "", idTo = "";
            string moFrom = "", moTo = "";
            string custFrom = "", custTo = "";
            string brandFrom = "", brandTo = "";
            string ownFrom = "", ownTo = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                fee_type = ja[0]["fee_type"].ToString().Trim();
                dateFrom = ja[0]["dateFrom"].ToString().Trim();
                dateTo = ja[0]["dateTo"].ToString().Trim();
                idFrom = ja[0]["idFrom"].ToString().Trim();
                idTo = ja[0]["idTo"].ToString().Trim();
                moFrom = ja[0]["moFrom"].ToString().Trim();
                moTo = ja[0]["moTo"].ToString().Trim();
                custFrom = ja[0]["custFrom"].ToString().Trim();
                custTo = ja[0]["custTo"].ToString().Trim();
                brandFrom = ja[0]["brandFrom"].ToString().Trim();
                brandTo = ja[0]["brandTo"].ToString().Trim();
                ownFrom = ja[0]["ownFrom"].ToString().Trim();
                ownTo = ja[0]["ownTo"].ToString().Trim();
            }
            else
            {
                fee_type = context.Request["fee_type"] != null ? context.Request["fee_type"] : "";
                dateFrom = context.Request["dateFrom"] != null ? context.Request["dateFrom"] : "";
                dateTo = context.Request["dateTo"] != null ? context.Request["dateTo"] : "";
                idFrom = context.Request["idFrom"] != null ? context.Request["idFrom"] : "";
                idTo = context.Request["idTo"] != null ? context.Request["idTo"] : "";
                moFrom = context.Request["moFrom"] != null ? context.Request["moFrom"] : "";
                moTo = context.Request["moTo"] != null ? context.Request["moTo"] : "";
                custFrom = context.Request["custFrom"] != null ? context.Request["custFrom"] : "";
                custTo = context.Request["custTo"] != null ? context.Request["custTo"] : "";
                brandFrom = context.Request["brandFrom"] != null ? context.Request["brandFrom"] : "";
                brandTo = context.Request["brandTo"] != null ? context.Request["brandTo"] : "";
                ownFrom = context.Request["ownFrom"] != null ? context.Request["ownFrom"] : "";
                ownTo = context.Request["ownTo"] != null ? context.Request["ownTo"] : "";
            }
            if (dateFrom == "" && dateTo == "" && idFrom == "" && idTo == "" && moFrom == "" && moTo == "")
            {
                dateFrom = "1900/01/01";
                dateTo = "1900/01/01";
                moFrom = "ZZZZZZZZZ";
                moTo = "ZZZZZZZZZ";
            }
            if (dateFrom != "" && dateTo != "")
                dateTo1 = Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy/MM/dd");
            string strSql = "";
            strSql += " Select a.id,CONVERT(VARCHAR(10),a.create_date,111) AS create_date,CONVERT(VARCHAR(10),a.order_date,111) AS order_date" +
                ",a.m_id,b.mo_id,b.goods_id,c.name AS goods_name" +
                ",CONVERT(VARCHAR(10), b.plan_complete, 111) AS hk_req_date, CONVERT(VARCHAR(10), b.arrive_date, 111) AS cs_req_date" +
                ", a.it_customer,d.name AS cust_cname,b.brand_id,a.create_by,b.mo_group,a.agent,Convert(INT,b.order_qty) AS order_qty,b.goods_unit" +
                ",CONVERT(VARCHAR(10), b.actual_bto_hk_date, 111) AS actual_bto_hk_date, e.fare_id,Convert(Decimal(10,2),e.price) As oth_price";
            strSql += " FROM " + remote_db + "so_order_manage a" +
                " INNER JOIN " + remote_db + "so_order_details b ON a.within_code = b.within_code AND a.id = b.id AND a.ver = b.ver" +
                " INNER JOIN " + remote_db + "it_goods c ON b.within_code = c.within_code And b.goods_id = c.id" +
                " LEFT JOIN " + remote_db + "it_customer d On a.within_code = d.within_code And a.it_customer = d.id" +
                " INNER JOIN " + remote_db + "so_other_fare e On b.within_code = e.within_code And b.id = e.id And b.id = e.id And b.ver = e.Ver And b.mo_id = e.mo_id";
            strSql += " WHERE a.within_code='" + within_code + "'";
            strSql += " And a.state<> '" + 'V' + "'";
            strSql += " And a.state<> '" + '2' + "'";
            strSql += " And b.state<> '" + '2' + "'";
            if (dateFrom != "" && dateTo != "")
                strSql += " AND a.order_date>='" + dateFrom + "' AND a.order_date < '" + dateTo1 + "'";
            if (brandFrom != "" && brandTo != "")
                strSql += " AND b.brand_id>='" + brandFrom + "' AND b.brand_id <= '" + brandTo + "'";
            if (custFrom != "" && custTo != "")
                strSql += " AND a.it_customer>='" + custFrom + "' AND a.it_customer <= '" + custTo + "'";
            if (ownFrom != "" && ownTo != "")
                strSql += " AND a.agent>='" + ownFrom + "' AND a.agent <= '" + ownTo + "'";
            if (moFrom != "" && moTo != "")
                strSql += " AND b.mo_id>='" + moFrom + "' AND b.mo_id <= '" + moTo + "'";
            if (idFrom != "" && idTo != "")
                strSql += " AND a.id>='" + idFrom + "' AND a.id <= '" + idTo + "'";
            strSql += " AND e.fare_id='" + fee_type + "'";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

    }
}