namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Data;
    using System.Data.SqlClient;

    [DataObject]
    public class AccountsDAL
    {
        public bool deleteEitity(string AccountsID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@AccountsID", SqlDbType.NVarChar) };
            parameters[0].Value = AccountsID;
            SQLHelper.RunProcedure("p_Accounts_deleteEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<Accounts> getAll()
        {
            List<Accounts> list = new List<Accounts>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Accounts_getAll", null);
            while (reader.Read())
            {
                Accounts item = new Accounts();
                item.AccountsID = reader.GetString(reader.GetOrdinal("AccountsID"));
                item.AccountsName = reader.GetString(reader.GetOrdinal("AccountsName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public Accounts getByID(string AccountsID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@AccountsID", SqlDbType.NVarChar) };
            parameters[0].Value = AccountsID;
            Accounts accounts = new Accounts();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Accounts_getByID", parameters);
            if (reader.Read())
            {
                accounts.AccountsID = reader.GetString(reader.GetOrdinal("AccountsID"));
                accounts.AccountsName = reader.GetString(reader.GetOrdinal("AccountsName"));
                accounts.Description = reader.GetString(reader.GetOrdinal("Description"));
            }
            reader.Close();
            return accounts;
        }

        public bool insertEitity(Accounts s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@AccountsID", SqlDbType.NVarChar), new SqlParameter("@AccountsName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.AccountsID;
            parameters[1].Value = s.AccountsName;
            parameters[2].Value = s.Description;
            SQLHelper.RunProcedure("p_Accounts_insertEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateEitity(Accounts s)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@AccountsID", SqlDbType.NVarChar), new SqlParameter("@AccountsName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            parameters[0].Value = s.AccountsID;
            parameters[1].Value = s.AccountsName;
            parameters[2].Value = s.Description;
            SQLHelper.RunProcedure("p_Accounts_updateEitity", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

