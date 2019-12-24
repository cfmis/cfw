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
    /// Summary description for Ax_DepProductStatus
    /// </summary>
    public class Ax_DepProductStatus : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string type = context.Request["paraa"].ToString();
            GetItemDetails(context);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public void GetItemDetails(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            string prdDep = "";
            string moFrom = "", moTo = "";
            string dateFrom = "", dateTo = "";
            string productType = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                prdDep = ja[0]["prdDep"].ToString().Trim();
                moFrom = ja[0]["moFrom"].ToString().Trim();
                moTo = ja[0]["moTo"].ToString().Trim();
                dateFrom = ja[0]["dateFrom"].ToString().Trim();
                dateTo = ja[0]["dateTo"].ToString().Trim();
                productType = ja[0]["productType"].ToString().Trim();
            }
            else
            {
                prdDep = context.Request["prdDep"] != null ? context.Request["prdDep"] : "";
                moFrom = context.Request["moFrom"] != null ? context.Request["moFrom"] : "";
                moTo = context.Request["moTo"] != null ? context.Request["moTo"] : "";
                dateFrom = context.Request["dateFrom"] != null ? context.Request["dateFrom"] : "";
                dateTo = context.Request["dateTo"] != null ? context.Request["dateTo"] : "";
                productType = context.Request["productType"] != null ? context.Request["productType"] : "";
            }
            if (prdDep == "" && moFrom == "" && moTo == "" && productType == "" && dateFrom == "" & dateTo == "")
            {

            }
            else
            {
                string strSql = "usp_DepProductStatus";

                SqlParameter[] parameters = {new SqlParameter("@dep", prdDep)
                                        ,new SqlParameter("@dateFrom", dateFrom), new SqlParameter("@dateTo", dateTo)
                                        ,new SqlParameter("@moFrom", moFrom), new SqlParameter("@moTo", moTo)
                                        , new SqlParameter("@productType", @productType)
                                        , new SqlParameter("@isComplete", 1)
                                        };

                DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);
                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
    }
}