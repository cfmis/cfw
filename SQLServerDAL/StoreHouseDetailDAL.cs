namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class StoreHouseDetailDAL
    {
        public bool deleteNode(int ID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int) };
            parameters[0].Value = ID;
            SQLHelper.RunProcedure("p_StoreHouseDetail_deleteNode", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<StoreHouseDetail> getAll()
        {
            List<StoreHouseDetail> list = new List<StoreHouseDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_StoreHouseDetail_getAll", null);
            while (reader.Read())
            {
                StoreHouseDetail item = new StoreHouseDetail();
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.HouseID = reader.GetInt32(reader.GetOrdinal("HouseID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public StoreHouseDetail getByID(int ID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int) };
            parameters[0].Value = ID;
            StoreHouseDetail detail = new StoreHouseDetail();
            SqlDataReader reader = SQLHelper.RunProcedure("p_StoreHouseDetail_getByID", parameters);
            if (reader.Read())
            {
                detail.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                detail.HouseID = reader.GetInt32(reader.GetOrdinal("HouseID"));
                detail.Description = reader.GetString(reader.GetOrdinal("Description"));
                detail.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
            }
            reader.Close();
            return detail;
        }

        public List<StoreHouseDetail> getListByHouseID(int HouseID)
        {
            List<StoreHouseDetail> list = new List<StoreHouseDetail>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseID", SqlDbType.Int) };
            parameters[0].Value = HouseID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_StoreHouseDetail_getListByHouseID", parameters);
            while (reader.Read())
            {
                StoreHouseDetail item = new StoreHouseDetail();
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.HouseID = reader.GetInt32(reader.GetOrdinal("HouseID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewNode(StoreHouseDetail s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseID", SqlDbType.Int), new SqlParameter("@SubareaName ", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.HouseID;
            parameters[1].Value = s.SubareaName;
            parameters[2].Value = s.Description;
            SQLHelper.RunProcedure("p_StoreHouseDetail_insertNewNode", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateStoreHouseDetail(StoreHouseDetail s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int), new SqlParameter("@SubareaName ", SqlDbType.NVarChar), new SqlParameter("@State ", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.ID;
            parameters[1].Value = s.SubareaName;
            parameters[2].Value = s.State;
            parameters[3].Value = s.Description;
            SQLHelper.RunProcedure("p_StoreHouseDetail_updateNode", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

