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

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_Sa_LoadGapInv
    /// </summary>
    public class Ax_Sa_LoadGapInv : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

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

        public void GetItem(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            string Date_from = "", Date_to = "";
            string vatDate_from = "", vatDate_to = "";
            string Brand_from = "", Brand_to = "";
            string Agent_from = "", Agent_to = "";
            int doc_type = 1;
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Date_from = ja[0]["Date_from"].ToString().Trim();
                Date_to = ja[0]["Date_to"].ToString().Trim();
                vatDate_from = ja[0]["vatDate_from"].ToString().Trim();
                vatDate_to = ja[0]["vatDate_to"].ToString().Trim();
                Brand_from = ja[0]["Brand_from"].ToString().Trim();
                Brand_to = ja[0]["Brand_to"].ToString().Trim();
                Agent_from = ja[0]["Agent_from"].ToString().Trim();
                Agent_to = ja[0]["Agent_to"].ToString().Trim();
                doc_type = Convert.ToInt32(ja[0]["doc_type"]);
            }
            else
            {
                Date_from = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                Date_to = context.Request["Date_to"] != null ? context.Request["Date_to"] : "";
                vatDate_from = context.Request["vatDate_from"] != null ? context.Request["vatDate_from"] : "";
                vatDate_to = context.Request["vatDate_to"] != null ? context.Request["vatDate_to"] : "";
                Brand_from = context.Request["Brand_from"] != null ? context.Request["Brand_from"] : "";
                Brand_to = context.Request["Brand_to"] != null ? context.Request["Brand_to"] : "";
                Agent_from = context.Request["Agent_from"] != null ? context.Request["Agent_from"] : "";
                Agent_to = context.Request["Agent_to"] != null ? context.Request["Agent_to"] : "";
                doc_type = context.Request["doc_type"] != null ? Convert.ToInt32(context.Request["doc_type"]) : 1;
            }
            if (Date_from == "" && vatDate_from == "" && Brand_from == "" && Agent_from == "" && Agent_to == "")
            {
                Date_from = "1900/01/01";
                Date_to = "1900/01/01";
                Agent_to = "ZZZZZZZZZ";
            }
            //else
            //{
            string strSql = "usp_LoadInvByAgent";
            SqlParameter[] parameters = {new SqlParameter("@doc_type", doc_type)
                                        ,new SqlParameter("@brand1", Brand_from),new SqlParameter("@brand2", Brand_to)
                                        ,new SqlParameter("@Agent1", Agent_from),new SqlParameter("@Agent2", Agent_to)
                                        ,new SqlParameter("@dat1", Date_from), new SqlParameter("@dat2", Date_to)
                                        ,new SqlParameter("@vatdat1", vatDate_from), new SqlParameter("@vatdat2", vatDate_to)
                                        };

            DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);


            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
    }
}