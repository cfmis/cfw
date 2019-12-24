namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class SupplierDAL
    {
        public List<Supplier> getAllSupplier()
        {
            List<Supplier> list = new List<Supplier>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Supplier_getALL", null);
            while (reader.Read())
            {
                Supplier item = new Supplier();
                item.SupplierID = reader.GetInt32(reader.GetOrdinal("SupplierID"));
                item.SupplierName = reader.GetString(reader.GetOrdinal("SupplierName"));
                item.Area = reader.GetString(reader.GetOrdinal("Area"));
                item.Postcode = reader.GetString(reader.GetOrdinal("Postcode"));
                item.Address = reader.GetString(reader.GetOrdinal("Address"));
                item.Linkman = reader.GetString(reader.GetOrdinal("Linkman"));
                item.Tel = reader.GetString(reader.GetOrdinal("Tel"));
                item.WebUrl = reader.GetString(reader.GetOrdinal("WebUrl"));
                item.Email = reader.GetString(reader.GetOrdinal("Email"));
                item.Bankname = reader.GetString(reader.GetOrdinal("Bankname"));
                item.BankAccount = reader.GetString(reader.GetOrdinal("BankAccount"));
                item.TaxNum = reader.GetString(reader.GetOrdinal("TaxNum"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public Supplier getBySupplierID(int SupplierID)
        {
            Supplier supplier = new Supplier();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SupplierID", SqlDbType.Int, 4) };
            parameters[0].Value = SupplierID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_Supplier_getByID", parameters);
            while (reader.Read())
            {
                supplier.SupplierID = reader.GetInt32(reader.GetOrdinal("SupplierID"));
                supplier.SupplierName = reader.GetString(reader.GetOrdinal("SupplierName"));
                supplier.Area = reader.GetString(reader.GetOrdinal("Area"));
                supplier.Postcode = reader.GetString(reader.GetOrdinal("Postcode"));
                supplier.Address = reader.GetString(reader.GetOrdinal("Address"));
                supplier.Linkman = reader.GetString(reader.GetOrdinal("Linkman"));
                supplier.Tel = reader.GetString(reader.GetOrdinal("Tel"));
                supplier.WebUrl = reader.GetString(reader.GetOrdinal("WebUrl"));
                supplier.Email = reader.GetString(reader.GetOrdinal("Email"));
                supplier.Bankname = reader.GetString(reader.GetOrdinal("Bankname"));
                supplier.BankAccount = reader.GetString(reader.GetOrdinal("BankAccount"));
                supplier.TaxNum = reader.GetString(reader.GetOrdinal("TaxNum"));
                supplier.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                supplier.State = reader.GetString(reader.GetOrdinal("State"));
                supplier.Description = reader.GetString(reader.GetOrdinal("Description"));
            }
            return supplier;
        }

        public List<Supplier> getSearchListByKey(string Key)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Key", SqlDbType.VarChar) };
            parameters[0].Value = Key;
            List<Supplier> list = new List<Supplier>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Supplier_SearchByKey", parameters);
            while (reader.Read())
            {
                Supplier item = new Supplier();
                item.SupplierID = reader.GetInt32(reader.GetOrdinal("SupplierID"));
                item.SupplierName = reader.GetString(reader.GetOrdinal("SupplierName"));
                item.Area = reader.GetString(reader.GetOrdinal("Area"));
                item.Postcode = reader.GetString(reader.GetOrdinal("Postcode"));
                item.Address = reader.GetString(reader.GetOrdinal("Address"));
                item.Linkman = reader.GetString(reader.GetOrdinal("Linkman"));
                item.Tel = reader.GetString(reader.GetOrdinal("Tel"));
                item.WebUrl = reader.GetString(reader.GetOrdinal("WebUrl"));
                item.Email = reader.GetString(reader.GetOrdinal("Email"));
                item.Bankname = reader.GetString(reader.GetOrdinal("Bankname"));
                item.BankAccount = reader.GetString(reader.GetOrdinal("BankAccount"));
                item.TaxNum = reader.GetString(reader.GetOrdinal("TaxNum"));
                item.CreateDate = reader.GetString(reader.GetOrdinal("CreateDate"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewSupplier(Supplier sp)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SupplierName", SqlDbType.NVarChar), new SqlParameter("@Area", SqlDbType.NVarChar), new SqlParameter("@Postcode", SqlDbType.NVarChar), new SqlParameter("@Address", SqlDbType.NVarChar), new SqlParameter("@Linkman", SqlDbType.NVarChar), new SqlParameter("@Tel", SqlDbType.NVarChar), new SqlParameter("@WebUrl", SqlDbType.NVarChar), new SqlParameter("@Email", SqlDbType.NVarChar), new SqlParameter("@Bankname", SqlDbType.NVarChar), new SqlParameter("@BankAccount", SqlDbType.NVarChar), new SqlParameter("@TaxNum", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = sp.SupplierName;
            parameters[1].Value = sp.Area;
            parameters[2].Value = sp.Postcode;
            parameters[3].Value = sp.Address;
            parameters[4].Value = sp.Linkman;
            parameters[5].Value = sp.Tel;
            parameters[6].Value = sp.WebUrl;
            parameters[7].Value = sp.Email;
            parameters[8].Value = sp.Bankname;
            parameters[9].Value = sp.BankAccount;
            parameters[10].Value = sp.TaxNum;
            parameters[11].Value = sp.CreateDate;
            parameters[12].Value = sp.State;
            parameters[13].Value = sp.Description;
            SQLHelper.RunProcedure("p_Supplier_insertNewSupplier", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateSupplier(Supplier sp)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SupplierName", SqlDbType.NVarChar), new SqlParameter("@Area", SqlDbType.NVarChar), new SqlParameter("@Postcode", SqlDbType.NVarChar), new SqlParameter("@Address", SqlDbType.NVarChar), new SqlParameter("@Linkman", SqlDbType.NVarChar), new SqlParameter("@Tel", SqlDbType.NVarChar), new SqlParameter("@WebUrl", SqlDbType.NVarChar), new SqlParameter("@Email", SqlDbType.NVarChar), new SqlParameter("@Bankname", SqlDbType.NVarChar), new SqlParameter("@BankAccount", SqlDbType.NVarChar), new SqlParameter("@TaxNum", SqlDbType.NVarChar), new SqlParameter("@CreateDate", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@SupplierID", SqlDbType.Int) };
            parameters[0].Value = sp.SupplierName;
            parameters[1].Value = sp.Area;
            parameters[2].Value = sp.Postcode;
            parameters[3].Value = sp.Address;
            parameters[4].Value = sp.Linkman;
            parameters[5].Value = sp.Tel;
            parameters[6].Value = sp.WebUrl;
            parameters[7].Value = sp.Email;
            parameters[8].Value = sp.Bankname;
            parameters[9].Value = sp.BankAccount;
            parameters[10].Value = sp.TaxNum;
            parameters[11].Value = sp.CreateDate;
            parameters[12].Value = sp.State;
            parameters[13].Value = sp.Description;
            parameters[14].Value = sp.SupplierID;
            SQLHelper.RunProcedure("p_Supplier_updateSupplier", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

