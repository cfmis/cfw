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
    /// Summary description for Ax_Iv_salesByPrdType
    /// </summary>
    public class Ax_Iv_salesByPrdType : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
            rpt_type = context.Request["rpt_type"] != null ? Convert.ToInt32(context.Request["rpt_type"]) : 0;
            string date1 = context.Request["date_from"] != null ? context.Request["date_from"] : "";
            string date2 = context.Request["date_to"] != null ? context.Request["date_to"] : "";
            string brand1 = context.Request["brand_from"] != null ? context.Request["brand_from"] : "";
            string brand2 = context.Request["brand_to"] != null ? context.Request["brand_to"] : "";
            string cust1 = context.Request["cust_from"] != null ? context.Request["cust_from"] : "";
            string cust2 = context.Request["cust_to"] != null ? context.Request["cust_to"] : "";
            string mo1 = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
            string mo2 = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
            if (date1==""&&date2==""&&brand1==""&&brand2=="" && cust1 == "" && cust2 == ""&&mo1==""&&mo2=="")
            {
                mo1 = "2000/01/01";
                mo2 = "2000/01/01";
            }
            string strSql = "usp_iv_salesByProductType";
            SqlParameter[] parameters = {new SqlParameter("@user_id", bp.getUserName())
                                        ,new SqlParameter("@rpt_type", rpt_type)
                                        ,new SqlParameter("@date1", date1), new SqlParameter("@date2", date2)
                                        , new SqlParameter("@brand1", brand1), new SqlParameter("@brand2", brand2)
                                        , new SqlParameter("@cust1", cust1), new SqlParameter("@cust2", cust2)
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