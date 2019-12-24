namespace Leyp.SQLServerDAL.Sales
{
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class SalesDispatchDAL
    {
        public bool deleteEitity(int DispatchID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DispatchID", SqlDbType.Int) };
            parameters[0].Value = DispatchID;
            SQLHelper.RunProcedure("p_SalesDispatch_deleteEitity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public List<VSalesDispatch> getByConsignorByDeliveryDate(string beginDate, string endDate, int sideState, string Consignor)
        {
            List<VSalesDispatch> list = new List<VSalesDispatch>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@Consignor", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = Consignor;
            parameters[3].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesDispatch_getByConsignorByDeliveryDate", parameters);
            while (reader.Read())
            {
                VSalesDispatch item = new VSalesDispatch();
                item.Consignor = reader.GetString(reader.GetOrdinal("Consignor"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.DeliveryDate = reader.GetString(reader.GetOrdinal("DeliveryDate"));
                item.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.DispatchID = reader.GetInt32(reader.GetOrdinal("DispatchID"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                item.SentDate = reader.GetString(reader.GetOrdinal("SentDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VSalesDispatch> getByDeliveryDate(string beginDate, string endDate, int sideState)
        {
            List<VSalesDispatch> list = new List<VSalesDispatch>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesDispatch_getByDeliveryDate", parameters);
            while (reader.Read())
            {
                VSalesDispatch item = new VSalesDispatch();
                item.Consignor = reader.GetString(reader.GetOrdinal("Consignor"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.DeliveryDate = reader.GetString(reader.GetOrdinal("DeliveryDate"));
                item.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.DispatchID = reader.GetInt32(reader.GetOrdinal("DispatchID"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                item.SentDate = reader.GetString(reader.GetOrdinal("SentDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VSalesDispatch> getByDeliveryType(int DeliveryID, int sideState, int PrintFlag)
        {
            List<VSalesDispatch> list = new List<VSalesDispatch>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DeliveryID", SqlDbType.Int), new SqlParameter("@sideState", SqlDbType.Int), new SqlParameter("@PrintFlag", SqlDbType.Int) };
            parameters[0].Value = DeliveryID;
            parameters[1].Value = sideState;
            parameters[2].Value = PrintFlag;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesDispatch_getByDeliveryType", parameters);
            while (reader.Read())
            {
                VSalesDispatch item = new VSalesDispatch();
                item.Consignor = reader.GetString(reader.GetOrdinal("Consignor"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.DeliveryDate = reader.GetString(reader.GetOrdinal("DeliveryDate"));
                item.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.DispatchID = reader.GetInt32(reader.GetOrdinal("DispatchID"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                item.SentDate = reader.GetString(reader.GetOrdinal("SentDate"));
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public VSalesDispatch getByID(int DispatchID)
        {
            bool flag = false;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DispatchID", SqlDbType.Int) };
            parameters[0].Value = DispatchID;
            VSalesDispatch dispatch = new VSalesDispatch();
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesDispatch_getByID", parameters);
            if (reader.Read())
            {
                dispatch.Consignor = reader.GetString(reader.GetOrdinal("Consignor"));
                dispatch.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                dispatch.DeliveryDate = reader.GetString(reader.GetOrdinal("DeliveryDate"));
                dispatch.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                dispatch.Description = reader.GetString(reader.GetOrdinal("Description"));
                dispatch.DispatchID = reader.GetInt32(reader.GetOrdinal("DispatchID"));
                dispatch.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                dispatch.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                dispatch.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                dispatch.SentDate = reader.GetString(reader.GetOrdinal("SentDate"));
                dispatch.State = reader.GetInt32(reader.GetOrdinal("State"));
                dispatch.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                dispatch.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                flag = true;
            }
            reader.Close();
            return (flag ? dispatch : null);
        }

        public VSalesDispatch getBySalesOrderID(string SalesOrderID)
        {
            bool flag = false;
            VSalesDispatch dispatch = new VSalesDispatch();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOrderID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesDispatch_getBySalesOrderID", parameters);
            while (reader.Read())
            {
                dispatch.Consignor = reader.GetString(reader.GetOrdinal("Consignor"));
                dispatch.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                dispatch.DeliveryDate = reader.GetString(reader.GetOrdinal("DeliveryDate"));
                dispatch.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                dispatch.Description = reader.GetString(reader.GetOrdinal("Description"));
                dispatch.DispatchID = reader.GetInt32(reader.GetOrdinal("DispatchID"));
                dispatch.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                dispatch.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                dispatch.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                dispatch.SentDate = reader.GetString(reader.GetOrdinal("SentDate"));
                dispatch.State = reader.GetInt32(reader.GetOrdinal("State"));
                dispatch.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                dispatch.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                flag = true;
            }
            reader.Close();
            return (flag ? dispatch : null);
        }

        public VSalesDispatch getBySalesOutID(string SalesOutID)
        {
            bool flag = false;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOutID;
            VSalesDispatch dispatch = new VSalesDispatch();
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesDispatch_getBySalesOutID", parameters);
            if (reader.Read())
            {
                dispatch.Consignor = reader.GetString(reader.GetOrdinal("Consignor"));
                dispatch.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                dispatch.DeliveryDate = reader.GetString(reader.GetOrdinal("DeliveryDate"));
                dispatch.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                dispatch.Description = reader.GetString(reader.GetOrdinal("Description"));
                dispatch.DispatchID = reader.GetInt32(reader.GetOrdinal("DispatchID"));
                dispatch.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                dispatch.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                dispatch.SalesOutID = reader.GetString(reader.GetOrdinal("SalesOutID"));
                dispatch.SentDate = reader.GetString(reader.GetOrdinal("SentDate"));
                dispatch.State = reader.GetInt32(reader.GetOrdinal("State"));
                dispatch.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                dispatch.DeliveryName = reader.GetString(reader.GetOrdinal("DeliveryName"));
                flag = true;
            }
            reader.Close();
            return (flag ? dispatch : null);
        }

        public DataSet getDataForPrintByDeliveryID(int DeliveryID)
        {
            DataSet set = new DataSet();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DeliveryID", SqlDbType.Int) };
            parameters[0].Value = DeliveryID;
            return SQLHelper.RunProcedure("p_SalesDispatch_getDataForPrintByDeliveryID", parameters, "dd");
        }

        public bool insertNewEntity(SalesDispatch s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOutID", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@DeliveryType", SqlDbType.NVarChar), new SqlParameter("@DeliveryDate", SqlDbType.NVarChar), new SqlParameter("@SentDate", SqlDbType.NVarChar), new SqlParameter("@Consignor ", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int) };
            parameters[0].Value = s.SalesOutID;
            parameters[1].Value = s.CreateDate;
            parameters[2].Value = s.DeliveryType;
            parameters[3].Value = s.DeliveryDate;
            parameters[4].Value = s.SentDate;
            parameters[5].Value = s.Consignor;
            parameters[6].Value = s.UserName;
            parameters[7].Value = s.Description;
            parameters[8].Value = s.State;
            SQLHelper.RunProcedure("p_SalesDispatch_insertNewEntity", parameters, out rowsAffected);
            if (s.State == 0)
            {
                new SalesOutDAL().updateSate(2, s.SalesOutID);
            }
            else if (s.State == 1)
            {
                new SalesOutDAL().updateSate(3, s.SalesOutID);
            }
            return (1 == rowsAffected);
        }

        public bool sentUpdate(int DispatchID, string SentDate, int State, string Description, float Postage)
        {
            VSalesDispatch dispatch;
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DispatchID", SqlDbType.Int), new SqlParameter("@SentDate", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@Postage", SqlDbType.Float) };
            parameters[0].Value = DispatchID;
            parameters[1].Value = SentDate;
            parameters[2].Value = State;
            parameters[3].Value = Description;
            parameters[4].Value = Postage;
            SQLHelper.RunProcedure("p_SalesDispatch_sentUpdate", parameters, out rowsAffected);
            if (State == 1)
            {
                dispatch = this.getByID(DispatchID);
                new SalesOutDAL().updateSate(3, dispatch.SalesOutID);
            }
            if (State == 3)
            {
                dispatch = this.getByID(DispatchID);
                new SalesOutDAL().updateSate(4, dispatch.SalesOutID);
            }
            return (0 < rowsAffected);
        }

        public void updataPrintFlag(int DispatchID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DispatchID", SqlDbType.Int) };
            parameters[0].Value = DispatchID;
            SQLHelper.RunProcedure("p_SalesDispatch_updataPrintFlag", parameters, out rowsAffected);
        }

        public bool updateEntity(SalesDispatch s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DeliveryType", SqlDbType.NVarChar), new SqlParameter("@DeliveryDate", SqlDbType.NVarChar), new SqlParameter("@SentDate", SqlDbType.NVarChar), new SqlParameter("@Consignor ", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int), new SqlParameter("@DispatchID", SqlDbType.Int) };
            parameters[0].Value = s.DeliveryType;
            parameters[1].Value = s.DeliveryDate;
            parameters[2].Value = s.SentDate;
            parameters[3].Value = s.Consignor;
            parameters[4].Value = s.UserName;
            parameters[5].Value = s.Description;
            parameters[6].Value = s.State;
            parameters[7].Value = s.DispatchID;
            SQLHelper.RunProcedure("p_SalesDispatch_updateEntity", parameters, out rowsAffected);
            if (s.State == 1)
            {
                new SalesOutDAL().updateSate(3, s.SalesOutID);
            }
            return (1 == rowsAffected);
        }
    }
}

