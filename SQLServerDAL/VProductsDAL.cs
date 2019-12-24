namespace Leyp.SQLServerDAL
{
    using Leyp.Model.View;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class VProductsDAL
    {
        public VProducts getByID(int ProductsID)
        {
            string s = "0";
            VProducts products = new VProducts();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int) };
            parameters[0].Value = ProductsID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_Products_GetByProductsID", parameters);
            if (reader.Read())
            {
                products.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                products.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                products.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                products.BrandID = reader.GetInt32(reader.GetOrdinal("BrandID"));
                products.BeginEnterDate = reader.GetString(reader.GetOrdinal("BeginEnterDate"));
                products.FinalEnterDate = reader.GetString(reader.GetOrdinal("FinalEnterDate"));
                products.LatelyOFSDate = reader.GetString(reader.GetOrdinal("LatelyOFSDate"));
                products.UnshelveDate = reader.GetString(reader.GetOrdinal("UnshelveDate"));
                products.Color = reader.GetString(reader.GetOrdinal("Color"));
                products.Weight = reader.GetString(reader.GetOrdinal("Weight"));
                products.Material = reader.GetString(reader.GetOrdinal("Material"));
                products.Spec = reader.GetString(reader.GetOrdinal("Spec"));
                products.TotalSalesNum = reader.GetInt32(reader.GetOrdinal("TotalSalesNum"));
                products.StocksNum = reader.GetInt32(reader.GetOrdinal("StocksNum"));
                products.Description = reader.GetString(reader.GetOrdinal("Description"));
                products.PhotoUrl = reader.GetString(reader.GetOrdinal("PhotoUrl"));
                products.ProductsUints = reader.GetString(reader.GetOrdinal("ProductsUints"));
                s = reader.GetValue(reader.GetOrdinal("Cost")).ToString();
                products.Cost = float.Parse(s);
                products.UpperLimit = reader.GetInt32(reader.GetOrdinal("UpperLimit"));
                products.LowerLimit = reader.GetInt32(reader.GetOrdinal("LowerLimit"));
                products.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                products.BrandName = reader.GetString(reader.GetOrdinal("BrandName"));
                products.PhotoUrl = reader.GetString(reader.GetOrdinal("PhotoUrl"));
            }
            reader.Close();
            return products;
        }

        public List<VProducts> getNewsProducts()
        {
            string s = "";
            List<VProducts> list = new List<VProducts>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Products_getNewsProducts", null);
            while (reader.Read())
            {
                VProducts item = new VProducts();
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.BrandID = reader.GetInt32(reader.GetOrdinal("BrandID"));
                item.BeginEnterDate = reader.GetString(reader.GetOrdinal("BeginEnterDate"));
                item.FinalEnterDate = reader.GetString(reader.GetOrdinal("FinalEnterDate"));
                item.LatelyOFSDate = reader.GetString(reader.GetOrdinal("LatelyOFSDate"));
                item.UnshelveDate = reader.GetString(reader.GetOrdinal("UnshelveDate"));
                item.Color = reader.GetString(reader.GetOrdinal("Color"));
                item.Weight = reader.GetString(reader.GetOrdinal("Weight"));
                item.Material = reader.GetString(reader.GetOrdinal("Material"));
                item.Spec = reader.GetString(reader.GetOrdinal("Spec"));
                item.TotalSalesNum = reader.GetInt32(reader.GetOrdinal("TotalSalesNum"));
                item.StocksNum = reader.GetInt32(reader.GetOrdinal("StocksNum"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.UpperLimit = reader.GetInt32(reader.GetOrdinal("UpperLimit"));
                item.LowerLimit = reader.GetInt32(reader.GetOrdinal("LowerLimit"));
                s = reader.GetValue(reader.GetOrdinal("Cost")).ToString();
                item.Cost = float.Parse(s);
                item.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                item.BrandName = reader.GetString(reader.GetOrdinal("BrandName"));
                item.PhotoUrl = reader.GetString(reader.GetOrdinal("PhotoUrl"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VProducts> searchProducts(int TypeID, int BrandID, string Key)
        {
            string s = "0";
            List<VProducts> list = new List<VProducts>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int), new SqlParameter("@BrandID", SqlDbType.Int), new SqlParameter("@Key", SqlDbType.NVarChar) };
            parameters[0].Value = TypeID;
            parameters[1].Value = BrandID;
            parameters[2].Value = Key;
            SqlDataReader reader = SQLHelper.RunProcedure("ps_VProdocts_getForSearch", parameters);
            while (reader.Read())
            {
                VProducts item = new VProducts();
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.BrandID = reader.GetInt32(reader.GetOrdinal("BrandID"));
                item.BeginEnterDate = reader.GetString(reader.GetOrdinal("BeginEnterDate"));
                item.FinalEnterDate = reader.GetString(reader.GetOrdinal("FinalEnterDate"));
                item.LatelyOFSDate = reader.GetString(reader.GetOrdinal("LatelyOFSDate"));
                item.UnshelveDate = reader.GetString(reader.GetOrdinal("UnshelveDate"));
                item.Color = reader.GetString(reader.GetOrdinal("Color"));
                item.Weight = reader.GetString(reader.GetOrdinal("Weight"));
                item.Material = reader.GetString(reader.GetOrdinal("Material"));
                item.Spec = reader.GetString(reader.GetOrdinal("Spec"));
                item.TotalSalesNum = reader.GetInt32(reader.GetOrdinal("TotalSalesNum"));
                item.StocksNum = reader.GetInt32(reader.GetOrdinal("StocksNum"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.UpperLimit = reader.GetInt32(reader.GetOrdinal("UpperLimit"));
                item.LowerLimit = reader.GetInt32(reader.GetOrdinal("LowerLimit"));
                s = reader.GetValue(reader.GetOrdinal("Cost")).ToString();
                item.Cost = float.Parse(s);
                item.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                item.BrandName = reader.GetString(reader.GetOrdinal("BrandName"));
                item.PhotoUrl = reader.GetString(reader.GetOrdinal("PhotoUrl"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VProducts> searchProductsForAll(int TypeID, int BrandID, string Key)
        {
            string s = "0";
            List<VProducts> list = new List<VProducts>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int), new SqlParameter("@BrandID", SqlDbType.Int), new SqlParameter("@Key", SqlDbType.NVarChar) };
            parameters[0].Value = TypeID;
            parameters[1].Value = BrandID;
            parameters[2].Value = Key;
            SqlDataReader reader = SQLHelper.RunProcedure("p_Prodocts_getForSearch", parameters);
            while (reader.Read())
            {
                VProducts item = new VProducts();
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.BrandID = reader.GetInt32(reader.GetOrdinal("BrandID"));
                item.BeginEnterDate = reader.GetString(reader.GetOrdinal("BeginEnterDate"));
                item.FinalEnterDate = reader.GetString(reader.GetOrdinal("FinalEnterDate"));
                item.LatelyOFSDate = reader.GetString(reader.GetOrdinal("LatelyOFSDate"));
                item.UnshelveDate = reader.GetString(reader.GetOrdinal("UnshelveDate"));
                item.Color = reader.GetString(reader.GetOrdinal("Color"));
                item.Weight = reader.GetString(reader.GetOrdinal("Weight"));
                item.Material = reader.GetString(reader.GetOrdinal("Material"));
                item.Spec = reader.GetString(reader.GetOrdinal("Spec"));
                item.TotalSalesNum = reader.GetInt32(reader.GetOrdinal("TotalSalesNum"));
                item.StocksNum = reader.GetInt32(reader.GetOrdinal("StocksNum"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.UpperLimit = reader.GetInt32(reader.GetOrdinal("UpperLimit"));
                item.LowerLimit = reader.GetInt32(reader.GetOrdinal("LowerLimit"));
                s = reader.GetValue(reader.GetOrdinal("Cost")).ToString();
                item.Cost = float.Parse(s);
                item.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                item.BrandName = reader.GetString(reader.GetOrdinal("BrandName"));
                item.PhotoUrl = reader.GetString(reader.GetOrdinal("PhotoUrl"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }
    }
}

