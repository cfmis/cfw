using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Leyp.SQLServerDAL;
using Leyp.SQLServerDAL.Sales;
using Leyp.Components;
using Leyp.Components.Module;

namespace WebPortal.ashx
{
    /// <summary>
    ///Sa_Order_Trace 的摘要描述
    /// </summary>
    public class Sa_Order_Trace : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            string jaa = Query(context);

            //string jaa = GenExcel(context);

            context.Response.Write(jaa);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private string Query(HttpContext context)
        {


            string para = context.Request["param"];

            string jsonText = @"{""input"" : ""value"", ""output"" : ""result""}";

            JsonReader reader = new JsonTextReader(new StringReader(para));
            while (reader.Read())
            {
                Console.WriteLine(reader.TokenType + "\t\t" + reader.ValueType + "\t\t" + reader.Value);

            }

            string jsonArrayText1 = "[{'a':'a1','b':'b1'},{'a':'a2','b':'b2'}]";
            //jsonArrayText1="[{'id':'2017/12/26','mo_id':'TBE009852'},{'id':'2017/12/26','mo_id':'TBE009852'}]";
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            string jaa = "";
            string jab = "";
            string result = "";
            string msg = "";
            string mo_id = "";
            for (int i = 0; i < ja.Count; i++)
            {

                jaa = ja[i]["order_date"].ToString();
                jab += ja[i]["id"].ToString() + "\t\t";
                string within_code = Base.within_code;
                mo_id = ja[i]["mo_id"].ToString();
                string prd_status = ja[i]["prd_status"].ToString();
                string ret_hk_status = ja[i]["ret_hk_status"].ToString();
                string sample_hk_status = ja[i]["sample_hk_status"].ToString();
                string chk_color_oth = ja[i]["chk_color_oth"].ToString();
                string chk_color_status = ja[i]["chk_color_status"].ToString();
                string chk_color_date = ja[i]["chk_color_date"].ToString();
                string job_no = ja[i]["job_no"].ToString();
                string test_result = ja[i]["test_result"].ToString();
                string test_status = ja[i]["test_status"].ToString();
                string inv_no = ja[i]["test_inv_no"].ToString();
                string inv_date = ja[i]["test_inv_date"].ToString();
                string shipment = ja[i]["shipment"].ToString();
                string shipment_oth = ja[i]["shipment_oth"].ToString();
                string awb_no = ja[i]["awb_no"].ToString();
                string sent_date = ja[i]["sent_date"].ToString();
                string remark = ja[i]["remark"].ToString();
                string mo_status = ja[i]["mo_status"].ToString();
                result = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().updOrderTrace(within_code, mo_id, prd_status
                    , ret_hk_status, sample_hk_status, chk_color_status, chk_color_oth, chk_color_date, job_no
                    ,test_result, test_status, inv_no, inv_date, shipment,shipment_oth, awb_no, sent_date, remark, mo_status);
                if (result != "")
                    break;
            
            }
            if (result == "")
                msg = "記錄更新成功!";
            else
                msg = "更新失敗，制單編號: "+mo_id+" !";
            return msg;

        }



        //protected void btnExpExcelNew_Click()
        //{
        //    string content = getExcelContent();
            

        //}




        private string GenExcel(HttpContext context)
        {


            string para = context.Request["param"];

            //string jsonText = @"{""input"" : ""value"", ""output"" : ""result""}";

            //JsonReader reader = new JsonTextReader(new StringReader(para));
            //while (reader.Read())
            //{
            //    Console.WriteLine(reader.TokenType + "\t\t" + reader.ValueType + "\t\t" + reader.Value);

            //}

            //string jsonArrayText1 = "[{'a':'a1','b':'b1'},{'a':'a2','b':'b2'}]";
            ////jsonArrayText1="[{'id':'2017/12/26','mo_id':'TBE009852'},{'id':'2017/12/26','mo_id':'TBE009852'}]";


            StringBuilder sb = new StringBuilder();
            string ex_str = "";

            sb.Append("<table borderColor='black' border='1' >");
            sb.Append("<tr>");

            ex_str += "<th bgColor='#ccfefe'>" + "訂單日期" + "</th>";
            ex_str += "<th bgColor='#ccfefe'>" + "客戶編號" + "</th>";
            ex_str += "<th bgColor='#ccfefe'>" + "客戶描述" + "</th>";

            sb.Append(ex_str);
            sb.Append("</tr></thead>");
            sb.Append("<tbody>");


            JArray ja = (JArray)JsonConvert.DeserializeObject(para);

            string msg = "";
            string mo_id = "";
            for (int i = 0; i < ja.Count; i++)
            {

                sb.Append("<tr class='firstTR'>");
                sb.Append("<td>" + ja[i]["mo_id"].ToString() + "</td>");
                sb.Append("<td>" + ja[i]["mo_id"].ToString() + "</td>");
                sb.Append("<td>" + ja[i]["prd_status"].ToString() + "</td>");
                //sb.Append("<td>" + "=\"" + row.Cells[j].Text.ToString() + "\"" + "</td>");

                sb.Append("</tr>");



            }
            sb.Append("</tbody></table>");

            string content = sb.ToString();

            string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
            string filename = "OC報表.xls";
            filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
            ExportToExcel(filename, content, css);

            msg = "記錄更新成功!";
            return msg;

        }



        //protected string getExcelContent()
        //{
        //    StringBuilder sb = new StringBuilder();
        //    string ex_str = "";

        //    sb.Append("<table borderColor='black' border='1' >");
        //    sb.Append("<tr>");
        //    for (int i = 0; i < gvDetails.Columns.Count; i++)
        //    {
        //        ex_str += "<th bgColor='#ccfefe'>" + gvDetails.Columns[i].HeaderText + "</th>";
        //    }

        //    sb.Append(ex_str);
        //    sb.Append("</tr></thead>");
        //    sb.Append("<tbody>");

        //    for (int i = 0; i < gvDetails.Rows.Count; i++)
        //    {
        //        GridViewRow row = gvDetails.Rows[i];
        //        sb.Append("<tr class='firstTR'>");

        //        for (int j = 0; j < gvDetails.Columns.Count; j++)
        //        {
        //            if (j == 0)
        //                sb.Append("<td>" + row.Cells[gvDetails.Columns.Count - 1].Text.ToString() + "</td>");//因為有網址連接的Mo欄不能匯出內容，所以用最後欄的Mo替換
        //            else
        //            {
        //                if (j == 1 || j == 2)//固定日期格式
        //                    sb.Append("<td>" + "=\"" + row.Cells[j].Text.ToString() + "\"" + "</td>");
        //                else
        //                    sb.Append("<td>" + row.Cells[j].Text.ToString() + "</td>");
        //            }
        //        }

        //        sb.Append("</tr>");
        //    }
        //    sb.Append("</tbody></table>");
        //    return sb.ToString();
        //}


        //匯出到Excel
        private void ExportToExcel(string filename, string content, string cssText)
        {
            var res = HttpContext.Current.Response;
            content = String.Format("<style type='text/css'>{0}</style>{1}", cssText, content);

            res.Clear();
            res.Buffer = true;
            res.Charset = "UTF-8";
            res.AddHeader("Content-Disposition", "attachment; filename=" + filename);
            //res.ContentEncoding = System.Text.Encoding.UTF8;// System.Text.Encoding.GetEncoding("GB2312");//簡體
            res.ContentEncoding = System.Text.Encoding.UTF8;// System.Text.Encoding//繁體
            res.ContentType = "application/ms-excel";//;charset=GB2312
            res.Write(content);
            res.Flush();
            res.End();
        }

    }
}