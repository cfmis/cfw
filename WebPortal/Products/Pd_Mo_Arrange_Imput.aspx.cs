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
    public partial class Pd_Mo_Arrange_Imput : BasePage//System.Web.UI.Page
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
            //txtArrangeDate.Value = System.DateTime.Now.ToString("yyyy/MM/dd");

            DataTable tbMo_group = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getDep();
            dlDep.DataSource = tbMo_group.DefaultView;
            dlDep.DataTextField = "dep_cdesc";
            dlDep.DataValueField = "dep_id";
            dlDep.DataBind();
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string result = "";
            //這個是JavaScript取值方法
            //string[] proSub = Request.Form.GetValues("selDep");
            //string prd_dep = proSub[selDep.SelectedIndex];

            string now_date = txtArrangeDate.Value; //System.DateTime.Now.ToString("yyyy/MM/dd");
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
            result=ImportExcel(savePath + fileName, fileName);
            //dsExcel = ImportExcel(savePath + fileName,fileName);
            ////DataSetOperator(dsExcel.Tables[0], fileName);
            ////DataOperator(fileName, savePath);


            //LoadBatchMo();
            if (result != "")
                StrHlp.WebMessageBox(this.Page, result);
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
        /// 数据集操作  
        /// </summary>  
        /// <param name="ds"></param>  
        /// 更新Excel表到临时表pu_temp_excel中
        private void DtOperator(DataTable dt, string fileName,string sheetName)
        {
            bool upd_flag = true;
            string result_str = "";
            string strSql = "", strSql_f = "";

            imgProcess.Visible = true;
            string now_date, prd_dep = "102";
            int excel_row = 1;
            //string[] proSub = Request.Form.GetValues("selDep");
            //prd_dep = proSub[selDep.SelectedIndex];
            prd_dep = dlDep.SelectedValue.ToString().Trim();
            now_date = txtArrangeDate.Value; //System.DateTime.Now.ToString("yyyy/MM/dd");
            string prd_mo, prd_item, urgent_status1, urgent_status, arrange_date, arrange_machine, cust_o_date = "", req_f_date, dep_rep_date, req_hk_date, dep_group;
            string pre_prd_dep_date = "";
            int pre_prd_dep_qty = 0;
            int arrange_seq, order_qty, req_qty, cpl_qty, arrange_qty, prd_cpl_qty;
            string prd_status = "00";//
            string rec_status = "0";
            user_id = getUserName();
            string strDep = fileName.Substring(0, 3);
            dep_group = "";
            if (prd_dep == "102")
            {
                if (fileName.Substring(0, 3) == "萬能機")
                    dep_group = "A";
                else
                {
                    if (fileName.Substring(0, 2) == "雞眼")
                        dep_group = "B";
                }
            }
            //strSql += string.Format(@"Delete From product_arrange Where prd_dep='{0}' and now_date='{1}'", prd_dep, now_date);
            try
            {
                string arrange_seq_h = "", prd_mo_h = "", urgent_status_h = "", prd_item_h = "", cust_o_date_h = "", req_f_date_h = "", order_qty_h = "", cpl_qty_h = ""
                            , arrange_date_h = "", arrange_qty_h = "", req_qty_h = "", prd_cpl_qty_h = "", dep_rep_date_h = "", arrange_machine_h = ""
                            , req_hk_date_h = "", dep_group_h1 = "", dep_group_h2 = "", dep_group_h3 = ""
                            , pre_prd_dep_date_h = "", pre_prd_dep_qty_h = "";
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string colName = dt.Columns[j].ColumnName;
                    arrange_seq_h = (colName == "序號" ? colName : arrange_seq_h);
                    prd_mo_h = (colName == "制單編號" || colName == "頁數" ? colName : prd_mo_h);
                    urgent_status_h = (colName == "急單" || colName == "状态" || colName == "狀態" ? colName : urgent_status_h);
                    arrange_date_h = (colName == "排期日期" || colName == "排期日期AA" || colName == "排期" ? colName : arrange_date_h);
                    prd_item_h = (colName == "產品編號" || colName == "物料編號" ? colName : prd_item_h);
                    cust_o_date_h = (colName == "客落單日期" ? colName : cust_o_date_h);
                    req_f_date_h = (colName == "要求完成時間" || colName == "pmc要求完成日期" ? colName : req_f_date_h);
                    order_qty_h = (colName == "訂單數量" ? colName : order_qty_h);
                    req_qty_h = (colName == "要求數量" || colName == "應生產數量" ? colName : req_qty_h);
                    cpl_qty_h = (colName == "完成數量" || colName == "已完成數量" ? colName : cpl_qty_h);
                    arrange_qty_h = (colName == "待完成數量" ? colName : arrange_qty_h);
                    prd_cpl_qty_h = (colName == "生產數量" ? colName : prd_cpl_qty_h);
                    dep_rep_date_h = (colName == "部門回覆" || colName == "部門覆期" || colName == "部門復期" ? colName : dep_rep_date_h);
                    arrange_machine_h = (colName == "生產設備" ? colName : arrange_machine_h);
                    req_hk_date_h = (colName == "計劃回港期" || colName == "計劃回港日期" || colName == "回港期" ? colName : req_hk_date_h);
                    dep_group_h1 = (colName == "自動" || colName == "组別" || colName == "組別" ? colName : dep_group_h1);
                    dep_group_h2 = (colName == "打扣" ? colName : dep_group_h2);
                    dep_group_h3 = (colName == "車碑" ? colName : dep_group_h3);
                    pre_prd_dep_date_h = (colName == "上部門來貨期" ? colName : pre_prd_dep_date_h);
                    pre_prd_dep_qty_h = (colName == "上部門來貨數量" ? colName : pre_prd_dep_qty_h);
                }


                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    strSql = "";
                    excel_row = excel_row + 1;
                    DataRow dr = dt.Rows[i];
                    //if (i == 577)
                    //{
                    //    int aa = 1;
                    //}
                    arrange_seq = (arrange_seq_h == "" ? 0 : (dr[arrange_seq_h].ToString() != "" ? Convert.ToInt32(dr[arrange_seq_h]) : 0));
                    prd_mo = (prd_mo_h == "" ? "" : dr[prd_mo_h].ToString().Trim());
                    if (prd_mo != "")
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
                        prd_item = (prd_item_h == "" ? "" : dr[prd_item_h].ToString());

                        cust_o_date = (cust_o_date_h == "" ? "" : (dr[cust_o_date_h].ToString() != "" ? Convert.ToDateTime(dr[cust_o_date_h].ToString()).ToString("yyyy/MM/dd") : ""));
                        req_f_date = (req_f_date_h == "" ? "" : (dr[req_f_date_h].ToString() != "" ? Convert.ToDateTime(dr[req_f_date_h].ToString()).ToString("yyyy/MM/dd") : ""));
                        order_qty = (order_qty_h == "" ? 0 : (dr[order_qty_h].ToString() != "" ? Convert.ToInt32(dr[order_qty_h]) : 0));
                        req_qty = (req_qty_h == "" ? 0 : (dr[req_qty_h].ToString() != "" ? Convert.ToInt32(dr[req_qty_h]) : 0));
                        cpl_qty = (cpl_qty_h == "" ? 0 : (dr[cpl_qty_h].ToString() != "" ? Convert.ToInt32(dr[cpl_qty_h]) : 0));
                        arrange_qty = (arrange_qty_h == "" ? 0 : (dr[arrange_qty_h].ToString() != "" ? Convert.ToInt32(dr[arrange_qty_h]) : 0));
                        prd_cpl_qty = (prd_cpl_qty_h == "" ? 0 : (dr[prd_cpl_qty_h].ToString() != "" ? Convert.ToInt32(dr[prd_cpl_qty_h]) : 0));
                        //dep_rep_date = (dep_rep_date_h == "" ? "" : (dr[dep_rep_date_h].ToString() != "" ? Convert.ToDateTime(dr[dep_rep_date_h].ToString()).ToString("yyyy/MM/dd") : ""));
                        dep_rep_date = (dep_rep_date_h == "" ? "" : (dr[dep_rep_date_h].ToString() != "" ? dr[dep_rep_date_h].ToString() : ""));
                        arrange_machine = (arrange_machine_h == "" ? "" : dr[arrange_machine_h].ToString());
                        req_hk_date = (req_hk_date_h == "" ? "" : (dr[req_hk_date_h].ToString() != "" ? Convert.ToDateTime(dr[req_hk_date_h].ToString()).ToString("yyyy/MM/dd") : ""));
                        pre_prd_dep_date = (pre_prd_dep_date_h == "" ? "" : dr[pre_prd_dep_date_h].ToString());
                        pre_prd_dep_qty = (pre_prd_dep_qty_h == "" ? 0 : (dr[pre_prd_dep_qty_h].ToString() != "" ? Convert.ToInt32(dr[pre_prd_dep_qty_h]) : 0));
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
                        }
                        else
                            dep_group = (dep_group_h1 == "" ? "" : dr[dep_group_h1].ToString());
                        string dtt = System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");

                        strSql_f = "Select arrange_id From dgcf_pad.dbo.product_arrange Where prd_dep='" + prd_dep + "' And now_date='" + now_date + "' And prd_mo='" + prd_mo + "' And prd_item='" + prd_item + "'";
                        DataTable dtArrange = sh.ExecuteSqlReturnDataTable(strSql_f);
                        if (dtArrange.Rows.Count == 0)
                        {
                            //產生自動單號
                            string id = prd_dep + dtt.Substring(0, 4) + dtt.Substring(5, 2) + dtt.Substring(8, 2) + dtt.Substring(11, 2) + dtt.Substring(14, 2) + dtt.Substring(17, 2) + (i + 1).ToString().PadLeft(4, '0');
                            //string prd_seq = "01";
                            strSql += string.Format(@"INSERT INTO dgcf_pad.dbo.product_arrange (arrange_id,now_date,prd_dep,prd_mo,prd_item,mo_urgent,arrange_machine,arrange_date,arrange_seq,order_qty
                            ,cust_o_date,req_f_date,req_qty,cpl_qty,arrange_qty,prd_cpl_qty,dep_rep_date,rec_status,prd_status,req_hk_date,dep_group,pre_prd_dep_date,pre_prd_dep_qty,crusr,crtim)
                            VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}','{18}','{19}','{20}','{21}','{22}','{23}',GETDATE())"
                                , id, now_date, prd_dep, prd_mo, prd_item, urgent_status, arrange_machine, arrange_date, arrange_seq, order_qty
                                , cust_o_date, req_f_date, req_qty, cpl_qty, arrange_qty, prd_cpl_qty, dep_rep_date, rec_status, prd_status, req_hk_date, dep_group, pre_prd_dep_date, pre_prd_dep_qty, user_id);
                        }
                        else
                        {
                            string arrange_id = dtArrange.Rows[0]["arrange_id"].ToString();
                            strSql += string.Format(@"Update dgcf_pad.dbo.product_arrange Set mo_urgent='{0}',arrange_machine='{1}',arrange_date='{2}',arrange_seq='{3}'
                            ,order_qty='{4}',cust_o_date='{5}',req_f_date='{6}',req_qty='{7}',cpl_qty='{8}',arrange_qty='{9}',prd_cpl_qty='{10}'
                            ,dep_rep_date='{11}',rec_status='{12}',prd_status='{13}',req_hk_date='{14}',dep_group='{15}',now_date='{16}',pre_prd_dep_date='{17}',pre_prd_dep_qty='{18}',amusr='{19}'
                            ,amtim=GETDATE() Where arrange_id='{20}'"
                                , urgent_status, arrange_machine, arrange_date, arrange_seq, order_qty, cust_o_date, req_f_date, req_qty
                                , cpl_qty, arrange_qty, prd_cpl_qty, dep_rep_date, rec_status, prd_status, req_hk_date, dep_group, now_date, pre_prd_dep_date, pre_prd_dep_qty, user_id, arrange_id);
                        }
                        result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                        if (result_str != "")
                        {
                            upd_flag = false;
                            break;
                        }
                    }
                }
                imgProcess.Visible = false;
                if (upd_flag)
                    StrHlp.WebMessageBox(this.Page, "匯入排期表成功!");
                else
                    StrHlp.WebMessageBox(this.Page, "匯入排期表失敗,記錄： " + excel_row.ToString() + " " + result_str);
                //if (strSql != "")
                //{
                //    result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                //    if (result_str == "")
                //        StrHlp.WebMessageBox(this.Page, "匯入排期表成功!");
                //    else
                //        StrHlp.WebMessageBox(this.Page, "匯入排期表失敗："+ result_str);
                //}
                //else
                //{
                //    result_str = "";

                //}
            }
            catch (Exception ex)
            {
                result_str = "Excel文件的欄位不正確,行:" + excel_row.ToString() + " " + ex.Message;
            }
            imgProcess.Visible = false;
            if (result_str != "")
            {
                //Response.Write(String.Format("<script text='text/javascript'>alert('{0}')</script>", result_str));
                StrHlp.WebMessageBox(this.Page, result_str);
            }
        }

        private string ImportExcel(string filePath,string fileName)

        {
            string result = "";
            //DataSet ds = null;

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

            //ds = new DataSet();
            bool findSheetFlag = false;
            for (int i = 0; i < dtSheetName.Rows.Count; i++)//這個是獲取Excel所有的Sheet
                //for (int i = 0; i < 1; i++)//只獲取Excel第1個Sheet
            {
                DataTable dt = new DataTable();
                dt.TableName = "table0";// + i.ToString();
                //获取表名
                sheetName = dtSheetName.Rows[i]["TABLE_NAME"].ToString();
                //有些Excel是隱藏了很多個臨時表的，只將實際的導入
                //如果sheet的名字為數字開頭的如：105或105abc等，則sheetName則為：'105$'，則要將符號'去掉後再判斷
                if (sheetName.Substring(sheetName.Length - 1, 1) == "$" 
                    || (sheetName.Substring(0, 1) == "'" && sheetName.Substring(sheetName.Length - 1, 1) == "'" && sheetName.Substring(sheetName.Length - 2, 1) == "$"))
                {
                    findSheetFlag = true;
                    OleDbDataAdapter oleda = new OleDbDataAdapter("select * from [" + sheetName + "]", conn);
                    oleda.Fill(dt);
                    DtOperator(dt, fileName, sheetName);
                }
                
            }
            //ds.Tables.Add(dt);
            //关闭连接，释放资源
            conn.Close();
            conn.Dispose();
            if (findSheetFlag == false)
                result = "沒有符合的工作表，請檢查工作表名稱是否正確!";
            return result;
        }

    }
}