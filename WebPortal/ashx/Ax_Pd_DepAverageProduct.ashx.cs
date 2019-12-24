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
    /// Summary description for Ax_Pd_DepAverageProduct
    /// </summary>
    public class Ax_Pd_DepAverageProduct : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
            int rpt_type = 0;
            string now_date_from = "", now_date_to = "";
            string dep1 = "", dep2 = "";
            string mo1 = "", mo2 = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                rpt_type = Convert.ToInt32(ja[0]["rpt_type"].ToString());
                now_date_from = ja[0]["now_date_from"].ToString().Trim();
                now_date_to = ja[0]["now_date_to"].ToString().Trim();
                dep1 = ja[0]["dep_from"].ToString().Trim();
                dep2 = ja[0]["dep_to"].ToString().Trim();
                mo1 = ja[0]["mo_from"].ToString().Trim();
                mo2 = ja[0]["mo_to"].ToString().Trim();
            }
            else
            {
                rpt_type = context.Request["rpt_type"] != null ? Convert.ToInt32(context.Request["rpt_type"]) : 0;
                now_date_from = context.Request["now_date_from"] != null ? context.Request["now_date_from"] : "";
                now_date_to = context.Request["now_date_to"] != null ? context.Request["now_date_to"] : "";
                dep1 = context.Request["dep_from"] != null ? context.Request["dep_from"] : "";
                dep2 = context.Request["dep_to"] != null ? context.Request["dep_to"] : "";
                mo1 = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
                mo2 = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
            }
            if (now_date_from == "" && now_date_to == "" && dep1 == "" && dep2 == "" && mo1 == "" && mo2 == "")
            {
                now_date_from = "2000/01/01";
                now_date_to = "2000/01/01";
                mo1 = "ZZZZZZZZZ";
                mo2 = "ZZZZZZZZZ";
            }
            string strSql = "usp_pd_depaverageproduct";
            SqlParameter[] parameters = {new SqlParameter("@rpt_type", rpt_type)
                    , new SqlParameter("@dep1", dep1), new SqlParameter("@dep2", dep2)
                    ,new SqlParameter("@dat1", now_date_from), new SqlParameter("@dat2", now_date_to)
                    , new SqlParameter("@mo1", mo1), new SqlParameter("@mo2", mo2)
            };

            DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);


            //DataTable dt = SQLHelper.ExecuteSqlReturnDataTable("select flag_id,flag_desc from bs_flag_desc");

            //if (paraa == "get_oc_a")
            //{

            //    ReturnValue = cls.DataTableJsonReturnTextBox(dt);//提取記錄，返回給文本框
            //}
            //else
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

    }
}