namespace Leyp.SQLServerDAL.Sales
{
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Data;
    using System.Data.SqlClient;

    [DataObject]
    public class SalesRecordDAL
    {
        public bool deleteEitity(int ID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = ID;
            parameters[1].Value = UserName;
            SQLHelper.RunProcedure("p_SalesRecord_deleteEitity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public List<VSalesRecord> getAll()
        {
            List<VSalesRecord> list = new List<VSalesRecord>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesRecord_getAll", null);
            while (reader.Read())
            {
                VSalesRecord item = new VSalesRecord();
                item.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.CustomerID = reader.GetString(reader.GetOrdinal("CustomerID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public VSalesRecord getBySalesOrderID(string SalesOrderID)
        {
            bool flag = false;
            VSalesRecord record = new VSalesRecord();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOrderID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesRecord_getBySalesOrderID", parameters);
            if (reader.Read())
            {
                record.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                record.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                record.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                record.CustomerID = reader.GetString(reader.GetOrdinal("CustomerID"));
                record.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                record.Description = reader.GetString(reader.GetOrdinal("Description"));
                record.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                record.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                flag = true;
            }
            reader.Close();
            return (flag ? record : null);
        }

        public List<VSalesRecord> getListByCustomerID(int PlatformID, string CustomerID)
        {
            List<VSalesRecord> list = new List<VSalesRecord>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@PlatformID", SqlDbType.Int), new SqlParameter("@CustomerID", SqlDbType.NVarChar) };
            parameters[0].Value = PlatformID;
            parameters[1].Value = CustomerID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesRecord_getListByCustomerID", parameters);
            while (reader.Read())
            {
                VSalesRecord item = new VSalesRecord();
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                item.CustomerID = reader.GetString(reader.GetOrdinal("CustomerID"));
                item.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VSalesRecord> getListByPlatformID(int PlatformID)
        {
            List<VSalesRecord> list = new List<VSalesRecord>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@PlatformID", SqlDbType.Int) };
            parameters[0].Value = PlatformID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesRecord_getListByPlatformID", parameters);
            while (reader.Read())
            {
                VSalesRecord item = new VSalesRecord();
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                item.CustomerID = reader.GetString(reader.GetOrdinal("CustomerID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VSalesRecord> getListByUserName(string UserName)
        {
            List<VSalesRecord> list = new List<VSalesRecord>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = UserName;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesRecord_getListByUserName", parameters);
            while (reader.Read())
            {
                VSalesRecord item = new VSalesRecord();
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.CustomerID = reader.GetString(reader.GetOrdinal("CustomerID"));
                item.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(SalesRecord s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@PlatformID", SqlDbType.Int), new SqlParameter("@CustomerID", SqlDbType.NVarChar), new SqlParameter("@SalesOrderID", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.PlatformID;
            parameters[1].Value = s.CustomerID;
            parameters[2].Value = s.SalesOrderID;
            parameters[3].Value = s.CreateDate;
            parameters[4].Value = s.UserName;
            parameters[5].Value = s.Description;
            SQLHelper.RunProcedure("p_SalesRecord_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

