using System;
using System.Data;
using System.Configuration;
using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
//using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
//using System.Web.Mail;
//using sqloperate;
using System.Text;

//using cfoa.cls;

/// <summary>
/// sqlhelp 的摘要说明
/// </summary>
/// 
namespace Leyp.SQLServerDAL
{
    public class SQLHelp
    {
        public static readonly string constring = ConfigurationManager.ConnectionStrings["ConnStr_DGSQL2_DB"].ConnectionString;
        public static readonly string constring1 = ConfigurationManager.ConnectionStrings["ConnStr_DGSQL2_PAD"].ConnectionString;
        public static readonly string constring2 = ConfigurationManager.ConnectionStrings["ConnStr_DGERP2_GEO"].ConnectionString;
        //public static readonly string con_hr = ConfigurationManager.ConnectionStrings["ConnStr_DGSQL1_HR"].ConnectionString;
        public readonly string con_hr = System.Configuration.ConfigurationManager.AppSettings["ConnStr_DGSQL1_HR"];
        SqlConnection con;

        public DataSet ds(string sqlstring)
        {
            con = new SqlConnection(constring);
            SqlDataAdapter da = new SqlDataAdapter(sqlstring, con);
            DataSet ds = new DataSet();
            da.Fill(ds, "table");
            da.Dispose();
            con.Close();
            return ds;
        }
        public int updatesql(string sqlstr)
        {
            con = new SqlConnection(constring);
            SqlCommand cmd = new SqlCommand(sqlstr, con);
            cmd.Connection = con;
            con.Open();
            try
            {
                cmd.ExecuteNonQuery();
                return 1;
            }
            catch (Exception ex)
            {
                return 0;
            }
            finally
            {
                con.Close();
            }
        }

        public DataSet ExecStore(string proname)
        {
            con = new SqlConnection(constring);
            SqlDataAdapter da = new SqlDataAdapter(proname, con);

            DataSet ds = new DataSet();
            da.Fill(ds, "proname");
            return ds;
        }
        public string insertvalue(string procedurename, SqlParameter[] para)
        {
            con = new SqlConnection(constring);
            SqlCommand cmd = new SqlCommand(procedurename, con);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                con.Open();
                foreach (SqlParameter par in para)
                {
                    cmd.Parameters.Add(par);
                }
                cmd.ExecuteNonQuery();
                con.Close();
                return "提交成功";

            }
            catch (Exception ex)
            {

                return "數據提交失敗!";
            }
            finally
            {
                con.Close();
            }
        }
        public int selectsql(string sql)
        {
            con = new SqlConnection(constring);
            SqlCommand cmd = new SqlCommand(sql, con);
            try
            {
                con.Open();
                int i = (int)cmd.ExecuteScalar();
                if (i > 0)
                    return 1;
                else
                    return 0;

            }
            catch (Exception ex)
            {
                return -1;
            }
            finally
            {

                con.Dispose();
                con.Close();
            }
        }
        
        /// <summary>
        ///執行存儲過程，返回dataTable 
        /// </summary>
        /// <param name="strSql"></param>
        /// <param name="paras"></param>
        /// <returns></returns>
        public DataTable ExecuteProcedure(string strSql, SqlParameter[] paras)
        {
            con = new SqlConnection(constring);
            DataTable dtData = new DataTable();
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = strSql;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 2400;//連接20分鐘
                cmd.Parameters.AddRange(paras);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(dtData);
                sda.Dispose();
            }
            catch (Exception ex)
            {

                string error;
                error = ex.Message;
                //MessageBox.Show(ex.Message);
            }
            finally
            {
                con.Close();
            }
            return dtData;
        }


        /// <summary>
        ///執行存儲過程，不返回值
        /// </summary>
        /// <param name="strSql"></param>
        /// <param name="paras"></param>
        /// <returns></returns>
        public int ExecuteProcedureNonQuery(string strSql, SqlParameter[] paras)
        {
            int result=-1;
            con = new SqlConnection(constring);
            try
            {

                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = strSql;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 1200;//連接20分鐘
                cmd.Parameters.AddRange(paras);
                result = cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            catch (Exception ex)
            {

                //MessageBox.Show(ex.Message);
            }
            finally
            {
                con.Close();
            }
            return result;
        }

        /// <summary>
        ///執行存儲過程，返回DataSet
        /// </summary>
        /// <param name="strSql"></param>
        /// <param name="paras"></param>
        /// <returns></returns>
        public DataSet ExecutePrdReturnDataSet(string strSql, SqlParameter[] paras)
        {
            DataSet ds = new DataSet();
            con = new SqlConnection(constring);
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = strSql;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 1200;//連接20分鐘
                cmd.Parameters.AddRange(paras);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
                sda.Dispose();
            }
            catch (Exception ex)
            {

                //MessageBox.Show(ex.Message);
            }
            finally
            {
                con.Close();
            }
            return ds;
        }

        /// <summary>
        /// 執行SQL，返回 dataTable 類型
        /// </summary>
        /// <returns></returns>
        public DataTable ExecuteSqlReturnDataTable(string strSQL)
        {
            con = new SqlConnection(constring);
            DataTable dtData = new DataTable();
            string err_str;
            try
            {
                SqlDataAdapter sda = new SqlDataAdapter(strSQL, con);
                sda.Fill(dtData);
                sda.Dispose();
            }
            catch (Exception ex)
            {

                //MessageBox.Show(ex.Message);
                err_str = ex.Message;
            }
            finally
            {
                con.Close();
            }
            return dtData;
        }
        //从Geo系统中提取记录，并返回TableData
        public DataTable ExecuteSqlReturnDataTableGeo(string strSQL)
        {
            DataTable dtData = new DataTable();
            con = new SqlConnection(constring2);
            string err_str;
            try
            {
                    SqlDataAdapter sda = new SqlDataAdapter(strSQL, con);
                    sda.Fill(dtData);
                    con.Close();
                    sda.Dispose();
            }
            catch (Exception ex)
            {

                //MessageBox.Show(ex.Message);
                err_str = ex.Message;
            }
            finally
            {
                con.Close();
            }
            return dtData;
        }
        public bool ExecuteSqlUpdateTable(StringBuilder toquery)
        {
            bool result = false;
            string err_str;
            con = new SqlConnection(constring);
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand(toquery.ToString(), con);

                if (Convert.ToInt32(command.ExecuteNonQuery()) > 0)
                {
                    result = true;

                }
                command.Dispose();
            }
            catch (Exception ex)
            {

                //MessageBox.Show(ex.Message);
                err_str = ex.Message;
            }
            finally
            {
                con.Close();
            }
            return result;
        }
        /// <summary>
        /// 執行SQL，返回 Reader 類型
        /// </summary>
        /// <returns></returns>
        //public SqlDataReader ExecuteSqlReturnReader(string strSQL)
        //{
        //    con = new SqlConnection(constring);
        //    con.Open();
        //    SqlCommand sqlcom = new SqlCommand(strSQL, con);
        //    SqlDataReader sda = sqlcom.ExecuteReader();
        //    sqlcom.Dispose();
        //    con.Close();
        //    return sda;
        //}
        
        public string ExecuteSqlUpdate(string strSql)
        {
            string Result_str = "";
            con = new SqlConnection(constring);
            con.Open();
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = strSql;
                cmd.CommandTimeout = 1200;//連接20分鐘
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Result_str = ex.Message;//
                Result_str = WipeRiskString(Result_str);
                //if (Result_str.IndexOf("'") > 0)//轉換成可以在屏幕上輸出的字符
                //    Result_str = ReplaceChar(Result_str, Convert.ToChar("'"), Convert.ToChar("‘"));//
                //if (Result_str.IndexOf("\\") > 0)//轉換成可以在屏幕上輸出的字符
                //    Result_str = clsPublic.ReplaceChar(Result_str, Convert.ToChar("\\"), Convert.ToChar("、"));//
            }
            finally
            {
                con.Close();
            }
            
            return Result_str;
        }
        //更新Geo系統
        public string ExecuteSqlUpdateGeo(string strSql)
        {
            string Result_str = "";
            con = new SqlConnection(constring2);
            con.Open();
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = strSql;
                cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            catch (Exception ex)
            {
                Result_str = ex.Message;//
            }
            finally
            {
                con.Close();
            }
            //if (Result_str != "" && Result_str.IndexOf("'") > 0)//轉換成可以在屏幕上輸出的字符
            //    Result_str = clsPublic.ReplaceChar(Result_str, Convert.ToChar("'"), Convert.ToChar("‘"));//
            //if (Result_str != "" && Result_str.IndexOf("\\") > 0)//轉換成可以在屏幕上輸出的字符
            //    Result_str = clsPublic.ReplaceChar(Result_str, Convert.ToChar("\\"), Convert.ToChar("、"));//
            return Result_str;
        }
        /// <summary>
        /// 執行sql 語句或存儲過程，返回結果 int 
        /// </summary>
        /// <param name="strSql"></param>
        /// <param name="paras"></param>
        /// <param name="isProce"></param>
        /// <returns></returns>
        public int ExecuteNonQuery(string strSql, SqlParameter[] paras, bool isProce)
        {
            int Result = 0;
            con = new SqlConnection(constring);
            try
            {

                con.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = strSql;
                if (paras != null)
                {
                    cmd.Parameters.AddRange(paras);
                }
                if (isProce)
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                }
                Result = cmd.ExecuteNonQuery();
                cmd.Dispose();
            }
            catch (Exception ex)
            {
                string err_str = ex.Message;
            }
            finally
            {
                con.Close();
            }
            return Result;
        }

        public DataSet ExecuteSqlReturnDataSet(string sql, string tablename)
        {
            con = new SqlConnection(constring);
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataSet ds = new DataSet();
            try
            {
                da.Fill(ds, tablename);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally
            {
                con.Close();
                da.Dispose();
            }
            return ds;
        }

        public DataSet ExecuteSqlReturnDsFromHr(string sql, string tablename)
        {
            con = new SqlConnection(con_hr);
            SqlDataAdapter da = new SqlDataAdapter(sql, con);
            DataSet ds = new DataSet();
            try
            {
                da.Fill(ds, tablename);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.ToString());
            }
            finally
            {
                con.Close();
                da.Dispose();
            }
            return ds;
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
            tstr = tstr.Replace("'", "");
            return tstr;
        }


    }
}
