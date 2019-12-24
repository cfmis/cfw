namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Data;
    using System.Data.SqlClient;

    [DataObject]
    public class ShopDAL
    {
        public bool deleteShop(int ShopID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ShopID", SqlDbType.Int) };
            parameters[0].Value = ShopID;
            SQLHelper.RunProcedure("p_Shop_deleteShop", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<Shop> getAllShop()
        {
            List<Shop> list = new List<Shop>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Shop_getAllShop", null);
            while (reader.Read())
            {
                Shop item = new Shop();
                item.ShopID = reader.GetInt32(reader.GetOrdinal("ShopID"));
                item.ShopName = reader.GetString(reader.GetOrdinal("ShopName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                item.ShopUrl = reader.GetString(reader.GetOrdinal("ShopUrl"));
                item.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public Shop getByShopID(int ShopID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ShopID", SqlDbType.Int) };
            parameters[0].Value = ShopID;
            Shop shop = new Shop();
            SqlDataReader reader = SQLHelper.RunProcedure("p_shop_getByShopID", parameters);
            if (reader.Read())
            {
                shop.ShopID = reader.GetInt32(reader.GetOrdinal("ShopID"));
                shop.ShopName = reader.GetString(reader.GetOrdinal("ShopName"));
                shop.Description = reader.GetString(reader.GetOrdinal("Description"));
                shop.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                shop.ShopUrl = reader.GetString(reader.GetOrdinal("ShopUrl"));
                shop.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
            }
            reader.Close();
            return shop;
        }

        public bool insertNewShop(Shop s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ShopName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@ShopUrl", SqlDbType.NVarChar), new SqlParameter("@PlatformID", SqlDbType.Int) };
            parameters[0].Value = s.ShopName;
            parameters[1].Value = s.Description;
            parameters[2].Value = s.ShopUrl;
            parameters[3].Value = s.PlatformID;
            SQLHelper.RunProcedure("p_Shop_insertNewShop", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateShop(Shop s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ShopID", SqlDbType.Int), new SqlParameter("@ShopName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@ShopUrl", SqlDbType.NVarChar), new SqlParameter("@PlatformID", SqlDbType.Int) };
            parameters[0].Value = s.ShopID;
            parameters[1].Value = s.ShopName;
            parameters[2].Value = s.Description;
            parameters[3].Value = s.ShopUrl;
            parameters[4].Value = s.PlatformID;
            SQLHelper.RunProcedure("p_Shop_updateShop", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

