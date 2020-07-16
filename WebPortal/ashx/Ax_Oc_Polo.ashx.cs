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
    /// Summary description for Ax_Oc_Polo
    /// </summary>
    public class Ax_Oc_Polo :  IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        clsPublic cls = new clsPublic();
        BasePage bp = new BasePage();
        SQLHelp sh = new SQLHelp();
        string remote_db = DBUtility.remote_db;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            
            //context.Response.Write("Hello World");
            string type = context.Request["paraa"].ToString();
            if (type == "get_oc")
                GetItem(context);
            else
            {
                if (type == "delete")
                    DeleteItem(context);
                else
                {
                    //if (type == "updateOc")
                    //    UpdateOC1(context);
                    //else
                        UpdateOC(context);
                }
            }
            
        }
        private void GetItem(HttpContext context)
        {
            string ReturnValue = string.Empty;
            string remote_db = DBUtility.remote_db;
            string within_code = DBUtility.within_code;
            BasePage bp = new BasePage();
            string userId = bp.getUserName();
            string para = context.Request["param"];
            string brand_from = "", brand_to = "";
            string order_date_from = "", order_date_to = "";
            string mo_from = "", mo_to = "";
            string ocno_from = "", ocno_to = "";
            string set_flag = "";
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                brand_from = ja[0]["brand_from"].ToString().Trim();
                brand_to = ja[0]["brand_to"].ToString().Trim();
                order_date_from = ja[0]["order_date_from"].ToString().Trim();
                order_date_to = ja[0]["order_date_to"].ToString().Trim();
                mo_from = ja[0]["mo_from"].ToString().Trim();
                mo_to = ja[0]["mo_to"].ToString().Trim();
                ocno_from = ja[0]["ocno_from"].ToString().Trim();
                ocno_to = ja[0]["ocno_to"].ToString().Trim();
                set_flag = ja[0]["set_flag"].ToString().Trim();
            }
            else
            {
                brand_from = context.Request["brand_from"] != null ? context.Request["brand_from"] : "";
                brand_to = context.Request["brand_to"] != null ? context.Request["brand_to"] : "";
                order_date_from = context.Request["order_date_from"] != null ? context.Request["order_date_from"] : "";
                order_date_to = context.Request["order_date_to"] != null ? context.Request["order_date_to"] : "";
                mo_from = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
                mo_to = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
                ocno_from = context.Request["ocno_from"] != null ? context.Request["ocno_from"] : "";
                ocno_to = context.Request["ocno_to"] != null ? context.Request["ocno_to"] : "";
                set_flag = context.Request["set_flag"] != null ? context.Request["set_flag"] : "";
            }
            if (brand_from == "" && order_date_from == "" && mo_from == "" && ocno_from == "")
            {
                mo_from = "ZZZZZZZZZZ";
                mo_to = "ZZZZZZZZZZ";
            }
            SqlParameter[] parameters = { new SqlParameter("@brand_from", brand_from)
                                        ,new SqlParameter("@brand_to", brand_to)
                                        ,new SqlParameter("@order_date_from", order_date_from)
                                        ,new SqlParameter("@order_date_to", order_date_to)
                                        ,new SqlParameter("@mo_from", mo_from), new SqlParameter("@mo_to", mo_to)
                                        ,new SqlParameter("@ocno_from", ocno_from), new SqlParameter("@ocno_to", ocno_to)
                                        ,new SqlParameter("@set_flag", set_flag)
                                        };

            DataTable dtOc = SQLHelper.ExecuteProcedureRetrunDataTable("usp_oc_polo", parameters);

            ReturnValue = cls.DataTableJsonReturnExcel(dtOc);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
        private void UpdateOC1(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            string ReturnValue = string.Empty;
            string remote_db = DBUtility.remote_db;
            string within_code = DBUtility.within_code;
            BasePage bp = new BasePage();
            string userId = bp.getUserName();
            string para = context.Request["param"];
            string mo_id = "";
            string regions = "";
            string req_mock_up = "", rec_mock_up = "";
            string data_sheet_pre = "", data_sheet_sent = "";
            string result = "";
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                mo_id = ja[0]["mo_id"].ToString().Trim();
                regions = ja[0]["regions"] != null ? ja[0]["regions"].ToString().Trim() : "";
                req_mock_up = ja[0]["req_mock_up"] != null ? ja[0]["req_mock_up"].ToString().Trim() : "";
                rec_mock_up = ja[0]["rec_mock_up"] != null ? ja[0]["rec_mock_up"].ToString().Trim() : "";
                data_sheet_pre = ja[0]["data_sheet_pre"] != null ? ja[0]["data_sheet_pre"].ToString().Trim() : "";
                data_sheet_sent = ja[0]["data_sheet_sent"] != null ? ja[0]["data_sheet_sent"].ToString().Trim() : "";
                
            }
            string strSql = "";
            string create_time = System.DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
            strSql += string.Format(@" SET XACT_ABORT  ON ");
            strSql += string.Format(@" BEGIN TRANSACTION ");
            if (!FindMo(mo_id))
                strSql += string.Format(@"Insert Into so_polo_order_trace (mo_id,regions,req_mock_up,rec_mock_up,data_sheet_pre,data_sheet_sent,create_user,create_time) Values " +
                "('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}')"
                , mo_id, regions, req_mock_up, rec_mock_up, data_sheet_pre, data_sheet_sent, userId, create_time);
            else
                strSql += string.Format(@"Update so_polo_order_trace Set regions='{0}',req_mock_up='{1}',rec_mock_up='{2}',data_sheet_pre='{3}'" +
                    ",data_sheet_sent='{4}',update_user='{5}',update_time='{6}'" +
                " Where mo_id='{7}'"
                , regions, req_mock_up, rec_mock_up, data_sheet_pre, data_sheet_sent, userId, create_time, mo_id);
            strSql += string.Format(@" COMMIT TRANSACTION ");
            result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
                ReturnValue = "更新記錄成功!";
            else
                ReturnValue = "更新記錄失敗!";
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();

        }

        private void UpdateOC(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            string ReturnValue = string.Empty;
            string remote_db = DBUtility.remote_db;
            string within_code = DBUtility.within_code;
            //string updated = context.Request["updated"];
            
            BasePage bp = new BasePage();
            string userId = bp.getUserName();
            string para = context.Request["updated"];
            string mo_id = "";
            string regions = "";
            string req_mock_up = "", rec_mock_up = "";
            string data_sheet_pre = "", data_sheet_sent = "";
            string result = "";
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            for (int i = 0; i < ja.Count; i++)
            {
                mo_id = ja[i]["mo_id"].ToString().Trim();
                regions = ja[i]["regions"] != null ? ja[i]["regions"].ToString().Trim() : "";
                req_mock_up = ja[i]["req_mock_up"] != null ? ja[i]["req_mock_up"].ToString().Trim() : "";
                rec_mock_up = ja[i]["rec_mock_up"] != null ? ja[i]["rec_mock_up"].ToString().Trim() : "";
                data_sheet_pre = ja[i]["data_sheet_pre"] != null ? ja[i]["data_sheet_pre"].ToString().Trim() : "";
                data_sheet_sent = ja[i]["data_sheet_sent"] != null ? ja[i]["data_sheet_sent"].ToString().Trim() : "";
                string strSql = "";
                string create_time = System.DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
                strSql += string.Format(@" SET XACT_ABORT  ON ");
                strSql += string.Format(@" BEGIN TRANSACTION ");
                if (!FindMo(mo_id))
                    strSql += string.Format(@"Insert Into so_polo_order_trace (mo_id,regions,req_mock_up,rec_mock_up,data_sheet_pre,data_sheet_sent,create_user,create_time) Values " +
                    "('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}')"
                    , mo_id, regions, req_mock_up, rec_mock_up, data_sheet_pre, data_sheet_sent, userId, create_time);
                else
                    strSql += string.Format(@"Update so_polo_order_trace Set regions='{0}',req_mock_up='{1}',rec_mock_up='{2}',data_sheet_pre='{3}'" +
                        ",data_sheet_sent='{4}',update_user='{5}',update_time='{6}'" +
                    " Where mo_id='{7}'"
                    , regions, req_mock_up, rec_mock_up, data_sheet_pre, data_sheet_sent, userId, create_time, mo_id);
                strSql += string.Format(@" COMMIT TRANSACTION ");
                result = sh.ExecuteSqlUpdate(strSql);
                if (result == "")
                    ReturnValue = "更新記錄成功!";
                else
                {
                    ReturnValue = "更新記錄失敗!";
                    break;
                }
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();

        }

        private bool FindMo(string mo_id)
        {
            string strSql = "";
            bool result = true;
            strSql = "Select mo_id From so_polo_order_trace Where mo_id='" + mo_id + "'";
            DataTable dtOc = sh.ExecuteSqlReturnDataTable(strSql);
            if (dtOc.Rows.Count == 0)
                result = false;
            return result;
        }
        private void DeleteItem(HttpContext context)
        {
            string strSql = "";
            string result = "";
            strSql += string.Format(@" SET XACT_ABORT  ON ");
            strSql += string.Format(@" BEGIN TRANSACTION ");
            string mo_id= context.Request["mo_id"] != null ? context.Request["mo_id"] : "";
            strSql += " Delete From so_polo_order_trace Where mo_id='" + mo_id + "'";
            strSql += string.Format(@" COMMIT TRANSACTION ");
            result = sh.ExecuteSqlUpdate(strSql);
            string ReturnValue = string.Empty;
            if (result == "")
                ReturnValue = "刪除記錄成功!";
            else
                ReturnValue = "刪除記錄失敗!";
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}