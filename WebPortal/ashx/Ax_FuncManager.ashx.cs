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
    /// Summary description for Ax_FuncManager
    /// </summary>
    public class Ax_FuncManager : IHttpHandler
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
                case "loadfunclang":
                    LoadFuncLang(context);
                    break;
                case "updatefunclang":
                    UpdateFuncLang(context, edit_mode);
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
            string typeid = "";
            rpt_type = context.Request["rpt_type"] != null ? Convert.ToInt32(context.Request["rpt_type"]) : 0;
            typeid = context.Request["typeid"] != null ? context.Request["typeid"] : "";
            //if (groupid == "" && groupname == "")
            //{
            //    groupid = "ZZZZZZZZZ";
            //    groupname = "ZZZZZZZZZ";
            //}
            string strSql = "Select a.authorityid,a.authorityname,a.typeid,b.authorityname As typecdesc,a.moduleurl,a.weburl,a.description,a.class,a.orderseq" +
                " From t_Authority a" +
                " Left Join t_Authority b On a.typeid=b.authorityid" +
                " Where a.TypeID<100 And b.TypeID<100 ";
            if (typeid != "")
                strSql += " And a.typeid ='" + typeid + "'";
            strSql += " Order By a.typeid,a.orderseq";
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
            int authorityid = 0;
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            authorityid = ja[0]["authorityid"].ToString() != "" ? Convert.ToInt32(ja[0]["authorityid"].ToString()) : 0;
            string strSql = "";
            if (edit_mode == "2")//刪除
                strSql = " Delete From t_Authority Where authorityid='" + authorityid + "'";
            else
            {
                string authorityname = "", orderseq = "00";
                string moduleurl = "", weburl = "", classa = "";
                int typeid = 0;
                authorityname = ja[0]["authorityname"].ToString().Trim();
                typeid = ja[0]["typeid"].ToString() != "" ? Convert.ToInt32(ja[0]["typeid"].ToString()) : 0;
                moduleurl = ja[0]["moduleurl"].ToString().Trim();
                weburl = ja[0]["weburl"].ToString().Trim();
                orderseq = ja[0]["orderseq"].ToString().Trim() != "" ? ja[0]["orderseq"].ToString().Trim() : "00";
                classa = ja[0]["class"].ToString().Trim() != "" ? ja[0]["class"].ToString().Trim() : "";
                strSql = "Select authorityid From t_Authority Where authorityid='" + authorityid + "'";
                DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
                if (dt.Rows.Count == 0)
                {
                    strSql = "Insert Into t_Authority (authorityid,authorityname,typeid,moduleurl,weburl,orderseq,class)" +
                        " Values ('"
                         + authorityid + "','" + authorityname + "','" + typeid + "','" + moduleurl + "','" + weburl
                         + "','" + orderseq + "','" + classa + "')";
                }
                else
                    strSql = "Update t_Authority Set authorityname='" + authorityname + "',typeid='" + typeid + "',moduleurl='" + moduleurl
                         + "',weburl='" + weburl + "',orderseq='" + orderseq + "',class='" + classa + "'"
                         + " Where authorityid='" + authorityid + "'";

            }

            result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
                result = "OK";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }
        private void LoadFuncLang(HttpContext context)
        {

            string ReturnValue = string.Empty;
            int authorityid = 0;
            authorityid = context.Request["authorityid"] != null ? Convert.ToInt32(context.Request["authorityid"]) : 0;
            string strSql = "Select a.authorityid,a.langid,a.authorityname" +
                " From t_AuthorityLang a";
            strSql += " Where a.authorityid ='" + authorityid + "'";
            strSql += " Order By a.authorityid";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);

            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
        private void UpdateFuncLang(HttpContext context, string edit_mode)
        {
            string para = context.Request["param"];
            string result = "";
            int authorityid = 0, langid = 0;
            string authorityname = "";
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            authorityid = ja[0]["authorityid"].ToString() != "" ? Convert.ToInt32(ja[0]["authorityid"].ToString()) : 0;
            langid = ja[0]["langid"].ToString() != "" ? Convert.ToInt32(ja[0]["langid"].ToString()) : 0;
            authorityname = ja[0]["langcdesc"].ToString();
            string strSql = "";
            if (edit_mode == "2")//刪除
                strSql = " Delete From t_AuthorityLang Where authorityid='" + authorityid + "' And langid='" + langid + "'";
            else
            {
                strSql = "Select authorityid From t_AuthorityLang Where authorityid='" + authorityid + "' And langid='" + langid + "'";
                DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
                if (dt.Rows.Count == 0)
                {
                    strSql = "Insert Into t_AuthorityLang (authorityid,langid,authorityname)" +
                        " Values ('"
                         + authorityid + "','" + langid + "','" + authorityname + "')";
                }
                else
                    strSql = "Update t_AuthorityLang Set authorityname='" + authorityname + "'"
                         + " Where authorityid='" + authorityid + "' And langid='" + langid + "'";

            }

            result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
                result = "OK";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }
    }
}