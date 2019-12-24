using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using Leyp.Components;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebPortal.ashx
{
    /// <summary>
    ///Base_Select 的摘要描述
    /// </summary>
    public class Base_Select : IHttpHandler
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
            string parab = context.Request["parab"];
            string para = context.Request["param"];
            string id = "", name = "";
            string search_val = "";
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);

                if (paraa == "get_prdtype")
                    search_val = ja[0]["search_val"].ToString().Trim();
                else
                {
                    id = ja[0]["id"].ToString().Trim();
                    name = ja[0]["name"].ToString().Trim();
                }
            }
            string ReturnValue = string.Empty;
            //BasicInformationFacade basicInformationFacade = new BasicInformationFacade();   //实例化基础信息外观  
            DataTable dt = new DataTable();
            //dt = basicInformationFacade.itemsQuery(); //根据查询条件获取结果
            switch (paraa)
            {
                case "sa_order_trace":
                    dt = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getCpFlag();
                    break;
                case "pd_mo_plan_dep":
                    dt = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getDep();
                    break;
                case "pd_mo_plan_work_type":
                    dt = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getWork_type();
                    break;
                case "get_oclab":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getOcLab();
                    break;
                case "get_mogroup":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getMoGroup();
                    break;
                case "getSa_Oc_NoCompleteOc":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getSa_Oc_NoCompleteOc();
                    break;
                case "get_season":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_season();
                    break;
                case "get_mogroup_para":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getMoGroup_para(id);
                    break;
                case "get_matdata":
                    search_val = context.Request["search_val"] != null ? context.Request["search_val"] : "";
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_MatData(search_val);
                    break;
                case "get_unit":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_unit();
                    break;
                case "get_prdtype":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_PrdType(search_val);
                    break;
                case "get_funcgroup":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_funcgroup();
                    break;
                case "get_salesgroup":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_salesgroup();
                    break; 
                case "get_lang":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_lang("LANG"); 
                    break;
                case "get_userstate":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_lang("user_state");
                    break;
                case "get_usertype":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_lang("user_type");
                    break;
                case "get_geousergroup":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_geousergroup();
                    break;
                case "get_transfer_flag":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_lang("st_jx_stransfer_flag");
                    break; 
                case "get_jx_dep":
                    dt = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getJxDep();
                    break;
                case "goods_transfer_jx":
                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().get_docflag("goods_transfer_jx");
                    break;
            }


            clsPublic cls = new clsPublic();
            if (parab == "list")
                ReturnValue = cls.DataTableJsonReturnList(dt);
            else
            {
                if (parab == "table")
                    ReturnValue = cls.DataTableJsonReturnExcel(dt);
                else
                    ReturnValue = cls.DataTableJsonReturnTextBox(dt);
            }
            context.Response.ContentType = "text/plain";
            //context.Response.ContentType = "application/json";
            context.Response.Write(ReturnValue);
            context.Response.End();
            //return ReturnValue;  
        }
        

    }
}