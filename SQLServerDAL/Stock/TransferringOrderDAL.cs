namespace Leyp.SQLServerDAL.Stock
{
    using Leyp.Model.Stock;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Service;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class TransferringOrderDAL
    {
        public bool AuditingOrder(string ID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TransferringOrderID", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = ID;
            parameters[1].Value = UserName;
            if (new TransferringService().AuditingTransferring(ID))
            {
                SQLHelper.RunProcedure("p_TransferringOrder_AuditingOrder", parameters, out rowsAffected);
            }
            return (0 < rowsAffected);
        }

        public bool deleteEitity(string ID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TransferringOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = ID;
            SQLHelper.RunProcedure("p_TransferringOrder_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public VTransferringOrder getByID(string ID)
        {
            return this.getSearchListByID(ID)[0];
        }

        public List<VTransferringOrder> getSearchList(string beginDate, string endDate, int sideState)
        {
            string s = "";
            List<VTransferringOrder> list = new List<VTransferringOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_TransferringOrder_getSearchList", parameters);
            while (reader.Read())
            {
                VTransferringOrder item = new VTransferringOrder();
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.Date = reader.GetString(reader.GetOrdinal("Date"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.ID = reader.GetString(reader.GetOrdinal("ID"));
                item.InHouseID = reader.GetInt32(reader.GetOrdinal("InHouseID"));
                item.OutHouseID = reader.GetInt32(reader.GetOrdinal("OutHouseID"));
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.InHouseName = reader.GetString(reader.GetOrdinal("InHouseName"));
                item.InSubareaName = reader.GetString(reader.GetOrdinal("InSubareaName"));
                item.OutHouseName = reader.GetString(reader.GetOrdinal("OutHouseName"));
                item.OutSubareaName = reader.GetString(reader.GetOrdinal("OutSubareaName"));
                item.Operator = reader.GetString(reader.GetOrdinal("Operator"));
                item.Ticket = reader.GetString(reader.GetOrdinal("Ticket"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                item.Price = float.Parse(s);
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VTransferringOrder> getSearchListByID(string ID)
        {
            string s = "";
            List<VTransferringOrder> list = new List<VTransferringOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ID", SqlDbType.NVarChar) };
            parameters[0].Value = ID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_TransferringOrder_getSearchListByID", parameters);
            while (reader.Read())
            {
                VTransferringOrder item = new VTransferringOrder();
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.Date = reader.GetString(reader.GetOrdinal("Date"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.ID = reader.GetString(reader.GetOrdinal("ID"));
                item.InHouseID = reader.GetInt32(reader.GetOrdinal("InHouseID"));
                item.OutHouseID = reader.GetInt32(reader.GetOrdinal("OutHouseID"));
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.InHouseName = reader.GetString(reader.GetOrdinal("InHouseName"));
                item.InSubareaName = reader.GetString(reader.GetOrdinal("InSubareaName"));
                item.OutHouseName = reader.GetString(reader.GetOrdinal("OutHouseName"));
                item.OutSubareaName = reader.GetString(reader.GetOrdinal("OutSubareaName"));
                item.Operator = reader.GetString(reader.GetOrdinal("Operator"));
                item.Ticket = reader.GetString(reader.GetOrdinal("Ticket"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                item.Price = float.Parse(s);
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(TransferringOrder b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Date", SqlDbType.NVarChar), new SqlParameter("@OutHouseID", SqlDbType.Int), new SqlParameter("@InHouseID", SqlDbType.Int), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Float), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@Operator", SqlDbType.NVarChar), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@Ticket", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int), new SqlParameter("@ID", SqlDbType.NVarChar) };
            parameters[0].Value = b.Date;
            parameters[1].Value = b.OutHouseID;
            parameters[2].Value = b.InHouseID;
            parameters[3].Value = b.ProductsID;
            parameters[4].Value = b.Quantity;
            parameters[5].Value = b.Price;
            parameters[6].Value = b.UserName;
            parameters[7].Value = b.Operator;
            parameters[8].Value = b.TradeDate;
            parameters[9].Value = b.Ticket;
            parameters[10].Value = b.Description;
            parameters[11].Value = b.State;
            parameters[12].Value = b.ID;
            SQLHelper.RunProcedure("p_TransferringOrder_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

