namespace Leyp.SQLServerDAL.Stock
{
    using Leyp.Model.Stock;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class OutStockDetailDAL
    {
        public bool deleteEitity(int DetailID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SQLHelper.RunProcedure("p_OutStockDetail_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public VOutStockDetail getByID(int DetailID)
        {
            string s = "";
            VOutStockDetail detail = new VOutStockDetail();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_OutStockDetail_getByID", parameters);
            if (reader.Read())
            {
                detail.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                detail.OutID = reader.GetString(reader.GetOrdinal("OutID"));
                detail.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                detail.Price = float.Parse(s);
                detail.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                detail.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                detail.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
            }
            return detail;
        }

        public List<VOutStockDetail> getListByOutID(string OutID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@OutID", SqlDbType.NVarChar) };
            parameters[0].Value = OutID;
            List<VOutStockDetail> list = new List<VOutStockDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_OutStockDetail_getListByOutID", parameters);
            while (reader.Read())
            {
                VOutStockDetail item = new VOutStockDetail();
                item.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                item.OutID = reader.GetString(reader.GetOrdinal("OutID"));
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

        public bool insertNewEitity(OutStockDetail s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@OutID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.OutID;
            parameters[1].Value = s.ProductsID;
            parameters[2].Value = s.Quantity;
            parameters[3].Value = s.Price;
            parameters[4].Value = s.Description;
            SQLHelper.RunProcedure("p_OutStockDetail_insertNewEntity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool updateEitity(OutStockDetail s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@OutID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = s.OutID;
            parameters[1].Value = s.ProductsID;
            parameters[2].Value = s.Quantity;
            parameters[3].Value = s.Price;
            parameters[4].Value = s.Description;
            parameters[5].Value = s.DetailID;
            SQLHelper.RunProcedure("p_OutStockDetail_updateEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

