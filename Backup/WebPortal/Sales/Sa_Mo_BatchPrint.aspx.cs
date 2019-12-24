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
            strSql = "Select mo_id From mo_BatchPrint Where within_code='" + within_code + "' AND user_id='" + user_id + "' AND mo_id='" + mo_id + "'";
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
            string strSql = "Select mo_id From mo_BatchPrint Where within_code='" + within_code + "' AND user_id='" + user_id + "'";
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
            DataOperator(fileName, savePath);
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
                DataSetOperator(ds.Tables[0]);
            }
            catch (Exception ex)
            {
                StrHlp.WebMessageBox(this.Page, ex.Message);
            }
        }

        /// <summary>  
        /// 数据集操作  
        /// </summary>  
        /// <param name="ds"></param>  
        /// 更新Excel表到临时表pu_temp_excel中
        private void DataSetOperator(DataTable dt)
        {
            string result_str = "";
            string strSql = "";
            user_id = getUserName();
            strSql += string.Format(@"Delete From mo_BatchPrint Where user_id='{0}'", user_id);
            try
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    strSql += string.Format(@"INSERT INTO mo_BatchPrint (within_code,mo_id,user_id,crusr,crtim)
                    VALUES ('{0}','{1}','{2}','{3}',GETDATE())"
                        , within_code, dt.Rows[i][0], user_id, user_id);
                }


                if (strSql != "")
                {
                    result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄

                }
                else
                {
                    result_str = "";

                }
            }
            catch (Exception ex)
            {
                result_str = "Excel文件的欄位不正確:" + ex.Message;
            }
            if (result_str != "")
            {
                //Response.Write(String.Format("<script text='text/javascript'>alert('{0}')</script>", result_str));
                StrHlp.WebMessageBox(this.Page, result_str);
            }
        }  
    }
}