using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Leyp.Components;
using Leyp.SQLServerDAL;
using Leyp.Components.Module;//獲取登錄的用戶名
//using Leyp.Model.View;

//using System.Web.UI;
//using System.Web.UI.WebControls;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_SaOrderManage
    /// </summary>
    public class Ax_SaOrderManage : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private SQLHelp sh = new SQLHelp();
        private BasePage bp = new BasePage();

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
            if (paraa == "get_initInterface")
            {
                string formname = context.Request["formname"];
                string obj_type= context.Request["obj_type"];
                dt = initInterfaceData(formname, obj_type);
                ReturnValue = cls.DataTableJsonReturnList(dt);
            }
            else
            {
                if (paraa == "get_unit")
                {

                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getUnit();
                    ReturnValue = cls.DataTableJsonReturnList(dt);//提取記錄，返回給列表框的數據源
                }
                else
                {
                    if (paraa == "get_season")
                    {

                        dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getSeason();
                        ReturnValue = cls.DataTableJsonReturnList(dt);
                    }
                    else
                    {
                        if (paraa == "update")
                        {

                            //ReturnValue = updateProcess(context);
                        }
                        else
                        {
                            if (paraa == "get_custuser")
                            {
                                dt = getCustByUser();
                                ReturnValue = cls.DataTableJsonReturnList(dt);
                            }
                            else
                            {
                                if (paraa == "update_order")
                                {
                                    ReturnValue = updateProcess(context);
                                }
                                else
                                {
                                    if (paraa == "getorder_a" || paraa == "getorder_b")
                                    {
                                        dt = getOrder(context);
                                        if (dt.Rows.Count > 0)
                                        {
                                            if (paraa == "getorder_a")
                                            {

                                                ReturnValue = cls.DataTableJsonReturnTextBox(dt);//提取記錄，返回給文本框
                                            }
                                            else
                                                ReturnValue = cls.DataTableJsonReturnTable(dt);//提取記錄，返回給表格
                                        }
                                        else
                                        {
                                            ReturnValue = "沒有找到記錄!";
                                        }
                                    }
                                    else
                                    {
                                        if (paraa == "get_color")
                                        {
                                            int select_type = 1;// context.Request["select_type"];
                                            string select_val = context.Request["select_val"];
                                            dt = Leyp.SQLServerDAL.Sales.Factory_New.SaColorGroupFindDAL().getColor(select_type, select_val);
                                            ReturnValue = cls.DataTableJsonReturnList(dt);
                                        }
                                        else
                                        {
                                            if (paraa == "delete_order")
                                            {
                                                ReturnValue = deleteOrderProcess(context);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            //clsPublic cls = new clsPublic();
            //ReturnValue = cls.DataTableJson(dt);
            //ReturnValue = DataTableJson(dt);
            context.Response.ContentType = "text/plain";
            //ReturnValue = "[{'dep_id':'101','dep_cdesc':'鈕 - 工程科'},{'dep_id':'102','dep_cdesc':'鈕 - 啤機'}]";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

        protected string updateProcess(HttpContext context)
        {
            string para = context.Request["param"];
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            string result = "";
            string msg = "";
            string id = ja[0]["id"].ToString().Trim();
            if (id == null || id == "")
                id = "";
            
            float order_qty = Convert.ToSingle(ja[0]["order_qty"].ToString());
            string sytim = DateTime.Now.ToString("yyyy'-'MM'-'dd' 'HH':'mm':'ss");
            string uname = bp.getUserName();
            string strSql = "";
            if (id == "")
            {
                string dat = System.DateTime.Now.ToString("yyyyMMdd HH:mm:ss");
                id = "OD" + dat.Substring(0, 8) + dat.Substring(9, 2) + dat.Substring(12, 2) + dat.Substring(15, 2);
                strSql = "Insert Into so_cust_order (id,pono,order_date,custcode,season,own,brand,cust_item,cust_item_cdesc,cust_color,cust_size,cust_style" +
                    ",order_qty,unit,req_date,cf_prd_item,cf_color,cf_size,test_item,packing,crusr,crtim)" +
                    " Values ("
                     + "'" + id + "','" + ja[0]["pono"].ToString().Trim() + "','" + ja[0]["order_date"].ToString().Trim() + "','" + ja[0]["custcode"].ToString().Trim()
                     + "','" + ja[0]["season"].ToString().Trim() + "','" + ja[0]["own"].ToString().Trim() + "','" + ja[0]["brand"].ToString().Trim()
                     + "','" + ja[0]["cust_item"].ToString().Trim() + "','" + ja[0]["cust_item_cdesc"].ToString().Trim() + "','" + ja[0]["cust_color"].ToString().Trim()
                     + "','" + ja[0]["cust_size"].ToString().Trim() + "','" + ja[0]["cust_style"].ToString().Trim() + "','" + order_qty + "','" + ja[0]["unit"].ToString().Trim()
                     + "','" + ja[0]["req_date"].ToString().Trim() + "','" + ja[0]["cf_prd_item"].ToString().Trim() + "','" + ja[0]["cf_color"].ToString().Trim()
                     + "','" + ja[0]["cf_size"].ToString().Trim() + "','" + ja[0]["test_item"].ToString().Trim() + "','" + ja[0]["packing"].ToString().Trim()
                     + "','" + uname + "','" + sytim
                    + "')";
            }
            else
                strSql = "Update so_cust_order Set "
                    + "pono='" + ja[0]["pono"].ToString().Trim() + "'" + ",order_date='" + ja[0]["order_date"].ToString().Trim() + "'" + ",custcode='" + ja[0]["custcode"].ToString().Trim() + "'"
                    + ",season='" + ja[0]["season"].ToString().Trim() + "'" + ",own='" + ja[0]["own"].ToString().Trim() + "'" + ",brand='" + ja[0]["brand"].ToString().Trim() + "'"
                    + ",cust_item='" + ja[0]["cust_item"].ToString().Trim() + "'" + ",cust_item_cdesc='" + ja[0]["cust_item_cdesc"].ToString().Trim() + "'" + ",cust_color='" + ja[0]["cust_color"].ToString().Trim() + "'"
                    + ",cust_size='" + ja[0]["cust_size"].ToString().Trim() + "'" + ",cust_style='" + ja[0]["cust_style"].ToString().Trim() + "'" + ",order_qty='" + order_qty + "'" + ",unit='" + ja[0]["unit"].ToString().Trim() + "'" 
                    + ",req_date='" + ja[0]["req_date"].ToString().Trim() + "'" + ",cf_prd_item='" + ja[0]["cf_prd_item"].ToString().Trim() + "'" + ",cf_color='" + ja[0]["cf_color"].ToString().Trim() + "'"
                    + ",cf_size='" + ja[0]["cf_size"].ToString().Trim() + "'" + ",test_item='" + ja[0]["test_item"].ToString().Trim() + "'" + ",packing='" + ja[0]["packing"].ToString().Trim() + "'"
                    + ",amusr='" + uname + "'" + ",amtim='" + sytim + "'"
                    + " Where id='" + id + "'";
            result = sh.ExecuteSqlUpdate(strSql);

            if (result == "")
                msg = "記錄更新成功!";
            else
                msg = result; //"更新失敗，制單編號: "+mo_id+" !";
            return msg;
        }

        protected DataTable getOrder(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            string id = context.Request["id"];
            if (id == null)
                id = "";
            string pono = context.Request["pono"];
            if (pono == null)
                pono = "";
            string custcode = context.Request["custcode"];
            if (custcode == null)
                custcode = getCustByUser().Rows[0]["custcode"].ToString();
            string date_from = context.Request["date_from"];
            if (date_from == null || date_from == "")
                date_from = "";
            string date_to = context.Request["date_to"];
            if (date_to == null || date_to == "")
                date_to = "";
            else
                date_to = Convert.ToDateTime(date_to).AddDays(1).ToString("yyyy/MM/dd");
            string strSql = "Select a.id,a.custcode,a.pono,a.order_date,a.season,a.own,a.brand,a.cust_item,a.cust_item_cdesc,a.cust_color,a.cust_size" +
                ",a.order_qty,a.unit,a.req_date,a.cf_prd_item,a.cf_color,a.cf_size,a.test_item,a.packing,a.crusr,Convert(Varchar(20),a.crtim,111) AS crtim" +
                ",a.amusr,Convert(Varchar(20),a.amtim,111) AS amtim" +
                " From so_cust_order a" +
                " Where a.id>=''";
            if (id != "")
                strSql += " And a.id='" + id + "'";
            if (custcode != "")
                strSql += " And a.custcode='" + custcode + "'";
            if (pono != "")
                strSql += " And a.pono like '" + "%" + pono + "%" + "'";
            if (date_from != "" && date_to != "")
                strSql += " And a.order_date>='" + date_from + "' And a.order_date<'" + date_to + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            
            return dt;
        }
        private DataTable getCustByUser()
        {

            DataTable dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getOrderCustByLoginUser(bp.getUserName());
            return dt;
        }
        private DataTable initInterfaceData(string formname,string obj_type)
        {
            string langid = bp.getUserLang();
            string strSql = "Select a.obj_id,b.show_name from tb_sy_form_object a" +
                " Inner Join tb_sy_dictionary_lang b On a.obj_id=b.obj_id" +
                " Where a.formname='"+formname+"' And a.obj_type='" + obj_type + "' And b.language_id='" + langid + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }

        protected string deleteOrderProcess(HttpContext context)
        {
            string id = context.Request["param"].Trim();
            string result = "";
            string msg = "";
            string strSql = "Delete From so_cust_order Where id='" + id + "'";

            result = sh.ExecuteSqlUpdate(strSql);

            if (result == "")
                msg = "刪除更新成功!";
            else
                msg = result; //"更新失敗，制單編號: "+mo_id+" !";
            return msg;
        }
    }
}