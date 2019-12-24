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
    public partial class Pd_Mo_OutSide_ReWork_SetMark : BasePage//System.Web.UI.Page
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
                DataSetBand();
            }
        }

        protected void init()
        {

            //txtPrd_mo.Value = "GBE029520";
            DataTable tbMo_group = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getDep();
            dlDep.DataSource = tbMo_group.DefaultView;
            dlDep.DataTextField = "dep_cdesc";
            dlDep.DataValueField = "dep_id";
            dlDep.DataBind();
            dlDep.SelectedValue = "501";
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
            bool is_val = false;
            string prd_dep = dlDep.SelectedValue;
            string prd_mo = txtPrd_mo.Value;

            this.OrderList.DataSource = null;
            System.Web.UI.WebControls.PagedDataSource ps = new PagedDataSource();
            //CollectionPager1.DataSource = null;


            SQLHelp sh = new SQLHelp();

            string strSql = "";
            strSql = "Select dep_id,vendor_id,mo_id,goods_id,remark,crusr,Convert(Varchar(20),crtim,120) As crtim " +
                    " From mo_outside_rework_mark Where dep_id>'' ";
            if (prd_dep != "" && prd_dep != null)
            {
                strSql += " And dep_id='" + prd_dep + "'";
                
            }
            if (txtVendor_id.Value != "")
            {
                strSql += " And vendor_id='" + txtVendor_id.Value + "'";
                is_val = true;
            }
            if (prd_mo != "" && prd_mo != null)
            {
                strSql += " And mo_id='" + prd_mo + "'";
                is_val = true;
            }
            if(is_val ==false)
            {
                string dat1 = System.DateTime.Now.ToString("yyyy/MM/dd");
                string dat2 = System.DateTime.Now.AddDays(1).ToString("yyyy/MM/dd");
                strSql += " And crtim>='" + dat1 + "' And crtim<'" + dat2 + "'";
            }
            strSql += " Order By dep_id,vendor_id,crtim Desc";

            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);


            ps.DataSource = dt.DefaultView;
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


            if (dlDep.SelectedIndex == 0)
            {
                StrHlp.WebMessageBox(this.Page, "部門不能為空！");
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
        /// 数据集操作  
        /// </summary>  
        /// <param name="ds"></param>  
        /// 更新Excel表到临时表pu_temp_excel中
        private void DataSetOperator(DataTable dt,string fileName)
        {
            string result_str = "";
            string strSql = "", strSql_f = "";


            string now_date, prd_dep = "501";
            int excel_row = 0;
            //string[] proSub = Request.Form.GetValues("selDep");
            //prd_dep = proSub[selDep.SelectedIndex];
            prd_dep = dlDep.SelectedValue.ToString().Trim();

            string vendor_id,prd_mo, prd_item,remark;

            user_id = getUserName();

            try
            {
                string vend_h = "", prd_mo_h = "", prd_item_h = "", remark_h = "";
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string colName = dt.Columns[j].ColumnName;
                    vend_h = (colName == "供應商" ? colName : vend_h);
                    prd_mo_h = (colName == "頁數" ? colName : prd_mo_h);
                    prd_item_h = (colName == "貨品編碼" ? colName : prd_item_h);
                    remark_h = (colName == "電鍍回覆" ? colName : remark_h);

                }
                if (vend_h == "" || prd_mo_h == "" || prd_item_h == "" || remark_h == "")
                {
                    StrHlp.WebMessageBox(this.Page, "Excel文件第一行必須為有效的表頭格式：供應商 -- 頁數 -- 貨品編碼--電鍍回覆!");
                    return;
                }


                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    excel_row = excel_row + 1;
                    DataRow dr = dt.Rows[i];

                    prd_mo = (prd_mo_h == "" ? "" : dr[prd_mo_h].ToString().Trim());
                    if (prd_mo != "")
                    {
                        vendor_id = (prd_item_h == "" ? "" : dr[vend_h].ToString());
                        prd_item = (prd_item_h == "" ? "" : dr[prd_item_h].ToString());
                        remark = (remark_h == "" ? "" : dr[remark_h].ToString());

                        strSql_f = "Select mo_id From mo_outside_rework_mark Where dep_id='" + prd_dep + "' And vendor_id='" + vendor_id + "' And mo_id='" + prd_mo + "' And goods_id='" + prd_item + "'";
                        DataTable dtArrange = sh.ExecuteSqlReturnDataTable(strSql_f);
                        if (dtArrange.Rows.Count == 0)
                        {
                            //產生自動單號

                            strSql += string.Format(@"INSERT INTO mo_outside_rework_mark (dep_id,vendor_id,mo_id,goods_id,remark,crusr,crtim)
                            VALUES ('{0}','{1}','{2}','{3}','{4}','{5}',GETDATE())"
                                , prd_dep, vendor_id, prd_mo, prd_item, remark, user_id);
                        }
                        else
                        {
                            strSql += string.Format(@"Update mo_outside_rework_mark Set remark='{0}',crusr='{1}'
                            ,crtim=GETDATE() Where dep_id='{2}' And vendor_id='{3}' And mo_id='{4}' And goods_id='{5}'"
                                , remark, user_id, prd_dep, vendor_id, prd_mo, prd_item);
                        }
                    }
                }

                if (strSql != "")
                {
                    result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                    StrHlp.WebMessageBox(this.Page, "匯入電鍍回覆成功!");
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