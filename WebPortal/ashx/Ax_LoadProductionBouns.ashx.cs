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
    /// Summary description for Ax_LoadProductionBouns
    /// </summary>
    public class Ax_LoadProductionBouns : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string return_type = context.Request["paraa"].ToString();
            GetData(context, return_type);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private void GetData(HttpContext context, string return_type)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            int rpt_type = 1;
            string dep = "";
            string date_from = "", date_to = "";
            string prd_worktype = "";
            rpt_type = context.Request["rpt_type"] != null ? Convert.ToInt32(context.Request["rpt_type"]) : 1;
            dep = context.Request["dep"] != null ? context.Request["dep"] : "";
            date_from = context.Request["date_from"] != null ? context.Request["date_from"] : "";
            date_to = context.Request["date_to"] != null ? context.Request["date_to"] : "";
            prd_worktype = context.Request["prd_worktype"] != null ? context.Request["prd_worktype"] : "";
            if (date_from == "" && date_to == "")
            {
                date_from = System.DateTime.Now.ToString("yyyy/MM/dd");
                date_to = date_from;
            }
            string strSql = "";
            strSql = "usp_LoadProductionBonus";
            SqlParameter[] parameters = {
                new SqlParameter("@rpt_type", rpt_type)
                ,new SqlParameter("@dep", dep)
                ,new SqlParameter("@date_from", date_from),new SqlParameter("@date_to", date_to)
                ,new SqlParameter("@prd_worktype", prd_worktype)
                };
            System.Data.DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);

            if (return_type == "xls")//返回Excel
            {
                if (rpt_type == 0)
                    ReturnValue = DataToExcelPrdDetails(context, dt, dep);//生產計劃明細表
                else
                    ReturnValue = DataToExcelPrdSum(context, dt, dep, date_from);//生產匯總表
            }
            else
            {
                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

        /// <summary>
        /// ///生產數獎金匯總表
        /// </summary>
        /// <param name="context"></param>
        /// <param name="dtExcel"></param>
        /// <param name="dep"></param>
        /// <param name="prd_date"></param>
        /// <returns></returns>
        private string DataToExcelPrdSum(HttpContext context, System.Data.DataTable dtExcel, string dep,string prd_date)
        {
            string result = "";
            string filePath = context.Server.MapPath("~/") + "file\\";

            string fileName = dep + "部門生產獎金.xls";// DateTime.Now.ToString("yyyyMMddHHmmss") + "跟单文件.xls";

            FileOperatpr(fileName, filePath);
            //filePath = savePath + fileName;
            result = fileName;// excelFileName;
            try
            {
                // 创建Excel应用程序对象
                Microsoft.Office.Interop.Excel.Application excel = new Microsoft.Office.Interop.Excel.Application();
                var ev = excel.Version;
                //excel.Visible = true;       //激活Excel
                Workbook wBook = excel.Workbooks.Add(true);
                Worksheet wSheet = (Microsoft.Office.Interop.Excel.Worksheet)wBook.ActiveSheet;
                //var wSheet = (Microsoft.Office.Interop.Excel._Worksheet)wBook.ActiveSheet;
                int excelRow = 1;
                int total_cols = 10;//總列數
                wSheet.Cells[excelRow, 1] = prd_date.Substring(0,7)+" 月份部門生產獎金";
                Range titleRange = wSheet.Range[wSheet.Cells[excelRow, 1], wSheet.Cells[excelRow, total_cols]];
                titleRange.MergeCells = true;//合併單元格
                titleRange.Font.Size = 14;
                titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                wSheet.Rows[excelRow].RowHeight = 30;
                excelRow++;
                wSheet.Cells[excelRow, 1] = "部門";
                wSheet.Cells[excelRow, 2] = "車間";
                wSheet.Cells[excelRow, 3] = "車間描述";
                wSheet.Cells[excelRow, 4] = "工號";
                wSheet.Cells[excelRow, 5] = "姓名";
                wSheet.Cells[excelRow, 6] = "職位";
                wSheet.Cells[excelRow, 7] = "職位描述";
                wSheet.Cells[excelRow, 8] = "生產數量";
                wSheet.Cells[excelRow, 9] = "生產時數";
                wSheet.Cells[excelRow, 10] = "應得獎金";
                wSheet.Rows[excelRow].RowHeight = 30;
                excelRow++;
                string picPath = DBUtility.image_map_path;// context.Server.MapPath("~/") + "images\\";
                for (int i = 0; i < dtExcel.Rows.Count; i++)
                {
                    DataRow dr = dtExcel.Rows[i];
                    wSheet.Cells[excelRow, 1] = dr["prd_dep"].ToString();
                    wSheet.Cells[excelRow, 2] = dr["dep_group"].ToString();
                    wSheet.Cells[excelRow, 3] = dr["dep_group_desc"].ToString();
                    wSheet.Cells[excelRow, 4] = "\'" + dr["prd_worker"].ToString();
                    wSheet.Cells[excelRow, 5] = dr["hrm1name"].ToString();
                    wSheet.Cells[excelRow, 6] = "\'" + dr["hrm1job"].ToString();
                    wSheet.Cells[excelRow, 7] = dr["hrc5name"].ToString();
                    wSheet.Cells[excelRow, 8] = dr["prd_nor_qty"].ToString();
                    wSheet.Cells[excelRow, 9] = dr["count_time"].ToString();
                    wSheet.Cells[excelRow, 10] = dr["prd_bonus"].ToString();
                    wSheet.Rows[excelRow].RowHeight = 30;
                    excelRow++;
                }

                ////标题  
                //for (int i = 0; i < 27; i++)
                //{
                //    Microsoft.Office.Interop.Excel.Range titleRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, i + 1]];//选中标题  
                //    titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                //}
                excelRow--;//退回一行
                
                
                //设置边框
                Microsoft.Office.Interop.Excel.Range allRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[excelRow, total_cols]];
                allRange.Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                allRange.Font.Size = 10;
                allRange.WrapText = true;
                ////////带有千位分隔符、2位小数和减号的标准数字格式
                ////////rng.NumberFormat = "# ##0.00:-# ##0.00"
                allRange = wSheet.Range[wSheet.Cells[2, 8], wSheet.Cells[excelRow, 8]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 9], wSheet.Cells[excelRow, 9]];
                allRange.NumberFormat = "###,##0.00";
                wSheet.Columns[1].ColumnWidth = 6;
                wSheet.Columns[2].ColumnWidth = 6;
                wSheet.Columns[3].ColumnWidth = 10;
                wSheet.Columns[4].ColumnWidth = 10;
                wSheet.Columns[5].ColumnWidth = 8;
                wSheet.Columns[6].ColumnWidth = 6;
                wSheet.Columns[7].ColumnWidth = 10;
                wSheet.Columns[8].ColumnWidth = 10;
                wSheet.Columns[9].ColumnWidth = 8;
                wSheet.Columns[10].ColumnWidth = 8;

                //wSheet.Columns.EntireColumn.AutoFit();//列宽自适应

                wSheet.Columns[1].Hidden = true;
                wSheet.Columns[2].Hidden = true;

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

        /// <summary>
        /// ///生產數明細表
        /// </summary>
        /// <param name="context"></param>
        /// <param name="dtExcel"></param>
        /// <param name="dep"></param>
        /// <returns></returns>
        private string DataToExcelPrdDetails(HttpContext context, System.Data.DataTable dtExcel, string dep)
        {
            string result = "";
            string filePath = context.Server.MapPath("~/") + "file\\";

            string fileName = dep + "部門生產數明細表.xls";// DateTime.Now.ToString("yyyyMMddHHmmss") + "跟单文件.xls";

            FileOperatpr(fileName, filePath);
            //filePath = savePath + fileName;
            result = fileName;// excelFileName;
            try
            {
                // 创建Excel应用程序对象
                Microsoft.Office.Interop.Excel.Application excel = new Microsoft.Office.Interop.Excel.Application();
                var ev = excel.Version;
                //excel.Visible = true;       //激活Excel
                Workbook wBook = excel.Workbooks.Add(true);
                Worksheet wSheet = (Microsoft.Office.Interop.Excel.Worksheet)wBook.ActiveSheet;
                //var wSheet = (Microsoft.Office.Interop.Excel._Worksheet)wBook.ActiveSheet;
                int excelRow = 1, total_cols = 29;
                wSheet.Cells[excelRow, 1] = "部門";
                wSheet.Cells[excelRow, 2] = "車間";
                wSheet.Cells[excelRow, 3] = "工號";
                wSheet.Cells[excelRow, 4] = "姓名";
                wSheet.Cells[excelRow, 5] = "生產日期";
                wSheet.Cells[excelRow, 6] = "生產類型";
                wSheet.Cells[excelRow, 7] = "類型描述";
                wSheet.Cells[excelRow, 8] = "制單編號";
                wSheet.Cells[excelRow, 9] = "物料編號";
                wSheet.Cells[excelRow, 10] = "物料描述";
                wSheet.Cells[excelRow, 11] = "開始時間";
                wSheet.Cells[excelRow, 12] = "結束時間";
                wSheet.Cells[excelRow, 13] = "正常班時數";
                wSheet.Cells[excelRow, 14] = "加班時數";
                wSheet.Cells[excelRow, 15] = "生產時數";
                wSheet.Cells[excelRow, 16] = "每小時標準數量";
                wSheet.Cells[excelRow, 17] = "應生產數量";
                wSheet.Cells[excelRow, 18] = "實際生產數量";
                wSheet.Cells[excelRow, 19] = "生產重量";
                wSheet.Cells[excelRow, 20] = "難度";
                wSheet.Cells[excelRow, 21] = "倍數";
                wSheet.Cells[excelRow, 22] = "應計時數";
                wSheet.Cells[excelRow, 23] = "應得獎金";
                wSheet.Cells[excelRow, 24] = "工種類型";
                wSheet.Cells[excelRow, 25] = "生產機器";
                wSheet.Cells[excelRow, 26] = "職位";
                wSheet.Cells[excelRow, 27] = "職位描述";
                wSheet.Cells[excelRow, 28] = "員工所屬";
                wSheet.Cells[excelRow, 29] = "單據編號";
                wSheet.Rows[excelRow].RowHeight = 20;
                excelRow++;
                string picPath = DBUtility.image_map_path;// context.Server.MapPath("~/") + "images\\";
                for (int i = 0; i < dtExcel.Rows.Count; i++)
                {
                    DataRow dr = dtExcel.Rows[i];
                    wSheet.Cells[excelRow, 1] = "\'" + dr["prd_dep"].ToString();
                    wSheet.Cells[excelRow, 2] = dr["dep_group"].ToString();
                    wSheet.Cells[excelRow, 3] = "\'" + dr["prd_worker"].ToString();
                    wSheet.Cells[excelRow, 4] = dr["hrm1name"].ToString();
                    wSheet.Cells[excelRow, 5] = "\'" + dr["prd_date"].ToString();
                    wSheet.Cells[excelRow, 6] = dr["prd_work_type"].ToString();
                    wSheet.Cells[excelRow, 7] = dr["prd_work_type_desc"].ToString();
                    wSheet.Cells[excelRow, 8] = dr["prd_mo"].ToString();
                    wSheet.Cells[excelRow, 9] = dr["prd_item"].ToString();
                    wSheet.Cells[excelRow, 10] = dr["prd_item_cdesc"].ToString();
                    wSheet.Cells[excelRow, 11] = dr["prd_start_time"].ToString();
                    wSheet.Cells[excelRow, 12] = dr["prd_end_time"].ToString();
                    wSheet.Cells[excelRow, 13] = dr["prd_normal_time"].ToString();
                    wSheet.Cells[excelRow, 14] = dr["prd_ot_time"].ToString();
                    wSheet.Cells[excelRow, 15] = dr["prd_time"].ToString();
                    wSheet.Cells[excelRow, 16] = dr["hour_std_qty"].ToString();
                    wSheet.Cells[excelRow, 17] = dr["prd_req_qty"].ToString();
                    wSheet.Cells[excelRow, 18] = dr["prd_qty"].ToString();
                    wSheet.Cells[excelRow, 19] = dr["prd_weg"].ToString();
                    wSheet.Cells[excelRow, 20] = dr["difficulty_level"].ToString();
                    wSheet.Cells[excelRow, 21] = dr["time_rate"].ToString();
                    wSheet.Cells[excelRow, 22] = dr["count_time"].ToString();
                    wSheet.Cells[excelRow, 23] = dr["prd_bonus"].ToString();
                    wSheet.Cells[excelRow, 24] = dr["job_type"].ToString();
                    wSheet.Cells[excelRow, 25] = dr["prd_machine"].ToString();
                    wSheet.Cells[excelRow, 26] = dr["hrm1job"].ToString();
                    wSheet.Cells[excelRow, 27] = dr["hrc5name"].ToString();
                    wSheet.Cells[excelRow, 28] = dr["hrm1corp"].ToString();
                    wSheet.Cells[excelRow, 29] = dr["prd_id"].ToString();
                    wSheet.Rows[excelRow].RowHeight = 20;
                    excelRow++;
                }

                ////标题  
                //for (int i = 0; i < 27; i++)
                //{
                //    Microsoft.Office.Interop.Excel.Range titleRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, i + 1]];//选中标题  
                //    titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                //}
                excelRow--;//退回一行


                //设置边框
                Microsoft.Office.Interop.Excel.Range allRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[excelRow, total_cols]];
                allRange.Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                allRange.Font.Size = 10;
                allRange.WrapText = true;
                ////////带有千位分隔符、2位小数和减号的标准数字格式
                ////////rng.NumberFormat = "# ##0.00:-# ##0.00"
                allRange = wSheet.Range[wSheet.Cells[2, 16], wSheet.Cells[excelRow, 16]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 17], wSheet.Cells[excelRow, 17]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 18], wSheet.Cells[excelRow, 18]];
                allRange.NumberFormat = "###,###,###";
                wSheet.Columns[1].ColumnWidth = 6;
                wSheet.Columns[2].ColumnWidth = 6;
                wSheet.Columns[3].ColumnWidth = 10;
                wSheet.Columns[4].ColumnWidth = 10;
                wSheet.Columns[5].ColumnWidth = 8;
                wSheet.Columns[6].ColumnWidth = 6;
                wSheet.Columns[7].ColumnWidth = 10;
                wSheet.Columns[8].ColumnWidth = 10;
                wSheet.Columns[9].ColumnWidth = 20;
                wSheet.Columns[10].ColumnWidth = 40;

                //wSheet.Columns.EntireColumn.AutoFit();//列宽自适应

                wSheet.Columns[1].Hidden = true;
                wSheet.Columns[2].Hidden = true;

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