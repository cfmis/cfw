namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Data;
    using System.Data.SqlClient;

    public class ProductsUserTypeDAL
    {
        public void deleteByProductsID(int ProductsID)
        {
        }

        public void deleteBySubClassID(int SubClassID)
        {
        }

        public DataSet getByProductsID(int ProductsID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int) };
            parameters[0].Value = ProductsID;
            return SQLHelper.RunProcedure("p_ProductsUserType_getByProductsID", parameters, "dd");
        }

        public ProductsUserType getByProductsIDAndSubClassID(int ProductsID, int SubClassID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SubClassID", SqlDbType.Int) };
            parameters[0].Value = ProductsID;
            parameters[1].Value = SubClassID;
            ProductsUserType type = new ProductsUserType();
            SqlDataReader reader = SQLHelper.RunProcedure("p_ProductsUserType_getByProductsIDandSubClassID", parameters);
            while (reader.Read())
            {
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                type.Price = double.Parse(s);
                type.SubClassID = SubClassID;
                type.ProductsID = ProductsID;
            }
            return type;
        }

        public bool insertNewRecord(ProductsUserType p)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SubClassID", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Float) };
            parameters[0].Value = p.ProductsID;
            parameters[1].Value = p.SubClassID;
            parameters[2].Value = p.Price;
            SQLHelper.RunProcedure("p_ProductsUserType_insertNewsNode", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateNodeupdate(ProductsUserType p)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SubClassID", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Float) };
            parameters[0].Value = p.ProductsID;
            parameters[1].Value = p.SubClassID;
            parameters[2].Value = p.Price;
            SQLHelper.RunProcedure("p_ProductsUserType_updateNode", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

