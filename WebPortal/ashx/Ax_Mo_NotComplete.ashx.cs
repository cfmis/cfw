using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Leyp.Components;
using Leyp.SQLServerDAL;
using Leyp.Components.Module;//獲取登錄的用戶名
using System.Data.OleDb;
using System.IO;
using Microsoft.Office.Interop.Excel;
using System.Text;
using System.Reflection;
using System.Drawing;

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_Mo_NotComplete
    /// </summary>
    public class Ax_Mo_NotComplete : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string return_type = context.Request["paraa"].ToString();
            GetItem(context, return_type);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private void GetItem(HttpContext context, string return_type)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            int rpt_type = 1;
            int complete_state = 0;
            string crdat1 = "", crdat2 = "";
            string mo1 = "", mo2 = "";
            rpt_type = context.Request["rpt_type"] != "" ? Convert.ToInt32(context.Request["rpt_type"]) : 1;
            complete_state = context.Request["complete_state"] != "" ? Convert.ToInt32(context.Request["complete_state"]) : 0;
            crdat1 = context.Request["date_from"] != null ? context.Request["date_from"] : "";
            crdat2 = context.Request["date_to"] != null ? context.Request["date_to"] : "";
            mo1 = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
            mo2 = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
            if (crdat1 == "" && crdat2 == "" && mo1 == "" && mo2 == "")
            {
                crdat1 = "2000/01/01";
                crdat2 = "2000/01/01";
                mo1 = "ZZZZZZZZZ";
                mo2 = "ZZZZZZZZZ";
            }
            string strSql = "";
            strSql = "usp_OcNotCompleteProduction";
            SqlParameter[] parameters = {
                new SqlParameter("@rpt_type", rpt_type)
                ,new SqlParameter("@complete_state", complete_state)
                ,new SqlParameter("@mo_group", "")
                ,new SqlParameter("@crdat1", crdat1),new SqlParameter("@crdat2", crdat2)
                ,new SqlParameter("@crby", "")
                ,new SqlParameter("@mo1", mo1),new SqlParameter("@mo2", mo2)
                ,new SqlParameter("@brand1", "")
                ,new SqlParameter("@cust1", "")
                ,new SqlParameter("@agent1", "")
                ,new SqlParameter("@season", "")
                ,new SqlParameter("@pono", "")
                ,new SqlParameter("@ocno", "")
                ,new SqlParameter("@goods_id", "")
                };
            System.Data.DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);

            if (return_type == "xls")//返回Excel
            {
                if (rpt_type == 0)
                    ReturnValue = DataToExcel(context, dt);//生產計劃明細表
                else if (rpt_type == 1)
                    ReturnValue = DataToExcelSum(context, dt);//生產計劃匯總表
            }
            else
            {
                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }


        private string DataToExcel(HttpContext context, System.Data.DataTable dtExcel)
        {
            string result = "";
            string filePath = context.Server.MapPath("~/") + "file\\";

            string fileName = "未完成訂單明細表.xls";// DateTime.Now.ToString("yyyyMMddHHmmss") + "跟单文件.xls";

            FileOperatpr(fileName, filePath);
            //filePath = savePath + fileName;
            result = fileName;// excelFileName;
            string picPath = DBUtility.image_map_path;// context.Server.MapPath("~/") + "images\\";
            try
            {
                // 创建Excel应用程序对象
                Microsoft.Office.Interop.Excel.Application excel = new Microsoft.Office.Interop.Excel.Application();
                var ev = excel.Version;
                //excel.Visible = true;       //激活Excel
                Workbook wBook = excel.Workbooks.Add(true);
                Worksheet wSheet = (Microsoft.Office.Interop.Excel.Worksheet)wBook.ActiveSheet;
                //var wSheet = (Microsoft.Office.Interop.Excel._Worksheet)wBook.ActiveSheet;

                wSheet.Cells[1, 1] = "OC編號";
                wSheet.Cells[1, 2] = "序號";
                wSheet.Cells[1, 3] = "開單日期";
                wSheet.Cells[1, 4] = "訂單日期";
                wSheet.Cells[1, 5] = "制單類型";
                wSheet.Cells[1, 6] = "制單編號";
                wSheet.Cells[1, 7] = "產品編號";
                wSheet.Cells[1, 8] = "產品描述";
                wSheet.Cells[1, 9] = "訂單數量(PCS)";
                wSheet.Cells[1, 10] = "訂單金額(HKD)";
                wSheet.Cells[1, 11] = "要求回港日期";
                wSheet.Cells[1, 12] = "客人要求日期";
                wSheet.Cells[1, 13] = "客戶編號";
                wSheet.Cells[1, 14] = "客戶描述";
                wSheet.Cells[1, 15] = "牌子編號";
                wSheet.Cells[1, 16] = "洋行代號";
                wSheet.Cells[1, 17] = "建立人";
                wSheet.Cells[1, 18] = "組別";
                wSheet.Cells[1, 19] = "訂單數量";
                wSheet.Cells[1, 20] = "數量單位";
                wSheet.Cells[1, 21] = "單價";
                wSheet.Cells[1, 22] = "單價單位";
                wSheet.Cells[1, 23] = "貨幣代號";
                wSheet.Cells[1, 24] = "顏色描述";
                wSheet.Cells[1, 25] = "顏色做法";
                wSheet.Cells[1, 26] = "客人產品編號";
                wSheet.Cells[1, 27] = "客人顏色編號";
                wSheet.Cells[1, 28] = "季度";
                wSheet.Cells[1, 29] = "客戶PO";
                wSheet.Cells[1, 30] = "客戶款號";
                int excelRow = 2;
                int total_cols = 30;//總列數
                for (int i = 0; i < dtExcel.Rows.Count; i++)
                {
                    DataRow dr = dtExcel.Rows[i];
                    wSheet.Cells[excelRow, 1] = dr["id"].ToString();
                    wSheet.Cells[excelRow, 2] = dr["sequence_id"].ToString();
                    wSheet.Cells[excelRow, 3] = "\'" + dr["create_date"].ToString();
                    wSheet.Cells[excelRow, 4] = "\'" + dr["order_date"].ToString();
                    wSheet.Cells[excelRow, 5] = dr["mo_type"].ToString();
                    wSheet.Cells[excelRow, 6] = dr["mo_id"].ToString();
                    wSheet.Cells[excelRow, 7] = dr["goods_id"].ToString();
                    wSheet.Cells[excelRow, 8] = dr["goods_name"].ToString();
                    wSheet.Cells[excelRow, 9] = dr["qty_pcs"].ToString();
                    wSheet.Cells[excelRow, 10] = dr["amt_hkd"].ToString();
                    wSheet.Cells[excelRow, 11] = "\'" + dr["hk_req_date"].ToString();
                    wSheet.Cells[excelRow, 12] = "\'" + dr["cs_req_date"].ToString();
                    wSheet.Cells[excelRow, 13] = dr["cust_code"].ToString();
                    wSheet.Cells[excelRow, 14] = dr["cust_cname"].ToString();
                    wSheet.Cells[excelRow, 15] = dr["brand_id"].ToString();
                    wSheet.Cells[excelRow, 16] = dr["agent"].ToString();
                    wSheet.Cells[excelRow, 17] = dr["create_by"].ToString();
                    wSheet.Cells[excelRow, 18] = dr["mo_group"].ToString();
                    wSheet.Cells[excelRow, 19] = dr["order_qty"].ToString();
                    wSheet.Cells[excelRow, 20] = dr["goods_unit"].ToString();
                    wSheet.Cells[excelRow, 21] = dr["unit_price"].ToString();
                    wSheet.Cells[excelRow, 22] = dr["p_unit"].ToString();
                    wSheet.Cells[excelRow, 23] = dr["m_id"].ToString();
                    wSheet.Cells[excelRow, 24] = dr["color_name"].ToString();
                    wSheet.Cells[excelRow, 25] = dr["do_color"].ToString();
                    wSheet.Cells[excelRow, 26] = dr["customer_goods"].ToString();
                    wSheet.Cells[excelRow, 27] = dr["customer_color_id"].ToString();
                    wSheet.Cells[excelRow, 28] = dr["season"].ToString();
                    wSheet.Cells[excelRow, 29] = dr["contract_id"].ToString();
                    wSheet.Cells[excelRow, 30] = dr["table_head"].ToString();

                    wSheet.Rows[excelRow].RowHeight = 20;
                    //if (excelRow % 2 != 0)
                    //{
                    //    Range bakRange = wSheet.Range[wSheet.Cells[excelRow, 1], wSheet.Cells[excelRow, total_cols]];
                    //    //bakRange.MergeCells = true;//合併單元格
                    //    //bakRange.Style.Color = Color.LightYellow;
                    //    // 获取单元格
                    //    //Excel.Range cellRange = worksheet.Range["A1"];
                    //    bakRange.Interior.Color = Color.DarkGray.ToArgb();
                    //}

                    excelRow++;

                }


                ////标题  
                //for (int i = 0; i < 27; i++)
                //{
                //    Microsoft.Office.Interop.Excel.Range titleRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, i + 1]];//选中标题  
                //    titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                //}
                excelRow--;//退回一行
                wSheet.Rows[1].RowHeight = 40;//第一行高度

                Range titleRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, total_cols]];
                titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                //设置文本自動換行
                Microsoft.Office.Interop.Excel.Range rangeWrapText = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[excelRow, total_cols]];
                rangeWrapText.WrapText = true;
                //设置边框
                Microsoft.Office.Interop.Excel.Range allRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[excelRow, total_cols]];
                allRange.Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                allRange.Font.Size = 10;
                allRange.WrapText = true;
                //excel.get_Range("A1", "A19").Select();
                //excel.get_Range("C1", "C1").Select();
                //excel.ActiveWindow.FreezePanes = true;//冻结窗口
                ////////带有千位分隔符、2位小数和减号的标准数字格式
                ////////rng.NumberFormat = "# ##0.00:-# ##0.00"
                allRange = wSheet.Range[wSheet.Cells[2, 9], wSheet.Cells[excelRow, 9]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 10], wSheet.Cells[excelRow, 10]];
                allRange.NumberFormat = "###,###,##0.00";
                allRange = wSheet.Range[wSheet.Cells[2, 19], wSheet.Cells[excelRow, 19]];
                allRange.NumberFormat = "###,###,###";

                //wSheet.Columns.EntireColumn.AutoFit();//列宽自适应

                wSheet.PageSetup.PaperSize = XlPaperSize.xlPaperA4;//纸张大小.XIPaperSize.xIPaperA3;//.xIPaperB4;//纸张大小
                wSheet.PageSetup.Orientation = XlPageOrientation.xlLandscape;//横向:纸张方向:豎向；XlPageOrientation.xlPortrait;
                wSheet.PageSetup.TopMargin = 12.5;
                wSheet.PageSetup.BottomMargin = 20;
                wSheet.PageSetup.LeftMargin = 12.5;
                wSheet.PageSetup.RightMargin = 12.5;
                wSheet.PageSetup.HeaderMargin = 10;//页眉
                wSheet.PageSetup.FooterMargin = 10;//页脚
                wSheet.PageSetup.CenterHorizontally = true;
                wSheet.PageSetup.PrintTitleRows = "$1:$1";//顶端标题行

                // 设置禁止弹出保存和覆盖的询问提示框
                excel.DisplayAlerts = false;
                excel.AlertBeforeOverwriting = false;
                //保存工作薄

                //wBook.Save();

                //每次保存激活的表，这样才能多次操作保存不同的Excel表，默认保存位置是在”我的文档"
                //excel.ActiveWorkbook.SaveCopyAs(filePath);
                //wBook.SaveAs(filePath + fileName);
                object m_objOpt = Missing.Value;
                wBook.SaveAs(filePath + fileName, m_objOpt, m_objOpt, m_objOpt, m_objOpt, m_objOpt, Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlNoChange, m_objOpt, m_objOpt, m_objOpt, m_objOpt, m_objOpt);
                wBook.Close();
                wBook = null;
                NAR(wBook);
                excel.Quit();
                excel = null;
                NAR(excel);
                GC.Collect();

            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            return result;
        }

        private string DataToExcelSum(HttpContext context, System.Data.DataTable dtExcel)
        {
            string result = "";
            string filePath = context.Server.MapPath("~/") + "file\\";

            string fileName = "未完成訂單匯總表.xls";// DateTime.Now.ToString("yyyyMMddHHmmss") + "跟单文件.xls";

            FileOperatpr(fileName, filePath);
            //filePath = savePath + fileName;
            result = fileName;// excelFileName;
            string picPath = DBUtility.image_map_path;// context.Server.MapPath("~/") + "images\\";
            try
            {
                // 创建Excel应用程序对象
                Microsoft.Office.Interop.Excel.Application excel = new Microsoft.Office.Interop.Excel.Application();
                var ev = excel.Version;
                //excel.Visible = true;       //激活Excel
                Workbook wBook = excel.Workbooks.Add(true);
                Worksheet wSheet = (Microsoft.Office.Interop.Excel.Worksheet)wBook.ActiveSheet;
                //var wSheet = (Microsoft.Office.Interop.Excel._Worksheet)wBook.ActiveSheet;

                wSheet.Cells[1, 1] = "組別";
                wSheet.Cells[1, 2] = "制單類型";
                wSheet.Cells[1, 3] = "訂單數量(PCS)";
                wSheet.Cells[1, 4] = "訂單金額(HKD)";
                int excelRow = 2;
                int total_cols = 4;//總列數
                for (int i = 0; i < dtExcel.Rows.Count; i++)
                {
                    DataRow dr = dtExcel.Rows[i];
                    wSheet.Cells[excelRow, 1] = dr["mo_group"].ToString();
                    wSheet.Cells[excelRow, 2] = dr["mo_type"].ToString();
                    wSheet.Cells[excelRow, 3] = dr["qty_pcs"].ToString();
                    wSheet.Cells[excelRow, 4] = dr["amt_hkd"].ToString();

                    wSheet.Rows[excelRow].RowHeight = 20;
                    //if (excelRow % 2 != 0)
                    //{
                    //    Range bakRange = wSheet.Range[wSheet.Cells[excelRow, 1], wSheet.Cells[excelRow, total_cols]];
                    //    //bakRange.MergeCells = true;//合併單元格
                    //    //bakRange.Style.Color = Color.LightYellow;
                    //    // 获取单元格
                    //    //Excel.Range cellRange = worksheet.Range["A1"];
                    //    bakRange.Interior.Color = Color.DarkGray.ToArgb();
                    //}

                    excelRow++;

                }


                ////标题  
                //for (int i = 0; i < 27; i++)
                //{
                //    Microsoft.Office.Interop.Excel.Range titleRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, i + 1]];//选中标题  
                //    titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                //}
                excelRow--;//退回一行
                wSheet.Rows[1].RowHeight = 40;//第一行高度

                Range titleRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, total_cols]];
                titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                //设置文本自動換行
                Microsoft.Office.Interop.Excel.Range rangeWrapText = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[excelRow, total_cols]];
                rangeWrapText.WrapText = true;
                //设置边框
                Microsoft.Office.Interop.Excel.Range allRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[excelRow, total_cols]];
                allRange.Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                allRange.Font.Size = 10;
                allRange.WrapText = true;
                //excel.get_Range("A1", "A19").Select();
                //excel.get_Range("C1", "C1").Select();
                //excel.ActiveWindow.FreezePanes = true;//冻结窗口
                ////////带有千位分隔符、2位小数和减号的标准数字格式
                ////////rng.NumberFormat = "# ##0.00:-# ##0.00"
                allRange = wSheet.Range[wSheet.Cells[2, 3], wSheet.Cells[excelRow, 3]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 4], wSheet.Cells[excelRow, 4]];
                allRange.NumberFormat = "###,###,##0.00";

                //wSheet.Columns.EntireColumn.AutoFit();//列宽自适应

                wSheet.PageSetup.PaperSize = XlPaperSize.xlPaperA4;//纸张大小.XIPaperSize.xIPaperA3;//.xIPaperB4;//纸张大小
                wSheet.PageSetup.Orientation = XlPageOrientation.xlLandscape;//横向:纸张方向:豎向；XlPageOrientation.xlPortrait;
                wSheet.PageSetup.TopMargin = 12.5;
                wSheet.PageSetup.BottomMargin = 20;
                wSheet.PageSetup.LeftMargin = 12.5;
                wSheet.PageSetup.RightMargin = 12.5;
                wSheet.PageSetup.HeaderMargin = 10;//页眉
                wSheet.PageSetup.FooterMargin = 10;//页脚
                wSheet.PageSetup.CenterHorizontally = true;
                wSheet.PageSetup.PrintTitleRows = "$1:$1";//顶端标题行

                // 设置禁止弹出保存和覆盖的询问提示框
                excel.DisplayAlerts = false;
                excel.AlertBeforeOverwriting = false;
                //保存工作薄

                //wBook.Save();

                //每次保存激活的表，这样才能多次操作保存不同的Excel表，默认保存位置是在”我的文档"
                //excel.ActiveWorkbook.SaveCopyAs(filePath);
                //wBook.SaveAs(filePath + fileName);
                object m_objOpt = Missing.Value;
                wBook.SaveAs(filePath + fileName, m_objOpt, m_objOpt, m_objOpt, m_objOpt, m_objOpt, Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlNoChange, m_objOpt, m_objOpt, m_objOpt, m_objOpt, m_objOpt);
                wBook.Close();
                wBook = null;
                NAR(wBook);
                excel.Quit();
                excel = null;
                NAR(excel);
                GC.Collect();

            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            return result;
        }
        private void FileOperatpr(string fileName, string savePath)
        {
            if (!Directory.Exists(savePath))
            {
                Directory.CreateDirectory(savePath);
            }
            if (File.Exists(savePath + fileName))
            {
                File.Delete(savePath + fileName);
            }
        }

        private void NAR(object o)
        {
            try
            {
                while (System.Runtime.InteropServices.Marshal.FinalReleaseComObject(o) > 0) ;
            }
            catch { }
            finally
            {
                o = null;
            }
        }
    }
}