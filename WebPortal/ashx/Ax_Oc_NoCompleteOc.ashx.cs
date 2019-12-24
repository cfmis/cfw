using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Leyp.Components;
using Leyp.SQLServerDAL;
using Leyp.Components.Module;//獲取登錄的用戶名

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_Oc_NoCompleteOc
    /// </summary>
    public class Ax_Oc_NoCompleteOc : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
            //string paraa = context.Request["paraa"];
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            clsPublic cls = new clsPublic();
            int period_type = 0;
            string period_type1 = context.Request["period_type"];
            if (period_type1 == null || period_type1 == "00")
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
            string mo1 = context.Request["mo_from"];
            if (mo1 == null)
                mo1 = "";
            string mo2 = context.Request["mo_to"];
            if (mo2 == null)
                mo2 = "";
            string mo_group = context.Request["mo_group"];
            if (mo_group == null)
                mo_group = "";
            string only_apart = "1";
            only_apart = context.Request["only_apart"];
            if (only_apart == null)
                only_apart = "";
            string crdate1 = context.Request["crdate1"];
            if (crdate1 == null || crdate1 == "")
                crdate1 = "";
            string crdate2 = context.Request["crdate2"];
            if (crdate2 == null || crdate2 == "")
                crdate2 = "";
            else
                crdate2 = Convert.ToDateTime(crdate2).AddDays(1).ToString("yyyy/MM/dd");
            string date1 = context.Request["date1"];
            if (date1 == null || date1 == "")
                date1 = "";
            string date2 = context.Request["date2"];
            if (date2 == null || date2 == "")
                date2 = "";
            else
                date2 = Convert.ToDateTime(date2).AddDays(1).ToString("yyyy/MM/dd");
            string cs_date1 = context.Request["cs_date1"];
            if (cs_date1 == null || cs_date1 == "")
                cs_date1 = "";
            string cs_date2 = context.Request["cs_date2"];
            if (cs_date2 == null || cs_date2 == "")
                cs_date2 = "";
            else
                cs_date2 = Convert.ToDateTime(cs_date2).AddDays(1).ToString("yyyy/MM/dd");
            string crby = context.Request["crby"];
            if (crby == null || crby == "")
                crby = "";
            string brand1 = context.Request["brand1"];
            if (brand1 == null || brand1 == "")
                brand1 = "";
            string cust1 = context.Request["cust1"];
            if (cust1 == null || cust1 == "")
                cust1 = "";
            string agent1 = context.Request["agent1"];
            if (agent1 == null || agent1 == "")
                agent1 = "";
            string cust_goods = context.Request["cust_goods"];
            if (cust_goods == null || cust_goods == "")
                cust_goods = "";
            string cust_color = context.Request["cust_color"];
            if (cust_color == null || cust_color == "")
                cust_color = "";
            string cust_style = context.Request["cust_style"];
            if (cust_style == null || cust_style == "")
                cust_style = "";
            string season = context.Request["season"];
            if (season == null || season == "")
                season = "";
            string mat_code = context.Request["mat_code"];
            if (mat_code == null || mat_code == "")
                mat_code = "";
            string prod_code = context.Request["prod_code"];
            if (prod_code == null || prod_code == "")
                prod_code = "";
            string art_code = context.Request["art_code"];
            if (art_code == null || art_code == "")
                art_code = "";
            string size_code = context.Request["size_code"];
            if (size_code == null || size_code == "")
                size_code = "";
            string clr_code = context.Request["clr_code"];
            if (clr_code == null || clr_code == "")
                clr_code = "";
            string pono = context.Request["pono"];
            if (pono == null || pono == "")
                pono = "";
            string ocno = context.Request["ocno"];
            if (ocno == null || ocno == "")
                ocno = "";
            string goods_id = context.Request["goods_id"];
            if (goods_id == null || goods_id == "")
                goods_id = "";
            if (mo1 == "" && mo2 == "" && crdate1 == "" && crdate2 == "" && date1 == "" && date2 == "" && brand1 == "" && cust1 == "" && mo_group == "")
            {
                brand1 = "ZZZZZZZZ";
                cust1 = "ZZZZZZZZ";
            }
            string strSql = "usp_Oc_NoCompleteOc";
            if (period_type >= 0)
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
            ReturnValue = cls.DataTableJsonReturnTable(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            //ReturnValue = "[{'dep_id':'101','dep_cdesc':'鈕 - 工程科'},{'dep_id':'102','dep_cdesc':'鈕 - 啤機'}]";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

    }
}