namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class NoticeDAL
    {
        public bool deleteEitity(int NoticeID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@NoticeID", SqlDbType.Int) };
            parameters[0].Value = NoticeID;
            SQLHelper.RunProcedure("p_Notice_deleteEitity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public List<Notice> getAll()
        {
            List<Notice> list = new List<Notice>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Notice_getAll", null);
            while (reader.Read())
            {
                Notice item = new Notice();
                item.NoticeID = reader.GetInt32(reader.GetOrdinal("NoticeID"));
                item.Info = reader.GetString(reader.GetOrdinal("Info"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.Title = reader.GetString(reader.GetOrdinal("Title"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.Type = reader.GetInt32(reader.GetOrdinal("Type"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public Notice getByID(int NoticeID)
        {
            bool flag = false;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@NoticeID", SqlDbType.Int, 4) };
            parameters[0].Value = NoticeID;
            Notice notice = new Notice();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Notice_getByID", parameters);
            if (reader.Read())
            {
                notice.NoticeID = reader.GetInt32(reader.GetOrdinal("NoticeID"));
                notice.Info = reader.GetString(reader.GetOrdinal("Info"));
                notice.State = reader.GetInt32(reader.GetOrdinal("State"));
                notice.Title = reader.GetString(reader.GetOrdinal("Title"));
                notice.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                notice.Type = reader.GetInt32(reader.GetOrdinal("Type"));
                notice.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                flag = true;
            }
            reader.Close();
            return (flag ? notice : null);
        }

        public List<Notice> getNewsByType(int Type)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Type", SqlDbType.Int, 4) };
            parameters[0].Value = Type;
            List<Notice> list = new List<Notice>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Notice_getNewsByType", parameters);
            while (reader.Read())
            {
                Notice item = new Notice();
                item.NoticeID = reader.GetInt32(reader.GetOrdinal("NoticeID"));
                item.Info = reader.GetString(reader.GetOrdinal("Info"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.Title = reader.GetString(reader.GetOrdinal("Title"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.Type = reader.GetInt32(reader.GetOrdinal("Type"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<Notice> getSearchListByType(int Type)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Type", SqlDbType.Int, 4) };
            parameters[0].Value = Type;
            List<Notice> list = new List<Notice>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Notice_getSearchListByType", parameters);
            while (reader.Read())
            {
                Notice item = new Notice();
                item.NoticeID = reader.GetInt32(reader.GetOrdinal("NoticeID"));
                item.Info = reader.GetString(reader.GetOrdinal("Info"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.Title = reader.GetString(reader.GetOrdinal("Title"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.Type = reader.GetInt32(reader.GetOrdinal("Type"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(Notice s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Type", SqlDbType.Int), new SqlParameter("@Title", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@Info", SqlDbType.NVarChar) };
            parameters[0].Value = s.Type;
            parameters[1].Value = s.Title;
            parameters[2].Value = s.UserName;
            parameters[3].Value = s.CreateDate;
            parameters[4].Value = s.Info;
            SQLHelper.RunProcedure("p_Notice_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

