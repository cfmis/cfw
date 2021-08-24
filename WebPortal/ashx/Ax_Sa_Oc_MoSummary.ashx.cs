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
    /// Summary description for Ax_Sa_Oc_MoSummary
    /// </summary>
    public class Ax_Sa_Oc_MoSummary : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private SQLHelp sh = new SQLHelp();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            //string type = context.Request["paraa"].ToString();
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
            BasePage bp = new BasePage();
            string userId= bp.getUserName();
            string moGroup = "";
            string dateFrom = "", dateTo = "";
            string orderDateFrom = "", orderDateTo = "";
            string productMoFrom = "", productMoTo = "";
            string brandFrom = "", brandTo = "";
            string ownFrom = "", ownTo = "";
            string custFrom = "", custTo = "";
            int sourceType = 1;
            string isAPart = "";
            string isComplete = "";
            string createBy = "";
            string csColor = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                moGroup = ja[0]["MoGroup"].ToString().Trim();
                createBy = ja[0]["CreateBy"].ToString().Trim();
                dateFrom = ja[0]["DateFrom"].ToString().Trim();
                dateTo = ja[0]["DateTo"].ToString().Trim();
                orderDateFrom = ja[0]["OrderDateFrom"].ToString().Trim();
                orderDateTo = ja[0]["OrderDateTo"].ToString().Trim();
                productMoFrom = ja[0]["MoFrom"].ToString().Trim();
                productMoTo = ja[0]["MoTo"].ToString().Trim();
                brandFrom = ja[0]["BrandFrom"].ToString().Trim();
                brandTo = ja[0]["BrandTo"].ToString().Trim();
                custFrom = ja[0]["CustFrom"].ToString().Trim();
                custTo = ja[0]["CustTo"].ToString().Trim();
                ownFrom = ja[0]["OwnFrom"].ToString().Trim();
                ownTo = ja[0]["OwnTo"].ToString().Trim();
                sourceType = Convert.ToInt32(ja[0]["SourceType"].ToString());
                isAPart = ja[0]["IsAPart"].ToString().Trim();
                isComplete = ja[0]["IsComplete"].ToString().Trim();
                csColor = ja[0]["csColor"].ToString().Trim();
            }
            else
            {
                moGroup = context.Request["MoGroup"] != null ? context.Request["MoGroup"] : "";
                createBy = context.Request["CreateBy"] != null ? context.Request["CreateBy"] : "";
                dateFrom = context.Request["DateFrom"] != null ? context.Request["DateFrom"] : "";
                dateTo = context.Request["DateTo"] != null ? context.Request["DateTo"] : "";
                orderDateFrom = context.Request["OrderDateFrom"] != null ? context.Request["OrderDateFrom"] : "";
                orderDateTo = context.Request["OrderDateTo"] != null ? context.Request["OrderDateTo"] : "";
                productMoFrom = context.Request["MoFrom"] != null ? context.Request["MoFrom"] : "";
                productMoTo = context.Request["MoTo"] != null ? context.Request["MoTo"] : "";
                brandFrom = context.Request["BrandFrom"] != null ? context.Request["BrandFrom"] : "";
                brandTo = context.Request["BrandTo"] != null ? context.Request["BrandTo"] : "";
                custFrom = context.Request["CustFrom"] != null ? context.Request["CustFrom"] : "";
                custTo = context.Request["CustTo"] != null ? context.Request["CustTo"] : "";
                ownFrom = context.Request["OwnFrom"] != null ? context.Request["OwnFrom"] : "";
                ownTo = context.Request["OwnTo"] != null ? context.Request["OwnTo"] : "";
                sourceType = context.Request["SourceType"] != null ? Convert.ToInt32(context.Request["SourceType"]) : 1;
                isAPart= context.Request["IsAPart"] != null ? context.Request["IsAPart"] : "";
                isComplete = context.Request["IsComplete"] != null ? context.Request["IsComplete"] : "";
                csColor = context.Request["csColor"] != null ? context.Request["csColor"] : "";
            }
            if(moGroup==""&&createBy==""&&dateFrom==""&&orderDateFrom==""&&productMoFrom==""&&brandFrom==""&&custFrom==""&&ownFrom=="" && custFrom == "" && csColor == "")
            {
                productMoFrom = "ZZZZZZZZZZ";
                productMoTo = "ZZZZZZZZZZ";
            }
            SqlParameter[] parameters = { new SqlParameter("@source_type", sourceType)
                                        ,new SqlParameter("@user_id", userId)
                                        ,new SqlParameter("@cp_state", isComplete)
                                        ,new SqlParameter("@mo_group", moGroup)
                                        ,new SqlParameter("@crdat1", dateFrom), new SqlParameter("@crdat2", dateTo)
                                        ,new SqlParameter("@crby", createBy)
                                        ,new SqlParameter("@dat1", orderDateFrom), new SqlParameter("@dat2", orderDateTo)
                                        , new SqlParameter("@mo1", productMoFrom), new SqlParameter("@mo2", productMoTo)
                                        , new SqlParameter("@brand1", brandFrom), new SqlParameter("@brand2", brandTo)
                                        , new SqlParameter("@cust1", custFrom), new SqlParameter("@cust2", custTo)
                                        , new SqlParameter("@own1", ownFrom), new SqlParameter("@own2", ownTo)
                                        , new SqlParameter("@showapart", isAPart)
                                        , new SqlParameter("@csColor", csColor)};

            DataTable dtOc = SQLHelper.ExecuteProcedureRetrunDataTable("usp_GetOcStatus", parameters);

            ReturnValue = cls.DataTableJsonReturnExcel(dtOc);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
    }
}