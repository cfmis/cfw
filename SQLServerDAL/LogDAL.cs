namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Data;
    using System.Data.SqlClient;

    [DataObject]
    public class LogDAL
    {
        public bool addLog(Log log)
        {
            SqlParameter[] commandParameters = new SqlParameter[] { new SqlParameter("@LogTime", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            commandParameters[0].Value = log.LogTime;
            commandParameters[1].Value = log.Description;
            int num = SQLHelper.ExecuteNonQuery(SQLHelper.strCon, CommandType.StoredProcedure, "p_log_addNewLog", commandParameters);
            return (1 == num);
        }

        public List<Log> getAllLog()
        {
            List<Log> list = new List<Log>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_log_getAll", null);
            while (reader.Read())
            {
                Log item = new Log();
                item.LogID = reader.GetInt32(reader.GetOrdinal("LogID"));
                item.LogTime = reader.GetString(reader.GetOrdinal("LogTime"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }
    }
}

