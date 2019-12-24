namespace Leyp.SQLServerDAL.Stock
{
    using Leyp.Model.Stock;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class AppendStockDetailDAL
    {
        public bool deleteEitity(int DetailID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SQLHelper.RunProcedure("p_AppendStockDetail_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public VAppendStockDetail getByID(int DetailID)
        {
            string s = "";
            VAppendStockDetail detail = new VAppendStockDetail();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_AppendStockDetail_getByID", parameters);
            if (reader.Read())
            {
                detail.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                detail.AppendID = reader.GetString(reader.GetOrdinal("AppendID"));
                detail.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                detail.Price = float.Parse(s);
                detail.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                detail.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                detail.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                detail.SupplierID = reader.GetInt32(reader.GetOrdinal("SupplierID"));
                detail.SupplierName = reader.GetString(reader.GetOrdinal("SupplierName"));
            }
            return detail;
        }

        public List<VAppendStockDetail> getListByAppendID(string AppendID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@AppendID", SqlDbType.NVarChar) };
            parameters[0].Value = AppendID;
            List<VAppendStockDetail> list = new List<VAppendStockDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_AppendStockDetail_getListByAppendID", parameters);
            while (reader.Read())
            {
                VAppendStockDetail item = new VAppendStockDetail();
                item.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                item.AppendID = reader.GetString(reader.GetOrdinal("AppendID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                item.Price = float.Parse(s);
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                item.SupplierID = reader.GetInt32(reader.GetOrdinal("SupplierID"));
                item.SupplierName = reader.GetString(reader.GetOrdinal("SupplierName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEitity(AppendStockDetail s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@AppendID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SupplierID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.AppendID;
            parameters[1].Value = s.ProductsID;
            parameters[2].Value = s.SupplierID;
            parameters[3].Value = s.Quantity;
            parameters[4].Value = s.Price;
            parameters[5].Value = s.Description;
            SQLHelper.RunProcedure("p_AppendStockDetail_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEitity(AppendStockDetail s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@AppendID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SupplierID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = s.AppendID;
            parameters[1].Value = s.ProductsID;
            parameters[2].Value = s.SupplierID;
            parameters[3].Value = s.Quantity;
            parameters[4].Value = s.Price;
            parameters[5].Value = s.Description;
            parameters[6].Value = s.DetailID;
            SQLHelper.RunProcedure("p_AppendStockDetail_updateEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

