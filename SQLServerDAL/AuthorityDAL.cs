namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Data;
    using System.Data.SqlClient;

    [DataObject]
    public class AuthorityDAL
    {
        public List<Authority> getAllAuthority()
        {
            List<Authority> list = new List<Authority>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Authority_getALL", null);
            while (reader.Read())
            {
                Authority item = new Authority();
                item.AuthorityID = reader.GetInt32(reader.GetOrdinal("AuthorityID"));
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.AuthorityName = reader.GetString(reader.GetOrdinal("AuthorityName")).Trim();
                item.ModuleUrl = reader.GetString(reader.GetOrdinal("ModuleUrl")).Trim();
                item.WebUrl = reader.GetString(reader.GetOrdinal("WebUrl")).Trim();
                item.Description = reader.GetString(reader.GetOrdinal("Description")).Trim();
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<Authority> getAuthorityByTypeID(int TypeID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@TypeID", SqlDbType.Int) };
            parameters[0].Value = TypeID;
            List<Authority> list = new List<Authority>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Authority_getAuthorityByTypeID", parameters);
            while (reader.Read())
            {
                Authority item = new Authority();
                item.AuthorityID = reader.GetInt32(reader.GetOrdinal("AuthorityID"));
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.AuthorityName = reader.GetString(reader.GetOrdinal("AuthorityName"));
                item.ModuleUrl = reader.GetString(reader.GetOrdinal("ModuleUrl"));
                item.WebUrl = reader.GetString(reader.GetOrdinal("WebUrl"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public Authority getByID(int AuthorityID)
        {
            Authority authority = new Authority();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@AuthorityID", SqlDbType.Int, 4) };
            parameters[0].Value = AuthorityID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_Authority_getByID", parameters);
            while (reader.Read())
            {
                authority.AuthorityID = reader.GetInt32(reader.GetOrdinal("AuthorityID"));
                authority.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                authority.AuthorityName = reader.GetString(reader.GetOrdinal("AuthorityName"));
                authority.ModuleUrl = reader.GetString(reader.GetOrdinal("ModuleUrl"));
                authority.WebUrl = reader.GetString(reader.GetOrdinal("WebUrl"));
                authority.Description = reader.GetString(reader.GetOrdinal("Description"));
            }
            reader.Close();
            return authority;
        }
    }
}

