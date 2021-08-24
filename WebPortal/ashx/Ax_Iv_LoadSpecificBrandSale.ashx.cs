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
    /// Summary description for Ax_Iv_LoadSpecificBrandSale
    /// </summary>
    public class Ax_Iv_LoadSpecificBrandSale : IHttpHandler, System.Web.SessionState.IRequiresSessionState//: IHttpHandler
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
            int rpt_type = 0;
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Date_from = ja[0]["Date_from"].ToString().Trim();
                Date_to = ja[0]["Date_to"].ToString().Trim();
                rpt_type = Convert.ToInt32(ja[0]["rpt_type"]);
            }
            else
            {
                Date_from = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                Date_to = context.Request["Date_to"] != null ? context.Request["Date_to"] : "";
                rpt_type = context.Request["rpt_type"] != null ? Convert.ToInt32(context.Request["rpt_type"]) : 0;
            }
            if (Date_from=="" && Date_to=="")
            {
                Date_from = "1900/01/01";
                Date_to = "1900/01/01";
            }
            //else
            //{
            string strSql = "usp_LoadSpecificBrandSale";
            SqlParameter[] parameters = {new SqlParameter("@rpt_type", rpt_type)
                                        ,new SqlParameter("@date_from", Date_from), new SqlParameter("@date_to", Date_to)
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