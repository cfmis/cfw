using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using Leyp.SQLServerDAL;
using Leyp.Components.Module;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Sa_Mo_Plan_Details
    /// </summary>
    public class Sa_Mo_Plan_Details : IHttpHandler
    {
        SQLHelp sh = new SQLHelp();
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

        private string[] getUrlPara(string para)
        {
            string para_str = para;
            string[] str=new string[3];
            int len_str = para_str.Length;
            int start_str, end_str;

            for (int i = 0; i < 3; i++)
            {
                start_str = para_str.IndexOf("=");
                end_str = para_str.IndexOf("&");
                string str1 = "";
                if (start_str != -1 && end_str != -1)
                {
                    str[i] = para_str.Substring(start_str+1,end_str-start_str-1);
                    str1 = str[i];
                    para_str = para_str.Substring(end_str+1, (len_str - end_str)-1);
                    len_str = para_str.Length;
                }
                else
                {
                    if (start_str != -1 && end_str == -1)
                    {
                        str[i] = para_str.Substring(start_str + 1,len_str-start_str-1);
                        str1 = str[i];
                    }
                }
            }

            return str;
        }
        private void Query(HttpContext context)
        {
            string tb_type = context.Request["tb_type"];
            string arrange_id = "";
            //string prd_dep = context.Request["prd_dep"];
            //string prd_mo = context.Request["prd_mo"];
            //string prd_item = context.Request["prd_item"];
            //string now_date = context.Request["now_date"];
            string upd_type = "0";
            //if(prd_dep==null)
            //{
                HttpRequest request = System.Web.HttpContext.Current.Request;

                Uri Project_Id = request.UrlReferrer;
                string a1 = Project_Id.Query.ToString();
                string[] urlPara = getUrlPara(a1);
                //prd_dep = urlPara[0];
                //prd_mo = urlPara[1];
                //prd_item = urlPara[2];
                //now_date = urlPara[3];
                arrange_id = urlPara[2];
            //}
            bool is_val = false;
            //SQLHelp sh = new SQLHelp();
            string strSql = "";
            string msg = "";
            string tablename = "";
            if (tb_type == "hrm01")
            {
                //strSql = "Select a.hrm1wid,a.hrm1name,c.hrc5name,b.hrc4name" +
                //    " From dgsql1.dghr.dbo.hrm01 a" +
                //    " Inner Join dgsql1.dghr.dbo.hrc04 b On a.hrm1stat2=b.hrc4class" +
                //    " Left Join dgsql1.dghr.dbo.hrc05 c On a.hrm1job=c.hrc5job" +
                //    " Where a.hrm1state='1'";
                //if (prd_dep != "" && prd_dep != null)
                //{
                //    strSql += " And b.wip_dep='" + prd_dep + "'";
                //    is_val = true;
                //}

                //if (is_val == false)
                //    strSql += " And a.hrm1stat2=''";
                //strSql += " Order By a.hrm1job,a.hrm1wid";
                //tablename = "hrm01";
            }
            else
            {
                if (tb_type == "prd01")
                {
                    strSql = "Select b.worker_id,c.hrm1name,b.work_type_id,d.work_type_desc" +
                        " From dgcf_pad.dbo.product_arrange a" +
                        " Inner Join dgcf_pad.dbo.product_arrange_worker b On a.arrange_id=b.arrange_id" +
                        " Left Join dgsql1.dghr.dbo.hrm01 c On b.worker_id COLLATE chinese_taiwan_stroke_CI_AS=c.hrm1wid" +
                        " Left Join dgcf_pad.dbo.work_type d On b.work_type_id=d.work_type_id " +
                        " Where a.arrange_id='" + arrange_id + "'";

                    tablename = "prd01";
                }
                else
                {
                    upd_type = "1";
                    string worker_id = context.Request["worker_id"];
                    string work_type_id = context.Request["work_type_id"].Trim();
                    if (tb_type == "upd_prd01")
                    {

                        BasePage bp = new BasePage();
                        string user_id = "admin";// bp.getUserName();
                        string crtim = System.DateTime.Now.ToString("yyyy/MM/dd HH:SS");
                        worker_id = worker_id.Trim().PadLeft(10, '0');
                        if (chkWorker(arrange_id, worker_id, work_type_id) == 0)
                            strSql = "Insert Into dgcf_pad.dbo.product_arrange_worker (arrange_id,worker_id,work_type_id,crusr)" +
                                " Values (" + "'" + arrange_id + "','" + worker_id + "','"+ work_type_id + "','" + user_id + "')";// + "','" + crtim,crtim
                        string result = sh.ExecuteSqlUpdate(strSql);
                        if (result == "")
                            msg = "添加工號成功!";
                        else
                            msg = "添加工號失敗!";
                    }
                    else
                    {
                        if (tb_type == "delete_prd01")
                        {
                            strSql = "Delete From dgcf_pad.dbo.product_arrange_worker Where arrange_id='" + arrange_id + "' And worker_id='" + worker_id + "' And work_type_id='" + work_type_id + "'";
                            string result = sh.ExecuteSqlUpdate(strSql);
                            if (result == "")
                                msg = "刪除工號成功!";
                            else
                                msg = "刪除工號失敗!";
                        }
                    }
                }
            }
            if (upd_type == "0")
            {
                DataSet ds = sh.ExecuteSqlReturnDataSet(strSql, tablename);
                DataTable dt = ds.Tables[0];

                int count = dt.Rows.Count;
                //DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
                string strJson = Dataset2Json(ds, count);//DataSet数据转化为Json数据   
                                                         //string strJson = DataTableJson(dt);//DataSet数据转化为Json数据
                context.Response.Write(strJson);
            }
            else
            {

                context.Response.Write(msg);
            }
            context.Response.End();
        }
        private int chkWorker(string arrange_id,string worker_id,string work_type_id)
        {
            string strSql = " Select worker_id From dgcf_pad.dbo.product_arrange_worker Where arrange_id='" + arrange_id + "' And worker_id='" + worker_id + "' And work_type_id='" + work_type_id + "'";
            return sh.ExecuteSqlReturnDataTable(strSql).Rows.Count;
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