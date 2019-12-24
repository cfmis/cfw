namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Data;
    using System.Data.SqlClient;

    [DataObject]
    public class ProductsDAL
    {
        public bool deleteByProductsID(int ProductsID)
        {
            SqlParameter[] commandParameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int) };
            commandParameters[0].Value = ProductsID;
            int num = SQLHelper.ExecuteNonQuery(SQLHelper.strCon, CommandType.StoredProcedure, "p_Products_DeleteByProductsID", commandParameters);
            return (1 == num);
        }

        public List<Products> getAllProducts()
        {
            string s = "";
            List<Products> list = new List<Products>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Products_GetAll", null);
            while (reader.Read())
            {
                Products item = new Products();
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.BrandID = reader.GetInt32(reader.GetOrdinal("BrandID"));
                item.BeginEnterDate = reader.GetString(reader.GetOrdinal("BeginEnterDate"));
                item.FinalEnterDate = reader.GetString(reader.GetOrdinal("FinalEnterDate"));
                item.LatelyOFSDate = reader.GetString(reader.GetOrdinal("LatelyOFSDate"));
                item.LoadingDate = reader.GetString(reader.GetOrdinal("LoadingDate"));
                s = reader.GetValue(reader.GetOrdinal("Cost")).ToString();
                item.Cost = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                item.Price = float.Parse(s);
                item.UnshelveDate = reader.GetString(reader.GetOrdinal("UnshelveDate"));
                item.ProductsUints = reader.GetString(reader.GetOrdinal("ProductsUints"));
                item.Color = reader.GetString(reader.GetOrdinal("Color"));
                item.Weight = reader.GetString(reader.GetOrdinal("Weight"));
                item.Material = reader.GetString(reader.GetOrdinal("Material"));
                item.Spec = reader.GetString(reader.GetOrdinal("Spec"));
                item.UpperLimit = reader.GetInt32(reader.GetOrdinal("UpperLimit"));
                item.LowerLimit = reader.GetInt32(reader.GetOrdinal("LowerLimit"));
                item.PhotoUrl = reader.GetString(reader.GetOrdinal("PhotoUrl"));
                item.TotalSalesNum = reader.GetInt32(reader.GetOrdinal("TotalSalesNum"));
                item.StocksNum = reader.GetInt32(reader.GetOrdinal("StocksNum"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public Products getByProductsID(int ProductsID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int) };
            parameters[0].Value = ProductsID;
            Products products = new Products();
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
                products.LoadingDate = reader.GetString(reader.GetOrdinal("LoadingDate"));
                products.ProductsUints = reader.GetString(reader.GetOrdinal("ProductsUints"));
                products.UpperLimit = reader.GetInt32(reader.GetOrdinal("UpperLimit"));
                products.LowerLimit = reader.GetInt32(reader.GetOrdinal("LowerLimit"));
                s = reader.GetValue(reader.GetOrdinal("Cost")).ToString();
                products.Cost = float.Parse(s);
                products.Color = reader.GetString(reader.GetOrdinal("Color"));
                products.Weight = reader.GetString(reader.GetOrdinal("Weight"));
                products.Material = reader.GetString(reader.GetOrdinal("Material"));
                products.Spec = reader.GetString(reader.GetOrdinal("Spec"));
                products.TotalSalesNum = reader.GetInt32(reader.GetOrdinal("TotalSalesNum"));
                products.StocksNum = reader.GetInt32(reader.GetOrdinal("StocksNum"));
                products.Description = reader.GetString(reader.GetOrdinal("Description"));
            }
            reader.Close();
            return products;
        }

        public bool insertNewProducts(Products pro)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@ProductsName", SqlDbType.NVarChar), new SqlParameter("@TypeID", SqlDbType.Int), new SqlParameter("@BrandID", SqlDbType.Int), new SqlParameter("@Color", SqlDbType.NVarChar), new SqlParameter("@Weight", SqlDbType.NVarChar), new SqlParameter("@Spec", SqlDbType.NVarChar), new SqlParameter("@Cost", SqlDbType.Money), new SqlParameter("@ProductsUints", SqlDbType.NVarChar), new SqlParameter("@Material", SqlDbType.NVarChar), new SqlParameter("@UpperLimit", SqlDbType.Int), new SqlParameter("@LowerLimit", SqlDbType.Int), new SqlParameter("@BeginEnterDate", SqlDbType.NVarChar), new SqlParameter("@FinalEnterDate", SqlDbType.NVarChar), new SqlParameter("@LatelyOFSDate", SqlDbType.NVarChar), new SqlParameter("@UnshelveDate", SqlDbType.NVarChar), new SqlParameter("@LoadingDate", SqlDbType.NVarChar), 
                new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@Price", SqlDbType.Float)
             };
            parameters[0].Value = pro.ProductsName;
            parameters[1].Value = pro.TypeID;
            parameters[2].Value = pro.BrandID;
            parameters[3].Value = pro.Color;
            parameters[4].Value = pro.Weight;
            parameters[5].Value = pro.Spec;
            parameters[6].Value = pro.Cost;
            parameters[7].Value = pro.ProductsUints;
            parameters[8].Value = pro.Material;
            parameters[9].Value = pro.UpperLimit;
            parameters[10].Value = pro.LowerLimit;
            parameters[11].Value = pro.BeginEnterDate;
            parameters[12].Value = pro.FinalEnterDate;
            parameters[13].Value = pro.LatelyOFSDate;
            parameters[14].Value = pro.UnshelveDate;
            parameters[15].Value = pro.LoadingDate;
            parameters[0x10].Value = pro.Description;
            parameters[0x11].Value = pro.Price;
            SQLHelper.RunProcedure("p_Products_InsertNew", parameters, out rowsAffected);
            if (rowsAffected == 1)
            {
                List<UserTypeSubClass> list = new List<UserTypeSubClass>();
                list = new UserTypeSubClassDAL().getAllUserTypeSubClass();
                int num2 = -1;
                SqlDataReader reader = SQLHelper.RunProcedure("p_Products_GetLastRecond", null);
                while (reader.Read())
                {
                    num2 = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                }
                for (int i = 0; i < list.Count; i++)
                {
                    ProductsUserType p = new ProductsUserType();
                    UserTypeSubClass class2 = list[i];
                    p.Price = pro.Price;
                    p.ProductsID = num2;
                    p.SubClassID = class2.SubClassID;
                    new ProductsUserTypeDAL().insertNewRecord(p);
                }
            }
            return (1 == rowsAffected);
        }

        public bool updateProducts(Products pro)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@ProductsName", SqlDbType.NVarChar), new SqlParameter("@TypeID", SqlDbType.Int), new SqlParameter("@BrandID", SqlDbType.Int), new SqlParameter("@Color", SqlDbType.NVarChar), new SqlParameter("@Weight", SqlDbType.NVarChar), new SqlParameter("@Spec", SqlDbType.NVarChar), new SqlParameter("@Cost", SqlDbType.Money), new SqlParameter("@ProductsUints", SqlDbType.NVarChar), new SqlParameter("@Material", SqlDbType.NVarChar), new SqlParameter("@UpperLimit", SqlDbType.Int), new SqlParameter("@LowerLimit", SqlDbType.Int), new SqlParameter("@BeginEnterDate", SqlDbType.NVarChar), new SqlParameter("@FinalEnterDate", SqlDbType.NVarChar), new SqlParameter("@LatelyOFSDate", SqlDbType.NVarChar), new SqlParameter("@UnshelveDate", SqlDbType.NVarChar), new SqlParameter("@LoadingDate", SqlDbType.NVarChar), 
                new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money)
             };
            parameters[0].Value = pro.ProductsName;
            parameters[1].Value = pro.TypeID;
            parameters[2].Value = pro.BrandID;
            parameters[3].Value = pro.Color;
            parameters[4].Value = pro.Weight;
            parameters[5].Value = pro.Spec;
            parameters[6].Value = pro.Cost;
            parameters[7].Value = pro.ProductsUints;
            parameters[8].Value = pro.Material;
            parameters[9].Value = pro.UpperLimit;
            parameters[10].Value = pro.LowerLimit;
            parameters[11].Value = pro.BeginEnterDate;
            parameters[12].Value = pro.FinalEnterDate;
            parameters[13].Value = pro.LatelyOFSDate;
            parameters[14].Value = pro.UnshelveDate;
            parameters[15].Value = pro.LoadingDate;
            parameters[0x10].Value = pro.Description;
            parameters[0x11].Value = pro.ProductsID;
            parameters[0x12].Value = pro.Price;
            SQLHelper.RunProcedure("p_Products_updateProducts", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateProductsPhoto(int ProductsID, string PhotoUrl)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@PhotoUrl", SqlDbType.NVarChar) };
            parameters[0].Value = ProductsID;
            parameters[1].Value = PhotoUrl;
            SQLHelper.RunProcedure("p_Products_updateProductsPhoto", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

