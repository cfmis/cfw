namespace Leyp.SQLServerDAL.Stock
{
    using Leyp.Model.Stock;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Service;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class InventoryDAL
    {
        public bool AuditingOrder(string InventoryID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@InventoryID", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = InventoryID;
            parameters[1].Value = UserName;
            if (new InventoryService().AuditingInventoryOrder(InventoryID))
            {
                SQLHelper.RunProcedure("p_Inventory_AuditingOrder", parameters, out rowsAffected);
            }
            return (0 < rowsAffected);
        }

        public bool deleteEitity(string ID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@InventoryID", SqlDbType.NVarChar) };
            parameters[0].Value = ID;
            SQLHelper.RunProcedure("p_Inventory_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public VInventory getByID(string InventoryID)
        {
            return this.getSearchListByID(InventoryID)[0];
        }

        public List<VInventory> getSearchList(string beginDate, string endDate, int sideState)
        {
            List<VInventory> list = new List<VInventory>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_Inventory_getSearchList", parameters);
            while (reader.Read())
            {
                VInventory item = new VInventory();
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.InventoryID = reader.GetString(reader.GetOrdinal("InventoryID"));
                item.AdjustNum = reader.GetInt32(reader.GetOrdinal("AdjustNum"));
                item.BillNum = reader.GetInt32(reader.GetOrdinal("BillNum"));
                item.RealityNum = reader.GetInt32(reader.GetOrdinal("RealityNum"));
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                item.Operator = reader.GetString(reader.GetOrdinal("Operator"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VInventory> getSearchListByID(string InventoryID)
        {
            List<VInventory> list = new List<VInventory>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@InventoryID", SqlDbType.NVarChar) };
            parameters[0].Value = InventoryID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_Inventory_getSearchListByID", parameters);
            while (reader.Read())
            {
                VInventory item = new VInventory();
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.InventoryID = reader.GetString(reader.GetOrdinal("InventoryID"));
                item.AdjustNum = reader.GetInt32(reader.GetOrdinal("AdjustNum"));
                item.BillNum = reader.GetInt32(reader.GetOrdinal("BillNum"));
                item.RealityNum = reader.GetInt32(reader.GetOrdinal("RealityNum"));
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.TradeDate = reader.GetString(reader.GetOrdinal("TradeDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.HouseDetailID = reader.GetInt32(reader.GetOrdinal("HouseDetailID"));
                item.HouseName = reader.GetString(reader.GetOrdinal("HouseName"));
                item.SubareaName = reader.GetString(reader.GetOrdinal("SubareaName"));
                item.Operator = reader.GetString(reader.GetOrdinal("Operator"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(Inventory b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@InventoryID", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@StoreHouseID", SqlDbType.Int), new SqlParameter("@HouseDetailID", SqlDbType.Int), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@RealityNum", SqlDbType.Int), new SqlParameter("@BillNum", SqlDbType.Int), new SqlParameter("@AdjustNum", SqlDbType.Int), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@Operator", SqlDbType.NVarChar), new SqlParameter("@TradeDate", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int) };
            parameters[0].Value = b.InventoryID;
            parameters[1].Value = b.CreateDate;
            parameters[2].Value = b.StoreHouseID;
            parameters[3].Value = b.HouseDetailID;
            parameters[4].Value = b.ProductsID;
            parameters[5].Value = b.RealityNum;
            parameters[6].Value = b.BillNum;
            parameters[7].Value = b.AdjustNum;
            parameters[8].Value = b.UserName;
            parameters[9].Value = b.Operator;
            parameters[10].Value = b.TradeDate;
            parameters[11].Value = b.Description;
            parameters[12].Value = b.State;
            SQLHelper.RunProcedure("p_Inventory_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

