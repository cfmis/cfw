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
    /// Summary description for Ax_Oc_NoCompleteOc_New
    /// </summary>
    public class Ax_Oc_NoCompleteOc_New : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
            string ReturnValue = string.Empty;

            string crdate1 = "", crdate2 = "";
            string date1 = "", date2 = "";
            string mo1 = "", mo2 = "";
            string mo_group = "";
            string cs_date1 = "", cs_date2 = "";
            string crby = "";
            string brand1 = "";
            string cust1 = "";
            string agent1 = "";
            string cust_goods = "";
            string cust_color = "";
            string cust_style = "";
            string season = "";
            string mat_code = "";
            string prod_code = "";
            string art_code = "";
            string size_code = "";
            string clr_code = "";
            string pono = "";
            string ocno = "";
            string goods_id = "";

            int period_type = 0;
            string period_type1 = "";
            string only_apart = "";
            string only_apart_chk = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                crdate1 = ja[0]["crdate1"].ToString().Trim();
                crdate2 = ja[0]["crdate2"].ToString().Trim();
                date1 = ja[0]["date1"].ToString().Trim();
                date2 = ja[0]["date2"].ToString().Trim();
                mo1 = ja[0]["mo1"].ToString().Trim();
                mo2 = ja[0]["mo2"].ToString().Trim();
                mo_group = ja[0]["mo_group"].ToString().Trim();
                cs_date1 = ja[0]["cs_date1"].ToString().Trim();
                cs_date2 = ja[0]["cs_date2"].ToString().Trim();
                crby = ja[0]["crby"].ToString().Trim();
                brand1 = ja[0]["brand1"].ToString().Trim();
                cust1 = ja[0]["cust1"].ToString().Trim();
                agent1 = ja[0]["agent1"].ToString().Trim();
                cust_goods = ja[0]["cust_goods"].ToString().Trim();
                cust_color = ja[0]["cust_color"].ToString().Trim();
                pono = ja[0]["pono"].ToString().Trim();
                season = ja[0]["season"].ToString().Trim();
                ocno = ja[0]["ocno"].ToString().Trim();
                goods_id = ja[0]["goods_id"].ToString().Trim();
                cust_style = ja[0]["cust_style"].ToString().Trim();


                period_type1 = ja[0]["period_type"].ToString().Trim();
                only_apart_chk = ja[0]["only_apart_chk"].ToString().Trim();
                if (only_apart_chk == "True")
                    only_apart = "1";
            }
            else
            {
                crdate1 = context.Request["crdate1"];
                crdate2 = context.Request["crdate2"];
                date1 = context.Request["date1"];
                date2 = context.Request["date2"];
                mo1 = context.Request["mo_from"];
                mo2 = context.Request["mo_to"];
                mo_group = context.Request["mo_group"];
                cs_date1 = context.Request["cs_date1"];
                cs_date2 = context.Request["cs_date2"];
                crby = context.Request["crby"];
                brand1 = context.Request["brand1"];
                cust1 = context.Request["cust1"];
                agent1 = context.Request["agent1"];
                cust_goods = context.Request["cust_goods"];
                cust_color = context.Request["cust_color"];
                cust_style = context.Request["cust_style"];
                season = context.Request["season"];
                mat_code = context.Request["mat_code"];
                prod_code = context.Request["prod_code"];
                art_code = context.Request["art_code"];
                size_code = context.Request["size_code"];
                clr_code = context.Request["clr_code"];
                pono = context.Request["pono"];
                ocno = context.Request["ocno"];
                goods_id = context.Request["goods_id"];
                period_type1 = context.Request["period_type"];
                only_apart_chk = context.Request["only_apart"];
                if (only_apart_chk == "on")
                    only_apart = "1";
            }
            if (crdate1 == null || crdate1 == "")
                crdate1 = "";
            if (crdate2 == null || crdate2 == "")
                crdate2 = "";
            if (date1 == null || date1 == "")
                date1 = "";
            if (date2 == null || date2 == "")
                date2 = "";
            if (mo1 == null)
                mo1 = "";
            if (mo2 == null)
                mo2 = "";
            if (mo_group == null)
                mo_group = "";
            if (cs_date1 == null || cs_date1 == "")
                cs_date1 = "";
            if (cs_date2 == null || cs_date2 == "")
                cs_date2 = "";
            if (crby == null || crby == "")
                crby = "";
            if (brand1 == null || brand1 == "")
                brand1 = "";
            if (cust1 == null || cust1 == "")
                cust1 = "";
            if (agent1 == null || agent1 == "")
                agent1 = "";
            if (cust_goods == null || cust_goods == "")
                cust_goods = "";
            if (cust_color == null || cust_color == "")
                cust_color = "";
            if (cust_style == null || cust_style == "")
                cust_style = "";
            if (season == null || season == "")
                season = "";
            if (mat_code == null || mat_code == "")
                mat_code = "";
            if (prod_code == null || prod_code == "")
                prod_code = "";
            if (art_code == null || art_code == "")
                art_code = "";
            if (size_code == null || size_code == "")
                size_code = "";
            if (clr_code == null || clr_code == "")
                clr_code = "";
            if (pono == null || pono == "")
                pono = "";
            if (ocno == null || ocno == "")
                ocno = "";
            if (goods_id == null || goods_id == "")
                goods_id = "";
            if (period_type1 == null || period_type1 == "" || period_type1 == "00")
                period_type = 0;
            else
            {
                if (period_type1 == "01")
                    period_type = 1;
                else
                {
                    if (period_type1 == "02")
                        period_type = 2;
                    else
                    {
                        if (period_type1 == "03")
                            period_type = 3;
                        else
                        {
                            if (period_type1 == "04")
                                period_type = 4;
                            else
                            {
                                if (period_type1 == "05")
                                    period_type = 5;
                                else
                                {
                                    if (period_type1 == "06")
                                        period_type = 6;
                                }
                            }
                        }
                    }
                }
            }

            if (mo1 == "" && mo2 == "" && crdate1 == "" && crdate2 == "" && date1 == "" && date2 == "" && brand1 == "" && cust1 == "" && mo_group == "")
            {
                date1 = System.DateTime.Now.ToString("yyyy/MM/dd");
                date2 = date1;
                mo1 = "ZZZZZZZZZ";
                mo2 = "ZZZZZZZZZ";
                brand1 = "ZZZZZZZZ";
                cust1 = "ZZZZZZZZ";
            }
            string strSql = "usp_Oc_NoCompleteOc";
            if (period_type >= 5)
                strSql = "usp_Oc_NoCompleteOc601";
            SqlParameter[] parameters = {new SqlParameter("@user_id", bp.getUserName())
                                        ,new SqlParameter("@period_type", period_type)
                                        ,new SqlParameter("@mo_group", mo_group)
                                        ,new SqlParameter("@only_apart", only_apart)
                                        ,new SqlParameter("@crdat1", crdate1), new SqlParameter("@crdat2", crdate2)
                                        ,new SqlParameter("@dat1", date1), new SqlParameter("@dat2", date2)
                                        ,new SqlParameter("@cs_dat1", cs_date1), new SqlParameter("@cs_dat2", cs_date2)
                                        ,new SqlParameter("@crby", crby)
                                        , new SqlParameter("@mo1", mo1), new SqlParameter("@mo2", mo2)
                                        , new SqlParameter("@brand1", brand1)
                                        , new SqlParameter("@cust1", cust1)
                                        , new SqlParameter("@agent1", agent1)
                                        , new SqlParameter("@cust_goods", cust_goods)
                                        , new SqlParameter("@cust_color", cust_color)
                                        , new SqlParameter("@cust_style", cust_style)
                                        , new SqlParameter("@season", season)
                                        , new SqlParameter("@mat_code", mat_code)
                                        , new SqlParameter("@prod_code", prod_code)
                                        , new SqlParameter("@art_code", art_code)
                                        , new SqlParameter("@size_code", size_code)
                                        , new SqlParameter("@clr_code", clr_code)
                                        , new SqlParameter("@pono", pono)
                                        , new SqlParameter("@ocno", ocno)
                                        , new SqlParameter("@goods_id", goods_id)
                                        };

            DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);


            //DataTable dt = SQLHelper.ExecuteSqlReturnDataTable("select flag_id,flag_desc from bs_flag_desc");

            //if (paraa == "get_oc_a")
            //{

            //    ReturnValue = cls.DataTableJsonReturnTextBox(dt);//提取記錄，返回給文本框
            //}
            //else
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            //ReturnValue = "[{'dep_id':'101','dep_cdesc':'鈕 - 工程科'},{'dep_id':'102','dep_cdesc':'鈕 - 啤機'}]";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
    }
}