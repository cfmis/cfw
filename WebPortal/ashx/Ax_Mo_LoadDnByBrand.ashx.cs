using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Leyp.SQLServerDAL;
using Leyp.Components;
using Leyp.Components.Module;//獲取登錄的用戶名

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_Mo_LoadDnByBrand
    /// </summary>
    public class Ax_Mo_LoadDnByBrand : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private SQLHelp sh = new SQLHelp();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            GetDn(context);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        public void GetDn(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            string date_from = "", date_to = "";
            string mo_from = "", mo_to = "";
            string para = context.Request["param"];
            date_from = context.Request["date_from"] != null ? context.Request["date_from"] : "";
            date_to = context.Request["date_to"] != null ? context.Request["date_to"] : "";
            mo_from = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
            mo_to = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
            if (date_from == "" && date_to == "" && mo_from == "" && mo_to == "")
            {
                mo_from = "ZZZZZZZZZ";
                mo_to = "ZZZZZZZZZ";
            }
            string strSql = "usp_LoadDnByBrand";
            SqlParameter[] parameters = {new SqlParameter("@date_from", date_from),new SqlParameter("@date_to", date_to)
                                        ,new SqlParameter("@mo_from", mo_from),new SqlParameter("@mo_to", mo_to)
                                        };
            DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
    }
}