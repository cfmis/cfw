using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Leyp.Components;
using Leyp.SQLServerDAL;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Data.SqlClient;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_Sa_Iv_InvoiceCustDetails1
    /// </summary>
    public class Ax_Sa_Iv_InvoiceCustDetails1 : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

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
            string custFrom = "", custTo = "";
            string productMoFrom = "", productMoTo = "";
            string invFrom = "", invTo = "";
            string vatInvFrom = "", vatInvTo = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                dateFrom = ja[0]["Date_from"].ToString().Trim();
                dateTo = ja[0]["Date_to"].ToString().Trim();
                custFrom = ja[0]["custFrom"].ToString().Trim();
                custTo = ja[0]["custTo"].ToString().Trim();
                productMoFrom = ja[0]["Prd_mo_from"].ToString().Trim();
                productMoTo = ja[0]["Prd_mo_to"].ToString().Trim();
                invFrom = ja[0]["invFrom"].ToString().Trim();
                invTo = ja[0]["invTo"].ToString().Trim();
                //vatInvFrom = ja[0]["vatInvFrom"].ToString().Trim();
                //vatInvTo = ja[0]["vatInvTo"].ToString().Trim();
            }
            else
            {
                dateFrom = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                dateTo = context.Request["Date_to"] != null ? context.Request["Date_to"] : "";
                custFrom = context.Request["custFrom"] != null ? context.Request["custFrom"] : "";
                custTo = context.Request["custTo"] != null ? context.Request["custTo"] : "";
                productMoFrom = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                productMoTo = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                invFrom = context.Request["invFrom"] != null ? context.Request["invFrom"] : "";
                invTo = context.Request["invTo"] != null ? context.Request["invTo"] : "";
                //vatInvFrom = context.Request["vatInvFrom"] != null ? context.Request["vatInvFrom"] : "";
                //vatInvTo = context.Request["vatInvTo"] != null ? context.Request["vatInvTo"] : "";
            }
            string strSql = "";
            if (dateFrom == "" && invFrom == "" && productMoFrom == "" && custFrom == "")
            {
                invFrom = "INV999999999";
                invTo = "INV999999999";
            }
            strSql = "usp_GetInvoiceCustDetails";
            SqlParameter[] parameters = {
                new SqlParameter("@dateFrom", dateFrom), new SqlParameter("@dateTo", dateTo)
                ,new SqlParameter("@custFrom", custFrom), new SqlParameter("@custTo", custTo)
                ,new SqlParameter("@moFrom", productMoFrom), new SqlParameter("@moTo", productMoTo)
                ,new SqlParameter("@invFrom", invFrom), new SqlParameter("@invTo", invTo)
                ,new SqlParameter("@vatInvFrom", vatInvFrom), new SqlParameter("@vatInvTo", vatInvTo)
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