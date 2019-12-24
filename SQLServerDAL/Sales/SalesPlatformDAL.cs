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
    public class SalesPlatformDAL
    {
        public bool deleteEitity(int PlatformID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@PlatformID", SqlDbType.NVarChar) };
            parameters[0].Value = PlatformID;
            SQLHelper.RunProcedure("p_SalesPlatform_deleteEitity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public SalesPlatform getByID(int PlatformID)
        {
            SalesPlatform platform = new SalesPlatform();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@PlatformID", SqlDbType.NVarChar) };
            parameters[0].Value = PlatformID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesPlatform_getByID", parameters);
            if (reader.Read())
            {
                platform.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                platform.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                platform.Description = reader.GetString(reader.GetOrdinal("Description"));
            }
            reader.Close();
            return platform;
        }

        public List<SalesPlatform> getList()
        {
            List<SalesPlatform> list = new List<SalesPlatform>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesPlatform_getList", null);
            while (reader.Read())
            {
                SalesPlatform item = new SalesPlatform();
                item.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                item.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(SalesPlatform s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@PlatformName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.PlatformName;
            parameters[1].Value = s.Description;
            SQLHelper.RunProcedure("p_SalesPlatform_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEitity(SalesPlatform s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@PlatformName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@PlatformID", SqlDbType.Int) };
            parameters[0].Value = s.PlatformName;
            parameters[1].Value = s.Description;
            parameters[2].Value = s.PlatformID;
            SQLHelper.RunProcedure("p_SalesPlatform_updateEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

