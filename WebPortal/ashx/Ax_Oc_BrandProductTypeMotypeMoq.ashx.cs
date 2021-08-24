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
    /// Summary description for Ax_Oc_BrandProductTypeMotypeMoq
    /// </summary>
    public class Ax_Oc_BrandProductTypeMotypeMoq : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //string type = context.Request["paraa"].ToString();
            GetItem(context);
            //context.Response.Write("Hello World");
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
            string Brand_from = "", Brand_to = "";
            int rpt_type = 0;
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Date_from = ja[0]["Date_from"].ToString().Trim();
                Date_to = ja[0]["Date_to"].ToString().Trim();
                Brand_from = ja[0]["Brand_from"].ToString().Trim();
                Brand_to = ja[0]["Brand_to"].ToString().Trim();
                rpt_type = Convert.ToInt32(ja[0]["rpt_type"]);
            }
            else
            {
                Date_from = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                Date_to = context.Request["Date_to"] != null ? context.Request["Date_to"] : "";
                Brand_from = context.Request["Brand_from"] != null ? context.Request["Brand_from"] : "";
                Brand_to = context.Request["Brand_to"] != null ? context.Request["Brand_to"] : "";
                rpt_type = context.Request["rpt_type"] != null ? Convert.ToInt32(context.Request["rpt_type"]) : 0;
            }
            //if (Loc_no == "" && Prd_mo_from == "" && Prd_mo_to == "" && Prd_item_from == "" && Prd_cdesc == "")
            //{

            //}
            //else
            //{
            string strSql = "usp_OcBrandProductTypeMotypeMoq";
            SqlParameter[] parameters = {new SqlParameter("@rpt_type", rpt_type)
                                        ,new SqlParameter("@order_date1", Date_from), new SqlParameter("@order_date2", Date_to)
                                        ,new SqlParameter("@brand1", Brand_from), new SqlParameter("@brand2", Brand_to)
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