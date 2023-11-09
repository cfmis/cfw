using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using Leyp.Components;
using Leyp.SQLServerDAL;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Leyp.Components.Module;//獲取登錄的用戶名
using System.Data.OleDb;
using System.IO;
using Microsoft.Office.Interop.Excel;
using Microsoft.CSharp;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_Pd_Mo_ArrangeImput
    /// </summary>
    public class Ax_Pd_Mo_ArrangeImput : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        BasePage bp = new BasePage();
        private SQLHelp sh = new SQLHelp();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string result=ImportExcel(context);
            //ReturnValue = "[{'dep_id':'101','dep_cdesc':'鈕 - 工程科'},{'dep_id':'102','dep_cdesc':'鈕 - 啤機'}]";
            context.Response.Write(result);
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        private void ReadExcelToTable(string fileName)
        {
            try
            {
                Microsoft.Office.Interop.Excel.Application excelApp = new Microsoft.Office.Interop.Excel.Application();
                Microsoft.Office.Interop.Excel.Workbook workbook = excelApp.Workbooks.Open(fileName);
                Microsoft.Office.Interop.Excel.Worksheet worksheet = workbook.Sheets[1];
                string val1 = worksheet.Cells[5, 3].Value;
                string val2 = worksheet.Cells[5, 4].Value;
                string val3 = worksheet.Cells[5, 6].Value;
                //DataTable result = new DataTable();
                //Workbook workbook = new Workbook();
                //workbook.Open(stream);
                //Cells cells = workbook.Worksheets[0].Cells;
                //result = cells.ExportDataTableAsString(0, 0, cells.MaxDataRow + 1, cells.MaxColumn + 1, false);
                //return result;
                // 关闭Excel应用程序
                workbook.Close();
                excelApp.Quit();
            }
            catch(Exception ex)
            {
                string error= ex.Message;//
            }
        }

        public string ImportExcel(HttpContext context)
        {
            string dep = context.Request["dep"].ToString();
            string now_date = context.Request["now_date"].ToString();
            var dd = context.Request.Files;
            string result = "";
            string dst_file = "";
            string fileName = "";
            //////////----------------------------這個是接收文件的----------------------------------------------
            foreach (string fn in context.Request.Files)
            {
                var file = context.Request.Files[fn];
                fileName = file.FileName.ToString();
                int findStrIndex = fileName.LastIndexOf("\\");
                if (findStrIndex > 0)
                    fileName = fileName.Substring(findStrIndex + 1, fileName.Length - (findStrIndex + 1));
                var savePath = context.Server.MapPath("~/file/");
                dst_file = savePath + fileName;
                FileOperatpr(dst_file, savePath);
                //result = savePath + "-->"+ fileName;
                try
                {
                    file.SaveAs(dst_file);
                }
                catch (Exception ex)
                {
                    result = ex.Message + "-->" + dst_file;
                }
            }
            if (result != "")
                return result;
            //return result;
            //////////----------------------------這個是接收文件的----------------------------------------------

            //////////----------------------------這個是接收參數的----------------------------------------------
            //string para = context.Request["param"];
            //string formData = context.Request["formData"] != null ? context.Request["formData"] : "";
            //string source_file = context.Request["source_file"] != null ? context.Request["source_file"] : "";
            //////////----------------------------這個是接收參數的----------------------------------------------
            
            //DataSet ds = null;

            OleDbConnection conn = new OleDbConnection();

            string strConn = string.Empty;

            string sheetName = string.Empty;
            try
            {
                // Excel 2003 版本连接字符串
                strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + dst_file + ";Extended Properties='Excel 8.0; HDR=YES; IMEX=1;'";
                conn = new OleDbConnection(strConn);
                conn.Open();
            }
            catch
            {
                try
                {
                    // Excel 2007 以上版本连接字符串
                    strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + dst_file + ";Extended Properties='Excel 12.0;HDR=Yes;IMEX=1;'";
                    conn = new OleDbConnection(strConn);
                    conn.Open();
                }catch(Exception ex)
                {
                    result = "不是有效的Excel文件!";
                }
            }
            if(result!="")
            {
                //关闭连接，释放资源
                conn.Close();
                conn.Dispose();
                return result;
            }

            //获取所有的 sheet 表
            System.Data.DataTable dtSheetName = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "Table" });
            //DataTable dt = new DataTable();
            //ds = new DataSet();
            string strDep = fileName.Substring(0, 3);
            string dep_group = "";
            if (dep == "102")
            {
                if (fileName.Substring(0, 3) == "萬能機")
                    dep_group = "102-A";
                else
                {
                    if (fileName.Substring(0, 2) == "雞眼")
                        dep_group = "102-B";
                }
            }
            bool findSheetFlag = false;
            for (int i = 0; i < dtSheetName.Rows.Count; i++)//這個是獲取Excel所有的Sheet
            //for (int i = 0; i < 1; i++)//只獲取Excel第1個Sheet
            {
                string prd_dep = dep;
                System.Data.DataTable dt = new System.Data.DataTable();
                dt.TableName = "table0";// + i.ToString();
                //获取表名
                sheetName = dtSheetName.Rows[i]["TABLE_NAME"].ToString();
                if (dep == "302" || dep == "322")
                {
                    if (sheetName.Substring(0, 3) == "J01")
                        prd_dep = "322";
                    else
                        prd_dep = "302";
                }
                else if (dep == "105")
                    dep_group = sheetName;
                //有些Excel是隱藏了很多個臨時表的，只將實際的導入
                //如果sheet的名字為數字開頭的如：105或105abc等，則sheetName則為：'105$'，則要將符號'去掉後再判斷
                if (sheetName.Substring(sheetName.Length - 1, 1) == "$"
                    || (sheetName.Substring(0, 1) == "'" && sheetName.Substring(sheetName.Length - 1, 1) == "'" && sheetName.Substring(sheetName.Length - 2, 1) == "$"))
                {
                    findSheetFlag = true;
                    OleDbDataAdapter oleda = new OleDbDataAdapter("select * from [" + sheetName + "]", conn);
                    oleda.Fill(dt);
                    result=DtOperator(dt,prd_dep,dep_group,now_date);
                }

            }
            //ds.Tables.Add(dt);
            //关闭连接，释放资源
            conn.Close();
            conn.Dispose();
            if (findSheetFlag == false)
                result = "沒有符合的工作表，請檢查工作表名稱是否正確!";
            if (result == "")
                result = "匯入排期表成功!";
            return result;
        }
        private void FileOperatpr(string fileName, string savePath)
        {
            if (!Directory.Exists(savePath))
            {
                Directory.CreateDirectory(savePath);
            }
            if (File.Exists(fileName))
            {
                File.Delete(fileName);
            }
        }



        private string DtOperator(System.Data.DataTable dt, string org_prd_dep,string org_dep_group, string now_date)
        {
            string result_str = "";
            string strSql = "", strSql_f = "";
            int excel_row = 1;
            //string[] proSub = Request.Form.GetValues("selDep");
            //prd_dep = proSub[selDep.SelectedIndex];
            string prd_dep = org_prd_dep;
            string dep_group = org_dep_group;
            //now_date = System.DateTime.Now.ToString("yyyy/MM/dd");
            string prd_mo, prd_item, urgent_status1, urgent_status, arrange_date, arrange_machine, to_dep_desc
                , cust_o_date = "", req_f_date, dep_rep_date, req_hk_date;
            string machine_type = "", install_moudle = "", vendor_desc = "", mo_urgent1 = "", period_flag = "";
            string pre_prd_dep_date = "";
            int pre_prd_dep_qty = 0;
            int line_num, req_num, arrange_seq, order_qty, req_qty, cpl_qty, arrange_qty, prd_cpl_qty;
            float req_time;
            string prd_status = "00";//
            string rec_status = "0";
            string user_id = bp.getUserName();

            //strSql += string.Format(@"Delete From product_arrange Where prd_dep='{0}' and now_date='{1}'", prd_dep, now_date);
            try
            {
                string arrange_seq_h = "", prd_mo_h = "", urgent_status_h = "", prd_item_h = "", cust_o_date_h = "", req_f_date_h = "", order_qty_h = "", cpl_qty_h = ""
                            , arrange_date_h = "", arrange_qty_h = "", req_qty_h = "", prd_cpl_qty_h = "", dep_rep_date_h = "", arrange_machine_h = ""
                            , req_hk_date_h = "", dep_group_h1 = "", dep_group_h2 = "", dep_group_h3 = ""
                            , pre_prd_dep_date_h = "", pre_prd_dep_qty_h = "", to_dep_desc_h = ""
                            , line_num_h = "", req_num_h = "", machine_type_h = "", install_moudle_h = "", vendor_desc_h = ""
                            , mo_urgent1_h = "", period_flag_h = "", req_time_h = "";
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string colName = dt.Columns[j].ColumnName;
                    arrange_seq_h = (colName == "序號" ? colName : arrange_seq_h);
                    prd_mo_h = (colName == "制單編號" || colName == "頁數" ? colName : prd_mo_h);
                    urgent_status_h = (colName == "急單" || colName == "状态" || colName == "狀態" ? colName : urgent_status_h);
                    arrange_date_h = (colName == "排期日期" || colName == "排期日期AA" || colName == "排期" ? colName : arrange_date_h);
                    prd_item_h = (colName == "產品編號" || colName == "物料編號" ? colName : prd_item_h);
                    to_dep_desc_h = (colName == "下部門" || colName == "收貨部門" ? colName : to_dep_desc_h);
                    cust_o_date_h = (colName == "客落單日期" ? colName : cust_o_date_h);
                    req_f_date_h = (colName == "要求完成時間" || colName == "pmc要求完成日期" || colName == "pmc要求日期" ? colName : req_f_date_h);
                    order_qty_h = (colName == "訂單數量" ? colName : order_qty_h);
                    req_qty_h = (colName == "要求數量" || colName == "應生產數量" ? colName : req_qty_h);
                    cpl_qty_h = (colName == "完成數量" || colName == "已完成數量" ? colName : cpl_qty_h);
                    arrange_qty_h = (colName == "待完成數量" || colName == "未完成數量" ? colName : arrange_qty_h);
                    prd_cpl_qty_h = (colName == "生產數量" ? colName : prd_cpl_qty_h);
                    dep_rep_date_h = (colName == "部門回覆" || colName == "部門覆期" || colName == "部門復期" ? colName : dep_rep_date_h);
                    arrange_machine_h = (colName == "生產設備" || colName == "機種" ? colName : arrange_machine_h);
                    req_hk_date_h = (colName == "計劃回港期" || colName == "計劃回港日期" || colName == "回港期" ? colName : req_hk_date_h);
                    dep_group_h1 = (colName == "自動" || colName == "组別" || colName == "組別" ? colName : dep_group_h1);
                    dep_group_h2 = (colName == "打扣" ? colName : dep_group_h2);
                    dep_group_h3 = (colName == "車碑" ? colName : dep_group_h3);
                    pre_prd_dep_date_h = (colName == "上部門來貨期" ? colName : pre_prd_dep_date_h);
                    pre_prd_dep_qty_h = (colName == "上部門來貨數量" ? colName : pre_prd_dep_qty_h);
                    line_num_h = (colName == "每啤" ? colName : line_num_h);
                    req_num_h = (colName == "需要啤數" ? colName : req_num_h);
                    req_time_h = (colName == "耗時(H)" ? colName : req_time_h);
                    install_moudle_h = (colName == "上模" ? colName : install_moudle_h);
                    vendor_desc_h = (colName == "供應商" ? colName : vendor_desc_h);
                    mo_urgent1_h = (colName == "急(1)" ? colName : mo_urgent1_h);
                    period_flag_h = (colName == "過期標識" ? colName : period_flag_h);
                }

                strSql += string.Format(@" SET XACT_ABORT  ON ");
                strSql += string.Format(@" BEGIN TRANSACTION ");
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    //strSql = "";
                    excel_row = excel_row + 1;
                    DataRow dr = dt.Rows[i];
                    //if (i == 97)
                    //{
                    //    int aa = 1;
                    //}
                    arrange_seq = (arrange_seq_h == "" ? 0 : (dr[arrange_seq_h].ToString() != "" ? Convert.ToInt32(dr[arrange_seq_h]) : 0));
                    prd_mo = (prd_mo_h == "" ? "" : dr[prd_mo_h].ToString().Trim());
                    prd_item = (prd_item_h == "" ? "" : dr[prd_item_h].ToString());
                    if (org_prd_dep == "102" || org_prd_dep == "122")
                    {
                        if (prd_mo.ToUpper().Trim() == "J02")
                        {
                            prd_dep = "122";
                            dep_group = "122-A";
                        }
                        else if (prd_mo.ToUpper().Trim() == "J03")
                        {
                            prd_dep = "122";
                            dep_group = "122-B";
                        }
                    }
                    if (prd_mo != "" && prd_item!="")
                    {
                        arrange_date = (arrange_date_h == "" ? "" : (dr[arrange_date_h].ToString() != "" ? Convert.ToDateTime(dr[arrange_date_h].ToString()).ToString("yyyy/MM/dd") : ""));
                        urgent_status1 = (urgent_status_h == "" ? "" : dr[urgent_status_h].ToString().Trim());
                        urgent_status = "";
                        if (urgent_status1 == "超特急")
                            urgent_status = "04";
                        else
                        {
                            if (urgent_status1 == "特急")
                                urgent_status = "03";
                            else
                            {
                                if (urgent_status1 == "急單" || urgent_status1 == "急")
                                    urgent_status = "02";
                                else
                                    urgent_status = "00";
                            }
                        }
                        

                        cust_o_date = (cust_o_date_h == "" ? "" : (dr[cust_o_date_h].ToString() != "" ? Convert.ToDateTime(dr[cust_o_date_h].ToString()).ToString("yyyy/MM/dd") : ""));
                        req_f_date = (req_f_date_h == "" ? "" : (dr[req_f_date_h].ToString() != "" ? Convert.ToDateTime(dr[req_f_date_h].ToString()).ToString("yyyy/MM/dd") : ""));
                        order_qty = (order_qty_h == "" ? 0 : (dr[order_qty_h].ToString() != "" ? Convert.ToInt32(dr[order_qty_h]) : 0));
                        req_qty = (req_qty_h == "" ? 0 : (dr[req_qty_h].ToString() != "" ? Convert.ToInt32(dr[req_qty_h]) : 0));
                        cpl_qty = (cpl_qty_h == "" ? 0 : (dr[cpl_qty_h].ToString() != "" ? Convert.ToInt32(dr[cpl_qty_h]) : 0));
                        arrange_qty = (arrange_qty_h == "" ? 0 : (dr[arrange_qty_h].ToString() != "" ? Convert.ToInt32(dr[arrange_qty_h]) : 0));
                        prd_cpl_qty = (prd_cpl_qty_h == "" ? 0 : (dr[prd_cpl_qty_h].ToString() != "" ? Convert.ToInt32(dr[prd_cpl_qty_h]) : 0));
                        //dep_rep_date = (dep_rep_date_h == "" ? "" : (dr[dep_rep_date_h].ToString() != "" ? Convert.ToDateTime(dr[dep_rep_date_h].ToString()).ToString("yyyy/MM/dd") : ""));
                        dep_rep_date = (dep_rep_date_h == "" ? "" : (dr[dep_rep_date_h].ToString() != "" ? dr[dep_rep_date_h].ToString() : ""));
                        to_dep_desc = (to_dep_desc_h == "" ? "" : dr[to_dep_desc_h].ToString());
                        arrange_machine = (arrange_machine_h == "" ? "" : dr[arrange_machine_h].ToString());
                        req_hk_date = (req_hk_date_h == "" ? "" : (dr[req_hk_date_h].ToString() != "" ? Convert.ToDateTime(dr[req_hk_date_h].ToString()).ToString("yyyy/MM/dd") : ""));
                        pre_prd_dep_date = (pre_prd_dep_date_h == "" ? "" : dr[pre_prd_dep_date_h].ToString());
                        pre_prd_dep_qty = (pre_prd_dep_qty_h == "" ? 0 : (dr[pre_prd_dep_qty_h].ToString() != "" ? Convert.ToInt32(dr[pre_prd_dep_qty_h]) : 0));
                        line_num = (line_num_h == "" ? 0 : (dr[line_num_h].ToString() != "" ? Convert.ToInt32(dr[line_num_h]) : 0));
                        req_num = (req_num_h == "" ? 0 : (dr[req_num_h].ToString() != "" ? Convert.ToInt32(dr[req_num_h]) : 0));
                        req_time = (req_time_h == "" ? 0 : (dr[req_time_h].ToString() != "" ? Convert.ToSingle(dr[req_time_h]) : 0));
                        machine_type = (machine_type_h == "" ? "" : dr[machine_type_h].ToString());
                        install_moudle = (install_moudle_h == "" ? "" : dr[install_moudle_h].ToString());
                        vendor_desc = (vendor_desc_h == "" ? "" : dr[vendor_desc_h].ToString());
                        mo_urgent1 = (mo_urgent1_h == "" ? "" : dr[mo_urgent1_h].ToString());
                        period_flag = (period_flag_h == "" ? "" : dr[period_flag_h].ToString());
                        if (prd_dep == "202")
                        {
                            dep_group = (dep_group_h1 == "" ? "" : dr[dep_group_h1].ToString());//自動
                            if (dep_group != "")
                                dep_group = "A";
                            else
                            {
                                if (dep_group == "")
                                {
                                    dep_group = (dep_group_h2 == "" ? "" : dr[dep_group_h2].ToString());//打扣
                                    if (dep_group != "")
                                        dep_group = "B";
                                    else
                                    {
                                        if (dep_group == "")
                                        {
                                            dep_group = (dep_group_h3 == "" ? "" : dr[dep_group_h3].ToString());//車碑
                                            if (dep_group != "")
                                                dep_group = "C";
                                        }
                                    }
                                }
                            }
                        }if(prd_dep=="105")
                            dep_group = (dep_group_h1 == "" ? "" : dr[dep_group_h1].ToString());
                        //else
                        //    dep_group = (dep_group_h1 == "" ? "" : dr[dep_group_h1].ToString());
                        string dtt = System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");

                        strSql_f = "Select arrange_id From dgcf_pad.dbo.product_arrange Where prd_dep='" + prd_dep + "' And now_date='" + now_date + "' And prd_mo='" + prd_mo + "' And prd_item='" + prd_item + "'";
                        System.Data.DataTable dtArrange = sh.ExecuteSqlReturnDataTable(strSql_f);
                        if (dtArrange.Rows.Count == 0)
                        {
                            //產生自動單號
                            string id = prd_dep + dtt.Substring(0, 4) + dtt.Substring(5, 2) + dtt.Substring(8, 2) + dtt.Substring(11, 2) + dtt.Substring(14, 2) + dtt.Substring(17, 2) + (i + 1).ToString().PadLeft(4, '0');
                            //string prd_seq = "01";
                            strSql += string.Format(@"INSERT INTO dgcf_pad.dbo.product_arrange (arrange_id,now_date,prd_dep,prd_mo,prd_item
                            ,mo_urgent,arrange_machine,arrange_date,arrange_seq,order_qty
                            ,cust_o_date,req_f_date,req_qty,cpl_qty,arrange_qty,prd_cpl_qty,dep_rep_date,rec_status,prd_status,req_hk_date
                            ,dep_group,pre_prd_dep_date,pre_prd_dep_qty,to_dep_desc, line_num, req_num, req_time, install_moudle
                            , vendor_desc, mo_urgent1, period_flag,crusr,crtim)
                            VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}'
                                ,'{17}','{18}','{19}','{20}','{21}','{22}','{23}','{24}','{25}','{26}','{27}','{28}','{29}','{30}','{31}'
                                ,GETDATE())"
                                , id, now_date, prd_dep, prd_mo, prd_item, urgent_status, arrange_machine, arrange_date, arrange_seq, order_qty
                                , cust_o_date, req_f_date, req_qty, cpl_qty, arrange_qty, prd_cpl_qty, dep_rep_date, rec_status, prd_status
                                , req_hk_date, dep_group, pre_prd_dep_date, pre_prd_dep_qty, to_dep_desc, line_num, req_num, req_time
                                , install_moudle, vendor_desc, mo_urgent1, period_flag, user_id);
                        }
                        else
                        {
                            string arrange_id = dtArrange.Rows[0]["arrange_id"].ToString();
                            strSql += string.Format(@"Update dgcf_pad.dbo.product_arrange Set mo_urgent='{0}',arrange_machine='{1}',arrange_date='{2}',arrange_seq='{3}'
                            ,order_qty='{4}',cust_o_date='{5}',req_f_date='{6}',req_qty='{7}',cpl_qty='{8}',arrange_qty='{9}',prd_cpl_qty='{10}'
                            ,dep_rep_date='{11}',rec_status='{12}',prd_status='{13}',req_hk_date='{14}',dep_group='{15}',now_date='{16}'
                            ,pre_prd_dep_date='{17}',pre_prd_dep_qty='{18}',amusr='{19}',to_dep_desc='{20}', line_num='{21}'
                            , req_num='{22}', req_time='{23}', install_moudle='{24}'
                            , vendor_desc='{25}', mo_urgent1='{26}', period_flag='{27}'
                            ,amtim=GETDATE() Where arrange_id='{28}'"
                                , urgent_status, arrange_machine, arrange_date, arrange_seq, order_qty, cust_o_date, req_f_date, req_qty
                                , cpl_qty, arrange_qty, prd_cpl_qty, dep_rep_date, rec_status, prd_status, req_hk_date, dep_group, now_date
                                , pre_prd_dep_date, pre_prd_dep_qty, user_id, to_dep_desc, line_num, req_num, req_time
                                , install_moudle, vendor_desc, mo_urgent1, period_flag, arrange_id);
                        }
                        //result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                        //if (result_str != "")
                        //{
                        //    break;
                        //}
                    }
                }
                strSql += string.Format(@" COMMIT TRANSACTION ");
                result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                //if (result_str != "")
                //{
                //    break;
                //}
            }
            catch (Exception ex)
            {
                result_str = "Excel文件的欄位不正確,行:" + excel_row.ToString() + " " + ex.Message;
            }
            return result_str;
        }

    }
}