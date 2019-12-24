namespace Leyp.SQLServerDAL.Buy
{
    using Leyp.Model.Buy;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class BuyPayDAL
    {
        public bool AuditingBuyPay(int PayID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@PayID", SqlDbType.Int), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = PayID;
            parameters[1].Value = UserName;
            SQLHelper.RunProcedure("p_BuyPay_AuditingBuyPay", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool deleteEitity(int PayID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@PayID", SqlDbType.Int) };
            parameters[0].Value = PayID;
            SQLHelper.RunProcedure("p_BuyPay_deleteEntity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public List<VBuyPay> getBuyPayOrderList(string beginDate, string endDate, int sideState)
        {
            string s = "";
            List<VBuyPay> list = new List<VBuyPay>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyPay_getBuyPayOrderList", parameters);
            while (reader.Read())
            {
                VBuyPay item = new VBuyPay();
                s = reader.GetValue(reader.GetOrdinal("RealPay")).ToString();
                item.RealPay = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("AttachPay")).ToString();
                item.AttachPay = float.Parse(s);
                item.PayID = reader.GetInt32(reader.GetOrdinal("PayID"));
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.BuyReceiptID = reader.GetString(reader.GetOrdinal("BuyReceiptID"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.PayType = reader.GetString(reader.GetOrdinal("PayType"));
                item.Ticket = reader.GetString(reader.GetOrdinal("Ticket"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VBuyPay> getByBuyReceiptID(string BuyReceiptID)
        {
            string s = "";
            List<VBuyPay> list = new List<VBuyPay>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReceiptID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyReceiptID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyPay_getByBuyReceiptID", parameters);
            while (reader.Read())
            {
                VBuyPay item = new VBuyPay();
                s = reader.GetValue(reader.GetOrdinal("RealPay")).ToString();
                item.RealPay = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("AttachPay")).ToString();
                item.AttachPay = float.Parse(s);
                item.PayID = reader.GetInt32(reader.GetOrdinal("PayID"));
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.BuyReceiptID = reader.GetString(reader.GetOrdinal("BuyReceiptID"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.PayType = reader.GetString(reader.GetOrdinal("PayType"));
                item.Ticket = reader.GetString(reader.GetOrdinal("Ticket"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public VBuyPay getViewNodeByID(int PayID)
        {
            string s = "";
            VBuyPay pay = new VBuyPay();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@PayID", SqlDbType.NVarChar) };
            parameters[0].Value = PayID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyPay_getViewNodeByID", parameters);
            if (reader.Read())
            {
                s = reader.GetValue(reader.GetOrdinal("RealPay")).ToString();
                pay.RealPay = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("AttachPay")).ToString();
                pay.AttachPay = float.Parse(s);
                pay.PayID = reader.GetInt32(reader.GetOrdinal("PayID"));
                pay.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                pay.BuyReceiptID = reader.GetString(reader.GetOrdinal("BuyReceiptID"));
                pay.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                pay.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                pay.PayType = reader.GetString(reader.GetOrdinal("PayType"));
                pay.Ticket = reader.GetString(reader.GetOrdinal("Ticket"));
                pay.State = reader.GetInt32(reader.GetOrdinal("State"));
                pay.UserName = reader.GetString(reader.GetOrdinal("UserName"));
            }
            reader.Close();
            return pay;
        }

        public bool insertNewEntity(BuyPay b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyReceiptID", SqlDbType.NVarChar), new SqlParameter("@Ticket", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@PayType", SqlDbType.NVarChar), new SqlParameter("@RealPay", SqlDbType.Money), new SqlParameter("@AttachPay", SqlDbType.Money), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int) };
            parameters[0].Value = b.BuyReceiptID;
            parameters[1].Value = b.Ticket;
            parameters[2].Value = b.CreateDate;
            parameters[3].Value = b.UserName;
            parameters[4].Value = b.PayType;
            parameters[5].Value = b.RealPay;
            parameters[6].Value = b.AttachPay;
            parameters[7].Value = b.Description;
            parameters[8].Value = b.State;
            SQLHelper.RunProcedure("p_BuyPay_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

