using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.IO;
using Leyp.Model;
using Leyp.Components;
using Leyp.Components.Module;
using Leyp.SQLServerDAL;

namespace WebPortal.Products
{
    public partial class Pd_Mo_Update_Status : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string user_id = "";//DBUtility.user_id;
        private string within_code = DBUtility.within_code;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                init();
                //DataSetBand();
            }
        }

        protected void init()
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //這個是JavaScript取值方法
            //string[] proSub = Request.Form.GetValues("selDep");
            //string prd_dep = proSub[selDep.SelectedIndex];


            Boolean fileOk = false;
            //判断是否已经选取文件
            if (fileId.HasFile)
            {
                //取得文件的扩展名,并转换成小写
                string fileExtension = System.IO.Path.GetExtension(fileId.FileName).ToLower();
                //限定只能上传jpg和gif图片
                //string[] allowExtension = { ".jpg", ".gif", ".xls" };
                string[] allowExtension = { ".xls" };
                //对上传的文件的类型进行一个个匹对
                for (int i = 0; i < allowExtension.Length; i++)
                {
                    if (fileExtension == allowExtension[i])
                    {
                        fileOk = true;
                        break;
                    }
                }
                //
                if (!fileOk)
                {
                    StrHlp.WebMessageBox(this.Page, "要上传的文件类型不对！");
                }

                //对上传文件的大小进行检测，限定文件最大不超过1M
                //if (fileId.PostedFile.ContentLength > 1024000)
                //{
                //    fileOk = false;
                //}
            }
            else
                StrHlp.WebMessageBox(this.Page, "文件不存在!");
            //Response.Write("<script>alert('弹出的消息')</script>");
            //this.Page.RegisterStartupScript(" ", "<script>alert(' 弹出的消息 '); </script> ");

            if (!fileOk)
                return;
            string fileName = fileId.FileName;
            if (fileName == "")
            {
                StrHlp.WebMessageBox(this.Page, "文件不存在!");
                return;
            }
            string savePath = Server.MapPath("~/file/");
            FileOperatpr(fileName, savePath);
            fileId.SaveAs(savePath + fileName);
            DataSet dsExcel = new DataSet();
            dsExcel = ImportExcel(savePath + fileName);
            DataSetOperator(dsExcel.Tables[0], fileName);
            //DataOperator(fileName, savePath);


            //LoadBatchMo();
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
        /// <summary>  
        /// 数据操作  
        /// </summary>  
        /// <param name="fileName"></param>  
        /// <param name="savePath"></param>  
        private void DataOperator(string fileName, string savePath)
        {
            string myString = "Provider = Microsoft.Jet.OLEDB.4.0 ; Data Source =  " + savePath + fileName + ";Extended Properties=Excel 8.0";
            OleDbConnection oconn = new OleDbConnection(myString);
            try
            {

                oconn.Open();
                DataSet ds = new DataSet();
                OleDbDataAdapter oda = new OleDbDataAdapter("select * from [Sheet1$]", oconn);
                oda.Fill(ds);
                oconn.Close();

                if (File.Exists(savePath + fileName))
                {

                    File.Delete(savePath + fileName);
                }
                DataSetOperator(ds.Tables[0], fileName);
            }
            catch (Exception ex)
            {
                StrHlp.WebMessageBox(this.Page, ex.Message);
                //StrHlp.WebMessageBox(this.Page, "錯誤!");
                //txtAddMo.Text = ex.Message;
            }
        }

        /// <summary>  
        /// 数据集操作  
        /// </summary>  
        /// <param name="ds"></param>  
        /// 更新Excel表到临时表pu_temp_excel中
        private void DataSetOperator(DataTable dt, string fileName)
        {
            string result_str = "";
            string strSql = "", strSql_f = "";
            int excel_row = 0;
            string prd_mo, urgent_status, urgent_status1 = "";
            user_id = getUserName();
            //strSql += string.Format(@"Delete From product_arrange Where prd_dep='{0}' and now_date='{1}'", prd_dep, now_date);
            try
            {
                string prd_mo_h = "", urgent_status_h = "";
                for (int j = 0; j < dt.Columns.Count; j++) 
                {
                    string colName = dt.Columns[j].ColumnName;
                    prd_mo_h = (colName == "制單編號" || colName == "頁數" || colName == "未完成頁數" ? colName : prd_mo_h);
                    urgent_status_h = (colName == "急單" || colName == "状态" || colName == "狀態" || colName == "急/特急狀態" ? colName : urgent_status_h);
                }


                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dt.Rows[i];
                    excel_row = excel_row + 1;
                    prd_mo = (prd_mo_h == "" ? "" : dr[prd_mo_h].ToString().Trim());
                    if (prd_mo != "")
                    {
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

                        strSql_f = "Select mo_id From mo_status Where mo_id='" + prd_mo + "'";
                        DataTable dtArrange = sh.ExecuteSqlReturnDataTable(strSql_f);
                        if (dtArrange.Rows.Count == 0)
                        {
                            strSql += string.Format(@"INSERT INTO mo_status (mo_id,mo_status,cr_usr,cr_tim)
                            VALUES ('{0}','{1}','{2}',GETDATE())", prd_mo, urgent_status, user_id);
                        }
                        else
                        {
                            strSql += string.Format(@"Update  mo_status Set mo_status='{0}',am_usr='{1}'
                            ,am_tim=GETDATE() Where mo_id='{2}'", urgent_status, user_id, prd_mo);
                        }
                    }
                }

                if (strSql != "")
                {
                    result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                    StrHlp.WebMessageBox(this.Page, "更新制單狀態成功!");
                 }
                else
                {
                    result_str = "";

                }
            }
            catch (Exception ex)
            {
                result_str = "Excel文件的欄位不正確:(" + excel_row.ToString() + ")" + ex.Message;
            }
            if (result_str != "")
            {
                //Response.Write(String.Format("<script text='text/javascript'>alert('{0}')</script>", result_str));
                StrHlp.WebMessageBox(this.Page, result_str);
            }
        }

        private DataSet ImportExcel(string filePath)

        {

            DataSet ds = null;

            OleDbConnection conn;

            string strConn = string.Empty;

            string sheetName = string.Empty;
            try
            {
                // Excel 2003 版本连接字符串
                strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties='Excel 8.0; HDR=YES; IMEX=1;'";
                conn = new OleDbConnection(strConn);
                conn.Open();
            }
            catch
            {
                // Excel 2007 以上版本连接字符串
                strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties='Excel 12.0;HDR=Yes;IMEX=1;'";
                conn = new OleDbConnection(strConn);
                conn.Open();
            }

            //获取所有的 sheet 表
            DataTable dtSheetName = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "Table" });

            ds = new DataSet();

            //for (int i = 0; i < dtSheetName.Rows.Count; i++)//這個是獲取Excel所有的Sheet
            for (int i = 0; i < 1; i++)//只獲取Excel第1個Sheet
            {
                DataTable dt = new DataTable();
                dt.TableName = "table" + i.ToString();

                //获取表名
                sheetName = dtSheetName.Rows[i]["TABLE_NAME"].ToString();

                OleDbDataAdapter oleda = new OleDbDataAdapter("select * from [" + sheetName + "]", conn);

                oleda.Fill(dt);

                ds.Tables.Add(dt);
            }

            //关闭连接，释放资源
            conn.Close();
            conn.Dispose();

            return ds;
        }

    }
}