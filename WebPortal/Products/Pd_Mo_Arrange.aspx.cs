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
//using Leyp.Components.Module.Stock;
//using Leyp.Model.Stock;

namespace WebPortal.Products
{
    public partial class Pd_Mo_Arrange : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string user_id = "";//DBUtility.user_id;
        private string within_code = DBUtility.within_code;
        private int curPage = 1;
        /*总的页数*/
        private int totalPage = 0;
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
            dateArrange.Value = System.DateTime.Now.ToString("yyyy/MM/dd");
            //txtPrd_mo.Value = "GBE029520";
            DataTable tbMo_group = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getDep();
            dlDep.DataSource = tbMo_group.DefaultView;
            dlDep.DataTextField = "dep_cdesc";
            dlDep.DataValueField = "dep_id";
            dlDep.DataBind();

            this.firstBtn.Enabled = false;
            this.nextBtn.Enabled = false;
            this.prevBtn.Enabled = false;
            this.lastBtn.Enabled = false;
        }

        protected void Select_Click(object sender, EventArgs e)
        {
            curPage = 1;//將上次查詢的頁數恢復為1
            dlCurrentPage.Items.Clear();
            DataSetBand();
        }


        protected void DataSetBand()
        {
            string prd_dep = dlDep.SelectedValue;
            string now_date = dateArrange.Value;
            string prd_mo = txtPrd_mo.Value;

            this.OrderList.DataSource = null;
            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
            //CollectionPager1.DataSource = null;
            DataTable dtMoArrange = Leyp.SQLServerDAL.Factory_New.getProductsMoArrangeDAL().getDataMoArrange(now_date,prd_dep,prd_mo);
            ////OrderList.DataSource = ds.Tables["dd"].DefaultView;
            ////OrderList.DataBind();

            //CollectionPager1.DataSource = dtMoArrange.DefaultView;// list;
            //CollectionPager1.BindToControl = OrderList;
            //OrderList.DataSource = CollectionPager1.DataSourcePaged;

            ps.DataSource = dtMoArrange.DefaultView;
            ps.AllowPaging = true;
            ps.PageSize = 30;//每页显示几条记录
            ps.CurrentPageIndex = curPage - 1;//设置当前页的索引(当前页码减1就是)
            //this.OrderList.DataSource = ps;
            ////this.hourseDataList.DataKeyField = "hourseId";
            //this.OrderList.DataBind();




            ////如果有UpdatePanel就用如下代码调用前台js

            //////this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "", "<script>fixgrid();</script>", true);
            //////ScriptManager.RegisterStartupScript(UpdatePanel, this.Page.GetType(), "", "fixgrid();", true);


            this.firstBtn.Enabled = true;
            this.nextBtn.Enabled = true;
            this.prevBtn.Enabled = true;
            this.lastBtn.Enabled = true;
            totalPage = ps.PageCount;
            setCurrentPage(totalPage);//設置下拉框頁數

            this.lTotalPage.Text = totalPage.ToString();

            if (curPage == 1)//当是第一页是.上一页和首页的按钮不可用
            {
                this.prevBtn.Enabled = false;
                this.firstBtn.Enabled = false;
            }
            if (curPage == ps.PageCount)//当是最后一页时下一页和最后一页的按钮不可用
            {
                this.nextBtn.Enabled = false;
                this.lastBtn.Enabled = false;
            }


            this.OrderList.DataSource = ps;
            //this.hourseDataList.DataKeyField = "hourseId";
            this.OrderList.DataBind();


            //如果有UpdatePanel就用如下代码调用前台js
            ScriptManager.RegisterStartupScript(UpdatePanel, this.Page.GetType(), "", "fixgrid();", true);


        }

        protected void Btn_Query_Click(object sender, EventArgs e)
        {
            curPage = 1;
            this.DataSetBand();
        }
        protected void firstBtn_Click(object sender, EventArgs e)
        {
            curPage = 1;
            dlCurrentPage.SelectedValue = curPage.ToString();
            this.DataSetBand();
        }
        protected void prevBtn_Click(object sender, EventArgs e)
        {
            //curPage--;
            curPage = Convert.ToInt32(dlCurrentPage.SelectedValue) - 1;
            dlCurrentPage.SelectedValue = curPage.ToString();
            this.DataSetBand();
        }
        protected void nextBtn_Click(object sender, EventArgs e)
        {
            //curPage++;
            curPage = Convert.ToInt32(dlCurrentPage.SelectedValue) + 1;
            dlCurrentPage.SelectedValue = curPage.ToString();
            this.DataSetBand();
        }
        protected void lastBtn_Click(object sender, EventArgs e)
        {
            curPage = Convert.ToInt32(lTotalPage.Text);// totalPage;//
            dlCurrentPage.SelectedValue = curPage.ToString();
            this.DataSetBand();
        }
        protected void setCurrentPage(int totalPage)
        {
            curPage = (dlCurrentPage.SelectedValue.ToString() != "" ? Convert.ToInt32(dlCurrentPage.SelectedValue) : 1);
            dlCurrentPage.Items.Clear();
            for (int i = 1; i < totalPage + 1; i++)
            {
                dlCurrentPage.Items.Add(i.ToString());
            }
            dlCurrentPage.SelectedValue = curPage.ToString();
        }
        protected void dlCurrentPage_Click(object sender,EventArgs e)
        {
            curPage = Convert.ToInt32(dlCurrentPage.SelectedValue);
            this.DataSetBand();
        }


        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //這個是JavaScript取值方法
            //string[] proSub = Request.Form.GetValues("selDep");
            //string prd_dep = proSub[selDep.SelectedIndex];

            string now_date = dateArrange.Value; //System.DateTime.Now.ToString("yyyy/MM/dd");
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
            dsExcel=ImportExcel(savePath + fileName);
            DataSetOperator(dsExcel.Tables[0],fileName);
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
                DataSetOperator(ds.Tables[0],fileName);
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
        private void DataSetOperator(DataTable dt,string fileName)
        {
            string result_str = "";
            string strSql = "", strSql_f = "";


            string now_date, prd_dep = "102";
            int excel_row = 0;
            //string[] proSub = Request.Form.GetValues("selDep");
            //prd_dep = proSub[selDep.SelectedIndex];
            prd_dep = dlDep.SelectedValue.ToString().Trim();
            now_date = dateArrange.Value; //System.DateTime.Now.ToString("yyyy/MM/dd");
            string prd_mo, prd_item, urgent_status1, urgent_status, arrange_date, arrange_machine, cust_o_date = "", req_f_date, dep_rep_date, req_hk_date,dep_group;
            string pre_prd_dep_date = "";
            int pre_prd_dep_qty = 0;
            int arrange_seq, order_qty, req_qty, cpl_qty, arrange_qty, prd_cpl_qty;
            string prd_status = "00";//
            string rec_status = "0";
            user_id = getUserName();
            string strDep = fileName.Substring(0, 3);
            dep_group = "";
            if (prd_dep=="102")
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
                    prd_item_h = (colName == "產品編號" ? colName : prd_item_h);
                    cust_o_date_h = (colName == "客落單日期" ? colName : cust_o_date_h);
                    req_f_date_h = (colName == "要求完成時間" ? colName : req_f_date_h);
                    order_qty_h = (colName == "訂單數量" ? colName : order_qty_h);
                    req_qty_h = (colName == "要求數量" || colName == "應生產數量" ? colName : req_qty_h);
                    cpl_qty_h = (colName == "完成數量" || colName == "已完成數量" ? colName : cpl_qty_h);
                    arrange_qty_h = (colName == "待完成數量" ? colName : arrange_qty_h);
                    prd_cpl_qty_h = (colName == "生產數量" ? colName: prd_cpl_qty_h);
                    dep_rep_date_h = (colName == "部門回覆" || colName == "部門覆期" || colName == "部門復期" ? colName : dep_rep_date_h);
                     arrange_machine_h = (colName == "生產設備" ? colName : arrange_machine_h);
                    req_hk_date_h = (colName == "計劃回港期" || colName == "計劃回港日期" || colName == "回港期" ? colName : req_hk_date_h);
                    dep_group_h1 = (colName == "自動" || colName == "组別" ? colName : dep_group_h1);
                    dep_group_h2 = (colName == "打扣" ? colName : dep_group_h2);
                    dep_group_h3 = (colName == "車碑" ? colName : dep_group_h3);
                    pre_prd_dep_date_h = (colName == "上部門來貨期" ? colName : pre_prd_dep_date_h);
                    pre_prd_dep_qty_h = (colName == "上部門來貨數量" ? colName : pre_prd_dep_qty_h);
                }

                
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    excel_row = excel_row + 1;
                    DataRow dr = dt.Rows[i];

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
                            dep_group= (dep_group_h1 == "" ? "" : dr[dep_group_h1].ToString());
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
                                , cust_o_date, req_f_date, req_qty, cpl_qty, arrange_qty, prd_cpl_qty, dep_rep_date, rec_status, prd_status,req_hk_date,dep_group, pre_prd_dep_date, pre_prd_dep_qty, user_id);
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
                    }
                }

                if (strSql != "")
                {
                    result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                    StrHlp.WebMessageBox(this.Page, "匯入排期表成功!");
                    this.DataSetBand();
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