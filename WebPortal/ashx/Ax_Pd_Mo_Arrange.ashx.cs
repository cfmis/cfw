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
    /// Summary description for Ax_Pd_Mo_Arrange
    /// </summary>
    public class Ax_Pd_Mo_Arrange : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private SQLHelp sh = new SQLHelp();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string type = context.Request["paraa"].ToString();
            if (type == "get_plan")
                getPlan(context);
            else if (type == "updateWorker")
                updateWorker(context);
            else if (type == "get_arrange_worker")
                getArrangeWorker(context);
            else if (type == "delete_arrange_worker")
                deleteArrangeWorker(context);
            else if (type == "delete")
                deleteProcess(context);
            else if (type == "getArrangeMoWithPrd")
                getArrangeMoWithPrd(context);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public void getPlan(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            string Prd_dep = "";
            string Arrange_date = "";
            string Prd_mo_from = "", Prd_mo_to = "";
            string Prd_item_from = "";
            string Dep_group = "";
            string strSql = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Prd_dep = ja[0]["Prd_dep"].ToString().Trim();
                Arrange_date = ja[0]["Arrange_date"].ToString().Trim();
                Prd_mo_from = ja[0]["Prd_mo_from"].ToString().Trim();
                Prd_mo_to = ja[0]["Prd_mo_to"].ToString().Trim();
                Prd_item_from = ja[0]["Prd_item_from"].ToString().Trim();
                Dep_group = ja[0]["Dep_group"].ToString().Trim();
            }
            else
            {
                Prd_dep = context.Request["Prd_dep"] != null ? context.Request["Prd_dep"] : "";
                Arrange_date = context.Request["Arrange_date"] != null ? context.Request["Arrange_date"] : "";
                Prd_mo_from = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                Prd_mo_to = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                Prd_item_from = context.Request["Prd_item_from"] != null ? context.Request["Prd_item_from"] : "";
                Dep_group = context.Request["Dep_group"] != null ? context.Request["Dep_group"] : "";
            }
            if (Prd_dep == "" && Arrange_date == "" && Prd_mo_from == "" && Prd_mo_to == "" && Prd_item_from == "" && Dep_group == "")
            {
                Prd_dep = "ZZZ";
                Prd_mo_from = "ZZZZZZZZZ";
                Prd_mo_to = "ZZZZZZZZZ";
                Prd_item_from = "";
            }
            strSql = "Select a.arrange_id,a.now_date, a.prd_dep, a.prd_mo, a.prd_item,b.name AS prd_item_cdesc, a.mo_urgent,c.flag_cdesc" +
                    ", a.arrange_machine, a.arrange_date, a.arrange_seq, a.order_qty" +
                    ", a.order_date, a.req_f_date, a.req_qty, a.cpl_qty, a.arrange_qty, a.prd_cpl_qty, a.dep_rep_date,a.cust_o_date,a.dep_group " +
                    ",dgcf_pad.dbo.fn_getArrangeWorker(a.arrange_id) AS worker_gp,a.pre_prd_dep_date,a.pre_prd_dep_qty " +
                    " From dgcf_pad.dbo.product_arrange a " +
                    " Left Join geo_it_goods b On a.prd_item COLLATE chinese_taiwan_stroke_CI_AS=b.id " +
                    " Left Join bs_flag_desc c On a.mo_urgent COLLATE chinese_taiwan_stroke_CI_AS=c.flag_id " +
                    " Where a.arrange_id>'' And c.doc_type='mo_urgent_status' ";
            if (Prd_dep != "")
                strSql += " And a.prd_dep='" + Prd_dep + "'";
            if (Arrange_date != "")
                strSql += " And a.now_date='" + Arrange_date + "'";
            if (Prd_mo_from != "" && Prd_mo_to != "")
                strSql += " And a.prd_mo>='" + Prd_mo_from + "' And a.prd_mo<='" + Prd_mo_to + "'";
            if (Dep_group != "")
                strSql += " And a.dep_group='" + Dep_group + "'";
            if (Prd_item_from != "")
                strSql += " And a.prd_item Like '" + "%" + Prd_item_from + "%'";
            strSql += " Order By a.prd_dep,a.dep_group,a.arrange_seq,a.arrange_date";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);

            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

        protected void deleteProcess(HttpContext context)
        {
            string result = "";
            BasePage bp = new BasePage();

            string strSql = "";
            strSql += string.Format(@" SET XACT_ABORT  ON ");
            strSql += string.Format(@" BEGIN TRANSACTION ");
            if (context.Request["arrange_id"] != null)//刪除一筆記錄
            {
                string arrange_id = context.Request["arrange_id"];
                strSql += string.Format(@"Delete From dgcf_pad.dbo.product_arrange Where arrange_id='{0}'", arrange_id);
            }
            else//刪除部門當日所有記錄
            {
                string Prd_dep = context.Request["Prd_dep"];
                string Arrange_date = context.Request["Arrange_date"];
                strSql += string.Format(@"Delete From dgcf_pad.dbo.product_arrange Where prd_dep='{0}' And now_date='{1}'", Prd_dep, Arrange_date);
            }
            //strSql += string.Format(@" IF @@error <> 0 ");
            //strSql += string.Format(@" ROLLBACK TRANSACTION ");
            //strSql += string.Format(@" ELSE ");
            strSql += string.Format(@" COMMIT TRANSACTION ");

            result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
                result = "記錄已刪除!";
            //return result;
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }

        protected void updateWorker(HttpContext context)
        {
            string result = "";
            BasePage bp = new BasePage();
            string arrange_id = "";
            string Worker = "";
            string Work_type = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                arrange_id = ja[0]["Arrange_id"].ToString().Trim();
                Worker = ja[0]["Worker"].ToString().Trim();
                Work_type = ja[0]["Work_type"].ToString().Trim();
                Worker = Worker.PadLeft(10, '0');
            }
            if (checkWorker(arrange_id, Worker, Work_type))
            {
                string strSql = "";
                strSql += string.Format(@" SET XACT_ABORT  ON ");
                strSql += string.Format(@" BEGIN TRANSACTION ");
                string crusr = bp.getUserName();
                string crtim = System.DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
                strSql += string.Format(@"Insert Into dgcf_pad.dbo.product_arrange_worker (arrange_id,worker_id,work_type_id,crusr,crtim) Values ('{0}','{1}','{2}','{3}','{4}')"
                    , arrange_id, Worker, Work_type, crusr, crtim);

                strSql += string.Format(@" COMMIT TRANSACTION ");

                result = sh.ExecuteSqlUpdate(strSql);
            }
            if (result == "")
                result = "記錄儲存成功!";
            //return result;
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }
        protected bool checkWorker(string arrange_id,string Worker,string Work_type)
        {
            bool result = false;
            string strSql = "Select arrange_id From dgcf_pad.dbo.product_arrange_worker Where arrange_id='" + arrange_id + "' And worker_id='" + Worker + "' And work_type_id='" + Work_type + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            if (dt.Rows.Count == 0)
                result = true;
            return result;
        }

        protected void getArrangeWorker(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            string ReturnValue = string.Empty;
            string arrange_id = context.Request["arrange_id"] != null ? context.Request["arrange_id"] : "";
            string para = context.Request["param"];
            string strSql = "Select * From dgcf_pad.dbo.product_arrange_worker Where arrange_id='" + arrange_id + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

        protected void deleteArrangeWorker(HttpContext context)
        {
            string result = "";
            BasePage bp = new BasePage();

            string strSql = "";
            strSql += string.Format(@" SET XACT_ABORT  ON ");
            strSql += string.Format(@" BEGIN TRANSACTION ");
            string arrange_id = context.Request["arrange_id"];
            string Worker = context.Request["Worker"];
            string Work_type = context.Request["Work_type"];
            strSql += string.Format(@"Delete From dgcf_pad.dbo.product_arrange_worker Where arrange_id='{0}' And worker_id='{1}' And work_type_id='{2}'"
            , arrange_id, Worker, Work_type);
            //strSql += string.Format(@" IF @@error <> 0 ");
            //strSql += string.Format(@" ROLLBACK TRANSACTION ");
            //strSql += string.Format(@" ELSE ");
            strSql += string.Format(@" COMMIT TRANSACTION ");

            result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
                result = "記錄已刪除!";
            //return result;
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }


        public void getArrangeMoWithPrd(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            string ReturnValue = string.Empty;
            string Prd_dep = "";
            string Arrange_date = "";
            string Prd_mo_from = "", Prd_mo_to = "";
            string Prd_item_from = "";
            string Dep_group = "";
            string strSql = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Prd_dep = ja[0]["Prd_dep"].ToString().Trim();
                Arrange_date = ja[0]["Arrange_date"].ToString().Trim();
                Prd_mo_from = ja[0]["Prd_mo_from"].ToString().Trim();
                Prd_mo_to = ja[0]["Prd_mo_to"].ToString().Trim();
                Prd_item_from = ja[0]["Prd_item_from"].ToString().Trim();
                Dep_group = ja[0]["Dep_group"].ToString().Trim();
            }
            if (Prd_dep == "" && Arrange_date == "" && Prd_mo_from == "" && Prd_mo_to == "" && Prd_item_from == "" && Dep_group == "")
            {
                Prd_dep = "ZZZ";
                Prd_mo_from = "ZZZZZZZZZ";
                Prd_mo_to = "ZZZZZZZZZ";
                Prd_item_from = "";
            }
            strSql = "Select a.arrange_id,a.now_date, a.prd_dep, a.prd_mo, a.prd_item,b.name AS prd_item_cdesc, a.mo_urgent,c.flag_cdesc" +
                    ", a.arrange_machine, a.arrange_date, a.arrange_seq, a.order_qty" +
                    ", a.order_date, a.req_f_date, a.req_qty, a.cpl_qty, a.arrange_qty, a.prd_cpl_qty, a.dep_rep_date,a.cust_o_date,a.dep_group " +
                    ",dgcf_pad.dbo.fn_getArrangeWorker(a.arrange_id) AS worker_gp,a.pre_prd_dep_date,a.pre_prd_dep_qty " +
                    ",d.prd_date,d.prd_qty,d.prd_worker,e.work_type_desc,d.prd_start_time,d.prd_end_time" +
                    " From dgcf_pad.dbo.product_arrange a " +
                    " Left Join geo_it_goods b On a.prd_item COLLATE chinese_taiwan_stroke_CI_AS=b.id " +
                    " Left Join bs_flag_desc c On a.mo_urgent COLLATE chinese_taiwan_stroke_CI_AS=c.flag_id " +
                    " Left Join dgcf_pad.dbo.product_records d On a.prd_dep=d.prd_dep And a.prd_mo=d.prd_mo And a.prd_item=d.prd_item" +
                    " Left Join dgcf_pad.dbo.work_type e On d.prd_work_type=e.work_type_id" +
                    " Where a.arrange_seq>0 And c.doc_type='mo_urgent_status' ";
            if (Prd_dep != "")
                strSql += " And a.prd_dep='" + Prd_dep + "'";
            if (Arrange_date != "")
                strSql += " And a.now_date='" + Arrange_date + "'";
            if (Prd_mo_from != "" && Prd_mo_to != "")
                strSql += " And a.prd_mo>='" + Prd_mo_from + "' And a.prd_mo<='" + Prd_mo_to + "'";
            if (Dep_group != "")
                strSql += " And a.dep_group='" + Dep_group + "'";
            if (Prd_item_from != "")
                strSql += " And a.prd_item Like '" + "%" + Prd_item_from + "%'";
            strSql += " Order By a.prd_dep,a.dep_group,a.arrange_seq,a.arrange_date";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);

            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }


    }
}