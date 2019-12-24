namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class ProductsTypeDAL
    {
        public bool deleteByTypeID(int typeID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int) };
            parameters[0].Value = typeID;
            SQLHelper.RunProcedure("p_ProductsType_DeleteByTypeID", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<ProductsType> getAllProductsType()
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@sign", SqlDbType.Int) };
            parameters[0].Value = 0;
            List<ProductsType> list = new List<ProductsType>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsType_GetAll", parameters);
            while (reader.Read())
            {
                ProductsType item = new ProductsType();
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<ProductsType> getAllProductsTypeCanUser()
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@sign", SqlDbType.Int) };
            parameters[0].Value = 1;
            List<ProductsType> list = new List<ProductsType>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsType_GetAll", parameters);
            while (reader.Read())
            {
                ProductsType item = new ProductsType();
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public ProductsType getByTypeID(int TypeID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int) };
            parameters[0].Value = TypeID;
            ProductsType type = new ProductsType();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsType_GetByTypeID", parameters);
            if (reader.Read())
            {
                type.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                type.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                type.State = reader.GetString(reader.GetOrdinal("State"));
                type.Description = reader.GetString(reader.GetOrdinal("Description"));
            }
            reader.Close();
            return type;
        }

        public bool insertNewProductsType(ProductsType pt)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeName", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.NChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = pt.TypeName;
            parameters[1].Value = pt.State;
            parameters[2].Value = pt.Description;
            SQLHelper.RunProcedure("p_ProductsType_InsertNew", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateProductsType(ProductsType pt)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int), new SqlParameter("@TypeName", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.NChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = pt.TypeID;
            parameters[1].Value = pt.TypeName;
            parameters[2].Value = pt.State;
            parameters[3].Value = pt.Description;
            SQLHelper.RunProcedure("p_ProductsType_update", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

