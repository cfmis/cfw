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
    /// Summary description for Ax_Mo_LoadSpecificColorProduct
    /// </summary>
    public class Ax_Mo_LoadSpecificColorProduct : IHttpHandler, System.Web.SessionState.IRequiresSessionState//: IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
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
            string remote_db = DBUtility.remote_db;
            string within_code = DBUtility.within_code;
            string ReturnValue = string.Empty;
            string Date_from = "", Date_to = "", Date_to1 = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Date_from = ja[0]["Date_from"].ToString().Trim();
                Date_to = ja[0]["Date_to"].ToString().Trim();
             }
            else
            {
                Date_from = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                Date_to = context.Request["Date_to"] != null ? context.Request["Date_to"] : "";
            }
            if (Date_from == "" && Date_to == "")
            {
                Date_from = "1900/01/01";
                Date_to = "1900/01/01";
            }
            else
            {
                Date_to1 = Convert.ToDateTime(Date_to).AddDays(1).ToString("yyyy/MM/dd");
            }
            string strSql1 = "", strFrom = "", strSql = "", strWh = "";

            strSql1 = "SELECT a.id, Convert(Varchar(20),a.con_date,111) AS dat,b.jo_sequence_id,b.mo_id, b.goods_id,c.name AS goods_cname"+
                ",Convert(numeric(20,0),b.con_qty) AS con_qty,Convert(numeric(20,2),b.sec_qty) AS sec_qty,c.do_color AS do_color, c.color, a.out_dept ";
            strSql += strSql1 + " INTO #tb_prd ";
            strFrom+=" FROM " + remote_db + "jo_materiel_con_mostly a " +
                " INNER JOIN " + remote_db + "jo_materiel_con_details b ON a.within_code = b.within_code AND a.id = b.id" +
                " INNER JOIN " + remote_db + "it_goods c ON b.within_code = c.within_code AND b.goods_id = c.id" +
                " INNER JOIN " + remote_db + "z_inm08b z ON c.within_code = z.within_code AND c.color = z.inm8loc" +
                " WHERE a.within_code = '" + within_code + "'" +
                " AND z.inm8item = '20200326'";
            strSql += strFrom;
            strSql += " AND a.out_dept = '108'";
            strWh = " AND a.con_date >= '" + Date_from + "' AND a.con_date < '" + Date_to1 + "'";
            strSql += strWh;
            strSql += " UNION ";
            strSql += strSql1;
            strSql += strFrom;
            strSql +=" AND a.out_dept = '128'";
            strSql += strWh;
            strSql += " SELECT * FROM #tb_prd ORDER BY color,goods_id,dat,mo_id";
            strSql += " DROP TABLE #tb_prd";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);


            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
    }
}