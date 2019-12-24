namespace Leyp.SQLServerDAL.Sales
{
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Service;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class SalesOutDAL
    {
        public bool AuditingOrder(string SalesOutID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOutID;
            parameters[1].Value = UserName;
            if (new SalesOutService().AuditingSalesOutOrder(SalesOutID))
            {
                SQLHelper.RunProcedure("p_SalesOut_AuditingOrder", parameters, out rowsAffected);
            }
            return (0 < rowsAffected);
        }

        public bool AuditingOrder(string SalesOutID, string UserName, string TradeDate, string Consignee)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@Consignee", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOutID;
            parameters[1].Value = UserName;
            parameters[2].Value = TradeDate;
            parameters[3].Value = Consignee;
            try
            {
                SQLHelper.RunProcedure("p_SalesOut_NewAuditingOrder", parameters, out rowsAffected);
                new SalesOutService().AuditingSalesOutOrder(SalesOutID);
            }
            catch
            {
                return false;
            }
            return (0 < rowsAffected);
        }

        public bool deleteEitity(string SalesOutID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOutID;
            SQLHelper.RunProcedure("p_SalesOut_deleteEitity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public VSalesOut getByID(string SalesOutID)
        {
            bool flag = false;
            string s = "";
            VSalesOut @out = new VSalesOut();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOutID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOut_getByID", parameters);
            while (reader.Read())
            {
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                @out.TotalPrice = float.Parse(s);
                @out.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                @out.Consignee = reader.GetString(reader.GetOrdinal("Consignee"));
                @out.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                s = reader.GetValue(reader.GetOrdinal("Deposits")).ToString();
                @out.Deposits = float.Parse(s);
                @out.Description = reader.GetString(reader.GetOrdinal("Description"));
                @out.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                @out.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                @out.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                @out.State = reader.GetInt32(reader.GetOrdinal("State"));
                @out.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                @out.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                @out.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                @out.DeliveryID = reader.GetInt32(reader.GetOrdinal("DeliveryID"));
                @out.AccountsID = reader.GetString(reader.GetOrdinal("AccountsID"));
                @out.State = reader.GetInt32(reader.GetOrdinal("State"));
                flag = true;
            }
            reader.Close();
            return (flag ? @out : null);
        }

        public List<VSalesOut> getSearchList(string beginDate, string endDate, int sideState)
        {
            string s = "";
            List<VSalesOut> list = new List<VSalesOut>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOut_getSearchList", parameters);
            while (reader.Read())
            {
                VSalesOut item = new VSalesOut();
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.Consignee = reader.GetString(reader.GetOrdinal("Consignee"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                s = reader.GetValue(reader.GetOrdinal("Deposits")).ToString();
                item.Deposits = float.Parse(s);
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                item.AccountsID = reader.GetString(reader.GetOrdinal("AccountsID"));
                item.DeliveryID = reader.GetInt32(reader.GetOrdinal("DeliveryID"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VSalesOut> getSearchListByID(string SalesOutID)
        {
            string s = "";
            List<VSalesOut> list = new List<VSalesOut>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOutID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOut_getSearchListByID", parameters);
            while (reader.Read())
            {
                VSalesOut item = new VSalesOut();
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.Consignee = reader.GetString(reader.GetOrdinal("Consignee"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                s = reader.GetValue(reader.GetOrdinal("Deposits")).ToString();
                item.Deposits = float.Parse(s);
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                item.AccountsID = reader.GetString(reader.GetOrdinal("AccountsID"));
                item.DeliveryID = reader.GetInt32(reader.GetOrdinal("DeliveryID"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(SalesOut s)
        {
            int rowsAffected = 0;
            float num2 = float.Parse("0.00");
            List<VSalesOutDetail> list = new SalesOutDetailDAL().getBySalesOutID(s.SalesOutID);
            for (int i = 0; i < list.Count; i++)
            {
                VSalesOutDetail detail = list[i];
                num2 += (detail.Price * detail.Quantity) * (1f - (detail.DiscountRate / 100f));
            }
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar), new SqlParameter("@SalesOrderID", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@Consignee", SqlDbType.NVarChar), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@TotalPrice", SqlDbType.Float), new SqlParameter("@Deposits", SqlDbType.Float), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int), new SqlParameter("@DeliveryID", SqlDbType.Int), new SqlParameter("@AccountsID", SqlDbType.NVarChar) };
            parameters[0].Value = s.SalesOutID;
            parameters[1].Value = s.SalesOrderID;
            parameters[2].Value = s.CreateDate;
            parameters[3].Value = s.Consignee;
            parameters[4].Value = s.TradeDate;
            parameters[5].Value = num2;
            parameters[6].Value = s.Deposits;
            parameters[7].Value = s.UserName;
            parameters[8].Value = s.Description;
            parameters[9].Value = s.State;
            parameters[10].Value = s.DeliveryID;
            parameters[11].Value = s.AccountsID;
            SQLHelper.RunProcedure("p_SalesOut_insertNewEntity", parameters, out rowsAffected);
            if (rowsAffected == 1)
            {
                new SalesOrderDAL().updateSate(2, s.SalesOrderID);
            }
            return (1 == rowsAffected);
        }

        public bool insertSalesDetailFrist(string SalesOrderID, string SalesOutID)
        {
            try
            {
                List<VSalesDetail> list = new List<VSalesDetail>();
                SalesOutDetailDAL ldal = new SalesOutDetailDAL();
                list = new SalesDetailDAL().getBySalesOrderID(SalesOrderID);
                for (int i = 0; i < list.Count; i++)
                {
                    SalesOutDetail b = new SalesOutDetail();
                    VSalesDetail detail2 = list[i];
                    b.ProductsID = detail2.ProductsID;
                    b.Quantity = detail2.Quantity;
                    b.SalesOutID = SalesOutID;
                    b.DiscountRate = detail2.DiscountRate;
                    b.Description = detail2.Description;
                    b.Price = detail2.Price;
                    ldal.insertNewEitity(b);
                }
                return true;
            }
            catch
            {
                return false;
            }
        }

        public List<VSalesOut> selectProductsByImg(string Date, int sideState)
        {
            string s = "";
            List<VSalesOut> list = new List<VSalesOut>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Date", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = Date;
            parameters[1].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOut_selectProductsByImg", parameters);
            while (reader.Read())
            {
                VSalesOut item = new VSalesOut();
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.Consignee = reader.GetString(reader.GetOrdinal("Consignee"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                s = reader.GetValue(reader.GetOrdinal("Deposits")).ToString();
                item.Deposits = float.Parse(s);
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                item.AccountsID = reader.GetString(reader.GetOrdinal("AccountsID"));
                item.DeliveryID = reader.GetInt32(reader.GetOrdinal("DeliveryID"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool updataEntity(SalesOut s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@Consignee", SqlDbType.NVarChar), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@DeliveryID", SqlDbType.Int) };
            parameters[0].Value = s.SalesOutID;
            parameters[1].Value = s.CreateDate;
            parameters[2].Value = s.Consignee;
            parameters[3].Value = s.TradeDate;
            parameters[4].Value = s.UserName;
            parameters[5].Value = s.Description;
            parameters[6].Value = s.DeliveryID;
            SQLHelper.RunProcedure("p_SalesOut_updataEntity", parameters, out rowsAffected);
            if (rowsAffected == 1)
            {
            }
            return (1 == rowsAffected);
        }

        public bool updateSate(int State, string SalesOutID)
        {
            if ((State > 3) || (State < 2))
            {
                return false;
            }
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@State", SqlDbType.Int), new SqlParameter("@SalesOutID", SqlDbType.NVarChar) };
            parameters[0].Value = State;
            parameters[1].Value = SalesOutID;
            SQLHelper.RunProcedure("p_SalesOut_updateSate", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }
    }
}

