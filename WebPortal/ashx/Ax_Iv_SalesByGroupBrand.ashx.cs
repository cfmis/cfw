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
    /// Summary description for Ax_Iv_SalesByGroupBrand
    /// </summary>
    public class Ax_Iv_SalesByGroupBrand : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
            int data_type = 0;
            string now_date_from = "",now_date_to="";
            string old_date_from = "", old_date_to = "";
            string brand1 = "", brand2 = "";
            string cust1 = "", cust2 = "";
            string mo1 = "", mo2 = "";
            string season1 = "", season2 = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                rpt_type = Convert.ToInt32(ja[0]["rpt_type"].ToString());
                now_date_from = ja[0]["now_date_from"].ToString().Trim();
                now_date_to = ja[0]["now_date_to"].ToString().Trim();
                old_date_from = ja[0]["old_date_from"].ToString().Trim();
                old_date_to = ja[0]["old_date_to"].ToString().Trim();
                brand1 = ja[0]["brand_from"].ToString().Trim();
                brand2 = ja[0]["brand_to"].ToString().Trim();
                cust1 = ja[0]["cust_from"].ToString().Trim();
                cust2 = ja[0]["cust_to"].ToString().Trim();
                mo1 = ja[0]["mo_from"].ToString().Trim();
                mo2 = ja[0]["mo_to"].ToString().Trim();
                season1 = ja[0]["season_from"].ToString().Trim();
                season2 = ja[0]["season_to"].ToString().Trim();
                if (ja[0]["data_type"].ToString().Trim() == "True")
                    data_type = 1;
            }
            else
            {
                rpt_type = context.Request["rpt_type"] != null ? Convert.ToInt32(context.Request["rpt_type"]) : 0;
                now_date_from = context.Request["now_date_from"] != null ? context.Request["now_date_from"] : "";
                now_date_to = context.Request["now_date_to"] != null ? context.Request["now_date_to"] : "";
                old_date_from = context.Request["old_date_from"] != null ? context.Request["old_date_from"] : "";
                old_date_to = context.Request["old_date_to"] != null ? context.Request["old_date_to"] : "";
                brand1 = context.Request["brand_from"] != null ? context.Request["brand_from"] : "";
                brand2 = context.Request["brand_to"] != null ? context.Request["brand_to"] : "";
                cust1 = context.Request["cust_from"] != null ? context.Request["cust_from"] : "";
                cust2 = context.Request["cust_to"] != null ? context.Request["cust_to"] : "";
                mo1 = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
                mo2 = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
                season1 = context.Request["season_from"] != null ? context.Request["season_from"] : "";
                season2 = context.Request["season_to"] != null ? context.Request["season_to"] : "";
                if (context.Request["data_type"] == "on")
                    data_type = 1;
            }
            if (now_date_from == "" && now_date_to == "" && brand1 == "" && brand2 == "" && cust1 == "" && cust2 == "" && mo1 == "" && mo2 == "")
            {
                now_date_from = "2000/01/01";
                now_date_to = "2000/01/01";
                old_date_from = "2000/01/01";
                old_date_to = "2000/01/01";
            }
            string strSql = "usp_iv_salesByGroupBrand";
            SqlParameter[] parameters = {new SqlParameter("@data_type", data_type),new SqlParameter("@rpt_type", rpt_type)
                                        ,new SqlParameter("@now_date1", now_date_from), new SqlParameter("@now_date2", now_date_to)
                                        ,new SqlParameter("@old_date1", old_date_from), new SqlParameter("@old_date2", old_date_to)
                                        , new SqlParameter("@brand1", brand1), new SqlParameter("@brand2", brand2)
                                        , new SqlParameter("@cust1", cust1), new SqlParameter("@cust2", cust2)
                                        , new SqlParameter("@mo1", mo1), new SqlParameter("@mo2", mo2)
                                        , new SqlParameter("@season1", season1), new SqlParameter("@season2", season2)
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