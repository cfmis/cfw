namespace Leyp.SQLServerDAL.Stock
{
    using Leyp.Model.Stock;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Service;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class OutStockDAL
    {
        public bool AuditingOrder(string OutID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@OutID", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = OutID;
            parameters[1].Value = UserName;
            SQLHelper.RunProcedure("p_OutStock_AuditingOrder", parameters, out rowsAffected);
            new OutStockService().AuditingOutStockOrder(OutID);
            return (0 < rowsAffected);
        }

        public bool deleteEitity(string OutID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@OutID", SqlDbType.NVarChar) };
            parameters[0].Value = OutID;
            SQLHelper.RunProcedure("p_OutStock_deleteEitity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public VOutStock getByID(string OutID)
        {
            string s = "";
            VOutStock stock = new VOutStock();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@OutID", SqlDbType.NVarChar) };
            parameters[0].Value = OutID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_OutStock_getByID", parameters);
            while (reader.Read())
            {
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                stock.AlreadyPay = float.Parse(s);
                stock.OutID = reader.GetString(reader.GetOrdinal("OutID"));
                stock.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                stock.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                stock.Description = reader.GetString(reader.GetOrdinal("Description"));
                stock.OutType = reader.GetInt32(reader.GetOrdinal("OutType"));
                stock.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                stock.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                stock.TotalPrice = float.Parse(s);
                stock.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                stock.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                stock.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                stock.UserName = reader.GetString(reader.GetOrdinal("UserName"));
            }
            reader.Close();
            return stock;
        }

        public List<VOutStock> getSearchList(string beginDate, string endDate, int sideState)
        {
            string s = "";
            List<VOutStock> list = new List<VOutStock>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_OutStock_getSearchList", parameters);
            while (reader.Read())
            {
                VOutStock item = new VOutStock();
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                item.AlreadyPay = float.Parse(s);
                item.OutID = reader.GetString(reader.GetOrdinal("OutID"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.OutType = reader.GetInt32(reader.GetOrdinal("OutType"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VOutStock> getSearchListByID(string OutID)
        {
            string s = "";
            List<VOutStock> list = new List<VOutStock>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@OutID", SqlDbType.NVarChar) };
            parameters[0].Value = OutID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_OutStock_getSearchListByID", parameters);
            while (reader.Read())
            {
                VOutStock item = new VOutStock();
                s = reader.GetValue(reader.GetOrdinal("AlreadyPay")).ToString();
                item.AlreadyPay = float.Parse(s);
                item.OutID = reader.GetString(reader.GetOrdinal("OutID"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.OutType = reader.GetInt32(reader.GetOrdinal("OutType"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.StoreHouseID = reader.GetInt32(reader.GetOrdinal("StoreHouseID"));
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(OutStock s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@OutID", SqlDbType.NVarChar), new SqlParameter("@OutType", SqlDbType.Int), new SqlParameter("@StoreHouseID", SqlDbType.Int), new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@TotalPrice", SqlDbType.Float), new SqlParameter("@AlreadyPay", SqlDbType.Float), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int), new SqlParameter("@CreateDate", SqlDbType.NVarChar) };
            parameters[0].Value = s.OutID;
            parameters[1].Value = s.OutType;
            parameters[2].Value = s.StoreHouseID;
            parameters[3].Value = s.HouseDetailID;
            parameters[4].Value = s.UserName;
            parameters[5].Value = s.TradeDate;
            parameters[6].Value = s.TotalPrice;
            parameters[7].Value = s.AlreadyPay;
            parameters[8].Value = s.Description;
            parameters[9].Value = s.State;
            parameters[10].Value = s.CreateDate;
            SQLHelper.RunProcedure("p_OutStock_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

