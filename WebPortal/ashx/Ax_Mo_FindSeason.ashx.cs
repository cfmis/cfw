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
    /// Summary description for Ax_Mo_FindSeason
    /// </summary>
    public class Ax_Mo_FindSeason : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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

            string dat1 = "", dat2 = "";
            string sea = "";
            string mo_group = "";// dlMo_group.Text;
            string brand1 = "", brand2 = "";
            string cust_goods = "";
            string para = context.Request["param"];

            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            dat1 = ja[0]["dat1"].ToString().Trim();
            dat2 = ja[0]["dat2"].ToString().Trim();
            mo_group = ja[0]["mo_group"].ToString().Trim();
            brand1 = ja[0]["brand1"].ToString().Trim();
            brand2 = ja[0]["brand2"].ToString().Trim();
            sea = ja[0]["season"].ToString().Trim();
            cust_goods = ja[0]["cust_goods"].ToString().Trim();

            string strSql = "usp_mo_find_season";
            SqlParameter[] parameters = {new SqlParameter("@sea", sea)
                        ,new SqlParameter("@mo_group", mo_group)
                        ,new SqlParameter("@dat1", dat1)
                        ,new SqlParameter("@dat2", dat2)
                        ,new SqlParameter("@brand1", brand1)
                        ,new SqlParameter("@brand2", brand2)
                        ,new SqlParameter("@cust_goods", cust_goods)
                        };


            DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);





            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            //ReturnValue = "[{'dep_id':'101','dep_cdesc':'鈕 - 工程科'},{'dep_id':'102','dep_cdesc':'鈕 - 啤機'}]";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }


    }
}