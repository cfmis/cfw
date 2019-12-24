namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data.SqlClient;

    public class UserTypeDAL
    {
        public List<UserType> getAllUserType()
        {
            List<UserType> list = new List<UserType>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_UserType_getAll", null);
            while (reader.Read())
            {
                UserType item = new UserType();
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }
    }
}

