using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Leyp.Components;
using Leyp.SQLServerDAL;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_Oc_CountOcByBrandGroup
    /// </summary>
    public class Ax_Oc_CountOcByBrandGroup : IHttpHandler
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
            string paraa = context.Request["paraa"];
            string ReturnValue = string.Empty;
            clsPublic cls = new clsPublic();
            //BasicInformationFacade basicInformationFacade = new BasicInformationFacade();   //实例化基础信息外观  
            DataTable dt = new DataTable();
            //dt = basicInformationFacade.itemsQuery(); //根据查询条件获取结果
            string mo_id = context.Request["parab"];
            if (mo_id == null)
                mo_id = "";
            string mo_group = context.Request["mo_group"];
            if (mo_group == null)
                mo_group = "";
            string date_from = context.Request["date_from"];
            if (date_from == null || date_from == "")
                date_from = "";
            string date_to = context.Request["date_to"];
            if (date_to == null || date_to == "")
                date_to = "";
            else
                date_to = Convert.ToDateTime(date_to).AddDays(1).ToString("yyyy/MM/dd");
            string brand_from = context.Request["brand_from"];
            if (brand_from == null || brand_from == "")
                brand_from = "";
            string brand_to = context.Request["brand_to"];
            if (brand_to == null || brand_to == "")
                brand_to = "";
            if (date_from == "" && date_to == "" && brand_from == "" && brand_to == "" && mo_group == "")
            {
                brand_from = "ZZZZZZZZ";
                brand_to = "ZZZZZZZZ";
            }
            SqlParameter[] parameters = { new SqlParameter("@dat1", date_from)
                                        ,new SqlParameter("@dat2", date_to)
                                        ,new SqlParameter("@brand1", brand_from)
                                        ,new SqlParameter("@brand2", brand_to)
                                        ,new SqlParameter("@mo_group", mo_group)
                                        };

            dt = SQLHelper.ExecuteProcedureRetrunDataTable("usp_Oc_CountOcByBrandGroup", parameters);


            if (paraa == "get_oc_a")
            {

                ReturnValue = cls.DataTableJsonReturnTextBox(dt);//提取記錄，返回給文本框
            }
            else
                ReturnValue = cls.DataTableJsonReturnTable(dt);//提取記錄，返回給表格
            //clsPublic cls = new clsPublic();
            //ReturnValue = cls.DataTableJson(dt);
            //ReturnValue = DataTableJson(dt);
            context.Response.ContentType = "text/plain";
            //ReturnValue = "[{'dep_id':'101','dep_cdesc':'鈕 - 工程科'},{'dep_id':'102','dep_cdesc':'鈕 - 啤機'}]";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }



    }
}