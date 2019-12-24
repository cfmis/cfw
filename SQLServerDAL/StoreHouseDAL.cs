namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class StoreHouseDAL
    {
        public bool deleteEitity(int HouseID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@houseID", SqlDbType.Int) };
            parameters[0].Value = HouseID;
            SQLHelper.RunProcedure("p_StoreHouse_deleteStoreHouse", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<StoreHouse> getAllStoreHouse()
        {
            List<StoreHouse> list = new List<StoreHouse>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_StoreHouse_getAll", null);
            while (reader.Read())
            {
                StoreHouse item = new StoreHouse();
                item.HouseID = reader.GetInt32(reader.GetOrdinal("HouseID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public StoreHouse getByHouseID(int HouseID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseID", SqlDbType.Int) };
            parameters[0].Value = HouseID;
            StoreHouse house = new StoreHouse();
            SqlDataReader reader = SQLHelper.RunProcedure("p_StoreHouse_getByHouseID", parameters);
            if (reader.Read())
            {
                house.HouseID = reader.GetInt32(reader.GetOrdinal("HouseID"));
                house.Description = reader.GetString(reader.GetOrdinal("Description"));
                house.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
            }
            reader.Close();
            return house;
        }

        public bool insertEitity(StoreHouse s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.HouseName;
            parameters[1].Value = s.Description;
            SQLHelper.RunProcedure("p_StoreHouse_insertNewStoreHouse", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateStoreHouse(StoreHouse s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseID", SqlDbType.Int), new SqlParameter("@HouseName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.HouseID;
            parameters[1].Value = s.HouseName;
            parameters[2].Value = s.Description;
            SQLHelper.RunProcedure("p_StoreHouse_updateStoreHouse", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

