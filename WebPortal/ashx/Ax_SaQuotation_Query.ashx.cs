using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Leyp.Components;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_SaQuotation_Query
    /// </summary>
    public class Ax_SaQuotation_Query : IHttpHandler
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
            if (paraa == "getquotation")
            {
                string prd_item = context.Request["prd_item"];
                if (prd_item == null)
                    prd_item = "";
                string clr = context.Request["clr"];
                if (clr == null)
                    clr = "";
                string size = context.Request["size"];
                if (size == null || size == "")
                    size = "";
                dt = Leyp.SQLServerDAL.Sales.Factory_New.SaQuotationQueryDAL().getQuotation(prd_item, clr, size);
                ReturnValue = cls.DataTableJsonReturnTable(dt);//提取記錄，返回給表格
            }
            else
                if (paraa == "get_color")
            {
                int select_type = 1;// context.Request["select_type"];
                string select_val = context.Request["select_val"];
                dt = Leyp.SQLServerDAL.Sales.Factory_New.SaQuotationQueryDAL().getColor(select_type, select_val);
                ReturnValue = cls.DataTableJsonReturnList(dt);
            }
                

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