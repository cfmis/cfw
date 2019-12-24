namespace Leyp.SQLServerDAL.Buy
{
    using Leyp.Model.Buy;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Data;
    using System.Data.SqlClient;

    [DataObject]
    public class BuyOrderDetailDAL
    {
        public bool deleteEitity(int DetailID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SQLHelper.RunProcedure("p_BuyOrderDetail_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<VBuyOrderDetail> getBuyOrderDetailByBuyOrderID(string BuyOrderID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyOrderID;
            List<VBuyOrderDetail> list = new List<VBuyOrderDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyOrderDetail_getByBuyOrderID", parameters);
            while (reader.Read())
            {
                VBuyOrderDetail item = new VBuyOrderDetail();
                item.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("DiscountRate")).ToString();
                item.DiscountRate = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                item.Price = float.Parse(s);
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                item.SupplierID = reader.GetInt32(reader.GetOrdinal("SupplierID"));
                item.SupplierName = reader.GetString(reader.GetOrdinal("SupplierName"));
                s = reader.GetValue(reader.GetOrdinal("TaxRate")).ToString();
                item.TaxRate = float.Parse(s);
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VBuyOrderDetail> getBuyOrderDetailforAjaxString(string BuyOrderID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyOrderID;
            List<VBuyOrderDetail> list = new List<VBuyOrderDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyOrderDetail_getByBuyOrderID", parameters);
            while (reader.Read())
            {
                VBuyOrderDetail item = new VBuyOrderDetail();
                item.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("DiscountRate")).ToString();
                item.DiscountRate = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                item.Price = float.Parse(s);
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                item.SupplierID = reader.GetInt32(reader.GetOrdinal("SupplierID"));
                item.SupplierName = reader.GetString(reader.GetOrdinal("SupplierName"));
                s = reader.GetValue(reader.GetOrdinal("TaxRate")).ToString();
                item.TaxRate = float.Parse(s);
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public DataSet getOrderDetailPhoto(string BuyOrderID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyOrderID;
            List<VBuyOrderDetail> list = new List<VBuyOrderDetail>();
            DataSet set = new DataSet();
            return SQLHelper.RunProcedure("p_BuyOrderDetail_getOrderDetailPhoto", parameters, "dd");
        }

        public bool insertNewEitity(BuyOrderDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SupplierID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@ReceiptNum", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@TaxRate", SqlDbType.Float), new SqlParameter("@DiscountRate", SqlDbType.Float), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = b.BuyOrderID;
            parameters[1].Value = b.ProductsID;
            parameters[2].Value = b.SupplierID;
            parameters[3].Value = b.Quantity;
            parameters[4].Value = 0;
            parameters[5].Value = b.Price;
            parameters[6].Value = b.TaxRate;
            parameters[7].Value = b.DiscountRate;
            parameters[8].Value = b.Description;
            SQLHelper.RunProcedure("p_BuyOrderDetail_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEitity(BuyOrderDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SupplierID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@TaxRate", SqlDbType.Float), new SqlParameter("@DiscountRate", SqlDbType.Float), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = b.DetailID;
            parameters[1].Value = b.ProductsID;
            parameters[2].Value = b.SupplierID;
            parameters[3].Value = b.Quantity;
            parameters[4].Value = b.Price;
            parameters[5].Value = b.TaxRate;
            parameters[6].Value = b.DiscountRate;
            parameters[7].Value = b.Description;
            SQLHelper.RunProcedure("p_BuyOrderDetail_updateEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

