using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

namespace Leyp.Components
{
    public class clsPublic
    {


        //匯出到Excel
        public void ExportToExcel(string filename, string content, string cssText)
        {
            var res = HttpContext.Current.Response;
            content = String.Format("<style type='text/css'>{0}</style>{1}", cssText, content);

            res.Clear();
            res.Buffer = true;
            res.Charset = "UTF-8";
            res.AddHeader("Content-Disposition", "attachment; filename=" + filename);
            res.ContentEncoding = System.Text.Encoding.UTF8;// System.Text.Encoding.GetEncoding("GB2312");
            res.ContentType = "application/ms-excel";//;charset=GB2312
            res.Write("<meta http-equiv=\"content-type\" content=\"application/ms-excel; charset=UTF-8\"/>" + content);
            res.Flush();
            res.End();
        }


        //複製文件
        public bool FileCopy(string source, string destination)
        {
            bool ret = false;
            System.IO.FileInfo file_s = new System.IO.FileInfo(source);
            System.IO.FileInfo file_d = new System.IO.FileInfo(destination);
            string Result_str;
            //File.Copy(Server.MapPath(source), destination);
            try
            {
                //file_s.CopyTo(destination);
                if (file_s.Exists)
                {
                    if (!file_d.Exists)
                    {
                        file_s.CopyTo(destination);
                        ret = true;
                    }
                }
            }
            catch (Exception ex)
            {
                Result_str = ex.Message;//
            }
            //if (ret == true)
            //{
            //    Response.Write("<script>alert('复制文件成功！');</script>");
            //}
            //else
            //{
            //    Response.Write("<script>alert('复制文件失败！');</script>");
            //}

            return ret;
            //return true;
        }


        #region dataTable转换成Json格式  
        /// <summary>       
        /// dataTable转换成Json格式       
        /// </summary>       
        /// <param name="dt"></param>       
        /// <returns></returns>       
        public string DataTableJsonReturnTextBox(DataTable dt)
        {
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("{\"");
            jsonBuilder.Append(dt.TableName.ToString());
            jsonBuilder.Append("\":[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString());
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }


        public string DataTableJsonReturnList(DataTable dt)
        {
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString());
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("]");
            //jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }

        //JASON格式，返回給EasyUI Table使用
        public string DataTableJsonReturnTable(DataTable dt)
        {
            StringBuilder json = new StringBuilder();
            StringBuilder jsonBuilder = new StringBuilder();
            json.Append("{\"total\":");
            json.Append(dt.Rows.Count);
            json.Append(",\"rows\":[");



            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    string aa = WipeRiskString(dt.Rows[i][j].ToString().Trim());
                    jsonBuilder.Append(WipeRiskString(dt.Rows[i][j].ToString().Trim()));
                    jsonBuilder.Append("\",");
                }
                if (dt.Columns.Count > 0)
                {
                    jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                }
                jsonBuilder.Append("},");
            }
            if (dt.Rows.Count > 0)
            {
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            }

            json.Append(jsonBuilder.ToString());
            json.Append("]}");

            return json.ToString();
        }

        #endregion

        //JASON格式，返回給匯出到Excel使用
        public string DataTableJsonReturnExcel(DataTable dt)
        {
            StringBuilder json = new StringBuilder();
            StringBuilder jsonBuilder = new StringBuilder();
             json.Append("[");



            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    string aa = WipeRiskString(dt.Rows[i][j].ToString().Trim());
                    jsonBuilder.Append(WipeRiskString(dt.Rows[i][j].ToString().Trim()));
                    jsonBuilder.Append("\",");
                }
                if (dt.Columns.Count > 0)
                {
                    jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                }
                jsonBuilder.Append("},");
            }
            if (dt.Rows.Count > 0)
            {
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            }

            json.Append(jsonBuilder.ToString());
            json.Append("]");

            return json.ToString();
        }
        //去處非法的字符
        public string WipeRiskString(string fstr)
        {
            string tstr = fstr;
            tstr = tstr.Replace("\r\n", "");
            tstr = tstr.Replace("\r", "");
            tstr = tstr.Replace("\n", "");
            tstr = tstr.Replace("\\", "");//SBL012647
            tstr = tstr.Replace("\u0002", "");//GBV043482
            tstr = tstr.Replace("\t", "");
            tstr = tstr.Replace("%", "");
            tstr = tstr.Replace("!", "");
            tstr = tstr.Replace("\"", "");
            tstr = tstr.Replace("”", "");
            tstr = tstr.Replace("“", "");
            //tstr = tstr.Replace(".", "");
            //tstr = tstr.Replace("~", "");
            tstr = tstr.Replace("{", "");
            tstr = tstr.Replace("}", "");
            tstr = tstr.Replace("?", "");
            return tstr;
        }

    }


}
