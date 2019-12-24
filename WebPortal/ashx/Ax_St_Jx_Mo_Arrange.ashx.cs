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
    /// Summary description for Ax_St_Jx_Mo_Arrange
    /// </summary>
    public class Ax_St_Jx_Mo_Arrange : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private SQLHelp sh = new SQLHelp();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string type = context.Request["paraa"].ToString();
            if (type == "get_plan")
                GetPlan(context);
            else if (type == "delete")
                deleteProcess(context);

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        public void GetPlan(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            string Prd_dep = "";
            string Now_date = "";
            string Prd_mo_from = "", Prd_mo_to = "";
            string Prd_item_from = "";
            string Mat_item_from = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Prd_dep = ja[0]["Prd_dep"].ToString().Trim();
                Now_date = ja[0]["Now_date"].ToString().Trim();
                Prd_mo_from = ja[0]["Prd_mo_from"].ToString().Trim();
                Prd_mo_to = ja[0]["Prd_mo_to"].ToString().Trim();
                Prd_item_from = ja[0]["Prd_item_from"].ToString().Trim();
                Mat_item_from = ja[0]["Mat_item_from"].ToString().Trim();
            }
            else
            {
                Prd_dep = context.Request["Prd_dep"] != null ? context.Request["Prd_dep"] : "";
                Now_date = context.Request["Now_date"] != null ? context.Request["Now_date"] : "";
                Prd_mo_from = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                Prd_mo_to = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                Prd_item_from = context.Request["Prd_item_from"] != null ? context.Request["Prd_item_from"] : "";
                Mat_item_from = context.Request["Mat_item_from"] != null ? context.Request["Mat_item_from"] : "";
            }
            if (Prd_dep == "" && Now_date == "" && Prd_mo_from == "" && Prd_mo_to == "" && Prd_item_from == "" && Mat_item_from == "")
            {
                Prd_dep = "ZZZ";
                Prd_mo_from = "ZZZZZZZZZ";
                Prd_mo_to = "ZZZZZZZZZ";
                Prd_item_from = "";
            }
            string strSql = "Select a.prd_seq,a.receive_date,a.prd_mo,a.prd_item,a.arrange_machine"+
                ",a.prd_worker,a.delivery_date,a.arrange_qty,a.cpl_qty,a.not_cpl_qty,a.mat_item,a.arrange_id,a.prd_dep" +
                ",a.arrange_date,a.now_date,a.wp_id"+
                ",b.name As prd_item_cdesc" +
                ",d.mat_item AS mat_item1,c.name As mat_item_cdesc,d.kg_qty_rate,Convert(float,d.kg_qty_rate) AS not_cpl_weg " +
                " From product_arrange_jx a" +
                " Left Join geo_it_goods b On a.prd_item=b.id" +
                " Left Join bs_mat_rate d On a.prd_item=d.prd_item And a.wp_id=d.dep_id" +
                " Left Join geo_it_goods c On d.mat_item=c.id" +
                " Where a.arrange_id>=''";
            if (Prd_dep != "")
                strSql += " And a.prd_dep='" + Prd_dep + "'";
            if (Now_date != "")
                strSql += " And a.now_date='" + Now_date + "'";
            if (Prd_mo_from != "" && Prd_mo_to != "")
                strSql += " And a.prd_mo>='" + Prd_mo_from + "' And a.prd_mo<='" + Prd_mo_to + "'";
            if (Prd_item_from != "")
                strSql += " And a.prd_item Like " + "'%" + Prd_item_from + "%'";
            if (Mat_item_from != "")
                strSql += " And d.mat_item Like " + "'%" + Mat_item_from + "%'";
            strSql += " Order By a.prd_dep,a.arrange_seq";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow dr = dt.Rows[i];
                double kg_qty_rate = dr["kg_qty_rate"].ToString() != "" ? Convert.ToInt32(dr["kg_qty_rate"]) : 0;
                dr["not_cpl_weg"] = kg_qty_rate != 0 ? Math.Round(Convert.ToDouble(dr["not_cpl_qty"]) / Convert.ToDouble(dr["kg_qty_rate"]), 2) : 0;
            }
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
                strSql += string.Format(@"Delete From product_arrange_jx Where arrange_id='{0}'", arrange_id);
            }
            else//刪除部門當日所有記錄
            {
                string Prd_dep = context.Request["Prd_dep"];
                string Arrange_date = context.Request["Arrange_date"];
                strSql += string.Format(@"Delete From product_arrange_jx Where prd_dep='{0}' And Now_date='{1}'", Prd_dep, Arrange_date);
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


    }
}