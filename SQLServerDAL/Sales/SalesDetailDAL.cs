namespace Leyp.SQLServerDAL.Sales
{
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class SalesDetailDAL
    {
        public bool deleteEitity(int DetailID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DetailID", SqlDbType.Int) };
            parameters[0].Value = DetailID;
            SQLHelper.RunProcedure("p_SalesDetail_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<VSalesDetail> getBySalesOrderID(string SalesOrderID)
        {
            string s = "";
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar) };
            parameters[0].Value = SalesOrderID;
            List<VSalesDetail> list = new List<VSalesDetail>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_SalesDetail_getBySalesOrderID", parameters);
            while (reader.Read())
            {
                VSalesDetail item = new VSalesDetail();
                item.DetailID = reader.GetInt32(reader.GetOrdinal("DetailID"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                s = reader.GetValue(reader.GetOrdinal("DiscountRate")).ToString();
                item.DiscountRate = float.Parse(s);
                s = reader.GetValue(reader.GetOrdinal("Price")).ToString();
                item.Price = float.Parse(s);
                item.ProductsID = reader.GetInt32(reader.GetOrdinal("ProductsID"));
                item.ProductsName = reader.GetString(reader.GetOrdinal("ProductsName"));
                item.Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public float getInitTotal(string SalesOrderID)
        {
            float num = float.Parse("0.00");
            List<VSalesDetail> list = this.getBySalesOrderID(SalesOrderID);
            for (int i = 0; i < list.Count; i++)
            {
                VSalesDetail detail = list[i];
                num += (detail.Quantity * detail.Price) * (1f - (detail.DiscountRate / 100f));
            }
            return num;
        }

        public bool insertNewEitity(SalesDetail b)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SalesOrderID", SqlDbType.NVarChar), new SqlParameter("@ProductsID", SqlDbType.Int), new SqlParameter("@Quantity", SqlDbType.Int), new SqlParameter("@Price", SqlDbType.Money), new SqlParameter("@DiscountRate", SqlDbType.Float), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = b.SalesOrderID;
            parameters[1].Value = b.ProductsID;
            parameters[2].Value = b.Quantity;
            parameters[3].Value = b.Price;
            parameters[4].Value = b.DiscountRate;
            parameters[5].Value = b.Description;
            SQLHelper.RunProcedure("p_SalesDetail_insertNewEntity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

