namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using Leyp.Model.View;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class ProductsStockDAL
    {
        public VProductsStock getByProductsIDStockID(int ProductsID, int HouseDetailID)
        {
            bool flag = false;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@HouseDetailID", SqlDbType.Int) };
            parameters[0].Value = ProductsID;
            parameters[1].Value = HouseDetailID;
            VProductsStock stock = new VProductsStock();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsStock_getByProductsIDStockID", parameters);
            while (reader.Read())
            {
                stock.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                stock.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                stock.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                stock.Num = reader.GetInt32(reader.GetOrdinal("Num"));
                flag = true;
            }
            reader.Close();
            return (flag ? stock : null);
        }

        public DataSet getDataSetByHouseDetailID(int HouseDetailID)
        {
            DataSet set = new DataSet();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseDetailID", SqlDbType.Int) };
            parameters[0].Value = HouseDetailID;
            return SQLHelper.RunProcedure("p_ProductsStock_getDataSetByHouseDetailID", parameters, "dd");
        }

        public DataSet getDataSetByProductsID(int ProductsID)
        {
            DataSet set = new DataSet();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int) };
            parameters[0].Value = ProductsID;
            return SQLHelper.RunProcedure("p_ProductsStock_getDataSetByProductsID", parameters, "dd");
        }

        public List<VProductsStock> getProductsList(int HouseDetailID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseDetailID", SqlDbType.Int) };
            parameters[0].Value = HouseDetailID;
            List<VProductsStock> list = new List<VProductsStock>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsStock_getProductsList", parameters);
            while (reader.Read())
            {
                VProductsStock item = new VProductsStock();
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VProductsStock> getStockList(int ProductsID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int) };
            parameters[0].Value = ProductsID;
            List<VProductsStock> list = new List<VProductsStock>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsStock_getStockList", parameters);
            while (reader.Read())
            {
                VProductsStock item = new VProductsStock();
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.HouseID = reader.GetInt32(reader.GetOrdinal("HouseID"));
                item.Num = reader.GetInt32(reader.GetOrdinal("Num"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEitity(ProductsStock p)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Num", SqlDbType.Int) };
            parameters[0].Value = p.HouseDetailID;
            parameters[1].Value = p.ProductsID;
            parameters[2].Value = p.Num;
            SQLHelper.RunProcedure("p_ProductsStock_insertNewEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool isHaveEitity(int HouseDetailID, int ProductsID)
        {
            bool flag = false;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@ProductsID", SqlDbType.Int) };
            parameters[0].Value = HouseDetailID;
            parameters[1].Value = ProductsID;
            if (SQLHelper.RunProcedure("p_ProductsStock_isHaveEitity", parameters).Read())
            {
                flag = true;
            }
            return flag;
        }

        public bool updateAddNum(ProductsStock p)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Num", SqlDbType.Int) };
            parameters[0].Value = p.HouseDetailID;
            parameters[1].Value = p.ProductsID;
            parameters[2].Value = p.Num;
            SQLHelper.RunProcedure("p_ProductsStock_updateAddNum", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateCutNum(ProductsStock p)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Num", SqlDbType.Int) };
            parameters[0].Value = p.HouseDetailID;
            parameters[1].Value = p.ProductsID;
            parameters[2].Value = p.Num;
            SQLHelper.RunProcedure("p_ProductsStock_updateCutNum", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEitityNum(ProductsStock p)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Num", SqlDbType.Int) };
            parameters[0].Value = p.HouseDetailID;
            parameters[1].Value = p.ProductsID;
            parameters[2].Value = p.Num;
            SQLHelper.RunProcedure("p_ProductsStock_updateEitityNum", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

