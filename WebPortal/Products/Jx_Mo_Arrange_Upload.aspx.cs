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
    public partial class Jx_Mo_Arrange_Upload : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string lnsql1_dgcf_pad = DBUtility.lnsql1_dgcf_pad;
        private string user_id = "";//DBUtility.user_id;
        private string within_code = DBUtility.within_code;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                init();
            }
        }
        protected void init()
        {
            //txtArrangeDate.Value = System.DateTime.Now.ToString("yyyy/MM/dd");

            DataTable tbMo_group = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getJxDep();
            dlDep.DataSource = tbMo_group.DefaultView;
            dlDep.DataTextField = "name";
            dlDep.DataValueField = "id";
            dlDep.DataBind();
        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //這個是JavaScript取值方法
            //string[] proSub = Request.Form.GetValues("selDep");
            //string prd_dep = proSub[selDep.SelectedIndex];

            string now_date = txtArrangeDate.Value.ToString();
            if (dlDep.SelectedIndex == 0)
            {
                StrHlp.WebMessageBox(this.Page, "部門不能為空！");
                return;
            }
            if (!StrHlp.CheckDateFormat(now_date))
            {
                StrHlp.WebMessageBox(this.Page, "日期無效！");
                return;
            }
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
                    StrHlp.WebMessageBox(this.Page, "上傳的文件類型不正確！");
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

        /// <summary>  
        /// 数据集操作  
        /// </summary>  
        /// <param name="ds"></param>  
        /// 更新Excel表到临时表pu_temp_excel中
        private void DataSetOperator(DataTable dt, string fileName)
        {

            string result = "";
            string arrange_date, prd_dep = "";
            int excel_row = 0;
            prd_dep = dlDep.SelectedValue.ToString().Trim();
            arrange_date = txtArrangeDate.Value.ToString(); //System.DateTime.Now.ToString("yyyy/MM/dd");
            string arrange_seq, prd_mo, prd_item, prd_seq, receive_date, prd_worker, delivery_date, mat_item
                , plan_date, pre_date, remark, mat_status, outside, wash_oil, wp_id, arrange_machine;
            int arrange_qty, cpl_qty, not_cpl_qty;
            string strSql = "";
            user_id = getUserName();
            string now_date = arrange_date;// System.DateTime.Now.ToString("yyyy/MM/dd");
            try
            {
                string prd_dep_h = "", prd_seq_h = "", receive_date_h = "", prd_mo_h = "", arrange_machine_h = "", prd_item_h = "", prd_worker_h = "", delivery_date_h = ""
                        , arrange_qty_h = "", cpl_qty_h = "", not_cpl_qty_h = "", mat_item_h = ""
                        , plan_date_h = "", pre_date_h = "", remark_h = "", mat_status_h = "", outside_h = "", wash_oil_h = ""
                        , wp_id_h = "";
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string colName = dt.Columns[j].ColumnName;
                    prd_dep_h = (colName == "部門編號" ? colName : prd_dep_h);
                    prd_seq_h = (colName == "序號" ? colName : prd_seq_h);
                    receive_date_h = (colName == "JX接單日期" ? colName : receive_date_h);
                    prd_item_h = (colName == "產品編號" ? colName : prd_item_h);
                    prd_mo_h = (colName == "訂單編號/頁數" || colName == "訂單編號" || colName == "制單編號" || colName == "頁數" ? colName : prd_mo_h);
                    arrange_machine_h = (colName == "機台編號" || colName == "機器編號" || colName == "機器編碼" ? colName : arrange_machine_h);
                    prd_worker_h = (colName == "操作員" || colName == "工號" ? colName : prd_worker_h);
                    delivery_date_h = (colName == "訂單交貨期" ? colName : delivery_date_h);
                    arrange_qty_h = (colName == "訂單生產數量" ? colName : arrange_qty_h);
                    cpl_qty_h = (colName == "已生產數量" ? colName : cpl_qty_h);
                    not_cpl_qty_h = (colName == "未生產生數量" || colName == "未生產數量" ? colName : not_cpl_qty_h);
                    mat_item_h = (colName == "原料曲" || colName == "原料編號" ? colName : mat_item_h);
                    plan_date_h = (colName == "計劃生產日期" ? colName : plan_date_h);
                    pre_date_h = (colName == "預計完成日期" ? colName : pre_date_h);
                    remark_h = (colName == "備註" ? colName : remark_h);
                    mat_status_h = (colName == "生產原料狀態" ? colName : mat_status_h);
                    outside_h = (colName == "外發大通電鍍編碼（CL-T0011)" ? colName : outside_h);
                    wash_oil_h = (colName == "洗油" ? colName : wash_oil_h);
                    wp_id_h = (colName == "車間" || colName == "生產車間" || colName == "車間編號" ? colName : wp_id_h);
                }

                strSql += string.Format(@" BEGIN TRANSACTION ");
                ////strSql = "";
                strSql += string.Format(@" Delete From product_arrange_jx Where now_date='{0}'", now_date);
                ////result = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    //strSql = "";
                    excel_row = excel_row + 2;
                    DataRow dr = dt.Rows[i];
                    prd_mo = (prd_mo_h == "" ? "" : dr[prd_mo_h].ToString().Trim());
                    prd_item = (prd_item_h == "" ? "" : dr[prd_item_h].ToString().Trim());
                    if (prd_mo == "YBY013687")
                    {
                        prd_mo = "YBY013687";
                    }
                    if (prd_mo != "" && prd_item != "")
                    {
                        prd_dep = (prd_dep_h == "" ? "" : dr[prd_dep_h].ToString().Trim().ToUpper());
                        prd_seq = (prd_seq_h == "" ? "" : dr[prd_seq_h].ToString().Trim());
                        receive_date = (receive_date_h == "" ? "" : dr[receive_date_h].ToString().Trim());
                        prd_worker = (prd_worker_h == "" ? "" : dr[prd_worker_h].ToString().Trim());
                        delivery_date = (delivery_date_h == "" ? "" : dr[delivery_date_h].ToString().Trim());
                        mat_item = (mat_item_h == "" ? "" : dr[mat_item_h].ToString().Trim());
                        plan_date = (plan_date_h == "" ? "" : dr[plan_date_h].ToString().Trim());
                        pre_date = (pre_date_h == "" ? "" : dr[pre_date_h].ToString().Trim());
                        remark = (remark_h == "" ? "" : dr[remark_h].ToString().Trim());
                        mat_status = (mat_status_h == "" ? "" : dr[mat_status_h].ToString().Trim());
                        outside = (outside_h == "" ? "" : dr[outside_h].ToString().Trim());
                        wash_oil = (wash_oil_h == "" ? "" : dr[wash_oil_h].ToString().Trim());
                        arrange_qty = (arrange_qty_h == "" ? 0 : (dr[arrange_qty_h].ToString() != "" ? Convert.ToInt32(dr[arrange_qty_h]) : 0));
                        cpl_qty = (cpl_qty_h == "" ? 0 : (dr[cpl_qty_h].ToString() != "" ? Convert.ToInt32(dr[cpl_qty_h]) : 0));
                        not_cpl_qty = (not_cpl_qty_h == "" ? 0 : (dr[not_cpl_qty_h].ToString() != "" ? Convert.ToInt32(dr[not_cpl_qty_h]) : 0));
                        wp_id = (wp_id_h == "" ? "" : dr[wp_id_h].ToString().Trim());
                        arrange_machine = (arrange_machine_h == "" ? "" : dr[arrange_machine_h].ToString().Trim());
                        string dtt = System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");

                        //產生自動單號
                        arrange_seq = (i + 1).ToString().PadLeft(4, '0');
                        string id = prd_dep + dtt.Substring(0, 4) + dtt.Substring(5, 2) + dtt.Substring(8, 2) + dtt.Substring(11, 2) + dtt.Substring(14, 2) + dtt.Substring(17, 2) + arrange_seq;
                        strSql += string.Format(@" INSERT INTO product_arrange_jx (arrange_id,now_date,arrange_seq,prd_dep,arrange_date
                            ,prd_mo, prd_item, prd_seq, receive_date, prd_worker,wp_id,arrange_machine, delivery_date,arrange_qty,cpl_qty,not_cpl_qty
                            , mat_item, plan_date, estimated_date, remark, mat_status, outside, wash_oil,crusr,crtim)
                            VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}'
                            ,'{14}','{15}','{16}','{17}','{18}','{19}','{20}','{21}','{22}','{23}','{24}')"
                            , id, now_date, arrange_seq, prd_dep, arrange_date, prd_mo, prd_item, prd_seq, receive_date, prd_worker, wp_id, arrange_machine
                            , delivery_date, arrange_qty, cpl_qty, not_cpl_qty
                            , mat_item, plan_date, pre_date, remark, mat_status, outside, wash_oil, user_id, dtt);

                        //result = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                        //if (result != "")
                        //    break;
                        //if (i == 2)
                        //    break;
                    }

                }
                strSql += string.Format(@" IF @@error <> 0 ");
                strSql += string.Format(@" ROLLBACK TRANSACTION ");
                strSql += string.Format(@" ELSE ");
                strSql += string.Format(@" COMMIT TRANSACTION ");

                //if (result == "")
                //{
                //    result = "匯入排期表成功!";
                //}
                //else
                //{
                //    result = "匯入排期表失敗!" + excel_row.ToString();

                //}


                if (strSql != "")
                {
                    result = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                    if (result == "")
                        result = "匯入排期表成功!";
                    StrHlp.WebMessageBox(this.Page, result);

                    //this.DataSetBand();
                }
                else
                {
                    result = "";

                }
            }
            //}
            catch (Exception ex)
            {
                result = "Excel文件的欄位不正確:(" + excel_row.ToString() + ")" + ex.Message;
            }
            if (result != "")
            {
                //Response.Write(String.Format("<script text='text/javascript'>alert('{0}')</script>", result_str));
                StrHlp.WebMessageBox(this.Page, result);
            }
        }

    }
}