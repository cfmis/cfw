namespace Leyp.SQLServerDAL.Sales
{
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class SalesReturnDetailDAL
    {
        public bool deleteEitity(int DetailID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SQLHelper.RunProcedure("p_SalesReturnDetail_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public VSalesReturnDetail getByID(int DetailID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            VSalesReturnDetail detail = new VSalesReturnDetail();
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesReturnDetail_getByID", parameters);
            while (reader.Read())
            {
                detail.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                detail.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                detail.Price = float.Parse(s);
                detail.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                detail.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                detail.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
            }
            reader.Close();
            return detail;
        }

        public List<VSalesReturnDetail> getBySalesReturnID(string SalesReturnID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesReturnID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesReturnID;
            List<VSalesReturnDetail> list = new List<VSalesReturnDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesReturnDetail_getBySalesReturnID", parameters);
            while (reader.Read())
            {
                VSalesReturnDetail item = new VSalesReturnDetail();
                item.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                item.Price = float.Parse(s);
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEitity(SalesReturnDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesReturnID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = b.SalesReturnID;
            parameters[1].Value = b.ProductsID;
            parameters[2].Value = b.Quantity;
            parameters[3].Value = b.Price;
            parameters[4].Value = b.Description;
            SQLHelper.RunProcedure("p_SalesReturnDetail_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEitity(SalesReturnDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int), new SqlParameter("@SalesReturnID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = b.DetailID;
            parameters[1].Value = b.SalesReturnID;
            parameters[2].Value = b.ProductsID;
            parameters[3].Value = b.Quantity;
            parameters[4].Value = b.Price;
            parameters[5].Value = b.Description;
            SQLHelper.RunProcedure("p_SalesReturnDetail_updateEntity", parameters, out rowsAffected);
            return (1 < rowsAffected);
        }
    }
}

