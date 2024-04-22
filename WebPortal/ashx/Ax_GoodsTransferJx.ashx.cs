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
    /// Summary description for Ax_GoodsTransferJx
    /// </summary>
    public class Ax_GoodsTransferJx : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private SQLHelp sh = new SQLHelp();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string type = context.Request["paraa"].ToString();
            if (type == "get_transfer")
                GetItem(context);
            else if (type == "get_transfer_details")
                GetItemDetails(context);
            else
                SetCplFlag(context);
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
            string Prd_dep = "";
            string Mo_group = "";
            string Prd_mo_from = "", Prd_mo_to = "";
            string Prd_item_from = "";
            string Not_cpl_flag = "";
            string Cpl_flag = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Prd_dep = ja[0]["Prd_dep"].ToString().Trim();
                Mo_group = ja[0]["Mo_group"].ToString().Trim();
                Prd_mo_from = ja[0]["Prd_mo_from"].ToString().Trim();
                Prd_mo_to = ja[0]["Prd_mo_to"].ToString().Trim();
                Prd_item_from = ja[0]["Prd_item_from"].ToString().Trim();
                Cpl_flag= ja[0]["Cpl_flag"].ToString().Trim();
                Not_cpl_flag = ja[0]["Not_cpl_flag"].ToString().Trim();
            }
            else
            {
                Prd_dep = context.Request["Prd_dep"] != null ? context.Request["Prd_dep"] : "";
                Mo_group = context.Request["Mo_group"] != null ? context.Request["Mo_group"] : "";
                Prd_mo_from = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                Prd_mo_to = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                Prd_item_from = context.Request["Prd_item_from"] != null ? context.Request["Prd_item_from"] : "";
                Not_cpl_flag = context.Request["Not_cpl_flag"] != null ? context.Request["Not_cpl_flag"] : "";
                Cpl_flag = context.Request["Cpl_flag"] != null ? context.Request["Cpl_flag"] : "";
            }
            //if (Prd_dep == "" && Prd_mo_from == "" && Prd_mo_to == "" && Prd_item_from == "")
            //{

            //}
            //else
            //{
                string strSql = "Select a.prd_dep,a.prd_mo,a.prd_item,b.name AS prd_item_cdesc,(a.out_qty - a.in_qty) AS qty,(a.out_weg - a.in_weg) AS weg" +
                    ",a.out_date,a.in_date,a.cpl_flag" +
                    " FROM dgcf_pad.dbo.product_transfer_jx_summary a" +
                    " LEFT JOIN geo_it_goods b ON a.prd_item=b.id COLLATE chinese_taiwan_stroke_CI_AS" +
                    " WHERE a.prd_dep>=''";
                if (Prd_dep != "")
                    strSql += " AND a.prd_dep='" + Prd_dep + "'";
                if (Mo_group != "")
                    strSql += " AND Substring(a.prd_mo,3,1)='" + Mo_group + "'";
                if (Prd_mo_from != "" && Prd_mo_to != "")
                    strSql += " AND a.prd_mo>='" + Prd_mo_from + "' AND a.prd_mo<='" + Prd_mo_to + "'";
                if (Prd_item_from != "")
                    strSql += " AND a.prd_item Like '" + "%" + Prd_item_from + "%" + "'";
                if (Not_cpl_flag == "1")
                    strSql += " AND ((a.out_qty - a.in_qty ) <> 0 OR (a.out_weg - a.in_weg <> 0 ))";
                if (Cpl_flag == "1")
                    strSql += " AND a.Cpl_flag<>'" + Cpl_flag + "'";
                strSql += " ORDER BY a.prd_dep,a.prd_item,a.prd_mo";
                DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);


                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
        public void SetCplFlag(HttpContext context)
        {
            SQLHelp sh = new SQLHelp();
            string Prd_dep = context.Request["prd_dep"].ToString();
            string Prd_mo = context.Request["prd_mo"].ToString();
            string Prd_item = context.Request["prd_item"].ToString();
            string Cpl_flag = context.Request["cpl_flag"].ToString();
            if (Cpl_flag == "1")
                Cpl_flag = "";
            else
                Cpl_flag = "1";
            string strSql = "Update dgcf_pad.dbo.product_transfer_jx_summary Set Cpl_flag='" + Cpl_flag + "'" +
                " Where Prd_dep='" + Prd_dep + "' And Prd_mo='" + Prd_mo + "' And Prd_item='" + Prd_item + "'";
            string result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
                result = "記錄更新成功!";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }


        public void GetItemDetails(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            string Prd_dep = "";
            string Mo_group = "";
            string Prd_mo_from = "", Prd_mo_to = "";
            string Prd_item_from = "";
            string Date_from = "", Date_to = "";
            string Transfer_flag = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Prd_dep = ja[0]["Prd_dep"].ToString().Trim();
                Prd_mo_from = ja[0]["Prd_mo_from"].ToString().Trim();
                Prd_mo_to = ja[0]["Prd_mo_to"].ToString().Trim();
                Mo_group = ja[0]["Mo_group"].ToString().Trim();
                Prd_item_from = ja[0]["Prd_item_from"].ToString().Trim();
                Date_from = ja[0]["Date_from"].ToString().Trim();
                Date_to = ja[0]["Date_to"].ToString().Trim();
                Transfer_flag = ja[0]["Transfer_flag"].ToString().Trim();
            }
            else
            {
                Prd_dep = context.Request["Prd_dep"] != null ? context.Request["Prd_dep"] : "";
                Prd_mo_from = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                Prd_mo_to = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                Mo_group = context.Request["Mo_group"] != null ? context.Request["Mo_group"] : "";
                Prd_item_from = context.Request["Prd_item_from"] != null ? context.Request["Prd_item_from"] : "";
                Date_from = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                Date_to = context.Request["Date_to"] != null ? context.Request["Date_to"] : "";
                Transfer_flag = context.Request["Transfer_flag"] != null ? context.Request["Transfer_flag"] : "";
            }
            if (Prd_dep == "" && Prd_mo_from == "" && Prd_mo_to == "" && Prd_item_from == "" && Date_from == "" & Date_to == "")
            {

            }
            else
            {

                string strSql = "Select a.prd_dep,d.dep_cdesc AS prd_dep_cdesc,a.prd_mo,a.prd_item,b.name AS prd_item_cdesc" +
                    ",a.transfer_qty,a.transfer_weg,a.wip_id" +
                    ",a.transfer_date,c.flag_desc,a.to_dep,e.dep_cdesc AS to_dep_cdesc ";
                if (Transfer_flag.Trim() == "1")
                    strSql += " FROM lnsql1.dgcf_pad.dbo.product_transfer_jx_details a";
                else
                    strSql += " FROM dgcf_pad.dbo.product_transfer_jx_details a";
                strSql +=" LEFT JOIN geo_it_goods b ON a.prd_item=b.id COLLATE chinese_taiwan_stroke_CI_AS" +
                    " LEFT JOIN bs_flag_desc c ON a.transfer_flag=c.flag_id COLLATE chinese_taiwan_stroke_CI_AS" +
                    " LEFT JOIN bs_dep d ON a.wip_id=d.dep_id COLLATE chinese_taiwan_stroke_CI_AS" +
                    " LEFT JOIN bs_dep e ON a.to_dep=e.dep_id COLLATE chinese_taiwan_stroke_CI_AS" +
                    " WHERE c.doc_type='goods_transfer_jx'";
                if (Prd_dep != "")
                    strSql += " AND a.wip_id='" + Prd_dep + "'";
                if (Mo_group != "")
                    strSql += " AND Substring(a.prd_mo,3,1)='" + Mo_group + "'";
                if (Prd_mo_from != "" && Prd_mo_to != "")
                    strSql += " AND a.prd_mo>='" + Prd_mo_from + "' AND a.prd_mo<='" + Prd_mo_to + "'";
                if (Prd_item_from != "")
                    strSql += " AND a.prd_item Like '" + "%" + Prd_item_from + "%" + "'";
                if (Date_from != "" && Date_to != "")
                    strSql += " AND a.Transfer_date>='" + Date_from + "' AND a.Transfer_date<='" + Date_to + "'";
                //if (Transfer_flag.Trim() == "0" || Transfer_flag.Trim() == "1")
                strSql += " AND a.Transfer_flag='" + "0" + "'";
                strSql += " ORDER BY a.wip_id,a.Transfer_flag,a.transfer_date,a.prd_item,a.prd_mo";
                DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);


                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

    }
}