namespace Leyp.SQLServerDAL
{
    using Leyp.Model.View;
    using System;
    using System.Collections.Generic;
    using System.Data.SqlClient;

    public class VstoreHouseDAL
    {
        public List<VstoreHouse> getAll()
        {
            List<VstoreHouse> list = new List<VstoreHouse>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_storeHouse_getAllview", null);
            while (reader.Read())
            {
                VstoreHouse item = new VstoreHouse();
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.HouseID = reader.GetInt32(reader.GetOrdinal("HouseID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }
    }
}

