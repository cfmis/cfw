using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using Leyp.SQLServerDAL;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Pd_Mo_Plan
    /// </summary>
    public class Pd_Mo_Plan : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            Query(context);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private void Query(HttpContext context)
        {
            int page = int.Parse(context.Request["page"]);
            int pagesize = int.Parse(context.Request["rows"]);
            string mo_id = context.Request["mo_id"];
            string prd_dep = context.Request["prd_dep"];
            string prd_cdesc = context.Request["prd_cdesc"];
            string now_date= context.Request["now_date"];
            //mo_id = "102";
            bool is_val = false;
            SQLHelp sh = new SQLHelp();
            int frist = pagesize * (page - 1);
            //string strfaca = "select top " + pagesize + " * from student where " + code + " id not in( select top " + frist + " id from student ) ";
            string strSql = "";
            strSql = "Select arrange_id,now_date, prd_dep, prd_mo, prd_item, urgent_status, arrange_machine, arrange_date, arrange_seq, order_qty" +
                    ", order_date, req_time, req_qty, cpl_qty, wait_cpl_qty, prd_cpl_qty, dep_rep_date" +
                    " From product_arrange Where arrange_seq>0 ";
            if (prd_dep != "" && prd_dep != null)
            {
                strSql += " And prd_dep='" + prd_dep + "'";
                is_val = true;
            }
            if (now_date != "" && now_date != null)
            {
                strSql += " And now_date='" + now_date + "'";
                is_val = true;
            }
            if (mo_id != "" && mo_id != null)
            {
                strSql += " And prd_mo='" + mo_id + "'";
                is_val = true;
            }
            if (is_val == false)
                strSql += " And prd_dep=''";
            //strSql += " And arrange_id Not In(select top " + frist + " arrange_id from product_arrange )";
            strSql += " Order By arrange_seq";
            string tablename = "prd_arrange";
            DataSet ds = sh.ExecuteSqlReturnDataSet(strSql, tablename);
            DataTable dt = ds.Tables[0];

            int count = dt.Rows.Count;
            //DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            string strJson =Dataset2Json(ds, count);//DataSet数据转化为Json数据   
            //string strJson = DataTableJson(dt);//DataSet数据转化为Json数据
            context.Response.Write(strJson);
            context.Response.End();
        }



        #region DataSet转换成Json格式  
        /// <summary>  
        /// DataSet转换成Json格式   
        /// </summary>   
        /// <paramname="ds">DataSet</param>  
        ///<returns></returns>   
        private string Dataset2Json(DataSet ds, int total = -1)
        {
            StringBuilder json = new StringBuilder();



            foreach (DataTable dt in ds.Tables)
            {
                //{"total":5,"rows":[  
                json.Append("{\"total\":");
                if (total == -1)
                {
                    json.Append(dt.Rows.Count);
                }
                else
                {
                    json.Append(total);
                }
                json.Append(",\"rows\":[");
                json.Append(DataTable2Json(dt));
                json.Append("]}");
            }
            return json.ToString();
        }
        #endregion


        #region dataTable转换成Json格式  
        /// <summary>   
        /// dataTable转换成Json格式   
        /// </summary>   
        /// <paramname="dt"></param>   
        ///<returns></returns>   
        private string DataTable2Json(DataTable dt)
        {
            StringBuilder jsonBuilder = new StringBuilder();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString());
                    jsonBuilder.Append("\",");
                }
                if (dt.Columns.Count > 0)
                {
                    jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                }
                jsonBuilder.Append("},");
            }
            if (dt.Rows.Count > 0)
            {
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            }

            return jsonBuilder.ToString();
        }
        #endregion


        #region dataTable转换成Json格式  
        /// <summary>       
        /// dataTable转换成Json格式       
        /// </summary>       
        /// <param name="dt"></param>       
        /// <returns></returns>       
        private string DataTableJson(DataTable dt)
        {
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("{\"");
            jsonBuilder.Append(dt.TableName.ToString());
            jsonBuilder.Append("\":[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString());
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }
        #endregion
    }
}