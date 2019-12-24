namespace Leyp.SQLServerDAL.Sales
{
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Service;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class SalesReturnDAL
    {
        public bool AuditingOrder(string SalesReturnID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesReturnID", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = SalesReturnID;
            parameters[1].Value = UserName;
            SQLHelper.RunProcedure("p_SalesReturn_AuditingOrder", parameters, out rowsAffected);
            new SalesReturnService().AuditingSalesOutOrder(SalesReturnID);
            return (0 < rowsAffected);
        }

        public bool deleteEitity(string SalesReturnID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesReturnID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesReturnID;
            SQLHelper.RunProcedure("p_SalesReturn_deleteEitity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public VSalesReturn getByID(string SalesReturnID)
        {
            return this.getSearchListByID(SalesReturnID)[0];
        }

        public List<VSalesReturn> getSearchList(string beginDate, string endDate, int sideState)
        {
            string s = "";
            List<VSalesReturn> list = new List<VSalesReturn>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesReturn_getSearchList", parameters);
            while (reader.Read())
            {
                VSalesReturn item = new VSalesReturn();
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ReturnType = reader.GetString(reader.GetOrdinal("ReturnType"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                s = reader.GetValue(reader.GetOrdinal("Deposits")).ToString();
                item.Deposits = float.Parse(s);
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.SalesReturnID = reader.GetString(reader.GetOrdinal("SalesReturnID"));
                item.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VSalesReturn> getSearchListByID(string SalesReturnID)
        {
            string s = "";
            List<VSalesReturn> list = new List<VSalesReturn>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesReturnID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesReturnID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesReturn_getSearchListByID", parameters);
            while (reader.Read())
            {
                VSalesReturn item = new VSalesReturn();
                s = reader.GetValue(reader.GetOrdinal("TotalPrice")).ToString();
                item.TotalPrice = float.Parse(s);
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ReturnType = reader.GetString(reader.GetOrdinal("ReturnType"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                s = reader.GetValue(reader.GetOrdinal("Deposits")).ToString();
                item.Deposits = float.Parse(s);
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.SalesReturnID = reader.GetString(reader.GetOrdinal("SalesReturnID"));
                item.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(SalesReturn s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesReturnID", SqlDbType.NVarChar), new SqlParameter("@SalesOutID", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@ReturnType", SqlDbType.NVarChar), new SqlParameter("@StoreHouseID", SqlDbType.Int), new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@TotalPrice", SqlDbType.Float), new SqlParameter("@Deposits", SqlDbType.Float), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int) };
            parameters[0].Value = s.SalesReturnID;
            parameters[1].Value = s.SalesOutID;
            parameters[2].Value = s.CreateDate;
            parameters[3].Value = s.ReturnType;
            parameters[4].Value = s.StoreHouseID;
            parameters[5].Value = s.HouseDetailID;
            parameters[6].Value = s.TradeDate;
            parameters[7].Value = s.TotalPrice;
            parameters[8].Value = s.Deposits;
            parameters[9].Value = s.UserName;
            parameters[10].Value = s.Description;
            parameters[11].Value = s.State;
            SQLHelper.RunProcedure("p_SalesReturn_insertNewEntity", parameters, out rowsAffected);
            List<VSalesOutDetail> list = new List<VSalesOutDetail>();
            SalesReturnDetailDAL ldal = new SalesReturnDetailDAL();
            list = new SalesOutDetailDAL().getBySalesOutID(s.SalesOutID);
            for (int i = 0; i < list.Count; i++)
            {
                VSalesOutDetail detail = list[i];
                SalesReturnDetail b = new SalesReturnDetail();
                b.Price = detail.Price;
                b.ProductsID = detail.ProductsID;
                b.Quantity = detail.Quantity;
                b.Description = "";
                b.SalesReturnID = s.SalesReturnID;
                ldal.insertNewEitity(b);
            }
            return (1 == rowsAffected);
        }
    }
}

