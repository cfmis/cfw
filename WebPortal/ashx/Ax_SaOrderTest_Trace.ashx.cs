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
    /// Summary description for Ax_SaOrderTest_Trace
    /// </summary>
    public class Ax_SaOrderTest_Trace : IHttpHandler
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
            string mo_id = "";
            //BasicInformationFacade basicInformationFacade = new BasicInformationFacade();   //实例化基础信息外观  
            DataTable dt = new DataTable();
            //dt = basicInformationFacade.itemsQuery(); //根据查询条件获取结果
            if (paraa == "get_oc_a" || paraa == "get_oc_b")
            {
                mo_id = context.Request["mo"] != null ? context.Request["mo"] : "";
                string mo_group = context.Request["mo_group"] != null ? context.Request["mo_group"] : "";
                string date_from = context.Request["date_from"] != null ? context.Request["date_from"] : "";
                string date_to = context.Request["date_to"] != null ? context.Request["date_to"] : "";
                string ref_no = context.Request["ref_no"] != null ? context.Request["ref_no"] : "";
                string item = context.Request["item"] != null ? context.Request["item"] : "";
                string color = context.Request["color"] != null ? context.Request["color"] : "";
                string size = context.Request["size"] != null ? context.Request["size"] : "";
                string season = context.Request["season"] != null ? context.Request["season"] : "";
                if (date_to != "")
                    date_to = Convert.ToDateTime(date_to).AddDays(1).ToString("yyyy/MM/dd");
                if (mo_id == "" && mo_group == "" && date_from == "" && date_to == "" && ref_no == "" && item == "" && color == "")
                    mo_id = "ZZZZZZZZZ";
                dt = Leyp.SQLServerDAL.Sales.Factory_New.SaOrderTestTraceDAL().getRecByMo(mo_group,date_from,date_to,mo_id,ref_no,item,color,size,season);
                if(dt.Rows.Count==0)
                    dt = Leyp.SQLServerDAL.Sales.Factory_New.SaOrderTestTraceDAL().getOcByMo(mo_id);
                if (paraa == "get_oc_a")
                {
                    
                    ReturnValue = cls.DataTableJsonReturnTextBox(dt);//提取記錄，返回給文本框
                }
                else
                    ReturnValue = cls.DataTableJsonReturnTable(dt);//提取記錄，返回給表格
            }
            else
            {
                if (paraa == "get_oclab")
                {

                    dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getOcLab();
                    ReturnValue = cls.DataTableJsonReturnList(dt);//提取記錄，返回給列表框的數據源
                }
                else
                {
                    if (paraa == "get_octest")
                    {

                        dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getOcTest();
                        ReturnValue = cls.DataTableJsonReturnList(dt);
                    }
                    else
                    {
                        if (paraa == "update")
                        {

                            ReturnValue = updateProcess(context);
                        }
                        else
                        {
                            if (paraa == "get_mogroup")
                            {
                                dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getMoGroup();
                                ReturnValue = cls.DataTableJsonReturnList(dt);
                            }
                            else
                            {
                                if (paraa == "update_invoice")
                                {
                                    ReturnValue = updateInvoiceProcess(context);
                                }
                                else
                                {
                                    if (paraa == "get_invoice_a" || paraa == "get_invoice_b")
                                    {
                                        string invoice_id = context.Request["parab"];
                                        if (invoice_id == null)
                                            invoice_id = "";
                                        mo_id = context.Request["mo_id"];
                                        if (mo_id == null)
                                            mo_id = "";
                                        string custcode = context.Request["custcode"];
                                        if (custcode == null)
                                            custcode = "";
                                        string brand = context.Request["brand"];
                                        if (brand == null)
                                            brand = "";
                                        string date_from = context.Request["date_from"];
                                        if (date_from == null || date_from == "")
                                            date_from = "";
                                        string mo_group = context.Request["mo_group"];
                                        if (mo_group == null || mo_group == "")
                                            mo_group = "";
                                        string date_to = context.Request["date_to"];
                                        if (date_to == null || date_to == "")
                                            date_to = "";
                                        else
                                            date_to = Convert.ToDateTime(date_to).AddDays(1).ToString("yyyy/MM/dd");
                                        if (invoice_id == "" && mo_id == "" && custcode == "" && mo_group=="" && brand == "" && date_from == "" && date_to == "")
                                        {
                                            mo_id = "ZZZZZZZZZ";
                                            date_from = "1900/01/01";
                                            date_from = "1900/01/01";
                                        }
                                        dt = Leyp.SQLServerDAL.Sales.Factory_New.SaOrderTestTraceDAL().getInvoiceData(date_from, date_to, invoice_id, mo_id, custcode, mo_group, brand);
                                        if (dt.Rows.Count > 0)
                                        {
                                            if (paraa == "get_invoice_a")
                                            {

                                                ReturnValue = cls.DataTableJsonReturnTextBox(dt);//提取記錄，返回給文本框
                                            }
                                            else
                                                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
                                        }
                                        else
                                        {
                                            ReturnValue = "沒有找到記錄!";
                                        }
                                    }
                                    else
                                    {
                                        if(paraa=="get_curr")
                                        {
                                            dt = Leyp.SQLServerDAL.Factory_New.BaseDataDAL().getCurr();
                                            ReturnValue = cls.DataTableJsonReturnList(dt);
                                        }
                                        else
                                        {
                                            if (paraa == "delete_OrderTestInvoice")
                                            {
                                                ReturnValue = deleteInvoiceProcess(context);
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
            string mo_id = ja[0]["mo_id"].ToString().Trim();
            string mo_group = mo_id.Substring(2, 1);

            result = Leyp.SQLServerDAL.Sales.Factory_New.SaOrderTestTraceDAL().updOrderTestTrace(mo_id,mo_group, ja[0]["rt_from_date"].ToString().Trim()
                , ja[0]["ref_no"].ToString().Trim(), ja[0]["lab_house"].ToString().Trim(), ja[0]["mat_desc"].ToString().Trim(), ja[0]["cust_item"].ToString().Trim()
                , ja[0]["cust_size"].ToString().Trim(), ja[0]["cust_color"].ToString().Trim(), ja[0]["season"].ToString().Trim(), ja[0]["division"].ToString().Trim()
                , ja[0]["test_method"].ToString().Trim(), ja[0]["bulk_mo"].ToString().Trim(), ja[0]["sent_to_hk"].ToString().Trim(), ja[0]["pass_to_lab"].ToString().Trim()
                , ja[0]["test_results"].ToString().Trim(), ja[0]["rsl"].ToString().Trim(), ja[0]["rsl_rp_date"].ToString().Trim(), ja[0]["appearance"].ToString().Trim()
                , ja[0]["appearance_rp_date"].ToString().Trim(), ja[0]["resist"].ToString().Trim(), ja[0]["resist_rp_date"].ToString().Trim(), ja[0]["salvia"].ToString().Trim()
                , ja[0]["salvia_rp_date"].ToString().Trim(), ja[0]["snap"].ToString().Trim(), ja[0]["snap_rp_date"].ToString().Trim(), ja[0]["underpart"].ToString().Trim()
                , ja[0]["underpart_rp_date"].ToString().Trim(), ja[0]["ftc_cmmts"].ToString().Trim());

            if (result == "")
                msg = "記錄更新成功!";
            else
                msg = result; //"更新失敗，制單編號: "+mo_id+" !";
            return msg;
        }




        protected string updateInvoiceProcess(HttpContext context)
        {
            string para = context.Request["param"];
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            string result = "";
            string msg = "";

            result = Leyp.SQLServerDAL.Sales.Factory_New.SaOrderTestTraceDAL().updOrderTestInvoice(ja[0]["invoice_id"].ToString().Trim()
                , ja[0]["invoice_date"].ToString().Trim(), ja[0]["report_no"].ToString().Trim(), ja[0]["amount"].ToString().Trim(), ja[0]["curr"].ToString().Trim()
                , ja[0]["ref_report"].ToString().Trim(), ja[0]["mo_id"].ToString().Trim(), ja[0]["custcode"].ToString().Trim(), ja[0]["brand"].ToString().Trim());

            if (result == "")
                msg = "記錄更新成功!";
            else
                msg = result; //"更新失敗，制單編號: "+mo_id+" !";
            return msg;
        }

        protected string deleteInvoiceProcess(HttpContext context)
        {
            string invoice_id = context.Request["param"].Trim();
            string result = "";
            string msg = "";

            result = Leyp.SQLServerDAL.Sales.Factory_New.SaOrderTestTraceDAL().deleteTestInvoice(invoice_id);

            if (result == "")
                msg = "刪除更新成功!";
            else
                msg = result; //"更新失敗，制單編號: "+mo_id+" !";
            return msg;
        }

    }
}