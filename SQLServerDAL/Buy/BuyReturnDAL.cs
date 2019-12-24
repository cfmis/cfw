namespace Leyp.SQLServerDAL.Buy
{
    using Leyp.Model.Buy;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Service;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class BuyReturnDAL
    {
        public bool AuditingBuyReturnOrder(string BuyReturnID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReturnID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyReturnID;
            if (new BuyReturnService().AuditingBuyReturnOrder(BuyReturnID))
            {
                SQLHelper.RunProcedure("p_BuyReturn_AuditingBuyReturnOrder", parameters, out rowsAffected);
            }
            return (0 < rowsAffected);
        }

        public bool deleteEitity(string BuyReturnID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReturnID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyReturnID;
            SQLHelper.RunProcedure("p_BuyReturn_deleteEntity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public List<VBuyReturn> getBuyReturnOrderList(string beginDate, string endDate, int sideState)
        {
            string s = "";
            List<VBuyReturn> list = new List<VBuyReturn>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReturn_getBuyReturnOrderList", parameters);
            while (reader.Read())
            {
                VBuyReturn item = new VBuyReturn();
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                item.AlreadyPay = float.Parse(s);
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.BuyReturnDate = reader.GetString(reader.GetOrdinal("BuyReturnDate"));
                item.BuyReturnID = reader.GetString(reader.GetOrdinal("BuyReturnID"));
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

        public VBuyReturn getByID(string BuyReturnID)
        {
            bool flag = false;
            string s = "";
            VBuyReturn return2 = new VBuyReturn();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReturnID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyReturnID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReturn_getListByBuyReturnID", parameters);
            if (reader.Read())
            {
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                return2.AlreadyPay = float.Parse(s);
                return2.Description = reader.GetString(reader.GetOrdinal("Description"));
                return2.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                return2.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                return2.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                return2.BuyReturnDate = reader.GetString(reader.GetOrdinal("BuyReturnDate"));
                return2.BuyReturnID = reader.GetString(reader.GetOrdinal("BuyReturnID"));
                return2.State = reader.GetInt32(reader.GetOrdinal("State"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                return2.TotalPrice = float.Parse(s);
                return2.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                return2.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                return2.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                return2.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                flag = true;
            }
            reader.Close();
            return (flag ? return2 : null);
        }

        public List<VBuyReturn> getListByBuyReturnID(string BuyReturnID)
        {
            string s = "";
            List<VBuyReturn> list = new List<VBuyReturn>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReturnID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyReturnID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReturn_getListByBuyReturnID", parameters);
            while (reader.Read())
            {
                VBuyReturn item = new VBuyReturn();
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                item.AlreadyPay = float.Parse(s);
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.BuyReturnDate = reader.GetString(reader.GetOrdinal("BuyReturnDate"));
                item.BuyReturnID = reader.GetString(reader.GetOrdinal("BuyReturnID"));
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

        public VBuyReturn getViewNodeByID(string BuyReturnID)
        {
            string s = "";
            VBuyReturn return2 = new VBuyReturn();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReturnID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyReturnID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyReturn_getViewNodeByID", parameters);
            if (reader.Read())
            {
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                return2.AlreadyPay = float.Parse(s);
                return2.Description = reader.GetString(reader.GetOrdinal("Description"));
                return2.ReceiptOrderID = reader.GetString(reader.GetOrdinal("ReceiptOrderID"));
                return2.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                return2.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                return2.BuyReturnDate = reader.GetString(reader.GetOrdinal("BuyReturnDate"));
                return2.BuyReturnID = reader.GetString(reader.GetOrdinal("BuyReturnID"));
                return2.State = reader.GetInt32(reader.GetOrdinal("State"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                return2.TotalPrice = float.Parse(s);
                return2.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                return2.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                return2.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                return2.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
            }
            return return2;
        }

        public bool insertNewEntity(BuyReturn b)
        {
            int rowsAffected = 0;
            float num2 = float.Parse("0.00");
            if (b.Identitys == 0)
            {
                BuyReturnDetailDAL ldal = new BuyReturnDetailDAL();
                List<VBuyReceiptDetail> list = new List<VBuyReceiptDetail>();
                list = new BuyReceiptDetailDAL().getBuyReceiptDetailByReceiptOrderID(b.ReceiptOrderID);
                for (int i = 0; i < list.Count; i++)
                {
                    BuyReturnDetail detail = new BuyReturnDetail();
                    VBuyReceiptDetail detail2 = list[i];
                    detail.Description = detail2.Description;
                    detail.Price = detail2.Price;
                    detail.ProductsID = detail2.ProductsID;
                    detail.Quantity = detail2.Quantity;
                    detail.SupplierID = detail2.SupplierID;
                    detail.BuyReturnID = b.BuyReturnID;
                    ldal.insertNewEitity(detail);
                    num2 += detail.Quantity * detail.Price;
                }
            }
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReturnID", SqlDbType.NVarChar), new SqlParameter("@BuyReturnDate", SqlDbType.NVarChar), new SqlParameter("@StoreHouseID", SqlDbType.Int), new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@ReceiptOrderID", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@TotalPrice", SqlDbType.Money), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@Identitys", SqlDbType.Int), new SqlParameter("@AlreadyPay", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int) };
            parameters[0].Value = b.BuyReturnID;
            parameters[1].Value = b.BuyReturnDate;
            parameters[2].Value = b.StoreHouseID;
            parameters[3].Value = b.HouseDetailID;
            parameters[4].Value = b.ReceiptOrderID;
            parameters[5].Value = b.UserName;
            parameters[6].Value = num2;
            parameters[7].Value = b.TradeDate;
            parameters[8].Value = b.Identitys;
            parameters[9].Value = b.AlreadyPay;
            parameters[10].Value = b.Description;
            parameters[11].Value = b.State;
            SQLHelper.RunProcedure("p_BuyReturn_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

