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
    /// Summary description for Ax_Mo_PackRecordNotSent
    /// </summary>
    public class Ax_Mo_PackRecordNotSent : IHttpHandler, System.Web.SessionState.IRequiresSessionState//: IHttpHandler
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
            string mo_group = "";
            string mo_from = "", mo_to = "";
            string cust_from = "", cust_to = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Date_from = ja[0]["date_from"].ToString().Trim();
                Date_to = ja[0]["date_to"].ToString().Trim();
                mo_group = ja[0]["mo_group"].ToString().Trim();
                cust_from = ja[0]["cust_from"].ToString().Trim();
                cust_to = ja[0]["cust_to"].ToString().Trim();
                mo_from = ja[0]["mo_from"].ToString().Trim();
                mo_to = ja[0]["mo_to"].ToString().Trim();
            }
            else
            {
                Date_from = context.Request["date_from"] != null ? context.Request["date_from"] : "";
                Date_to = context.Request["date_to"] != null ? context.Request["date_to"] : "";
                mo_group = context.Request["mo_group"];
                cust_from = context.Request["cust_from"] != null ? context.Request["cust_from"] : "";
                cust_to = context.Request["cust_to"] != null ? context.Request["cust_to"] : "";
                mo_from = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
                mo_to = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
            }
            if (mo_group == null || mo_group=="0")
                mo_group = "";
            if (Date_from == "" && Date_to == ""&&mo_from==""&&mo_to==""&&cust_from=="")
            {
                Date_from = "1900/01/01";
                Date_to = "1900/01/01";
                mo_from = "ZZZZZZZZ";
                mo_to = "ZZZZZZZZ";
            }
            //else
            //{
            string strSql = "usp_PackRecordNotSent";
            SqlParameter[] parameters = {new SqlParameter("@date_from", Date_from), new SqlParameter("@date_to", Date_to)
                    , new SqlParameter("@mo_group", mo_group)
                    , new SqlParameter("@cust_from", cust_from), new SqlParameter("@cust_to", cust_to)
                    , new SqlParameter("@mo_from", mo_from), new SqlParameter("@mo_to", mo_to)
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