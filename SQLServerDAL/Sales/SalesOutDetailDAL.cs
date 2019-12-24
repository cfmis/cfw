namespace Leyp.SQLServerDAL.Sales
{
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class SalesOutDetailDAL
    {
        public bool deleteEitity(int DetailID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SQLHelper.RunProcedure("p_SalesOutDetail_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public VSalesOutDetail getByID(int DetailID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            VSalesOutDetail detail = new VSalesOutDetail();
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOutDetail_getByID", parameters);
            while (reader.Read())
            {
                detail.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                detail.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("DiscountRate")).ToString();
                detail.DiscountRate = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                detail.Price = float.Parse(s);
                detail.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                detail.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                detail.PhotoUrl = reader.GetString(reader.GetOrdinal("PhotoUrl"));
                detail.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                detail.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                detail.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
            }
            reader.Close();
            return detail;
        }

        public List<VSalesOutDetail> getBySalesOutID(string SalesOutID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOutID;
            List<VSalesOutDetail> list = new List<VSalesOutDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOutDetail_getBySalesOrderID", parameters);
            while (reader.Read())
            {
                VSalesOutDetail item = new VSalesOutDetail();
                item.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("DiscountRate")).ToString();
                item.DiscountRate = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                item.Price = float.Parse(s);
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.PhotoUrl = reader.GetString(reader.GetOrdinal("PhotoUrl"));
                item.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                item.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VSalesOutDetail> getBySalesOutIDinit(string SalesOutID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOutID;
            List<VSalesOutDetail> list = new List<VSalesOutDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOutDetail_getBySalesOrderIDinit", parameters);
            while (reader.Read())
            {
                VSalesOutDetail item = new VSalesOutDetail();
                item.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("DiscountRate")).ToString();
                item.DiscountRate = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                item.Price = float.Parse(s);
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.PhotoUrl = reader.GetString(reader.GetOrdinal("PhotoUrl"));
                item.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                item.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEitity(SalesOutDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@DiscountRate", SqlDbType.Float), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@StoreHouseID", SqlDbType.Int), new SqlParameter("@HouseDetailID", SqlDbType.Int) };
            parameters[0].Value = b.SalesOutID;
            parameters[1].Value = b.ProductsID;
            parameters[2].Value = b.Quantity;
            parameters[3].Value = b.Price;
            parameters[4].Value = b.DiscountRate;
            parameters[5].Value = b.Description;
            parameters[6].Value = b.StoreHouseID;
            parameters[7].Value = b.HouseDetailID;
            SQLHelper.RunProcedure("p_SalesOutDetail_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEitity(SalesOutDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int), new SqlParameter("@SalesOutID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@DiscountRate", SqlDbType.Float), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@StoreHouseID", SqlDbType.Int), new SqlParameter("@HouseDetailID", SqlDbType.Int) };
            parameters[0].Value = b.DetailID;
            parameters[1].Value = b.SalesOutID;
            parameters[2].Value = b.ProductsID;
            parameters[3].Value = b.Quantity;
            parameters[4].Value = b.Price;
            parameters[5].Value = b.DiscountRate;
            parameters[6].Value = b.Description;
            parameters[7].Value = b.StoreHouseID;
            parameters[8].Value = b.HouseDetailID;
            SQLHelper.RunProcedure("p_SalesOutDetail_updateEntity", parameters, out rowsAffected);
            return (1 < rowsAffected);
        }
    }
}

