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
using System.Web.Script.Serialization;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_SetOutsideProducePrice
    /// </summary>
    public class Ax_SetOutsideProducePrice : IHttpHandler, System.Web.SessionState.IRequiresSessionState//: IHttpHandler
    {
        private string remote_db = DBUtility.remote_db;
        private string within_code = DBUtility.within_code;
        private SQLHelp sh = new SQLHelp();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string type = context.Request["paraa"].ToString();
            if (type == "update")
                UpdateProcess(context);
            else if (type == "find")
                FindData(context);
            else//type="select" or "amount" //明細表或金額表
                GetItem(context,type);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        private void GetItem(HttpContext context,string type)
        {
            clsPublic cls = new clsPublic();
            //BasePage bp = new BasePage();
            
            string ReturnValue = string.Empty;
            int show_details = 0;//顯示明細表記錄  1--匯總表記錄
            int show_price = 0;
            string rpt_type = "";
            string date_from = "", date_to = "", date_to1 = "";
            string dep = "";
            string vend_id = "";
            string id_from = "", id_to = "";
            string prd_item = "";
            string mo_from = "", mo_to = "";
            string order_date_from = "", order_date_to = "", order_date_to1 = "";
            string color_id = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                date_from = ja[0]["date_from"].ToString().Trim();
                date_to = ja[0]["date_to"].ToString().Trim();
                dep= ja[0]["dep"].ToString().Trim();
                id_from= ja[0]["id_from"].ToString().Trim();
                id_to= ja[0]["id_to"].ToString().Trim();
                mo_from= ja[0]["mo_from"].ToString().Trim();
                mo_to= ja[0]["mo_to"].ToString().Trim();
                vend_id= ja[0]["vend_id"].ToString().Trim();
                show_price= ja[0]["price_status"] != null ? Convert.ToInt32(ja[0]["price_status"]) : 0;
                rpt_type= ja[0]["rpt_type"].ToString().Trim();
                prd_item = ja[0]["prd_item"].ToString().Trim();
                order_date_from = ja[0]["order_date_from"].ToString().Trim();
                order_date_to = ja[0]["order_date_to"].ToString().Trim();
                color_id = ja[0]["color_id"].ToString().Trim();
            }
            else
            {
                date_from = context.Request["date_from"] != null ? context.Request["date_from"] : "";
                date_to = context.Request["date_to"] != null ? context.Request["date_to"] : "";
                dep = context.Request["dep"] != null ? context.Request["dep"] : "";
                id_from = context.Request["id_from"] != null ? context.Request["id_from"] : "";
                id_to = context.Request["id_to"] != null ? context.Request["id_to"] : "";
                mo_from = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
                mo_to = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
                vend_id = context.Request["vend_id"] != null ? context.Request["vend_id"] : "";
                show_price = context.Request["price_status"] != null ? Convert.ToInt32(context.Request["price_status"]) : 0;
                rpt_type = context.Request["rpt_type"] != null ? context.Request["rpt_type"] : "";
                prd_item = context.Request["prd_item"] != null ? context.Request["prd_item"] : "";
                order_date_from = context.Request["order_date_from"] != null ? context.Request["order_date_from"] : "";
                order_date_to = context.Request["order_date_to"] != null ? context.Request["order_date_to"] : "";
                color_id = context.Request["color_id"] != null ? context.Request["color_id"] : "";
            }
            if (rpt_type == "True")
                show_details = 1;
            if (type == "amount")
                show_details = 2;
            if (date_from == "" && date_to == ""&&id_from==""&&id_to==""&&mo_from==""&&mo_to==""&&prd_item==""&&order_date_from==""&&order_date_to==""&&color_id=="")
            {
                date_from = "1900/01/01";
                date_to = "1900/01/01";
                mo_from = "ZZZZZZZZZ";
                mo_to = "ZZZZZZZZZ";
            }
            if (date_from != "" && date_to != "")
            {
                date_to1 = Convert.ToDateTime(date_to).AddDays(1).ToString("yyyy/MM/dd");
            }
            if (order_date_from != "" && order_date_to != "")
            {
                order_date_to1 = Convert.ToDateTime(order_date_to).AddDays(1).ToString("yyyy/MM/dd");
            }
            string sqlstr = "pu_DeliverSetPrice_find";
            SqlParameter[] parameters = {new SqlParameter("@show_details", show_details),new SqlParameter("@show_price", show_price)
                                            ,new SqlParameter("@dep", dep),new SqlParameter("@vend_id", vend_id),new SqlParameter("@prd_item", prd_item)
                                            , new SqlParameter("@doc_id1", id_from), new SqlParameter("@doc_id2", id_to)
                                            ,new SqlParameter("@color_id", color_id)
                                        ,new SqlParameter("@date1", date_from),new SqlParameter("@date2", date_to1)
                                        , new SqlParameter("@mo_from", mo_from), new SqlParameter("@mo_to", mo_to)
                                        ,new SqlParameter("@order_date_from", order_date_from),new SqlParameter("@order_date_to", order_date_to1)
            };
            DataTable dt = sh.ExecuteProcedure(sqlstr, parameters);
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
        public void UpdateProcess(HttpContext context)
        {
            string strSql = "";
            string ReturnValue = string.Empty;
            string updated = context.Request["updated"];
            JArray ja = (JArray)JsonConvert.DeserializeObject(updated);

            for (int i = 0; i < ja.Count; i++)
            {
                string id = "";
                string sequence_id = "";
                double price, sec_price, mould_fee, former_free, qty, weg;
                string remark = "";
                id = ja[i]["id"].ToString().Trim();
                sequence_id = ja[i]["sequence_id"].ToString().Trim();
                price = ja[i]["price"].ToString() != "" ? Convert.ToDouble(ja[i]["price"]) : 0;
                sec_price = ja[i]["sec_price"].ToString() != "" ? Convert.ToDouble(ja[i]["sec_price"]) : 0;
                mould_fee = ja[i]["mould_fee"].ToString() != "" ? Convert.ToDouble(ja[i]["mould_fee"]) : 0;
                former_free = ja[i]["former_free"].ToString() != "" ? Convert.ToDouble(ja[i]["former_free"]) : 0;
                qty = ja[i]["prod_qty"].ToString() != "" ? Convert.ToDouble(ja[i]["prod_qty"]) : 0;
                weg = ja[i]["sec_qty"].ToString() != "" ? Convert.ToDouble(ja[i]["sec_qty"]) : 0;
                remark = ja[i]["remark"].ToString().Trim();
                string p_unit = ja[i]["p_unit"].ToString().Trim();
                string sec_p_unit = ja[i]["sec_p_unit"].ToString().Trim();
                double rate = getUnitRate(p_unit);
                string process_request = ja[i]["process_request"].ToString().Trim();
                double total_prices = Math.Round(qty * (price / rate) + weg * sec_price + mould_fee + former_free, 2);
                strSql += string.Format(@"UPDATE " + remote_db + "op_outpro_out_displace SET price='{0}',sec_price='{1}',mould_fee='{2}',former_free='{3}',process_request='{4}'" +
                            ",p_unit='{5}',sec_p_unit='{6}',total_prices='{7}',remark='{8}'" +
                            " WHERE within_code='{9}' AND id='{10}' AND sequence_id='{11}' "
                            , price, sec_price, mould_fee, former_free, process_request, p_unit, sec_p_unit, total_prices,remark
                            , within_code, id, sequence_id);
            }

            ReturnValue = sh.ExecuteSqlUpdate(strSql);
            if (ReturnValue == "")
                ReturnValue = "記錄更新成功!";
            context.Response.ContentType = "text/plain";
            //context.Response.Write(ReturnValue);
            context.Response.Write(new JavaScriptSerializer().Serialize(ReturnValue));
            context.Response.End();

        }
        private double getUnitRate(string unit)
        {
            double rate = 0;
            string strSql = "Select rate From " + remote_db + "it_coding Where unit_code='" + unit + "' And id='*'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            if (dt.Rows.Count > 0)
                rate = Convert.ToDouble(dt.Rows[0]["rate"]);
            if (rate == 0)
                rate = 1;
            return rate;
        }

        private void FindData(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            //BasePage bp = new BasePage();

            string ReturnValue = string.Empty;
            int show_price = 0;
            string dep = "";
            string prd_item = "";
            string mo_from = "", mo_to = "";
            string order_date_from = "", order_date_to = "";
            string color_id = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                dep = ja[0]["dep"].ToString().Trim();
                mo_from = ja[0]["mo_from"].ToString().Trim();
                mo_to = ja[0]["mo_to"].ToString().Trim();
                show_price = ja[0]["price_status"] != null ? Convert.ToInt32(ja[0]["price_status"]) : 0;
                prd_item = ja[0]["prd_item"].ToString().Trim();
                order_date_from = ja[0]["order_date_from"].ToString().Trim();
                order_date_to = ja[0]["order_date_to"].ToString().Trim();
                color_id = ja[0]["color_id"].ToString().Trim();
            }
            else
            {
                dep = context.Request["dep"] != null ? context.Request["dep"] : "";
                mo_from = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
                mo_to = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
                show_price = context.Request["price_status"] != null ? Convert.ToInt32(context.Request["price_status"]) : 0;
                prd_item = context.Request["prd_item"] != null ? context.Request["prd_item"] : "";
                order_date_from = context.Request["order_date_from"] != null ? context.Request["order_date_from"] : "";
                order_date_to = context.Request["order_date_to"] != null ? context.Request["order_date_to"] : "";
                color_id = context.Request["color_id"] != null ? context.Request["color_id"] : "";
            }
            if (mo_from == "" && mo_to == "" && prd_item == "" && order_date_from == "" && order_date_to == "" && color_id == "")
            {
                mo_from = "ZZZZZZZZZ";
                mo_to = "ZZZZZZZZZ";
            }
            string sqlstr = "usp_FindOutSideProductPrice";
            SqlParameter[] parameters = {new SqlParameter("@show_price", show_price)
                                            ,new SqlParameter("@dep", dep),new SqlParameter("@prd_item", prd_item)
                                            ,new SqlParameter("@color_id", color_id)
                                        , new SqlParameter("@mo_from", mo_from), new SqlParameter("@mo_to", mo_to)
                                        ,new SqlParameter("@order_date_from", order_date_from),new SqlParameter("@order_date_to", order_date_to)
            };
            DataTable dt = sh.ExecuteProcedure(sqlstr, parameters);
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

        private void FindAmountData(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            //BasePage bp = new BasePage();

            string ReturnValue = string.Empty;
            int show_price = 0;
            string dep = "";
            string prd_item = "";
            string mo_from = "", mo_to = "";
            string order_date_from = "", order_date_to = "";
            string color_id = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                dep = ja[0]["dep"].ToString().Trim();
                mo_from = ja[0]["mo_from"].ToString().Trim();
                mo_to = ja[0]["mo_to"].ToString().Trim();
                show_price = ja[0]["price_status"] != null ? Convert.ToInt32(ja[0]["price_status"]) : 0;
                prd_item = ja[0]["prd_item"].ToString().Trim();
                order_date_from = ja[0]["order_date_from"].ToString().Trim();
                order_date_to = ja[0]["order_date_to"].ToString().Trim();
                color_id = ja[0]["color_id"].ToString().Trim();
            }
            else
            {
                dep = context.Request["dep"] != null ? context.Request["dep"] : "";
                mo_from = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
                mo_to = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
                show_price = context.Request["price_status"] != null ? Convert.ToInt32(context.Request["price_status"]) : 0;
                prd_item = context.Request["prd_item"] != null ? context.Request["prd_item"] : "";
                order_date_from = context.Request["order_date_from"] != null ? context.Request["order_date_from"] : "";
                order_date_to = context.Request["order_date_to"] != null ? context.Request["order_date_to"] : "";
                color_id = context.Request["color_id"] != null ? context.Request["color_id"] : "";
            }
            if (mo_from == "" && mo_to == "" && prd_item == "" && order_date_from == "" && order_date_to == "" && color_id == "")
            {
                mo_from = "ZZZZZZZZZ";
                mo_to = "ZZZZZZZZZ";
            }
            string sqlstr = "usp_FindOutSideProductPrice";
            SqlParameter[] parameters = {new SqlParameter("@show_price", show_price)
                                            ,new SqlParameter("@dep", dep),new SqlParameter("@prd_item", prd_item)
                                            ,new SqlParameter("@color_id", color_id)
                                        , new SqlParameter("@mo_from", mo_from), new SqlParameter("@mo_to", mo_to)
                                        ,new SqlParameter("@order_date_from", order_date_from),new SqlParameter("@order_date_to", order_date_to)
            };
            DataTable dt = sh.ExecuteProcedure(sqlstr, parameters);
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
    }
}