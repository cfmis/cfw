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
//using Leyp.SQLServerDAL.Sales;
using Leyp.Components;
using Leyp.Components.Module;


namespace WebPortal.Products
{
    public partial class Pd_Mo_Plan_New : BasePage//System.Web.UI.Page
    {
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private string lang_id = DBUtility.lang_id;
        private string user_id = "";//DBUtility.user_id;
        private string within_code = DBUtility.within_code;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                initControls();

            }
        }

        private void initControls()
        {
            dateArrange.Value = System.DateTime.Now.AddDays(1).ToString("yyyy/MM/dd");

            DataTable tbMo_group = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getDep();
            dlDep.DataSource = tbMo_group.DefaultView;
            dlDep.DataTextField = "dep_cdesc";
            dlDep.DataValueField = "dep_id";
            dlDep.DataBind();

           
        }
        protected void btnUpload_Click(object sender, EventArgs e)
        {
            //這個是JavaScript取值方法
            //string[] proSub = Request.Form.GetValues("selDep");
            //string prd_dep = proSub[selDep.SelectedIndex];

            string now_date = dateArrange.Value; //System.DateTime.Now.ToString("yyyy/MM/dd");
            if (dlDep.SelectedIndex==0)
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
                DataSetOperator(ds.Tables[0]);
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
        private void DataSetOperator(DataTable dt)
        {
            string result_str = "";
            string strSql = "", strSql_f = "";
            

            string now_date,prd_dep = "102";
            int excel_row = 0;
            //string[] proSub = Request.Form.GetValues("selDep");
            //prd_dep = proSub[selDep.SelectedIndex];
            prd_dep = dlDep.SelectedValue.ToString().Trim();
            now_date = dateArrange.Value; //System.DateTime.Now.ToString("yyyy/MM/dd");
            string prd_mo, prd_item, urgent_status1, urgent_status, arrange_date, arrange_machine, order_date = "", req_time, dep_rep_date;
            int arrange_seq, order_qty, req_qty, cpl_qty, wait_cpl_qty, prd_cpl_qty;
            user_id = getUserName();
            //strSql += string.Format(@"Delete From product_arrange Where prd_dep='{0}' and now_date='{1}'", prd_dep, now_date);
            try
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    excel_row = excel_row + 1;
                    DataRow dr = dt.Rows[i];
                    arrange_seq = (dr[0].ToString() != "" ? Convert.ToInt32(dr[0]) : 0);
                    prd_mo = dr[1].ToString();
                    if (prd_mo != "")
                    {
                        arrange_date = (dr[2].ToString() != "" ? Convert.ToDateTime(dr[2].ToString()).ToString("yyyy/MM/dd") : "");
                        urgent_status1 = dr[3].ToString();
                        urgent_status = "";
                        if (urgent_status1 == "超特急")
                            urgent_status = "01";
                        else
                        {
                            if (urgent_status1 == "特急")
                                urgent_status = "02";
                            else
                            {
                                if (urgent_status1 == "急單" || urgent_status1 == "急")
                                    urgent_status = "03";
                            }
                        }
                        prd_item = dr[4].ToString();

                        order_date = (dr[7].ToString() != "" ? Convert.ToDateTime(dr[7].ToString()).ToString("yyyy/MM/dd") : "");
                        req_time = (dr[9].ToString() != "" ? Convert.ToDateTime(dr[9].ToString()).ToString("yyyy/MM/dd") : "");
                        order_qty = (dr[10].ToString() != "" ? Convert.ToInt32(dr[10]) : 0);
                        req_qty = (dr[11].ToString() != "" ? Convert.ToInt32(dr[11]) : 0);
                        cpl_qty = (dr[12].ToString() != "" ? Convert.ToInt32(dr[12]) : 0);
                        wait_cpl_qty = (dr[13].ToString() != "" ? Convert.ToInt32(dr[13]) : 0);
                        prd_cpl_qty = (dr[14].ToString() != "" ? Convert.ToInt32(dr[14]) : 0);
                        dep_rep_date = (dr[16].ToString() != "" ? Convert.ToDateTime(dr[16].ToString()).ToString("yyyy/MM/dd") : "");
                        arrange_machine = dr[17].ToString();
                        string dtt = System.DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");
                        string id = prd_dep + dtt.Substring(0, 4) + dtt.Substring(5, 2) + dtt.Substring(8, 2) + dtt.Substring(11, 2) + dtt.Substring(14, 2) + dtt.Substring(17, 2) + (i + 1).ToString().PadLeft(4, '0');
                        strSql_f = "Select prd_mo From product_arrange Where prd_dep='" + prd_dep + "' And now_date='" + now_date + "' And prd_mo='" + prd_mo + "' And prd_item='" + prd_item + "'";
                        if (sh.ExecuteSqlReturnDataTable(strSql_f).Rows.Count == 0)
                            strSql += string.Format(@"INSERT INTO product_arrange (arrange_id,now_date,prd_dep,prd_mo,prd_item,urgent_status,arrange_machine,arrange_date,arrange_seq,order_qty
                            ,order_date,req_time,req_qty,cpl_qty,wait_cpl_qty,prd_cpl_qty,dep_rep_date,crusr,crtim)
                            VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}','{14}','{15}','{16}','{17}',GETDATE())"
                                , id, now_date, prd_dep, prd_mo, prd_item, urgent_status, arrange_machine, arrange_date, arrange_seq, order_qty
                                , order_date, req_time, req_qty, cpl_qty, wait_cpl_qty, prd_cpl_qty, dep_rep_date, user_id);
                        else
                            strSql += string.Format(@"Update product_arrange Set urgent_status='{0}',arrange_machine='{1}',arrange_date='{2}',arrange_seq='{3}'
                            ,order_qty='{4}',order_date='{5}',req_time='{6}',req_qty='{7}',cpl_qty='{8}',wait_cpl_qty='{9}',prd_cpl_qty='{10}'
                            ,dep_rep_date='{11}',amusr='{12}',amtim=GETDATE() Where prd_dep='{13}' And now_date='{14}' And prd_mo='{15}' And prd_item='{16}'"
                                , urgent_status, arrange_machine, arrange_date, arrange_seq, order_qty
                                , order_date, req_time, req_qty, cpl_qty, wait_cpl_qty, prd_cpl_qty, dep_rep_date, user_id, prd_dep, now_date, prd_mo, prd_item);
                    }
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
                result_str = "Excel文件的欄位不正確:(" + excel_row.ToString() + ")" + ex.Message;
            }
            if (result_str != "")
            {
                //Response.Write(String.Format("<script text='text/javascript'>alert('{0}')</script>", result_str));
                StrHlp.WebMessageBox(this.Page, result_str);
            }
        }


    }
}