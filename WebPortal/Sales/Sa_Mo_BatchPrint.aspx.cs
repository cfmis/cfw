using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Leyp.SQLServerDAL;
using Leyp.SQLServerDAL.Sales;
using Leyp.Components;
using Leyp.Components.Module;

namespace WebPortal.Sales
{
    public partial class Sa_Mo_BatchPrint : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string user_id = "";//DBUtility.user_id;
        private string within_code = DBUtility.within_code;
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["user"] == null)
            //{
            //    Response.Redirect("logout.aspx"); //Response.Redirect("showDetailsAlia.aspx");
            //}
            //else
            //    user_id = Session["user"].ToString();
            LoadBatchMo();
        }

        protected void btnBatch_Click(object sender, EventArgs e)
        {
            if (txtAddMo.Text == "")
                return;
            user_id = getUserName();
            string mo_id = txtAddMo.Text.ToUpper();
            string strSql = "";
            string result = "";
            //strSql = "Delect From mo_BatchPrint Where within_code='" + within_code + "' AND user_id='" + user_id + "'";
            strSql = "Select mo_id " +
                " From mo_BatchPrint " +
                " Where within_code='" + within_code + "' AND user_id='" + user_id + "' AND mo_id='" + mo_id + "'";
            DataTable tbMoFind = sh.ExecuteSqlReturnDataTable(strSql);
            if (tbMoFind.Rows.Count == 0)
            {
                strSql = string.Format(@"INSERT INTO mo_BatchPrint( 
                              within_code,mo_id,user_id,crusr,crtim)
                              VALUES ('{0}','{1}','{2}','{3}',GETDATE()) "
                              , within_code, mo_id, user_id, user_id);
                result = sh.ExecuteSqlUpdate(strSql);
                if (result != "")
                    StrHlp.WebMessageBox(this.Page, result);
                else
                {
                    txtAddMo.Text = "";
                    txtAddMo.Focus();
                }
            }
            LoadBatchMo();
        }
        protected void btnLoadBatchMo_Click(object sender, EventArgs e)
        {
            LoadBatchMo();
        }
        protected void btnShowOc_Click(object sender, EventArgs e)
        {
            Response.Redirect("oc_ShowStatus.aspx");
        }
        protected void LoadBatchMo()
        {
            user_id = getUserName();
            string strSql = "Select mo_id,status_desc,crusr,Convert(Varchar(20),crtim,111) AS crtim" +
                " From mo_BatchPrint "+
                " Where within_code='" + within_code + "' AND user_id='" + user_id + "'";
            DataTable tbMoFind = sh.ExecuteSqlReturnDataTable(strSql);
            if (tbMoFind.Rows.Count == 0)
                tbMoFind.Rows.Add();
            gvBatchMo.DataSource = tbMoFind.DefaultView;
            gvBatchMo.DataBind();
        }
        protected void btnCleanMo_Click(object sender, EventArgs e)
        {
            DeleteMo("");
        }
        protected void gvDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string mo_id = "";
            int i = e.RowIndex;
            mo_id = gvBatchMo.Rows[i].Cells[0].Text;
            DeleteMo(mo_id);
        }
        protected void DeleteMo(string mo_id)
        {
            string strSql = "";
            string result = "";
            user_id = getUserName();
            strSql = "Delete From mo_BatchPrint Where within_code='" + within_code + "' AND user_id='" + user_id + "'";
            if (mo_id != "")
                strSql += " AND mo_id='" + mo_id + "'";
            result = sh.ExecuteSqlUpdate(strSql);
            if (result != "")
                StrHlp.WebMessageBox(this.Page, result);
            LoadBatchMo();
        }


        protected void btnUpload_Click(object sender, EventArgs e)
        {
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
                if (fileId.PostedFile.ContentLength > 1024000)
                {
                    fileOk = false;
                }
            }
            else
                StrHlp.WebMessageBox(this.Page, "文件不存在!");
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
            DataOperator(savePath + fileName);
            LoadBatchMo();
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
        private void DataOperator(string fileName)
        {
            //string myString = "Provider = Microsoft.Jet.OLEDB.4.0 ; Data Source =  " + savePath + fileName + ";Extended Properties=Excel 8.0";
            //OleDbConnection oconn = new OleDbConnection(myString);
            //try
            //{

            //    oconn.Open();
            //    DataSet ds = new DataSet();
            //    OleDbDataAdapter oda = new OleDbDataAdapter("select * from [Sheet1$]", oconn);
            //    oda.Fill(ds);
            //    oconn.Close();

            //    if (File.Exists(savePath + fileName))
            //    {

            //        File.Delete(savePath + fileName);
            //    }
            //    DataSetOperator(ds.Tables[0]);
            //}
            //catch (Exception ex)
            //{
            //    StrHlp.WebMessageBox(this.Page, ex.Message);
            //    //StrHlp.WebMessageBox(this.Page, "錯誤!");
            //    //txtAddMo.Text = ex.Message;
            //}

            string result = "";
            OleDbConnection conn = new OleDbConnection();

            string strConn = string.Empty;

            
            try
            {
                // Excel 2003 版本连接字符串
                strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileName + ";Extended Properties='Excel 8.0; HDR=YES; IMEX=1;'";
                conn = new OleDbConnection(strConn);
                conn.Open();
            }
            catch
            {
                try
                {
                    // Excel 2007 以上版本连接字符串
                    strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileName + ";Extended Properties='Excel 12.0;HDR=Yes;IMEX=1;'";
                    conn = new OleDbConnection(strConn);
                    conn.Open();
                }
                catch (Exception ex)
                {
                    result = "不是有效的Excel文件!";
                }
            }
            if (result != "")
            {
                //关闭连接，释放资源
                conn.Close();
                conn.Dispose();
            }
            //////刪除舊有的記錄
            string strSql = string.Format(@"Delete From mo_BatchPrint Where user_id='{0}'", user_id);
            sh.ExecuteSqlUpdate(strSql);//更新明細記錄

            //获取所有的 sheet 表
            System.Data.DataTable dtSheetName = conn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "Table" });
            bool findSheetFlag = false;
            for (int i = 0; i < dtSheetName.Rows.Count; i++)//這個是獲取Excel所有的Sheet
            //for (int i = 0; i < 1; i++)//只獲取Excel第1個Sheet
            {
                System.Data.DataTable dt = new System.Data.DataTable();
                dt.TableName = "table0";// + i.ToString();
                //获取表名
                string sheetName = string.Empty;
                sheetName = dtSheetName.Rows[i]["TABLE_NAME"].ToString();
                //有些Excel是隱藏了很多個臨時表的，只將實際的導入
                //如果sheet的名字為數字開頭的如：105或105abc等，則sheetName則為：'105$'，則要將符號'去掉後再判斷
                if (sheetName.Substring(sheetName.Length - 1, 1) == "$"
                    || (sheetName.Substring(0, 1) == "'" && sheetName.Substring(sheetName.Length - 1, 1) == "'" && sheetName.Substring(sheetName.Length - 2, 1) == "$"))
                {
                    findSheetFlag = true;
                    OleDbDataAdapter oleda = new OleDbDataAdapter("select * from [" + sheetName + "]", conn);
                    oleda.Fill(dt);
                    result = DataSetOperator(dt);
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
            if (result != "")
            {
                //Response.Write(String.Format("<script text='text/javascript'>alert('{0}')</script>", result_str));
                StrHlp.WebMessageBox(this.Page, result);
            }
        }

        /// <summary>  
        /// 数据集操作  
        /// </summary>  
        /// <param name="ds"></param>  
        /// 更新Excel表到临时表pu_temp_excel中
        private string DataSetOperator(DataTable dt)
        {
            string result_str = "";
            string strSql = "";
            user_id = getUserName();
            string mo_id_h = "";
            string status_h = "";
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                string colName = dt.Columns[j].ColumnName;
                mo_id_h = (colName == "制單編號" || colName == "頁數" || colName == "未完成頁數" ? colName : mo_id_h);
                status_h = (colName == "急單" || colName == "状态" || colName == "狀態" || colName == "急/特急狀態" ? colName : status_h);

            }
            if (mo_id_h == "" || status_h == "")
            {
                result_str = "Excel文件的欄位不正確";
                return result_str;
            }
            strSql += string.Format(@" SET XACT_ABORT  ON ");
            strSql += string.Format(@" BEGIN TRANSACTION ");

            

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string mo_id = "";
                string status = "";
                DataRow dr = dt.Rows[i];
                mo_id = (mo_id_h == "" ? "" : dr[mo_id_h].ToString().Trim());
                if (mo_id != "")
                {
                    status = (status_h == "" ? "" : dr[status_h].ToString().Trim());
                    strSql += string.Format(@"INSERT INTO mo_BatchPrint (within_code,mo_id,status_desc,user_id,crusr,crtim)
                    VALUES ('{0}','{1}','{2}','{3}','{4}',GETDATE())"
                            , within_code, mo_id, status, user_id, user_id);
                }
            }

            strSql += string.Format(@" COMMIT TRANSACTION ");
            result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
            return result_str;
        }
    }
}