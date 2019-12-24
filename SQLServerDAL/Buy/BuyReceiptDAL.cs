namespace Leyp.SQLServerDAL.Buy
{
    using Leyp.Model.Buy;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Service;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class BuyReceiptDAL
    {
        public bool AuditingBuyReceiptOrder(string ReceiptOrderID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ReceiptOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = ReceiptOrderID;
            SQLHelper.RunProcedure("p_BuyReceipt_AuditingBuyReceiptOrder", parameters, out rowsAffected);
            new BuyReceiptService().AuditingBuyReceiptOrder(ReceiptOrderID);
            return (0 < rowsAffected);
        }

        public bool deleteEitity(string ReceiptOrderID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ReceiptOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = ReceiptOrderID;
            SQLHelper.RunProcedure("p_BuyReceipt_deleteEntity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public List<VBuyReceipt> getAdminBuyReceiptOrderList(string beginDate, string endDate, int sideState)
        {
            string s = "";
            List<VBuyReceipt> list = new List<VBuyReceipt>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReceipt_getAdminBuyReceiptOrderList", parameters);
            while (reader.Read())
            {
                VBuyReceipt item = new VBuyReceipt();
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                item.AlreadyPay = float.Parse(s);
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.ReceiptOrderDate = reader.GetString(reader.GetOrdinal("ReceiptOrderDate"));
                item.ReceiptOrderID = reader.GetString(reader.GetOrdinal("ReceiptOrderID"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public BuyReceipt getByID(string ReceiptOrderID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ReceiptOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = ReceiptOrderID;
            BuyReceipt receipt = new BuyReceipt();
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReceipt_getByID", parameters);
            if (reader.Read())
            {
                receipt.ReceiptOrderDate = reader.GetString(reader.GetOrdinal("ReceiptOrderDate"));
                receipt.ReceiptOrderID = reader.GetString(reader.GetOrdinal("ReceiptOrderID"));
                receipt.BuyOrderID = reader.GetString(reader.GetOrdinal("BuyOrderID"));
                receipt.Description = reader.GetString(reader.GetOrdinal("Description"));
                receipt.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                receipt.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                receipt.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                receipt.State = reader.GetInt32(reader.GetOrdinal("State"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                receipt.TotalPrice = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                receipt.AlreadyPay = float.Parse(s);
                receipt.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                receipt.UserName = reader.GetString(reader.GetOrdinal("UserName"));
            }
            reader.Close();
            return receipt;
        }

        public List<VBuyReceipt> getListByReceiptOrderID(string ReceiptOrderID)
        {
            string s = "";
            List<VBuyReceipt> list = new List<VBuyReceipt>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ReceiptOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = ReceiptOrderID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReceipt_getListByReceiptOrderID", parameters);
            while (reader.Read())
            {
                VBuyReceipt item = new VBuyReceipt();
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                item.AlreadyPay = float.Parse(s);
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.ReceiptOrderDate = reader.GetString(reader.GetOrdinal("ReceiptOrderDate"));
                item.ReceiptOrderID = reader.GetString(reader.GetOrdinal("ReceiptOrderID"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public VBuyReceipt getViewByID(string ReceiptOrderID)
        {
            string s = "";
            VBuyReceipt receipt = new VBuyReceipt();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ReceiptOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = ReceiptOrderID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReceipt_getListByReceiptOrderID", parameters);
            if (reader.Read())
            {
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                receipt.AlreadyPay = float.Parse(s);
                receipt.Description = reader.GetString(reader.GetOrdinal("Description"));
                receipt.BuyOrderID = reader.GetString(reader.GetOrdinal("BuyOrderID"));
                receipt.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                receipt.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                receipt.ReceiptOrderDate = reader.GetString(reader.GetOrdinal("ReceiptOrderDate"));
                receipt.ReceiptOrderID = reader.GetString(reader.GetOrdinal("ReceiptOrderID"));
                receipt.State = reader.GetInt32(reader.GetOrdinal("State"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                receipt.TotalPrice = float.Parse(s);
                receipt.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                receipt.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                receipt.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                receipt.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
            }
            return receipt;
        }

        public bool insertNewEntity(BuyReceipt b)
        {
            int rowsAffected = 0;
            float num2 = float.Parse("0.00");
            if (b.Identitys == 0)
            {
                BuyReceiptDetailDAL ldal = new BuyReceiptDetailDAL();
                List<VBuyOrderDetail> list = new List<VBuyOrderDetail>();
                list = new BuyOrderDetailDAL().getBuyOrderDetailByBuyOrderID(b.BuyOrderID);
                for (int i = 0; i < list.Count; i++)
                {
                    BuyReceiptDetail detail = new BuyReceiptDetail();
                    BuyOrderDetail detail2 = list[i];
                    detail.Description = detail2.Description;
                    detail.DiscountRate = detail2.DiscountRate;
                    detail.Price = detail2.Price;
                    detail.ProductsID = detail2.ProductsID;
                    detail.Quantity = detail2.Quantity;
                    detail.SupplierID = detail2.SupplierID;
                    detail.TaxRate = detail2.TaxRate;
                    detail.ReceiptOrderID = b.ReceiptOrderID;
                    ldal.insertNewEitity(detail);
                    num2 += (((detail.Quantity * detail.Price) * (100f + detail.TaxRate)) / 100f) - (((detail.Quantity * detail.Price) * detail.DiscountRate) / 100f);
                }
            }
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ReceiptOrderID", SqlDbType.NVarChar), new SqlParameter("@ReceiptOrderDate", SqlDbType.NVarChar), new SqlParameter("@StoreHouseID", SqlDbType.Int), new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@BuyOrderID", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@TotalPrice", SqlDbType.Money), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@Identitys", SqlDbType.Int), new SqlParameter("@AlreadyPay", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int) };
            parameters[0].Value = b.ReceiptOrderID;
            parameters[1].Value = b.ReceiptOrderDate;
            parameters[2].Value = b.StoreHouseID;
            parameters[3].Value = b.HouseDetailID;
            parameters[4].Value = b.BuyOrderID;
            parameters[5].Value = b.UserName;
            parameters[6].Value = num2;
            parameters[7].Value = b.TradeDate;
            parameters[8].Value = b.Identitys;
            parameters[9].Value = b.AlreadyPay;
            parameters[10].Value = b.Description;
            parameters[11].Value = b.State;
            SQLHelper.RunProcedure("p_BuyReceipt_insertNewEntity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }
    }
}

