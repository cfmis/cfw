namespace Leyp.SQLServerDAL.Sales
{
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class SalesOrderDAL
    {
        public bool AuditingOrder(string SalesOrderID, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOrderID;
            parameters[1].Value = UserName;
            SQLHelper.RunProcedure("p_SalesOrder_AuditingOrder", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool deleteEitity(string SalesOrderID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOrderID;
            SQLHelper.RunProcedure("p_SalesOrder_deleteEitity", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public VSalesOrder getByID(string SalesOrderID)
        {
            bool flag = false;
            string s = "";
            VSalesOrder order = new VSalesOrder();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOrderID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOrder_getByID", parameters);
            while (reader.Read())
            {
                s = reader.GetValue(reader.GetOrdinal("SalesIncome")).ToString();
                order.SalesIncome = float.Parse(s);
                order.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                order.ClosingDate = reader.GetString(reader.GetOrdinal("ClosingDate"));
                order.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                order.Description = reader.GetString(reader.GetOrdinal("Description"));
                order.ClosingType = reader.GetString(reader.GetOrdinal("ClosingType"));
                order.ShopID = reader.GetInt32(reader.GetOrdinal("ShopID"));
                order.SalesType = reader.GetInt32(reader.GetOrdinal("SalesType"));
                order.DeliveryPlace = reader.GetString(reader.GetOrdinal("DeliveryPlace"));
                order.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                order.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                order.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                order.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                s = reader.GetValue(reader.GetOrdinal("AttachPay")).ToString();
                order.AttachPay = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Discount")).ToString();
                order.Discount = float.Parse(s);
                order.State = reader.GetInt32(reader.GetOrdinal("State"));
                order.CustomerName = reader.GetString(reader.GetOrdinal("CustomerName"));
                order.CustomerPost = reader.GetString(reader.GetOrdinal("CustomerPost"));
                order.CustomerTel = reader.GetString(reader.GetOrdinal("CustomerTel"));
                order.CustomerArea = reader.GetString(reader.GetOrdinal("CustomerArea"));
                order.CustomerID = reader.GetString(reader.GetOrdinal("CustomerID"));
                order.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                order.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                flag = true;
            }
            reader.Close();
            return (flag ? order : null);
        }

        public List<VSalesOrder> getReportListByPlatformID(string beginDate, string endDate, int PlatformID)
        {
            string s = "";
            List<VSalesOrder> list = new List<VSalesOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@PlatformID", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = PlatformID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOrder_getReportListByPlatformID", parameters);
            while (reader.Read())
            {
                VSalesOrder item = new VSalesOrder();
                s = reader.GetValue(reader.GetOrdinal("SalesIncome")).ToString();
                item.SalesIncome = float.Parse(s);
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ClosingDate = reader.GetString(reader.GetOrdinal("ClosingDate"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.ClosingType = reader.GetString(reader.GetOrdinal("ClosingType"));
                item.ShopID = reader.GetInt32(reader.GetOrdinal("ShopID"));
                item.SalesType = reader.GetInt32(reader.GetOrdinal("SalesType"));
                item.DeliveryPlace = reader.GetString(reader.GetOrdinal("DeliveryPlace"));
                item.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                s = reader.GetValue(reader.GetOrdinal("AttachPay")).ToString();
                item.AttachPay = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Discount")).ToString();
                item.Discount = float.Parse(s);
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.CustomerName = reader.GetString(reader.GetOrdinal("CustomerName"));
                item.CustomerPost = reader.GetString(reader.GetOrdinal("CustomerPost"));
                item.CustomerTel = reader.GetString(reader.GetOrdinal("CustomerTel"));
                item.CustomerArea = reader.GetString(reader.GetOrdinal("CustomerArea"));
                item.CustomerID = reader.GetString(reader.GetOrdinal("CustomerID"));
                item.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                item.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VSalesOrder> getSearchList(string beginDate, string endDate, int sideState)
        {
            string s = "";
            List<VSalesOrder> list = new List<VSalesOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOrder_getSearchList", parameters);
            while (reader.Read())
            {
                VSalesOrder item = new VSalesOrder();
                s = reader.GetValue(reader.GetOrdinal("SalesIncome")).ToString();
                item.SalesIncome = float.Parse(s);
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ClosingDate = reader.GetString(reader.GetOrdinal("ClosingDate"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.ClosingType = reader.GetString(reader.GetOrdinal("ClosingType"));
                item.ShopID = reader.GetInt32(reader.GetOrdinal("ShopID"));
                item.SalesType = reader.GetInt32(reader.GetOrdinal("SalesType"));
                item.DeliveryPlace = reader.GetString(reader.GetOrdinal("DeliveryPlace"));
                item.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                s = reader.GetValue(reader.GetOrdinal("AttachPay")).ToString();
                item.AttachPay = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Discount")).ToString();
                item.Discount = float.Parse(s);
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.CustomerName = reader.GetString(reader.GetOrdinal("CustomerName"));
                item.CustomerPost = reader.GetString(reader.GetOrdinal("CustomerPost"));
                item.CustomerTel = reader.GetString(reader.GetOrdinal("CustomerTel"));
                item.CustomerArea = reader.GetString(reader.GetOrdinal("CustomerArea"));
                item.CustomerID = reader.GetString(reader.GetOrdinal("CustomerID"));
                item.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                item.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VSalesOrder> getSearchListByID(string SalesOrderID)
        {
            string s = "";
            List<VSalesOrder> list = new List<VSalesOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOrderID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOrder_getSearchListByID", parameters);
            while (reader.Read())
            {
                VSalesOrder item = new VSalesOrder();
                s = reader.GetValue(reader.GetOrdinal("SalesIncome")).ToString();
                item.SalesIncome = float.Parse(s);
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ClosingDate = reader.GetString(reader.GetOrdinal("ClosingDate"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.ClosingType = reader.GetString(reader.GetOrdinal("ClosingType"));
                item.ShopID = reader.GetInt32(reader.GetOrdinal("ShopID"));
                item.SalesType = reader.GetInt32(reader.GetOrdinal("SalesType"));
                item.DeliveryPlace = reader.GetString(reader.GetOrdinal("DeliveryPlace"));
                item.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                s = reader.GetValue(reader.GetOrdinal("AttachPay")).ToString();
                item.AttachPay = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Discount")).ToString();
                item.Discount = float.Parse(s);
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.CustomerName = reader.GetString(reader.GetOrdinal("CustomerName"));
                item.CustomerPost = reader.GetString(reader.GetOrdinal("CustomerPost"));
                item.CustomerTel = reader.GetString(reader.GetOrdinal("CustomerTel"));
                item.CustomerArea = reader.GetString(reader.GetOrdinal("CustomerArea"));
                item.CustomerID = reader.GetString(reader.GetOrdinal("CustomerID"));
                item.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                item.PlatformID = reader.GetInt32(reader.GetOrdinal("PlatformID"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<VSalesOrder> getSearchListByUserName(string beginDate, string endDate, int sideState, string UserName)
        {
            string s = "";
            List<VSalesOrder> list = new List<VSalesOrder>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@beginDate", SqlDbType.NVarChar), new SqlParameter("@endDate", SqlDbType.NVarChar), new SqlParameter("@sideState", SqlDbType.Int), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = beginDate;
            parameters[1].Value = endDate;
            parameters[2].Value = sideState;
            parameters[3].Value = UserName;
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesOrder_getSearchListByUserName", parameters);
            while (reader.Read())
            {
                VSalesOrder item = new VSalesOrder();
                s = reader.GetValue(reader.GetOrdinal("SalesIncome")).ToString();
                item.SalesIncome = float.Parse(s);
                item.AuditingUser = reader.GetString(reader.GetOrdinal("AuditingUser"));
                item.ClosingDate = reader.GetString(reader.GetOrdinal("ClosingDate"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.ClosingType = reader.GetString(reader.GetOrdinal("ClosingType"));
                item.ShopID = reader.GetInt32(reader.GetOrdinal("ShopID"));
                item.SalesType = reader.GetInt32(reader.GetOrdinal("SalesType"));
                item.DeliveryPlace = reader.GetString(reader.GetOrdinal("DeliveryPlace"));
                item.DeliveryType = reader.GetString(reader.GetOrdinal("DeliveryType"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.SalesOrderID = reader.GetString(reader.GetOrdinal("SalesOrderID"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                s = reader.GetValue(reader.GetOrdinal("AttachPay")).ToString();
                item.AttachPay = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Discount")).ToString();
                item.Discount = float.Parse(s);
                item.State = reader.GetInt32(reader.GetOrdinal("State"));
                item.CustomerName = reader.GetString(reader.GetOrdinal("CustomerName"));
                item.CustomerPost = reader.GetString(reader.GetOrdinal("CustomerPost"));
                item.CustomerTel = reader.GetString(reader.GetOrdinal("CustomerTel"));
                item.CustomerArea = reader.GetString(reader.GetOrdinal("CustomerArea"));
                item.CustomerID = reader.GetString(reader.GetOrdinal("CustomerID"));
                item.PlatformName = reader.GetString(reader.GetOrdinal("PlatformName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewEntity(SalesOrder s)
        {
            int rowsAffected = 0;
            float num2 = float.Parse("0.00");
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@SalesOrderID", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@SalesType", SqlDbType.Int), new SqlParameter("@ShopID", SqlDbType.Int), new SqlParameter("@CustomerID", SqlDbType.NVarChar), new SqlParameter("@DeliveryType", SqlDbType.NVarChar), new SqlParameter("@DeliveryPlace", SqlDbType.NVarChar), new SqlParameter("@ClosingType", SqlDbType.NVarChar), new SqlParameter("@ClosingDate", SqlDbType.NVarChar), new SqlParameter("@SalesIncome", SqlDbType.Float), new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.Int), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@AttachPay", SqlDbType.Float), new SqlParameter("@Discount", SqlDbType.Float), new SqlParameter("@CustomerName", SqlDbType.NVarChar), 
                new SqlParameter("@CustomerTel", SqlDbType.NVarChar), new SqlParameter("@CustomerPost", SqlDbType.NVarChar), new SqlParameter("@CustomerArea", SqlDbType.NVarChar), new SqlParameter("@PlatformID", SqlDbType.Int)
             };
            parameters[0].Value = s.SalesOrderID;
            parameters[1].Value = s.CreateDate;
            parameters[2].Value = s.SalesType;
            parameters[3].Value = s.ShopID;
            parameters[4].Value = s.CustomerID;
            parameters[5].Value = s.DeliveryType;
            parameters[6].Value = s.DeliveryPlace;
            parameters[7].Value = s.ClosingType;
            parameters[8].Value = s.ClosingDate;
            parameters[9].Value = (new SalesDetailDAL().getInitTotal(s.SalesOrderID) + s.AttachPay) - s.Discount;
            parameters[10].Value = s.UserName;
            parameters[11].Value = s.State;
            parameters[12].Value = s.Description;
            parameters[13].Value = s.AttachPay;
            parameters[14].Value = s.Discount;
            parameters[15].Value = s.CustomerName;
            parameters[0x10].Value = s.CustomerTel;
            parameters[0x11].Value = s.CustomerPost;
            parameters[0x12].Value = s.CustomerArea;
            parameters[0x13].Value = s.PlatformID;
            SQLHelper.RunProcedure("p_SalesOrder_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool rAuditingOrder(string SalesOrderID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOrderID;
            SQLHelper.RunProcedure("p_SalesOrder_rAuditingOrder", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool updateCustomerInfo(SalesOrder s)
        {
            int rowsAffected = 0;
            float num2 = float.Parse("0.00");
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar), new SqlParameter("@AttachPay", SqlDbType.Float), new SqlParameter("@Discount", SqlDbType.Float), new SqlParameter("@CustomerName", SqlDbType.NVarChar), new SqlParameter("@CustomerTel", SqlDbType.NVarChar), new SqlParameter("@CustomerPost", SqlDbType.NVarChar), new SqlParameter("@CustomerArea", SqlDbType.NVarChar), new SqlParameter("@PlatformID", SqlDbType.Int), new SqlParameter("@CustomerID", SqlDbType.NVarChar) };
            parameters[0].Value = s.SalesOrderID;
            parameters[1].Value = s.AttachPay;
            parameters[2].Value = s.Discount;
            parameters[3].Value = s.CustomerName;
            parameters[4].Value = s.CustomerTel;
            parameters[5].Value = s.CustomerPost;
            parameters[6].Value = s.CustomerArea;
            parameters[7].Value = s.PlatformID;
            parameters[8].Value = s.CustomerID;
            SQLHelper.RunProcedure("p_SalesOrder_updateCustomerInfo", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updatePayInfo(string SalesOrderID, string payInfo)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar), new SqlParameter("@payInfo", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOrderID;
            parameters[1].Value = payInfo;
            SQLHelper.RunProcedure("p_SalesOrder_updatePayInfo", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public bool updateSate(int State, string SalesOrderID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@State", SqlDbType.Int), new SqlParameter("@SalesOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = State;
            parameters[1].Value = SalesOrderID;
            SQLHelper.RunProcedure("p_SalesOrder_updateSate", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }
    }
}

