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
    /// Summary description for Ax_Bs_Mat_Rate
    /// </summary>
    public class Ax_Bs_Mat_Rate : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private SQLHelp sh = new SQLHelp();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string type = context.Request["paraa"].ToString();
            if (type == "update")
                updateProcess(context);
            else if (type == "get_prd_item")
                GetPrdItem(context);
            else if (type == "delete")
                deleteProcess(context);
            //else if (type == "get_exist_record")
            //    deleteProcess(context);
            else
                GetItem(context);
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
            string Dep_id = "";
            string Mat_item = "";
            string Prd_item = "";
            string para = context.Request["param"];
            string parab = context.Request["parab"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Dep_id = ja[0]["Dep_id"].ToString().Trim();
                Prd_item = ja[0]["Prd_item"].ToString().Trim();
                Mat_item = ja[0]["Mat_item"].ToString().Trim();
            }
            else
            {
                Dep_id = context.Request["Dep_id"] != null ? context.Request["Dep_id"] : "";
                Prd_item = context.Request["Prd_item"] != null ? context.Request["Prd_item"] : "";
                Mat_item = context.Request["Mat_item"] != null ? context.Request["Mat_item"] : "";
            }
            if (Dep_id == "" && Prd_item == "" && Mat_item == "")
            {
                Dep_id = "J99";
                Prd_item = "";
                Mat_item = "";
            }
            string strSql = "Select a.*,b.name AS prd_item_cdesc,c.name AS mat_item_cdesc" +
                " From bs_mat_rate a " +
                " Left Join geo_it_goods b ON a.prd_item=b.id" +
                " Left Join geo_it_goods c ON a.mat_item=c.id" +
                " Where a.prd_item>=''";
            if (Dep_id != "")
                strSql += " And a.dep_id = '" + Dep_id + "'";
            if (Prd_item != "")
                strSql += " And a.Prd_item Like '" + "%" + Prd_item + "%" + "'";
            if (Mat_item != "")
                strSql += " And a.mat_item Like '" + "%" + Mat_item + "%" + "'";
            strSql += " Order By a.dep_id,a.prd_item,a.mat_item";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            if (parab == "list")
                ReturnValue = cls.DataTableJsonReturnExcel(dt);
            else
                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

        protected void updateProcess(HttpContext context)
        {
            BasePage bp = new BasePage();
            string para = context.Request["param"];
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            string result = "";
            string Prd_item = ja[0]["Prd_item"].ToString().Trim();
            string Dep_id = ja[0]["Dep_id"].ToString().Trim();
            string Mat_item = ja[0]["Mat_item"].ToString().Trim();
            decimal Prd_weg = ja[0]["Prd_weg"].ToString().Trim() != "" ? Convert.ToDecimal(ja[0]["Prd_weg"].ToString().Trim()) : 0;
            decimal Waste_weg = ja[0]["Waste_weg"].ToString().Trim() != "" ? Convert.ToDecimal(ja[0]["Waste_weg"].ToString().Trim()) : 0;
            decimal Use_weg = ja[0]["Use_weg"].ToString().Trim() != "" ? Convert.ToDecimal(ja[0]["Use_weg"].ToString().Trim()) : 0;
            decimal Hour_std_qty = ja[0]["Hour_std_qty"].ToString().Trim() != "" ? Convert.ToDecimal(ja[0]["Hour_std_qty"].ToString().Trim()) : 0;
            decimal Kg_qty_rate = ja[0]["Kg_qty_rate"].ToString().Trim() != "" ? Convert.ToDecimal(ja[0]["Kg_qty_rate"].ToString().Trim()) : 0;
            string crusr = bp.getUserName();
            string crtim = System.DateTime.Now.ToString("yyyy/MM/dd HH:ss:mm");
            string strSql = "";
            strSql += string.Format(@" SET XACT_ABORT  ON ");
            strSql += string.Format(@" BEGIN TRANSACTION ");
            DataTable dtPrdItem = CehckPrdItem(Prd_item,Mat_item, Dep_id);
            if (dtPrdItem.Rows.Count == 0)
                strSql += string.Format(@"Insert Into bs_mat_rate (Prd_item,Mat_item,Dep_id,Prd_weg,Waste_weg,Use_weg,Hour_std_qty,Kg_qty_rate,crusr,crtim) Values " +
                "('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}')"
                , Prd_item, Mat_item, Dep_id, Prd_weg, Waste_weg, Use_weg, Hour_std_qty, Kg_qty_rate, crusr, crtim);
            else
            {
                strSql += string.Format(@"Update bs_mat_rate Set Prd_weg='{0}',Waste_weg='{1}',Use_weg='{2}',Hour_std_qty='{3}'" +
                    ",Kg_qty_rate='{4}',crusr='{5}',crtim='{6}'" +
                    " Where Prd_item='{7}' And Mat_item='{8}' And Dep_id='{9}'"
                    , Prd_weg, Waste_weg, Use_weg, Hour_std_qty, Kg_qty_rate, crusr, crtim, Prd_item, Mat_item, Dep_id);
            }
            //strSql += string.Format(@" IF @@error <> 0 ");
            //strSql += string.Format(@" ROLLBACK TRANSACTION ");
            //strSql += string.Format(@" ELSE ");
            strSql += string.Format(@" COMMIT TRANSACTION ");

            result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
                result = "記錄更新成功!";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }


        protected void deleteProcess(HttpContext context)
        {
            string result = "";
            string Dep_id = context.Request["Dep_id"] != null ? context.Request["Dep_id"] : "";
            string Prd_item = context.Request["Prd_item"] != null ? context.Request["Prd_item"] : "";
            string Mat_item = context.Request["Mat_item"] != null ? context.Request["Mat_item"] : "";
            string strSql = "Delete From bs_mat_rate Where dep_id='" + Dep_id + "' And Prd_item='" + Prd_item + "' And Mat_item='" + Mat_item + "'";
            result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
                result = "刪除記錄成功!";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }

        protected DataTable CehckPrdItem(string Prd_item,string Mat_item,string Dep_id)
        {
            string strSql = "";
            strSql = "Select Prd_item From bs_mat_rate Where Prd_item='" + Prd_item + "' And Mat_item='" + Mat_item + "' And Dep_id='" + Dep_id + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }
        public void GetPrdItem(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            string ReturnValue = string.Empty;
            string Prd_item = context.Request["Prd_item"] != null ? context.Request["Prd_item"] : "";
            string strSql = "Select id,name As goods_name From geo_it_goods Where id='" + Prd_item + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

    }
}