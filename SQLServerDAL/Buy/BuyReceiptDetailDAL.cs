namespace Leyp.SQLServerDAL.Buy
{
    using Leyp.Model.Buy;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class BuyReceiptDetailDAL
    {
        public bool deleteEitity(int DetailID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SQLHelper.RunProcedure("p_BuyReceiptDetail_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<VBuyReceiptDetail> getBuyReceiptDetailByReceiptOrderID(string ReceiptOrderID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ReceiptOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = ReceiptOrderID;
            List<VBuyReceiptDetail> list = new List<VBuyReceiptDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReceiptDetail_getReceiptOrderID", parameters);
            while (reader.Read())
            {
                VBuyReceiptDetail item = new VBuyReceiptDetail();
                item.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                item.ReceiptOrderID = reader.GetString(reader.GetOrdinal("ReceiptOrderID"));
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

        public VBuyReceiptDetail getByID(int DetailID)
        {
            string s = "";
            VBuyReceiptDetail detail = new VBuyReceiptDetail();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReceiptDetail_getByID", parameters);
            if (reader.Read())
            {
                detail.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                detail.ReceiptOrderID = reader.GetString(reader.GetOrdinal("ReceiptOrderID"));
                detail.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("DiscountRate")).ToString();
                detail.DiscountRate = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                detail.Price = float.Parse(s);
                detail.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                detail.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                detail.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                detail.SupplierID = reader.GetInt32(reader.GetOrdinal("SupplierID"));
                detail.SupplierName = reader.GetString(reader.GetOrdinal("SupplierName"));
                s = reader.GetValue(reader.GetOrdinal("TaxRate")).ToString();
                detail.TaxRate = float.Parse(s);
            }
            return detail;
        }

        public bool insertNewEitity(BuyReceiptDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ReceiptOrderID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SupplierID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@TaxRate", SqlDbType.Float), new SqlParameter("@DiscountRate", SqlDbType.Float), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = b.ReceiptOrderID;
            parameters[1].Value = b.ProductsID;
            parameters[2].Value = b.SupplierID;
            parameters[3].Value = b.Quantity;
            parameters[4].Value = b.Price;
            parameters[5].Value = b.TaxRate;
            parameters[6].Value = b.DiscountRate;
            parameters[7].Value = b.Description;
            SQLHelper.RunProcedure("p_BuyReceiptDetail_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEitity(BuyReceiptDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ReceiptOrderID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@SupplierID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@TaxRate", SqlDbType.Float), new SqlParameter("@DiscountRate", SqlDbType.Float), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = b.ReceiptOrderID;
            parameters[1].Value = b.ProductsID;
            parameters[2].Value = b.SupplierID;
            parameters[3].Value = b.Quantity;
            parameters[4].Value = b.Price;
            parameters[5].Value = b.TaxRate;
            parameters[6].Value = b.DiscountRate;
            parameters[7].Value = b.Description;
            parameters[8].Value = b.DetailID;
            SQLHelper.RunProcedure("p_BuyReceiptDetail_updateEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

