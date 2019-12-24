using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;
using System.IO;
using Leyp.Components.Module;
using Leyp.Components;
using Leyp.SQLServerDAL;

namespace WebPortal.Stock
{
    public partial class St_Jx_Store_Transfer : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string user_id = "";//DBUtility.user_id;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //這個是JavaScript取值方法
            //string[] proSub = Request.Form.GetValues("selDep");
            //string prd_dep = proSub[selDep.SelectedIndex];

            string now_date = txtDate.Value.ToString();

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
            DataSetOperator(dsExcel.Tables[0]);
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
        private void DataSetOperator(DataTable dt)
        {
            string result = "";
            int excel_row = 0;
            bool Valid_flag = true;
            try
            {
                string prd_dep_h = "",prd_mo_h="",lot_no_h="", prd_item_h = "", weg_h = "", qty_h = "";
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string colName = dt.Columns[j].ColumnName;
                    prd_dep_h = (colName == "車間" || colName == "部門編號" || colName == "車間編號" || colName == "貨倉編號" || colName == "倉庫編號" ? colName : prd_dep_h);
                    prd_item_h = (colName == "產品編號" || colName == "物料編號" ? colName : prd_item_h);
                    weg_h = (colName == "重量" || colName == "調整重量" ? colName : weg_h);
                    qty_h = (colName == "數量" || colName == "調整數量" ? colName : qty_h);
                    prd_mo_h = (colName == "制單編號" || colName == "頁數" ? colName : prd_mo_h);
                    lot_no_h = (colName == "批號" ? colName : lot_no_h);
                }
                if(prd_dep_h=="" || prd_item_h== ""||prd_mo_h==""||lot_no_h=="" || weg_h == "" || qty_h == "")
                {
                    result = "匯入的字段不正確!";
                    Valid_flag = false;
                }
                if (Valid_flag == true)
                {
                    DataTable tblDatas = new DataTable("Datas");
                    tblDatas.Columns.Add("Loc_no", typeof(string));
                    tblDatas.Columns.Add("Prd_item", typeof(string));
                    tblDatas.Columns.Add("Prd_mo", typeof(string));
                    tblDatas.Columns.Add("Lot_no", typeof(string));
                    tblDatas.Columns.Add("Qty", typeof(decimal));
                    tblDatas.Columns.Add("Weg", typeof(decimal));

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string Loc_no = "";
                        string Prd_item = "";
                        string Prd_mo = "ZZZZZZZZZ", Lot_no = "0000000000";
                        decimal Qty = 0, Weg = 0;
                        excel_row = excel_row + 1;
                        DataRow dr = dt.Rows[i];
                        Loc_no = (prd_dep_h == "" ? "" : dr[prd_dep_h].ToString().Trim().ToUpper());
                        Prd_item = (prd_item_h == "" ? "" : dr[prd_item_h].ToString().Trim());
                        Prd_mo = (prd_mo_h == "" ? "" : dr[prd_mo_h].ToString().Trim());
                        Lot_no = (lot_no_h == "" ? "" : dr[lot_no_h].ToString().Trim());
                        Qty = (qty_h == "" ? 0 : (dr[qty_h].ToString() != "" ? Convert.ToInt32(dr[qty_h]) : 0));
                        Weg = (weg_h == "" ? 0 : (dr[weg_h].ToString() != "" ? Math.Round(Convert.ToDecimal(dr[weg_h]), 2) : 0));
                        if (Loc_no == "" || Prd_item == "" || Prd_mo == "" || Lot_no == "")
                        {
                            result = "記錄：" + (i + 1).ToString() + "必要的倉存字段不完整(貨倉編號|物料編號|制單編號|批號)!";
                            Valid_flag = false;
                            break;
                        }
                        if (Qty < 0 || Weg < 0)
                        {
                            result = "記錄：" + (i + 1).ToString() + "數量或重量不能小於0!";
                            Valid_flag = false;
                            break;
                        }
                        tblDatas.Rows.Add(new object[] { Loc_no, Prd_item, Prd_mo, Lot_no, Qty, Weg });
                    }
                    if (Valid_flag == true)
                        UpdateStoreProcess(tblDatas);
                }
            }
            catch (Exception ex)
            {
                result = "Excel文件的欄位不正確:(" + excel_row.ToString() + ")" + ex.Message;
            }
            if (Valid_flag == false)
                StrHlp.WebMessageBox(this.Page, result);
            //if (result != "")
            //{
            //    ////Response.Write(String.Format("<script text='text/javascript'>alert('{0}')</script>", result_str));

            //txtError.Value = result;
            //}
        }

        protected void UpdateStoreProcess(DataTable tblDatas)
        {
            string result = "";
            bool Valid_flag = true;
            string Flag_id = "06";
            user_id = getUserName();
            string crtim = System.DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
            string Transfer_date;
            Transfer_date = txtDate.Value.ToString(); //System.DateTime.Now.ToString("yyyy/MM/dd");            
            var query = from t in tblDatas.AsEnumerable()
                        group t by new { t1 = t.Field<string>("Loc_no"), t2 = t.Field<string>("Prd_item"), t3 = t.Field<string>("Prd_mo"), t4 = t.Field<string>("Lot_no") } into m
                        select new
                        {
                            Loc_no = m.Key.t1,
                            Prd_item = m.Key.t2,
                            Prd_mo = m.Key.t3,
                            Lot_no = m.Key.t4,
                            Qty = m.Sum(n => n.Field<decimal>("Qty")),
                            Weg = m.Sum(n => n.Field<decimal>("Weg"))
                        };
            foreach (var item in query.ToList())
            {
                string Loc_no = "";
                string Prd_item = "";
                string Prd_mo = "ZZZZZZZZZ", Lot_no = "0000000000";
                decimal Qty = 0, Weg = 0;
                decimal wh_rec_qty = 0, wh_rec_weg = 0;
                decimal Transfer_qty = 0, Transfer_weg = 0;
                int i = 0;
                string strSql = "";
                strSql += string.Format(@" SET XACT_ABORT  ON ");
                strSql += string.Format(@" BEGIN TRANSACTION ");

                Loc_no = item.Loc_no.Trim().ToUpper();
                Prd_item = item.Prd_item.ToString().Trim();
                Prd_mo = item.Prd_mo.ToString().Trim();
                Lot_no = item.Lot_no.ToString().Trim();
                Qty = Math.Round(item.Qty, 0);
                Weg = Math.Round(item.Weg, 2);
                DataTable dtSt = CehckStore(Loc_no, Prd_item, Prd_mo, Lot_no);
                if (dtSt.Rows.Count == 0)
                {
                    Transfer_qty = Qty;
                    Transfer_weg = Weg;
                    wh_rec_qty = Qty;
                    wh_rec_weg = Weg;
                    strSql += string.Format(@"Insert Into st_jx_store_summary (Loc_no,Prd_item,Prd_mo,Lot_no,wh_rec_weg,wh_rec_qty,crusr,crtim) Values " +
                    "('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}')"
                    , Loc_no, Prd_item, Prd_mo, Lot_no, wh_rec_weg, wh_rec_qty, user_id, crtim);
                }
                else
                {
                    DataRow drSt = dtSt.Rows[0];
                    Transfer_qty = Qty - Convert.ToDecimal(drSt["wh_bal_qty"]);
                    Transfer_weg = Weg - Convert.ToDecimal(drSt["wh_bal_weg"]);
                    wh_rec_qty = Convert.ToDecimal(drSt["wh_rec_qty"]) + Transfer_qty;
                    wh_rec_weg = Convert.ToDecimal(drSt["wh_rec_weg"]) + Transfer_weg;
                    strSql += string.Format(@"Update st_jx_store_summary Set wh_rec_weg='{0}',wh_rec_qty='{1}',crusr='{2}',crtim='{3}'" +
                    " Where Loc_no='{4}' And Prd_item='{5}' And Prd_mo='{6}' And Lot_no='{7}'"
                    , wh_rec_weg, wh_rec_qty, user_id, crtim, Loc_no, Prd_item, Prd_mo, Lot_no);
                }
                int Seq = GenID(Loc_no, Flag_id, Transfer_date);
                string id = "";
                id = Loc_no + Flag_id + "-" + Transfer_date.Substring(2, 2) + Transfer_date.Substring(5, 2) + Transfer_date.Substring(8, 2) + (Seq + i).ToString().PadLeft(4, '0');
                strSql += string.Format(@"Insert Into st_jx_store_transfer (id,flag_id,transfer_date,Loc_no,prd_item,prd_mo,lot_no,transfer_qty,transfer_weg,crusr,crtim) Values " +
                "('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}')"
                , id, Flag_id, Transfer_date, Loc_no, Prd_item, Prd_mo, Lot_no, Transfer_qty, Transfer_weg, user_id, crtim);

                strSql += string.Format(@" COMMIT TRANSACTION ");
                result = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                if (result != "")
                {
                    Valid_flag = false;
                    result = "匯入Excel失敗!";
                    break;
                }
                i = i + 1;
            }

            if (Valid_flag == true)
                result = "匯入排期表成功!";
            StrHlp.WebMessageBox(this.Page, result);
        }

        //產生ID編號
        protected int GenID(string Loc_no, string Flag_id,string Transfer_date)
        {
            int Seq;
            //產生自動單號
            string ID1, ID2;
            ID1 = Loc_no + Flag_id;
            ID2 = ID1 + "-" + Transfer_date.Substring(2, 2) + Transfer_date.Substring(5, 2) + Transfer_date.Substring(8, 2) + "9999";
            string strSql = "Select MAX(ID) AS max_id From st_jx_store_transfer Where ID>='" + ID1 + "' And ID<='" + ID2 + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            if (dt.Rows.Count > 0)
                Seq = dt.Rows[0]["max_id"].ToString() != "" ? (Convert.ToInt32(dt.Rows[0]["max_id"].ToString().Substring(12, 4)) + 1) : 1;
            else
                Seq = 1;
            return Seq;
        }

        protected DataTable CehckStore(string Loc_no, string Prd_item, string Prd_mo, string Lot_no)
        {
            string strSql = "";
            strSql = "Select wh_rec_qty,wh_rec_weg,wh_out_qty,wh_out_weg,(wh_rec_qty-wh_out_qty) AS wh_bal_qty,(wh_rec_weg-wh_out_weg) AS wh_bal_weg" +
                " From st_jx_store_summary " +
                " Where Loc_no='" + Loc_no + "' And Prd_item='" + Prd_item + "' And Prd_mo='" + Prd_mo + "' And Lot_no='" + Lot_no + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }


    }
}