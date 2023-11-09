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

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_Mo_LoadDepPlan
    /// </summary>
    public class Ax_Mo_LoadDepPlan : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string return_type = context.Request["paraa"].ToString();
            //if (type == "100")
            //    DownloadExcel(context);
            //else
            GetPlan(context, return_type);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private void GetPlan(HttpContext context,string return_type)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            int rpt_flag = 1;
            string dep = "";
            string date_from = "", date_to = "";
            string mo_from = "", mo_to = "";
            rpt_flag = context.Request["rpt_type"] != null ? Convert.ToInt32(context.Request["rpt_type"]) : 1;
            dep = context.Request["dep"] != null ? context.Request["dep"] : "";
            date_from = context.Request["date_from"] != null ? context.Request["date_from"] : "";
            date_to = context.Request["date_to"] != null ? context.Request["date_to"] : "";
            mo_from = context.Request["mo_from"] != null ? context.Request["mo_from"] : "";
            mo_to = context.Request["mo_to"] != null ? context.Request["mo_to"] : "";
            if (date_from == "" && date_to == "" && mo_from == "" && mo_to == "")
            {
                mo_from = "ZZZZZZZZZ";
                mo_to = "ZZZZZZZZZ";
            }
            string strSql = "";
            strSql = "usp_DepPlanStatus";
            if (rpt_flag == 2)
            {
                strSql = "usp_DepPlanStatusPrd";
            }
            SqlParameter[] parameters = {
                new SqlParameter("@rpt_flag", rpt_flag)
                ,new SqlParameter("@dep", dep)
                ,new SqlParameter("@date_from", date_from),new SqlParameter("@date_to", date_to)
                ,new SqlParameter("@mo_from", mo_from),new SqlParameter("@mo_to", mo_to)
                };
            System.Data.DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);

            if (return_type == "xls")//返回Excel
            {
                if (rpt_flag == 0)
                    ReturnValue = DataToExcel(context, dt, dep);//生產計劃明細表
                else if (rpt_flag == 1)
                    ReturnValue = DataToExcelSum(context, dt, dep);//生產計劃匯總表
                else
                    ReturnValue = DataToExcelPrd(context, dt, dep);//生產匯總表
            }
            else
            {
                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }


        private string DataToExcel(HttpContext context,System.Data.DataTable dtExcel,string dep)
        {
            string result = "";
            string filePath = context.Server.MapPath("~/") + "file\\";

            string fileName = dep+"部門生產計劃單.xls";// DateTime.Now.ToString("yyyyMMddHHmmss") + "跟单文件.xls";

            FileOperatpr(fileName, filePath);
            //filePath = savePath + fileName;
            result = fileName;// excelFileName;
            try
            {
                // 创建Excel应用程序对象
                Microsoft.Office.Interop.Excel.Application excel = new Microsoft.Office.Interop.Excel.Application();
                var ev=excel.Version;
                //excel.Visible = true;       //激活Excel
                Workbook wBook = excel.Workbooks.Add(true);
                Worksheet wSheet = (Microsoft.Office.Interop.Excel.Worksheet)wBook.ActiveSheet;
                //var wSheet = (Microsoft.Office.Interop.Excel._Worksheet)wBook.ActiveSheet;
                wSheet.Cells[1, 1] = "序號 ";
                wSheet.Cells[1, 2] = "制單編號";
                wSheet.Cells[1, 3] = "排期日期";
                wSheet.Cells[1, 4] = "急單";
                wSheet.Cells[1, 5] = "產品編號";
                wSheet.Cells[1, 6] = "產品描述";
                wSheet.Cells[1, 7] = "圖片";
                wSheet.Cells[1, 8] = "PMC要求日期";
                wSheet.Cells[1, 9] = "訂單數量";
                wSheet.Cells[1, 10] = "要求數量";
                wSheet.Cells[1, 11] = "完成數量";
                wSheet.Cells[1, 12] = "待完成數量";
                wSheet.Cells[1, 13] = "生產數量";
                wSheet.Cells[1, 14] = "部門覆期";
                wSheet.Cells[1, 15] = "下部門";
                wSheet.Cells[1, 16] = "標準時產量";
                wSheet.Cells[1, 17] = "需要時間";
                wSheet.Cells[1, 18] = "生產設備";
                wSheet.Cells[1, 19] = "計劃回港期";
                wSheet.Cells[1, 20] = "上部門來貨數量";
                wSheet.Cells[1, 21] = "上部門來貨期";
                wSheet.Cells[1, 22] = "组別";
                wSheet.Cells[1, 23] = "每啤";
                wSheet.Cells[1, 24] = "需要啤數";
                wSheet.Cells[1, 25] = "上模";
                wSheet.Cells[1, 26] = "供應商";
                wSheet.Cells[1, 27] = "過期標識";
                int excelRow = 2;
                string picPath = DBUtility.image_map_path;// context.Server.MapPath("~/") + "images\\";
                for (int i = 0; i < dtExcel.Rows.Count; i++)
                {
                    DataRow dr = dtExcel.Rows[i];
                    wSheet.Cells[excelRow, 1] = dr["arrange_seq"].ToString();
                    wSheet.Cells[excelRow, 2] = dr["prd_mo"].ToString();
                    wSheet.Cells[excelRow, 3] = dr["arrange_date"].ToString() != "" ? "\'" + dr["arrange_date"].ToString() : "";// "=\"" +dr["arrange_date"].ToString() + "\"";
                    wSheet.Cells[excelRow, 4] = dr["status_desc"].ToString();
                    wSheet.Cells[excelRow, 5] = dr["prd_item"].ToString();
                    wSheet.Cells[excelRow, 6] = dr["goods_cname"].ToString();
                    wSheet.Cells[excelRow, 7] = "";
                    wSheet.Cells[excelRow, 8] = dr["req_f_date"].ToString() != "" ? "\'" + dr["req_f_date"].ToString() : ""; //"=\"" + dr["req_f_date"].ToString() + "\"";
                    wSheet.Cells[excelRow, 9] = dr["order_qty"].ToString();
                    wSheet.Cells[excelRow, 10] = dr["req_qty"].ToString();
                    wSheet.Cells[excelRow, 11] = dr["cpl_qty"].ToString();
                    wSheet.Cells[excelRow, 12] = dr["arrange_qty"].ToString();
                    wSheet.Cells[excelRow, 13] = dr["prd_cpl_qty"].ToString();
                    wSheet.Cells[excelRow, 14] = dr["dep_rep_date"].ToString();
                    wSheet.Cells[excelRow, 15] = dr["to_dep_desc"].ToString();
                    wSheet.Cells[excelRow, 16] = dr["hour_std_qty"].ToString();
                    wSheet.Cells[excelRow, 17] = dr["req_time"].ToString();
                    wSheet.Cells[excelRow, 18] = dr["arrange_machine"].ToString();
                    wSheet.Cells[excelRow, 19] = dr["req_hk_date"].ToString() != "" ? "\'" + dr["req_hk_date"].ToString() : ""; //"=\"" + dr["req_hk_date"].ToString() + "\"";
                    wSheet.Cells[excelRow, 20] = dr["pre_prd_dep_qty"].ToString();
                    wSheet.Cells[excelRow, 21] = dr["pre_prd_dep_date"].ToString() != "" ? "\'" + dr["pre_prd_dep_date"].ToString() : ""; //"=\"" + dr["pre_prd_dep_date"].ToString() + "\"";
                    wSheet.Cells[excelRow, 22] = dr["dep_group"].ToString();
                    wSheet.Cells[excelRow, 23] = dr["line_num"].ToString();
                    wSheet.Cells[excelRow, 24] = dr["req_num"].ToString();
                    wSheet.Cells[excelRow, 25] = dr["install_moudle"].ToString();
                    wSheet.Cells[excelRow, 26] = dr["vendor_desc"].ToString();
                    wSheet.Cells[excelRow, 27] = dr["period_flag"].ToString();
                    string picName = dr["art_image"].ToString().Trim(); //"pencil.png";
                    if (picName != "")
                    {
                        picName = picName.Replace("\\", "/");
                        picName = picPath + picName;
                        string file_d = context.Server.MapPath(picName);
                        //file_d = context.Server.MapPath("~/") + "images\\"+ "leftico01.png";
                        if (File.Exists(file_d))
                        {
                            Microsoft.Office.Interop.Excel.Range picRange = wSheet.Range[wSheet.Cells[excelRow, 7], wSheet.Cells[excelRow, 7]];
                            picRange.Select();
                            //object m_objOpt = Missing.Value;
                            //Pictures pics = (Pictures)wSheet.Pictures(m_objOpt);
                            //pics.Insert(file_d, m_objOpt);

                            float PicLeft, PicTop;
                            PicLeft = Convert.ToSingle(picRange.Left+2);
                            PicTop = Convert.ToSingle(picRange.Top+2);
                            wSheet.Shapes.AddPicture(file_d, Microsoft.Office.Core.MsoTriState.msoFalse, Microsoft.Office.Core.MsoTriState.msoTrue, PicLeft, PicTop, 50, 50);


                        }
                    }
                    wSheet.Rows[excelRow].RowHeight = 60;
                    excelRow++;
                }

                ////标题  
                //for (int i = 0; i < 27; i++)
                //{
                //    Microsoft.Office.Interop.Excel.Range titleRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, i + 1]];//选中标题  
                //    titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                //}
                excelRow--;//退回一行
                wSheet.Rows[1].RowHeight = 30;//第一行高度
                Range titleRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, 27]];
                titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                //设置边框
                Microsoft.Office.Interop.Excel.Range allRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[excelRow, 27]];
                allRange.Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                allRange.Font.Size = 10;
                allRange = wSheet.Range[wSheet.Cells[2, 9], wSheet.Cells[excelRow, 9]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 10], wSheet.Cells[excelRow, 10]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 11], wSheet.Cells[excelRow, 11]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 12], wSheet.Cells[excelRow, 12]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 13], wSheet.Cells[excelRow, 13]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 16], wSheet.Cells[excelRow, 16]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 20], wSheet.Cells[excelRow, 20]];
                allRange.NumberFormat = "###,###,###";
                Microsoft.Office.Interop.Excel.Range Range1 = wSheet.Range[wSheet.Cells[1, 19], wSheet.Cells[excelRow, 19]];
                Range1.NumberFormatLocal = "YYYY/MM/DD";// "YYYY-MM-DD HH:MM:SS";

                //设置文本自動換行
                Microsoft.Office.Interop.Excel.Range rangeWrapText = wSheet.Range[wSheet.Cells[1, 6], wSheet.Cells[excelRow, 6]];
                rangeWrapText.WrapText = true;
                rangeWrapText = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, 27]];
                rangeWrapText.WrapText = true;
                wSheet.Columns[1].ColumnWidth = 4;
                wSheet.Columns[4].ColumnWidth = 5;
                wSheet.Columns[6].ColumnWidth = 30;
                wSheet.Columns[7].ColumnWidth = 10;
                wSheet.Columns[9].ColumnWidth = 6;
                wSheet.Columns[10].ColumnWidth = 6;
                wSheet.Columns[11].ColumnWidth = 6;
                wSheet.Columns[12].ColumnWidth = 6;
                wSheet.Columns[13].ColumnWidth = 6;
                wSheet.Columns[16].ColumnWidth = 6;
                wSheet.Columns[17].ColumnWidth = 5;
                wSheet.Columns[20].ColumnWidth = 6;
                wSheet.Columns[27].ColumnWidth = 6;

                wSheet.Columns[5].Hidden = true;

                //wSheet.Columns.EntireColumn.AutoFit();//列宽自适应

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
                excel.Quit();

            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            return result;
        }


        private string DataToExcelSum(HttpContext context, System.Data.DataTable dtExcel, string dep)
        {
            string result = "";
            string filePath = context.Server.MapPath("~/") + "file\\";

            string fileName = dep + "部門生產計劃匯總表.xls";// DateTime.Now.ToString("yyyyMMddHHmmss") + "跟单文件.xls";

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
                wSheet.Cells[1, 1] = "部門";
                wSheet.Cells[1, 2] = "部門描述";
                wSheet.Cells[1, 3] = "車間";
                wSheet.Cells[1, 4] = "車間描述";
                wSheet.Cells[1, 5] = "日標準產量";
                wSheet.Cells[1, 6] = "制單狀態";
                wSheet.Cells[1, 7] = "過期或到期日期";
                wSheet.Cells[1, 8] = "做貨單單數";
                wSheet.Cells[1, 9] = "做貨單數量";
                wSheet.Cells[1, 10] = "需生產天數";
                wSheet.Cells[1, 11] = "Y單單數";
                wSheet.Cells[1, 12] = "Y單數量";
                wSheet.Cells[1, 13] = "需生產天數";
                wSheet.Cells[1, 14] = "合計單數";
                wSheet.Cells[1, 15] = "合計數量";
                wSheet.Cells[1, 16] = "需生產天數";
                wSheet.Cells[1, 17] = "急單單數";
                wSheet.Cells[1, 18] = "急單數量";
                wSheet.Cells[1, 19] = "需生產天數";
                int excelRow = 2;
                string picPath = DBUtility.image_map_path;// context.Server.MapPath("~/") + "images\\";
                for (int i = 0; i < dtExcel.Rows.Count; i++)
                {
                    DataRow dr = dtExcel.Rows[i];
                    wSheet.Cells[excelRow, 1] = dr["wp_id"].ToString();
                    wSheet.Cells[excelRow, 2] = dr["dep_cdesc"].ToString();
                    wSheet.Cells[excelRow, 3] = dr["wp_group"].ToString();
                    wSheet.Cells[excelRow, 4] = dr["prd_group_desc"].ToString();
                    wSheet.Cells[excelRow, 5] = dr["day_std_qty"].ToString();
                    wSheet.Cells[excelRow, 6] = dr["flag_desc"].ToString();
                    wSheet.Cells[excelRow, 7] = dr["flag_cdesc"].ToString();
                    wSheet.Cells[excelRow, 8] = dr["p_g"].ToString();
                    wSheet.Cells[excelRow, 9] = dr["q_g"].ToString();
                    wSheet.Cells[excelRow, 10] = dr["g_n_day"].ToString();
                    wSheet.Cells[excelRow, 11] = dr["p_y"].ToString();
                    wSheet.Cells[excelRow, 12] = dr["q_y"].ToString();
                    wSheet.Cells[excelRow, 13] = dr["p_n_day"].ToString();
                    wSheet.Cells[excelRow, 14] = dr["tot_mo"].ToString();
                    wSheet.Cells[excelRow, 15] = dr["tot_qty"].ToString();
                    wSheet.Cells[excelRow, 16] = dr["tot_n_day"].ToString();
                    wSheet.Cells[excelRow, 17] = dr["urgent_m_s"].ToString();
                    wSheet.Cells[excelRow, 18] = dr["urgent_q_s"].ToString();
                    wSheet.Cells[excelRow, 19] = dr["urgent_n_day"].ToString();

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
                wSheet.Rows[1].RowHeight = 40;//第一行高度
                Range titleRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, 19]];
                titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                //设置边框
                Microsoft.Office.Interop.Excel.Range allRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[excelRow, 19]];
                allRange.Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                allRange.Font.Size = 10;
                allRange.WrapText = true;
                ////////带有千位分隔符、2位小数和减号的标准数字格式
                ////////rng.NumberFormat = "# ##0.00:-# ##0.00"
                allRange = wSheet.Range[wSheet.Cells[2, 5], wSheet.Cells[excelRow, 5]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 8], wSheet.Cells[excelRow, 19]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 10], wSheet.Cells[excelRow, 10]];
                allRange.NumberFormat = "###,###,##0.00";
                allRange = wSheet.Range[wSheet.Cells[2, 13], wSheet.Cells[excelRow, 13]];
                allRange.NumberFormat = "###,###,##0.00";
                allRange = wSheet.Range[wSheet.Cells[2, 16], wSheet.Cells[excelRow, 16]];
                allRange.NumberFormat = "###,###,##0.00";
                allRange = wSheet.Range[wSheet.Cells[2, 19], wSheet.Cells[excelRow, 19]];
                allRange.NumberFormat = "###,###,##0.00";

                wSheet.Columns[1].ColumnWidth = 3;
                wSheet.Columns[2].ColumnWidth = 7;
                wSheet.Columns[3].ColumnWidth = 5;
                wSheet.Columns[4].ColumnWidth = 8;
                wSheet.Columns[5].ColumnWidth = 8.8;
                wSheet.Columns[6].ColumnWidth = 7;
                wSheet.Columns[7].ColumnWidth = 12;
                wSheet.Columns[8].ColumnWidth = 4;
                wSheet.Columns[9].ColumnWidth = 7.5;
                wSheet.Columns[10].ColumnWidth = 4;
                wSheet.Columns[11].ColumnWidth = 4;
                wSheet.Columns[12].ColumnWidth = 7.5;
                wSheet.Columns[13].ColumnWidth = 4;
                wSheet.Columns[14].ColumnWidth = 4;
                wSheet.Columns[15].ColumnWidth = 7.5;
                wSheet.Columns[16].ColumnWidth = 4;
                wSheet.Columns[17].ColumnWidth = 4;
                wSheet.Columns[18].ColumnWidth = 7.5;
                wSheet.Columns[19].ColumnWidth = 4;
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
                excel.Quit();

            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            return result;
        }


        private string DataToExcelPrd(HttpContext context, System.Data.DataTable dtExcel, string dep)
        {
            string result = "";
            string filePath = context.Server.MapPath("~/") + "file\\";

            string fileName = dep + "部門生產匯總表.xls";// DateTime.Now.ToString("yyyyMMddHHmmss") + "跟单文件.xls";

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
                wSheet.Cells[1, 1] = "部門";
                wSheet.Cells[1, 2] = "部門描述";
                wSheet.Cells[1, 3] = "車間";
                wSheet.Cells[1, 4] = "車間描述";
                wSheet.Cells[1, 5] = "生產日期";
                wSheet.Cells[1, 6] = "日標準產量";
                wSheet.Cells[1, 7] = "生產數量";
                wSheet.Cells[1, 8] = "產量達標率";
                wSheet.Cells[1, 9] = "每小時標準產量";
                wSheet.Cells[1, 10] = "每小時產量";
                wSheet.Cells[1, 11] = "產能達標率";
                int excelRow = 2;
                string picPath = DBUtility.image_map_path;// context.Server.MapPath("~/") + "images\\";
                for (int i = 0; i < dtExcel.Rows.Count; i++)
                {
                    DataRow dr = dtExcel.Rows[i];
                    wSheet.Cells[excelRow, 1] = dr["prd_dep"].ToString();
                    wSheet.Cells[excelRow, 2] = "";
                    wSheet.Cells[excelRow, 3] = dr["prd_group"].ToString();
                    wSheet.Cells[excelRow, 4] = dr["prd_group_desc"].ToString();
                    wSheet.Cells[excelRow, 5] = "\'" + dr["prd_date"].ToString();
                    wSheet.Cells[excelRow, 6] = dr["day_std_qty"].ToString();
                    wSheet.Cells[excelRow, 7] = dr["prd_qty"].ToString();
                    wSheet.Cells[excelRow, 8] = dr["per_day_qty"].ToString();
                    wSheet.Cells[excelRow, 9] = dr["hour_std_qty"].ToString();
                    wSheet.Cells[excelRow, 10] = dr["act_hour_qty"].ToString();
                    wSheet.Cells[excelRow, 11] = dr["per_hour_qty"].ToString();
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
                wSheet.Rows[1].RowHeight = 40;//第一行高度
                Range titleRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[1, 11]];
                titleRange.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter; //水平居中  
                //设置边框
                Microsoft.Office.Interop.Excel.Range allRange = wSheet.Range[wSheet.Cells[1, 1], wSheet.Cells[excelRow, 11]];
                allRange.Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                allRange.Font.Size = 10;
                allRange.WrapText = true;
                ////////带有千位分隔符、2位小数和减号的标准数字格式
                ////////rng.NumberFormat = "# ##0.00:-# ##0.00"
                allRange = wSheet.Range[wSheet.Cells[2, 6], wSheet.Cells[excelRow, 6]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 7], wSheet.Cells[excelRow, 7]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 8], wSheet.Cells[excelRow, 8]];
                allRange.NumberFormat = "###,##0.00";
                allRange = wSheet.Range[wSheet.Cells[2, 9], wSheet.Cells[excelRow, 9]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 10], wSheet.Cells[excelRow, 10]];
                allRange.NumberFormat = "###,###,###";
                allRange = wSheet.Range[wSheet.Cells[2, 11], wSheet.Cells[excelRow, 11]];
                allRange.NumberFormat = "###,##0.00";
                wSheet.Columns[1].ColumnWidth = 3;
                wSheet.Columns[2].ColumnWidth = 7;
                wSheet.Columns[3].ColumnWidth = 5;
                wSheet.Columns[4].ColumnWidth = 8;
                wSheet.Columns[5].ColumnWidth = 8;
                wSheet.Columns[6].ColumnWidth = 8;
                wSheet.Columns[7].ColumnWidth = 8;
                wSheet.Columns[8].ColumnWidth = 5;
                wSheet.Columns[9].ColumnWidth = 6;
                wSheet.Columns[10].ColumnWidth = 6;
                wSheet.Columns[11].ColumnWidth = 5;
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
                excel.Quit();

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
            if (File.Exists(savePath+fileName))
            {
                File.Delete(savePath+fileName);
            }
        }

        //文件下载
        //downFileName下载后保存名，sourceFileName服务器端物理路径
        public void DownLoad1(HttpContext context,string downFileName, string sourceFileName)
        {
            if (File.Exists(sourceFileName))
            {
                context.Response.Clear();
                context.Response.ClearHeaders();
                context.Response.ClearContent();
                context.Response.Buffer = true;
                context.Response.AddHeader("content-disposition", string.Format("attachment; FileName={0}", downFileName));
                context.Response.Charset = "GB2312";
                context.Response.ContentEncoding = Encoding.GetEncoding("GB2312");
                context.Response.ContentType = MimeMapping.GetMimeMapping(downFileName);
                context.Response.WriteFile(sourceFileName);
                context.Response.Flush();
                context.Response.Close();
            }
        }



        public void DownLoad2(HttpContext context, string downFileName, string sourceFileName)
        {
            string fileName = downFileName;// "456.zip";//客户端保存的文件名
            string filePath = sourceFileName;// AppDomain.CurrentDomain.BaseDirectory.Replace("\\", "/") + "Excel/123.zip";

            System.IO.FileInfo fileInfo = new System.IO.FileInfo(filePath);

            if (fileInfo.Exists == true)
            {
                //每次读取文件，只读取1M，这样可以缓解服务器的压力
                const long ChunkSize = 1048576;
                byte[] buffer = new byte[ChunkSize];

                context.Response.Clear();
                //获取文件
                System.IO.FileStream iStream = System.IO.File.OpenRead(filePath);
                //获取下载的文件总大小
                long dataLengthToRead = iStream.Length;
                //二进制流数据（如常见的文件下载）
                context.Response.ContentType = "application/octet-stream";
                //通知浏览器下载文件而不是打开 
                context.Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(fileName));

                using (iStream)//解决文件占用问题，using 外 iStream.Dispose() 无法释放文件
                {
                    while (dataLengthToRead > 0 && context.Response.IsClientConnected)
                    {
                        int lengthRead = iStream.Read(buffer, 0, Convert.ToInt32(ChunkSize));//读取的大小
                        context.Response.OutputStream.Write(buffer, 0, lengthRead);
                        context.Response.Flush();
                        dataLengthToRead = dataLengthToRead - lengthRead;
                    }
                    iStream.Dispose();
                    iStream.Close();
                }

                context.Response.Close();
                context.Response.End();
            }
        }


        public static void DataToExcel1(System.Data.DataTable dataTable, string fileName)
        {
            if (File.Exists(fileName))                                //存在则删除
            {
                File.Delete(fileName);
            }
            FileStream objFileStream;
            StreamWriter objStreamWriter;
            string strLine = "";
            objFileStream = new FileStream(fileName, System.IO.FileMode.OpenOrCreate, FileAccess.Write);
            objStreamWriter = new StreamWriter(objFileStream, Encoding.Unicode);
            for (int i = 0; i < dataTable.Columns.Count; i++)
            {
                strLine = strLine + dataTable.Columns[i].Caption.ToString() + Convert.ToChar(9);      //写列标题
            }
            objStreamWriter.WriteLine(strLine);
            strLine = "";
            for (int i = 0; i < dataTable.Rows.Count; i++)
            {
                for (int j = 0; j < dataTable.Columns.Count; j++)
                {
                    if (dataTable.Rows[i].ItemArray[j] == null)
                        strLine = strLine + " " + Convert.ToChar(9);                                    //写内容
                    else
                    {
                        string rowstr = "";
                        rowstr = dataTable.Rows[i].ItemArray[j].ToString();
                        if (rowstr.IndexOf("\r\n") > 0)
                            rowstr = rowstr.Replace("\r\n", " ");
                        if (rowstr.IndexOf("\t") > 0)
                            rowstr = rowstr.Replace("\t", " ");
                        strLine = strLine + rowstr + Convert.ToChar(9);
                    }
                }
                objStreamWriter.WriteLine(strLine);
                strLine = "";
            }
            objStreamWriter.Close();
            objFileStream.Close();
        }


    }
}