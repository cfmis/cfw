namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class DeliveryDAL
    {
        public bool deleteDelivery(int DeliveryID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DeliveryID", SqlDbType.Int) };
            parameters[0].Value = DeliveryID;
            SQLHelper.RunProcedure("p_Delivery_deleteDelivery", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<Delivery> getAllDelivery()
        {
            List<Delivery> list = new List<Delivery>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Delivery_getAllDelivery", null);
            while (reader.Read())
            {
                Delivery item = new Delivery();
                item.DeliveryID = reader.GetInt32(reader.GetOrdinal("DeliveryID"));
                item.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.Default = reader.GetInt32(reader.GetOrdinal("Default"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public Delivery getByID(int DeliveryID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DeliveryID", SqlDbType.Int) };
            parameters[0].Value = DeliveryID;
            Delivery delivery = new Delivery();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Delivery_getByID", parameters);
            if (reader.Read())
            {
                delivery.DeliveryID = reader.GetInt32(reader.GetOrdinal("DeliveryID"));
                delivery.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                delivery.Description = reader.GetString(reader.GetOrdinal("Description"));
                delivery.Default = reader.GetInt32(reader.GetOrdinal("Default"));
            }
            reader.Close();
            return delivery;
        }

        public Delivery getDefaultEitity()
        {
            Delivery delivery = new Delivery();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Delivery_getDefaultEitity", null);
            if (reader.Read())
            {
                delivery.DeliveryID = reader.GetInt32(reader.GetOrdinal("DeliveryID"));
                delivery.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                delivery.Description = reader.GetString(reader.GetOrdinal("Description"));
                delivery.Default = reader.GetInt32(reader.GetOrdinal("Default"));
            }
            reader.Close();
            return delivery;
        }

        public bool insertNewEitity(Delivery s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DeliveryName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@Default", SqlDbType.Int) };
            parameters[0].Value = s.DeliveryName;
            parameters[1].Value = s.Description;
            parameters[2].Value = s.Default;
            SQLHelper.RunProcedure("p_Delivery_insertNewEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updataDefault(int DeliveryID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DeliveryID", SqlDbType.Int) };
            parameters[0].Value = DeliveryID;
            SQLHelper.RunProcedure("p_Delivery_updataDefault", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool updateDelivery(Delivery s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DeliveryID", SqlDbType.Int), new SqlParameter("@DeliveryName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.DeliveryID;
            parameters[1].Value = s.DeliveryName;
            parameters[2].Value = s.Description;
            SQLHelper.RunProcedure("p_Delivery_updateDelivery", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

