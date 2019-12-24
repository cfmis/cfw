namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class ProductsPhotoDAL
    {
        public bool deleteNodeByID(int ID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.Int) };
            parameters[0].Value = ID;
            SQLHelper.RunProcedure("p_ProductsPhoto_deleteNode", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<ProductsPhoto> getListByProductsID(int ProductsID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int) };
            parameters[0].Value = ProductsID;
            List<ProductsPhoto> list = new List<ProductsPhoto>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsPhoto_getByProductsID", parameters);
            while (reader.Read())
            {
                ProductsPhoto item = new ProductsPhoto();
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.PhotoUrl = reader.GetString(reader.GetOrdinal("PhotoUrl"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewNode(ProductsPhoto p)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@PhotoUrl", SqlDbType.NVarChar) };
            parameters[0].Value = p.ProductsID;
            parameters[1].Value = p.PhotoUrl;
            SQLHelper.RunProcedure("p_ProductsPhoto_insertNewNode", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

