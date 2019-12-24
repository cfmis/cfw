namespace Leyp.SQLServerDAL.Buy
{
    using Leyp.Model.Buy;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class BuyReturnDetailDAL
    {
        public bool deleteEitity(int DetailID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SQLHelper.RunProcedure("p_BuyReturnDetail_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<VBuyReturnDetail> getBuyReturnDetailByBuyReturnID(string BuyReturnID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReturnID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyReturnID;
            List<VBuyReturnDetail> list = new List<VBuyReturnDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReturnDetail_getByBuyReturnID", parameters);
            while (reader.Read())
            {
                VBuyReturnDetail item = new VBuyReturnDetail();
                item.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                item.BuyReturnID = reader.GetString(reader.GetOrdinal("BuyReturnID"));
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

        public VBuyReturnDetail getByID(int DetailID)
        {
            string s = "";
            VBuyReturnDetail detail = new VBuyReturnDetail();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReturnDetail_getByID", parameters);
            if (reader.Read())
            {
                detail.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                detail.BuyReturnID = reader.GetString(reader.GetOrdinal("BuyReturnID"));
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

        public bool insertNewEitity(BuyReturnDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReturnID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SupplierID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = b.BuyReturnID;
            parameters[1].Value = b.ProductsID;
            parameters[2].Value = b.SupplierID;
            parameters[3].Value = b.Quantity;
            parameters[4].Value = b.Price;
            parameters[5].Value = b.Description;
            SQLHelper.RunProcedure("p_BuyReturnDetail_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEitity(BuyReturnDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReturnID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SupplierID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = b.BuyReturnID;
            parameters[1].Value = b.ProductsID;
            parameters[2].Value = b.SupplierID;
            parameters[3].Value = b.Quantity;
            parameters[4].Value = b.Price;
            parameters[5].Value = b.Description;
            parameters[6].Value = b.DetailID;
            SQLHelper.RunProcedure("p_BuyReturnDetail_updateEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

