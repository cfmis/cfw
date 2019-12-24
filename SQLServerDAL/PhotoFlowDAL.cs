namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class PhotoFlowDAL
    {
        public bool AuditingOrder(int FlowID, string Reply, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@FlowID", SqlDbType.Int), new SqlParameter("@Reply", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = FlowID;
            parameters[1].Value = Reply;
            parameters[2].Value = UserName;
            SQLHelper.RunProcedure("p_PhotoFlow__AuditingOrder", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool deleteEitity(int FlowID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@FlowID", SqlDbType.Int), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = FlowID;
            parameters[1].Value = UserName;
            SQLHelper.RunProcedure("p_PhotoFlow_deleteEitity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public PhotoFlow getByID(int FlowID)
        {
            PhotoFlow flow = new PhotoFlow();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@FlowID", SqlDbType.Int) };
            parameters[0].Value = FlowID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_PhotoFlow_getByID", parameters);
            while (reader.Read())
            {
                flow.Content = reader.GetString(reader.GetOrdinal("Content"));
                flow.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                flow.FlowID = reader.GetInt32(reader.GetOrdinal("FlowID"));
                flow.FlowTitle = reader.GetString(reader.GetOrdinal("FlowTitle"));
                flow.Reply = reader.GetString(reader.GetOrdinal("Reply"));
                flow.State = reader.GetInt32(reader.GetOrdinal("State"));
                flow.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                flow.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
            }
            reader.Close();
            return flow;
        }

        public List<PhotoFlow> getSearchList()
        {
            List<PhotoFlow> list = new List<PhotoFlow>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_PhotoFlow_getSearchList", null);
            while (reader.Read())
            {
                PhotoFlow item = new PhotoFlow();
                item.Content = reader.GetString(reader.GetOrdinal("Content"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.FlowID = reader.GetInt32(reader.GetOrdinal("FlowID"));
                item.FlowTitle = reader.GetString(reader.GetOrdinal("FlowTitle"));
                item.Reply = reader.GetString(reader.GetOrdinal("Reply"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(PhotoFlow s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@FlowTitle", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@Content", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int) };
            parameters[0].Value = s.FlowTitle;
            parameters[1].Value = s.CreateDate;
            parameters[2].Value = s.UserName;
            parameters[3].Value = s.Content;
            parameters[4].Value = s.State;
            SQLHelper.RunProcedure("p_PhotoFlow_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

