namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class ServiceTypeDAL
    {
        public bool deleteDelivery(int TypeID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int) };
            parameters[0].Value = TypeID;
            SQLHelper.RunProcedure("p_ServiceType_deleteDelivery", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<ServiceType> getAll()
        {
            List<ServiceType> list = new List<ServiceType>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ServiceType_getAll", null);
            while (reader.Read())
            {
                ServiceType item = new ServiceType();
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.ServiceName = reader.GetString(reader.GetOrdinal("ServiceName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public ServiceType getByID(int TypeID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int) };
            parameters[0].Value = TypeID;
            ServiceType type = new ServiceType();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ServiceType_getByID", parameters);
            if (reader.Read())
            {
                type.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                type.ServiceName = reader.GetString(reader.GetOrdinal("ServiceName"));
                type.Description = reader.GetString(reader.GetOrdinal("Description"));
            }
            reader.Close();
            return type;
        }

        public bool insertNewEitity(ServiceType s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ServiceName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.ServiceName;
            parameters[1].Value = s.Description;
            SQLHelper.RunProcedure("p_ServiceType_insertNewEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEitity(ServiceType s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int), new SqlParameter("@ServiceName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.TypeID;
            parameters[1].Value = s.ServiceName;
            parameters[2].Value = s.Description;
            SQLHelper.RunProcedure("p_ServiceType_updateEitity(", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

