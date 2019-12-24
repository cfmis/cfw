namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class ProductsBrandDAL
    {
        public bool deleteByBrandID(int brandID)
        {
            SqlParameter[] commandParameters = new SqlParameter[] { new SqlParameter("@BrandID", SqlDbType.Int) };
            commandParameters[0].Value = brandID;
            int num = SQLHelper.ExecuteNonQuery(SQLHelper.strCon, CommandType.StoredProcedure, "p_ProductsBrand_DeleteByBrandID", commandParameters);
            return (1 == num);
        }

        public List<ProductsBrand> getAllProductsBrand()
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@sign", SqlDbType.Int) };
            parameters[0].Value = 0;
            List<ProductsBrand> list = new List<ProductsBrand>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsBrand_GetAll", parameters);
            while (reader.Read())
            {
                ProductsBrand item = new ProductsBrand();
                item.BrandID = reader.GetInt32(reader.GetOrdinal("BrandID"));
                item.BrandName = reader.GetString(reader.GetOrdinal("BrandName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<ProductsBrand> getAllProductsBrandCanUser()
        {
            List<ProductsBrand> list = new List<ProductsBrand>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@sign", SqlDbType.Int) };
            parameters[0].Value = 1;
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsBrand_GetAll", parameters);
            while (reader.Read())
            {
                ProductsBrand item = new ProductsBrand();
                item.BrandID = reader.GetInt32(reader.GetOrdinal("BrandID"));
                item.BrandName = reader.GetString(reader.GetOrdinal("BrandName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public ProductsBrand getByBrandID(int BrandID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BrandID", SqlDbType.Int) };
            parameters[0].Value = BrandID;
            ProductsBrand brand = new ProductsBrand();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsBrand_GetByBrandID", parameters);
            if (reader.Read())
            {
                brand.BrandID = reader.GetInt32(reader.GetOrdinal("BrandID"));
                brand.BrandName = reader.GetString(reader.GetOrdinal("BrandName"));
                brand.Description = reader.GetString(reader.GetOrdinal("Description"));
                brand.State = reader.GetString(reader.GetOrdinal("State"));
            }
            reader.Close();
            return brand;
        }

        public bool insertNewProductsBrand(ProductsBrand pb)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BrandName", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = pb.BrandName;
            parameters[1].Value = pb.State;
            parameters[2].Value = pb.Description;
            SQLHelper.RunProcedure("p_ProductsBrand_InsertNew", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updataProductsBrand(ProductsBrand pb)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BrandID", SqlDbType.NVarChar), new SqlParameter("@BrandName", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = pb.BrandID;
            parameters[1].Value = pb.BrandName;
            parameters[2].Value = pb.State;
            parameters[3].Value = pb.Description;
            SQLHelper.RunProcedure("p_ProductsBrand_update", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

