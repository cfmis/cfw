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
    /// Summary description for Ax_UserGroupManager
    /// </summary>
    public class Ax_UserGroupManager : IHttpHandler
    {
        clsPublic cls = new clsPublic();
        BasePage bp = new BasePage();
        SQLHelp sh = new SQLHelp();
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
                case "loadgroupfunc"://顯示群組的功能
                    GetGroupFunc(context);
                    break;
                case "updategroupfunc"://更新群組的功能
                    UpdateGroupFunc(context);
                    break;
                case "loadgroupusers"://顯示群組的用戶
                    GetGroupUsers(context, edit_mode);
                    break;
                case "loadnogroupusers"://顯示非群組的用戶
                    GetGroupUsers(context, edit_mode);
                    break;
                case "updategroupusers"://更新群組的用戶
                    UpdateGroupUsers(context, edit_mode);
                    break;
                case "deletegroupusers"://刪除群組的用戶
                    UpdateGroupUsers(context, edit_mode);
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
            string groupid = "", groupname = "";
            rpt_type = context.Request["rpt_type"] != null ? Convert.ToInt32(context.Request["rpt_type"]) : 0;
            groupid = context.Request["groupid"] != null ? context.Request["groupid"] : "";
            groupname = context.Request["groupname"] != null ? context.Request["groupname"] : "";

            //if (groupid == "" && groupname == "")
            //{
            //    groupid = "ZZZZZZZZZ";
            //    groupname = "ZZZZZZZZZ";
            //}
            string strSql = "Select * From t_group Where rst='1' ";
            if (groupid != "")
                strSql += " And groupid like '" + "%" + groupid + "%" + "'";
            if (groupname != "")
                strSql += " And groupname like '" + "%" + groupname + "%" + "'";
            strSql += " Order By groupid";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);


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

        private void UpdateData(HttpContext context, string edit_mode)
        {
            string para = context.Request["param"];
            int groupid = 0;
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            groupid = Convert.ToInt32(ja[0]["groupid"].ToString());
            string strSql = "";
            if (edit_mode == "2")
                strSql = " Delete From t_group Where groupid='" + groupid + "'";
            else
            {
                string groupname = "";
                string cdesc = "";
                groupname = ja[0]["groupname"].ToString().Trim();
                cdesc = ja[0]["cdesc"].ToString().Trim();
                strSql = "Select groupid From t_group Where groupid=' " + groupid + "'";
                DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
                if (dt.Rows.Count == 0)
                    strSql = "Insert Into t_group (groupid,groupname,Description,rst) Values ('" + groupid + "','" + groupname + "','" + cdesc + "','" + "1" + "')";
                else
                    strSql = "Update t_group Set groupname='" + groupname + "',Description='" + cdesc + "'" + " Where groupid='" + groupid + "'";
            }
            
            string result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
                result = "OK";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }
        private void GetGroupFunc(HttpContext context)
        {
            string ReturnValue = string.Empty;
            int groupid = Convert.ToInt32(context.Request["groupid"] != null ? context.Request["groupid"] : "0");
            //string strSql = "Select a.AuthorityID,a.AuthorityName,a.TypeID,c.AuthorityName AS func_name" +
            //    " From t_Authority a " +
            //    " Left Join t_GroupAuthority b On a.AuthorityID=b.AuthorityID" +
            //    " Left Join t_Authority c On a.TypeID=c.AuthorityID" +
            //    " Where a.TypeID<100 And c.TypeID<100 And b.GroupID='" + groupid + "'";
            //strSql += " Order By a.TypeID,a.orderseq,a.AuthorityID";

            string strSql = "usp_sy_GroupFuncs";
            SqlParameter[] parameters = {new SqlParameter("@groupid", groupid)
            };
            DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
        private void UpdateGroupFunc(HttpContext context)
        {
            string para = context.Request["param"];
            string result = "";
            string groupid = "", authorityid = "";
            string strSql = "";
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            for (int i = 0; i < ja.Count; i++)
            {
                groupid = ja[i]["groudid"].ToString();
                authorityid = ja[i]["authorityid"].ToString();
                for (int j = 0; j < 2; j++)//同時要將authorityid 、typeid更新到群
                {
                    strSql = "Select groupid From t_GroupAuthority Where groupid='" + groupid + "' And authorityid='" + authorityid + "'";
                    DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
                    if (dt.Rows.Count == 0)
                        strSql = " Insert Into t_GroupAuthority (groupid,authorityid) Values ('" + groupid + "','" + authorityid + "')";
                    result = sh.ExecuteSqlUpdate(strSql);
                    if (result != "")
                        break;
                    authorityid = ja[i]["typeid"].ToString();
                }
                if (result != "")
                    break;
            }
            if (result == "")
                result = "OK";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }

        private void GetGroupUsers(HttpContext context,string edit_mode)
        {
            string ReturnValue = string.Empty;
            int groupid = Convert.ToInt32(context.Request["groupid"] != null ? context.Request["groupid"] : "0");
            //string strSql = "Select a.AuthorityID,a.AuthorityName,a.TypeID,c.AuthorityName AS func_name" +
            //    " From t_Authority a " +
            //    " Left Join t_GroupAuthority b On a.AuthorityID=b.AuthorityID" +
            //    " Left Join t_Authority c On a.TypeID=c.AuthorityID" +
            //    " Where a.TypeID<100 And c.TypeID<100 And b.GroupID='" + groupid + "'";
            //strSql += " Order By a.TypeID,a.orderseq,a.AuthorityID";
            string cnd = "=";
            string orStr = "";
            if (edit_mode == "loadnogroupusers")
            {
                cnd = "<>";
                orStr = " Or a.t_groupid Is Null";
            }
            string strSql = "Select a.uname,a.uname_desc,b.groupid,b.groupname" +
                " From tb_sy_user a" +
                " Left Join t_group b On a.t_groupid=b.groupid" +
                " Where a.t_groupid" + cnd + "'" + groupid + "'";
            strSql = strSql + orStr;
            strSql += " Order By a.uname";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

        private void UpdateGroupUsers(HttpContext context,string opr_type)
        {
            string para = context.Request["param"];
            string result = "";
            int groupid = 0;
            string uname = "";
            string strSql = "";
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            int jac = ja.Count;
            if (opr_type == "deletegroupusers")
                jac = 1;
            for (int i = 0; i < jac; i++)
            {
                groupid = Convert.ToInt32(ja[i]["groudid"].ToString());
                uname = ja[i]["uname"].ToString();
                strSql = "Update tb_sy_user Set t_groupid='" + groupid + "' Where uname='" + uname + "'";
                result = sh.ExecuteSqlUpdate(strSql);
                if (result != "")
                    break;
            }
            if (result == "")
                result = "OK";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }

    }
}