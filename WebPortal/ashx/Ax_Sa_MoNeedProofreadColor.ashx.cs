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
    /// Summary description for Ax_Sa_MoNeedProofreadColor
    /// </summary>
    public class Ax_Sa_MoNeedProofreadColor : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string type = context.Request["paraa"].ToString();
            if (type == "getData")
                getData(context);
            else
                updateData(context);
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
            string dateFrom = "", dateTo = "";
            string productMoFrom = "", productMoTo = "";
            string Proofread_status = "";
            string moGroup = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                dateFrom = ja[0]["Date_from"].ToString().Trim();
                dateTo = ja[0]["Date_to"].ToString().Trim();
                productMoFrom = ja[0]["Prd_mo_from"].ToString().Trim();
                productMoTo = ja[0]["Prd_mo_to"].ToString().Trim();
                Proofread_status = ja[0]["Proofread_status"].ToString().Trim();
                moGroup = ja[0]["Mo_group"].ToString().Trim();
            }
            else
            {
                dateFrom = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                dateTo = context.Request["Date_to"] != null ? context.Request["Date_to"] : "";
                productMoFrom = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                productMoTo = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                Proofread_status = context.Request["Proofread_status"] != null ? context.Request["Proofread_status"] : "";
                moGroup = context.Request["Mo_group"] != null ? context.Request["Mo_group"] : "0";
            }
            string strSql = "Select a.mo_id,Convert(Varchar(20),a.create_time,120) AS create_time,a.create_user,a.proofread_status " +
                ",a.proofread_user,Convert(Varchar(20),a.proofread_time,120) AS proofread_time" +
                " From mo_need_proofread_color a" +
                " Where a.mo_id >='' ";
            if (dateFrom == "" && productMoFrom == "" && moGroup == "")
            {
                productMoFrom = "999999999";
                productMoTo = "999999999";
            }
            if (dateFrom != "" && dateTo != "")
            {
                dateTo = Convert.ToDateTime(dateTo).AddDays(1).ToString("yyyy/MM/dd");
                strSql += " And a.create_time>='" + dateFrom + "' And a.create_time<'" + dateTo + "'";
            }
            if (productMoFrom != "" && productMoTo != "")
            {
                strSql += " And a.mo_id>='" + productMoFrom + "' And a.mo_id<='" + productMoTo + "'";
            }
            if (Proofread_status != "")
                strSql += " And a.Proofread_status='" + Proofread_status + "'";
            if (moGroup != "0" && moGroup != "")
                strSql += " And Substring(a.mo_id,3,1)='" + moGroup + "'";
            strSql += " Order By a.update_time Desc ";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);


            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
        public void updateData(HttpContext context)
        {
            string para = context.Request["param"];
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            string Result = "";
            BasePage bp = new BasePage();
            string mo_id = ja[0]["mo_id"].ToString().Trim().ToUpper();
            string proofread_status = ja[0]["proofread_status"].ToString().Trim().ToUpper();
            string strSql = "";
            string update_user = bp.getUserName();
            string update_time = System.DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
            if (!checkData(mo_id))
                strSql = " Insert Into mo_need_proofread_color (mo_id,proofread_status,create_user,create_time)" +
                    " Values (" + "'" + mo_id + "','" + proofread_status + "','" + update_user + "','" + update_time + "'" +
                    " )";
            else
                strSql = " Update mo_need_proofread_color Set proofread_status='" + proofread_status + "',update_user='" + update_user + "',update_time='" + update_time + "'" +
                    " Where mo_id='" + mo_id + "'";
            SQLHelp sh = new SQLHelp();
            Result = sh.ExecuteSqlUpdate(strSql);
            if (Result == "")
                Result = "記錄更新成功!";
            context.Response.ContentType = "text/plain";
            context.Response.Write(Result);
            context.Response.End();
        }
        private bool checkData(string mo_id)
        {
            bool Result = false;
            string strSql = "Select mo_id From mo_need_proofread_color Where mo_id='" + mo_id + "'";
            SQLHelp sh = new SQLHelp();
            DataTable dtData = sh.ExecuteSqlReturnDataTable(strSql);
            if (dtData.Rows.Count > 0)
                Result = true;
            return Result;
        }
    }
}