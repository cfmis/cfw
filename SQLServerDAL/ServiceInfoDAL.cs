namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using Leyp.Model.View;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class ServiceInfoDAL
    {
        public bool addReplyInfo(int ID, string Reply)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int), new SqlParameter("@Reply", SqlDbType.NVarChar) };
            parameters[0].Value = ID;
            parameters[1].Value = Reply;
            SQLHelper.RunProcedure("p_ServiceInfo_addReplyInfo", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool deleteEitity(int ID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int) };
            parameters[0].Value = ID;
            SQLHelper.RunProcedure("p_ServiceInfo_deleteEitity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public List<VServiceInfo> getAll()
        {
            List<VServiceInfo> list = new List<VServiceInfo>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ServiceInfo_getAll", null);
            while (reader.Read())
            {
                VServiceInfo item = new VServiceInfo();
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ServiceTitle = reader.GetString(reader.GetOrdinal("ServiceTitle"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.ServiceName = reader.GetString(reader.GetOrdinal("ServiceName"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public VServiceInfo getByID(int ID)
        {
            bool flag = false;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int, 4) };
            parameters[0].Value = ID;
            VServiceInfo info = new VServiceInfo();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ServiceInfo_getByID", parameters);
            if (reader.Read())
            {
                info.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                info.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                info.State = reader.GetInt32(reader.GetOrdinal("State"));
                info.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                info.ServiceTitle = reader.GetString(reader.GetOrdinal("ServiceTitle"));
                info.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                info.ServiceName = reader.GetString(reader.GetOrdinal("ServiceName"));
                info.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                info.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                info.Content = reader.GetString(reader.GetOrdinal("Content"));
                info.ReplyInfo = reader.GetString(reader.GetOrdinal("ReplyInfo"));
                flag = true;
            }
            reader.Close();
            return (flag ? info : null);
        }

        public List<VServiceInfo> getMyAuditingUserTopic(string UserName)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = UserName;
            List<VServiceInfo> list = new List<VServiceInfo>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ServiceInfo_getMyAuditingUserTopic", parameters);
            while (reader.Read())
            {
                VServiceInfo item = new VServiceInfo();
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ServiceTitle = reader.GetString(reader.GetOrdinal("ServiceTitle"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.ServiceName = reader.GetString(reader.GetOrdinal("ServiceName"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VServiceInfo> getMyTopic(string UserName)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = UserName;
            List<VServiceInfo> list = new List<VServiceInfo>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ServiceInfo_getMyTopic", parameters);
            while (reader.Read())
            {
                VServiceInfo item = new VServiceInfo();
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ServiceTitle = reader.GetString(reader.GetOrdinal("ServiceTitle"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.ServiceName = reader.GetString(reader.GetOrdinal("ServiceName"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VServiceInfo> getSearchListByDate(string beginDate, string endDate, int sideState)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            List<VServiceInfo> list = new List<VServiceInfo>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ServiceInfo_getSearchListByDate", parameters);
            while (reader.Read())
            {
                VServiceInfo item = new VServiceInfo();
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ServiceTitle = reader.GetString(reader.GetOrdinal("ServiceTitle"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.ServiceName = reader.GetString(reader.GetOrdinal("ServiceName"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VServiceInfo> getSearchListByType(int TypeID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int, 4) };
            parameters[0].Value = TypeID;
            List<VServiceInfo> list = new List<VServiceInfo>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ServiceInfo_getSearchListByTypeID", parameters);
            while (reader.Read())
            {
                VServiceInfo item = new VServiceInfo();
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ServiceTitle = reader.GetString(reader.GetOrdinal("ServiceTitle"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.ServiceName = reader.GetString(reader.GetOrdinal("ServiceName"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(ServiceInfo s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int), new SqlParameter("@ServiceTitle", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@SalesOrderID", SqlDbType.NVarChar), new SqlParameter("@Content", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = s.TypeID;
            parameters[1].Value = s.ServiceTitle;
            parameters[2].Value = s.CreateDate;
            parameters[3].Value = s.SalesOrderID;
            parameters[4].Value = s.Content;
            parameters[5].Value = s.UserName;
            SQLHelper.RunProcedure("p_ServiceInfo_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateAotoCancel(string DateNowStr)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DateNowStr", SqlDbType.NVarChar) };
            parameters[0].Value = DateNowStr;
            SQLHelper.RunProcedure("p_ServiceInfo_updateAotoCancel", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool updateCancel(int ID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = ID;
            parameters[1].Value = UserName;
            SQLHelper.RunProcedure("p_ServiceInfo_updateCancel", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool updateSolve(int ID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = ID;
            parameters[1].Value = UserName;
            SQLHelper.RunProcedure("p_ServiceInfo_updateSolve", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool updateUserforAuditing(int ID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = ID;
            parameters[1].Value = UserName;
            SQLHelper.RunProcedure("p_ServiceInfo_updateUserforAuditing", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }
    }
}

