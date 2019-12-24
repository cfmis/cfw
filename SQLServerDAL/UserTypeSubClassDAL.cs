namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class UserTypeSubClassDAL
    {
        public bool deleteNode(int SubClassID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SubClassID", SqlDbType.Int) };
            parameters[0].Value = SubClassID;
            SQLHelper.RunProcedure("p_UserTypeSubClass_deleteNodeByID", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public List<UserTypeSubClass> getAllUserTypeSubClass()
        {
            List<UserTypeSubClass> list = new List<UserTypeSubClass>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_UserTypeSubClass_getAllUserTypeSubClass", null);
            while (reader.Read())
            {
                UserTypeSubClass item = new UserTypeSubClass();
                item.UserTypeID = reader.GetInt32(reader.GetOrdinal("UserTypeID"));
                item.SubClassID = reader.GetInt32(reader.GetOrdinal("SubClassID"));
                item.SubClassName = reader.GetString(reader.GetOrdinal("SubClassName"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public UserTypeSubClass getByID(int SubClassID)
        {
            UserTypeSubClass class2 = new UserTypeSubClass();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SubClassID", SqlDbType.Int, 4) };
            parameters[0].Value = SubClassID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_UserTypeSubClass_getByID", parameters);
            while (reader.Read())
            {
                class2.SubClassID = reader.GetInt32(reader.GetOrdinal("SubClassID"));
                class2.SubClassName = reader.GetString(reader.GetOrdinal("SubClassName"));
                class2.State = reader.GetString(reader.GetOrdinal("State"));
                class2.UserTypeID = reader.GetInt32(reader.GetOrdinal("UserTypeID"));
            }
            return class2;
        }

        public List<UserTypeSubClass> getSubClassByUserTypeID(int UserTypeID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserTypeID", SqlDbType.Int) };
            parameters[0].Value = UserTypeID;
            List<UserTypeSubClass> list = new List<UserTypeSubClass>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_UserTypeSubClass_getByUserTypeID", parameters);
            while (reader.Read())
            {
                UserTypeSubClass item = new UserTypeSubClass();
                item.UserTypeID = reader.GetInt32(reader.GetOrdinal("UserTypeID"));
                item.SubClassID = reader.GetInt32(reader.GetOrdinal("SubClassID"));
                item.SubClassName = reader.GetString(reader.GetOrdinal("SubClassName"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public bool insertNewUserTypeSubClass(UserTypeSubClass u)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserTypeID", SqlDbType.Int), new SqlParameter("@SubClassName", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.NVarChar) };
            parameters[0].Value = u.UserTypeID;
            parameters[1].Value = u.SubClassName;
            parameters[2].Value = u.State;
            SQLHelper.RunProcedure("p_UserTypeSubClass_insertNewUserTypeSubClass", parameters, out rowsAffected);
            List<Products> list = new List<Products>();
            list = new ProductsDAL().getAllProducts();
            int num2 = -1;
            SqlDataReader reader = SQLHelper.RunProcedure("p_UserTypeSubClass_getLastRecond", null);
            while (reader.Read())
            {
                num2 = reader.GetInt32(reader.GetOrdinal("SubClassID"));
            }
            for (int i = 0; i < list.Count; i++)
            {
                ProductsUserType p = new ProductsUserType();
                Products products = list[i];
                p.Price = products.Price;
                p.ProductsID = products.ProductsID;
                p.SubClassID = num2;
                new ProductsUserTypeDAL().insertNewRecord(p);
            }
            return (1 == rowsAffected);
        }

        public bool updateUserTypeSubClass(UserTypeSubClass u)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@SubClassID", SqlDbType.Int), new SqlParameter("@SubClassName", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.NVarChar) };
            parameters[0].Value = u.SubClassID;
            parameters[1].Value = u.SubClassName;
            parameters[2].Value = u.State;
            SQLHelper.RunProcedure("p_UserTypeSubClass_updateUserTypeSubClass", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }
    }
}

