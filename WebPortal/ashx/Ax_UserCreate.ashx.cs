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
    /// Summary description for Ax_UserCreate
    /// </summary>
    public class Ax_UserCreate : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        clsPublic cls = new clsPublic();
        BasePage bp = new BasePage();
        SQLHelp sh = new SQLHelp();
        string remote_db = DBUtility.remote_db;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string edit_mode = context.Request["edit_mode"] != null ? context.Request["edit_mode"] : "";
            switch (edit_mode)
            {
                case "0":
                    GetItem(context);
                    break;
                case "chkgeouser":
                    ChkGeoUser(context);
                    break;
                default:
                    UpdateData(context, edit_mode);//更新或刪除群組代號
                    break;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private void GetItem(HttpContext context)
        {

            string ReturnValue = string.Empty;
            int rpt_type = 0;
            string uname = "",uname_desc="",state="";
            rpt_type = context.Request["rpt_type"] != null ? Convert.ToInt32(context.Request["rpt_type"]) : 0;
            uname = context.Request["uname"] != null ? context.Request["uname"] : "";
            uname_desc = context.Request["uname_desc"] != null ? context.Request["uname_desc"] : "";
            state = context.Request["state"] != null ? context.Request["state"] : "";
            //if (groupid == "" && groupname == "")
            //{
            //    groupid = "ZZZZZZZZZ";
            //    groupname = "ZZZZZZZZZ";
            //}
            string strSql = "Select a.uname,a.uname_desc,a.sales_group,a.user_group,b.groupid,b.groupname,a.language,a.u_type,a.rid,a.state,a.vend_id,c.group_id As geo_groupid" +
                " From tb_sy_user a" +
                " Left Join t_group b On a.t_groupid=b.groupid" +
                " Left Join " + remote_db + "sys_user c On a.uname=c.user_id COLLATE chinese_taiwan_stroke_CI_AS" +
                " Where a.uname>=''";
            if (uname != "")
                strSql += " And a.uname like '" + "%" + uname + "%" + "'";
            if (uname_desc != "")
                strSql += " And a.uname_desc like '" + "%" + uname_desc + "%" + "'";
            if (state != "")
                strSql += " And a.state ='" + state + "'";
            strSql += " Order By a.uname";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);

            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

        private void UpdateData(HttpContext context, string edit_mode)
        {
            string para = context.Request["param"];
            string result = "";
            string uname = "";
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            uname = ja[0]["uname"].ToString();
            string strSql = "", strSql_geo = "";
            if (edit_mode == "2")//刪除
                strSql = " Delete From tb_sy_user Where uname='" + uname + "'";
            else
            {
                string uname_desc = "", pwd = "", language = "0", vend_id = "", u_type = "I";
                string sales_group = "", user_group = "", state = "0";
                int t_groupid = 0, rid = 0, t_typeid = 0, t_subclassid = 1;
                string geo_groupid = "";
                string userid = bp.getUserName();
                uname_desc = ja[0]["uname_desc"].ToString().Trim();
                t_groupid = ja[0]["t_groupid"].ToString() != "" ? Convert.ToInt32(ja[0]["t_groupid"].ToString()) : 0;
                sales_group = ja[0]["sales_group"].ToString().Trim();
                user_group = ja[0]["user_group"].ToString().Trim();
                language = ja[0]["language"].ToString().Trim() != "" ? ja[0]["language"].ToString().Trim() : "0";
                u_type = ja[0]["u_type"].ToString().Trim() != "" ? ja[0]["u_type"].ToString().Trim() : "I";
                state = ja[0]["state"].ToString().Trim() != "" ? ja[0]["state"].ToString().Trim() : "0";
                vend_id= ja[0]["vend_id"].ToString().Trim();
                rid = ja[0]["rid"].ToString() != "" ? Convert.ToInt32(ja[0]["rid"].ToString()) : 0;
                geo_groupid= ja[0]["geo_groupid"].ToString().Trim() != "" ? ja[0]["geo_groupid"].ToString().Trim() : "0";
                strSql = "Select uname From tb_sy_user Where uname='" + uname + "'";
                DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
                if (dt.Rows.Count == 0)
                {
                    strSql = "Insert Into tb_sy_user (uname,uname_desc,pwd,rid,language,vend_id,rid_oa,u_type,sales_group" +
                        ",user_group,t_typeid,t_subclassid,t_groupid,state)" +
                        " Values ('"
                         + uname + "','" + uname_desc + "','" + pwd + "','" + rid + "','" + language + "','" + vend_id + "','" + t_groupid + "','" + u_type + "','" + sales_group
                         + "','" + user_group + "','" + t_typeid + "','" + t_subclassid + "','" + t_groupid + "','" + state + "')";
                }
                else
                    strSql = "Update tb_sy_user Set uname_desc='" + uname_desc + "',rid='" + rid + "',language='" + language
                         + "',u_type='" + u_type + "',sales_group='" + sales_group + "',user_group='" + user_group + "',t_typeid='" + t_typeid + "',t_subclassid='" + t_subclassid
                          + "',t_groupid='" + t_groupid + "',state='" + state
                        + "'" + " Where uname='" + uname + "'";
                //更新Geo中的用戶表
                strSql_geo = "Select user_id From " + remote_db + "sys_user Where user_id='" + uname + "'";
                dt = SQLHelper.ExecuteSqlReturnDataTable(strSql_geo);
                if (dt.Rows.Count == 0)
                {
                    PublicAppDAL pba = new PublicAppDAL();
                    pwd = pba.GeoEncrypt(ja[0]["pwd"].ToString().Trim());
                    strSql_geo = "Insert Into " + remote_db + "sys_user" +
                        " (within_code,user_id,user_name,password,group_id,ava_date,status,typeid,masterdepid,usr_type,inherit_type,createby,createdate)" +
                        " Values ('"
                        + "" + "','" + uname + "','" + uname_desc + "','" + pwd + "','" + geo_groupid + "','" + System.DateTime.Now.ToString("yyyy/MM/dd")
                        + "','" + "0" + "','" + "U" + "','" + "Y" + "','" + "G" + "','" + "Y" + "','" + userid + "','" + System.DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
                        + "')";
                }
                else//如果存在，就不更新Geo中的用戶了
                    strSql_geo = "";
                    //    strSql_geo = "Update " + remote_db + "sys_user Set "
                    //        + "user_name='" + uname_desc + "',group_id='" + geo_groupid + "',modifyby='" + userid + "',modifydate='" + System.DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss")
                    //        + "'";
                    
            }

            result = sh.ExecuteSqlUpdate(strSql);
            if (result == "" && strSql_geo != "")//更新Geo中的用戶表
                result = sh.ExecuteSqlUpdate(strSql_geo);
            if (result == "")
                result = "OK";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }
        private void ChkGeoUser(HttpContext context)
        {
            string para = context.Request["param"];
            string result = "";
            string uname = "";
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            uname = ja[0]["uname"].ToString();
            string strSql_geo = "Select user_id From " + remote_db + "sys_user Where user_id='" + uname + "'";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql_geo);
            if (dt.Rows.Count > 0)
                result = "OK";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }
    }
}