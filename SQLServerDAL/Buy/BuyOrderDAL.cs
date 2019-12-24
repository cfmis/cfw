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
    public class BuyOrderDAL
    {
        public bool auditingBuyOrderByID(string BuyOrderID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyOrderID;
            SQLHelper.RunProcedure("p_BuyOrder_AuditingBuyOrderByID", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool deleteBuyOrder(string BuyOrderID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyOrderID;
            SQLHelper.RunProcedure("p_BuyOrder_deleteBuyOrder", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool deleteEntity()
        {
            return false;
        }

        public List<VBuyOrder> getAdminBuyOrderByBuyOrderID(string BuyOrderID)
        {
            string s = "";
            List<VBuyOrder> list = new List<VBuyOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyOrderID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyOrder_getAdminBuyOrderByBuyOrderID", parameters);
            while (reader.Read())
            {
                VBuyOrder item = new VBuyOrder();
                item.BuyOrderDate = reader.GetString(reader.GetOrdinal("BuyOrderDate"));
                item.BuyOrderID = reader.GetString(reader.GetOrdinal("BuyOrderID"));
                item.Delegate = reader.GetString(reader.GetOrdinal("Delegate"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.SignDate = reader.GetString(reader.GetOrdinal("SignDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.TradeAddress = reader.GetString(reader.GetOrdinal("TradeAddress"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VBuyOrder> getAdminBuyOrderList(string beginDate, string endDate, int sideState, int Identitys)
        {
            string s = "";
            List<VBuyOrder> list = new List<VBuyOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int), new SqlParameter("@Identitys", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            parameters[3].Value = Identitys;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyOrder_getAdminBuyOrderList", parameters);
            while (reader.Read())
            {
                VBuyOrder item = new VBuyOrder();
                item.BuyOrderDate = reader.GetString(reader.GetOrdinal("BuyOrderDate"));
                item.BuyOrderID = reader.GetString(reader.GetOrdinal("BuyOrderID"));
                item.Delegate = reader.GetString(reader.GetOrdinal("Delegate"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.SignDate = reader.GetString(reader.GetOrdinal("SignDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.TradeAddress = reader.GetString(reader.GetOrdinal("TradeAddress"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VBuyOrder> getBetweenTwoDate(string beginDate, string endDate, int State, int Identitys)
        {
            string s = "";
            List<VBuyOrder> list = new List<VBuyOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int), new SqlParameter("@Identitys", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = State;
            parameters[3].Value = Identitys;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyOrder_getBetweenTwoDate", parameters);
            while (reader.Read())
            {
                VBuyOrder item = new VBuyOrder();
                item.BuyOrderDate = reader.GetString(reader.GetOrdinal("BuyOrderDate"));
                item.BuyOrderID = reader.GetString(reader.GetOrdinal("BuyOrderID"));
                item.Delegate = reader.GetString(reader.GetOrdinal("Delegate"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                item.SignDate = reader.GetString(reader.GetOrdinal("SignDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.TradeAddress = reader.GetString(reader.GetOrdinal("TradeAddress"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public VBuyOrder getByID(string BuyOrderID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyOrderID;
            VBuyOrder order = new VBuyOrder();
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyOrder_getByID", parameters);
            if (reader.Read())
            {
                order.BuyOrderDate = reader.GetString(reader.GetOrdinal("BuyOrderDate"));
                order.BuyOrderID = reader.GetString(reader.GetOrdinal("BuyOrderID"));
                order.Delegate = reader.GetString(reader.GetOrdinal("Delegate"));
                order.Description = reader.GetString(reader.GetOrdinal("Description"));
                order.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                order.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                order.SignDate = reader.GetString(reader.GetOrdinal("SignDate"));
                order.State = reader.GetInt32(reader.GetOrdinal("State"));
                order.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                order.TotalPrice = float.Parse(s);
                order.TradeAddress = reader.GetString(reader.GetOrdinal("TradeAddress"));
                order.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                order.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                order.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                order.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                order.RealName = reader.GetString(reader.GetOrdinal("RealName"));
            }
            reader.Close();
            return order;
        }

        public List<VBuyOrder> getUserBuyOrderByBuyOrderID(string UserName, string BuyOrderID)
        {
            string s = "";
            List<VBuyOrder> list = new List<VBuyOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@BuyOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = UserName;
            parameters[1].Value = BuyOrderID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyOrder_getUserBuyOrderByBuyOrderID", parameters);
            while (reader.Read())
            {
                VBuyOrder item = new VBuyOrder();
                item.BuyOrderDate = reader.GetString(reader.GetOrdinal("BuyOrderDate"));
                item.BuyOrderID = reader.GetString(reader.GetOrdinal("BuyOrderID"));
                item.Delegate = reader.GetString(reader.GetOrdinal("Delegate"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                item.SignDate = reader.GetString(reader.GetOrdinal("SignDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.TradeAddress = reader.GetString(reader.GetOrdinal("TradeAddress"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VBuyOrder> getUserOrderList(string UserName, string beginDate, string endDate, int sideState, int Identitys)
        {
            string s = "";
            List<VBuyOrder> list = new List<VBuyOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int), new SqlParameter("@Identitys", SqlDbType.Int) };
            parameters[0].Value = UserName;
            parameters[1].Value = beginDate;
            parameters[2].Value = endDate;
            parameters[3].Value = sideState;
            parameters[4].Value = Identitys;
            SqlDataReader reader = SQLHelper.RunProcedure("p_BuyOrder_getUserBuyOrderList", parameters);
            while (reader.Read())
            {
                VBuyOrder item = new VBuyOrder();
                item.BuyOrderDate = reader.GetString(reader.GetOrdinal("BuyOrderDate"));
                item.BuyOrderID = reader.GetString(reader.GetOrdinal("BuyOrderID"));
                item.Delegate = reader.GetString(reader.GetOrdinal("Delegate"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.Identitys = reader.GetInt32(reader.GetOrdinal("Identitys"));
                item.SignDate = reader.GetString(reader.GetOrdinal("SignDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.TradeAddress = reader.GetString(reader.GetOrdinal("TradeAddress"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(BuyOrder b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar), new SqlParameter("@BuyOrderDate", SqlDbType.NVarChar), new SqlParameter("@StoreHouseID", SqlDbType.Int), new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@Delegate", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@TotalPrice", SqlDbType.Money), new SqlParameter("@SignDate", SqlDbType.NVarChar), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@TradeAddress", SqlDbType.NVarChar), new SqlParameter("@Identitys", SqlDbType.Int), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int) };
            parameters[0].Value = b.BuyOrderID;
            parameters[1].Value = b.BuyOrderDate;
            parameters[2].Value = b.StoreHouseID;
            parameters[3].Value = b.HouseDetailID;
            parameters[4].Value = b.Delegate;
            parameters[5].Value = b.UserName;
            parameters[6].Value = b.TotalPrice;
            parameters[7].Value = b.SignDate;
            parameters[8].Value = b.TradeDate;
            parameters[9].Value = b.TradeAddress;
            parameters[10].Value = b.Identitys;
            parameters[11].Value = b.Description;
            parameters[12].Value = b.State;
            SQLHelper.RunProcedure("p_BuyOrder_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool rAuditingBuyOrderByID(string BuyOrderID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = BuyOrderID;
            SQLHelper.RunProcedure("p_BuyOrder_rAuditingBuyOrderByID", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEntity(BuyOrder b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@BuyOrderID", SqlDbType.NVarChar), new SqlParameter("@StoreHouseID", SqlDbType.Int), new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@Delegate", SqlDbType.NVarChar), new SqlParameter("@TotalPrice", SqlDbType.Money), new SqlParameter("@SignDate", SqlDbType.NVarChar), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@TradeAddress", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = b.BuyOrderID;
            parameters[1].Value = b.StoreHouseID;
            parameters[2].Value = b.HouseDetailID;
            parameters[3].Value = b.Delegate;
            parameters[4].Value = b.TotalPrice;
            parameters[5].Value = b.SignDate;
            parameters[6].Value = b.TradeDate;
            parameters[7].Value = b.TradeAddress;
            parameters[8].Value = b.Description;
            SQLHelper.RunProcedure("p_BuyOrder_updateEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        protected bool userDeleteSelfBuyOrder(string UserName, string BuyOrderID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@BuyOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = UserName;
            parameters[1].Value = BuyOrderID;
            SQLHelper.RunProcedure("p_BuyOrder_userDeleteSelfBuyOrder", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }
    }
}

