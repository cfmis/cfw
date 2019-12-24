namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Data;
    using System.Data.SqlClient;

    [DataObject]
    public class GroupAuthorityDAL
    {
        public List<GroupAuthority> getALLGroupAuthorityByGroupID(int GroupID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@GroupID", SqlDbType.Int, 4) };
            parameters[0].Value = GroupID;
            List<GroupAuthority> list = new List<GroupAuthority>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_GroupAuthority_getAll_ByGroupID", parameters);
            while (reader.Read())
            {
                GroupAuthority item = new GroupAuthority();
                item.ID = reader.GetInt32(reader.GetOrdinal("ID"));
                item.AuthorityID = reader.GetInt32(reader.GetOrdinal("AuthorityID"));
                item.GroupID = reader.GetInt32(reader.GetOrdinal("GroupID"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public void insertNode(GroupAuthority g)
        {
            SqlParameter[] commandParameters = new SqlParameter[] { new SqlParameter("@GroupID", SqlDbType.Int, 4), new SqlParameter("@AuthorityID", SqlDbType.Int, 4) };
            commandParameters[0].Value = g.GroupID;
            commandParameters[1].Value = g.AuthorityID;
            int num = SQLHelper.ExecuteNonQuery(SQLHelper.strCon, CommandType.StoredProcedure, "p_GroupAuthority_insertNewNode", commandParameters);
        }

        public bool validataAuthorityAndGroupID(string ModuleName, int GroupID)
        {
            bool flag = false;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@ModuleUrl", SqlDbType.NVarChar), new SqlParameter("@GroupID", SqlDbType.Int) };
            parameters[0].Value = ModuleName;
            parameters[1].Value = GroupID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_GroupAuthority_validataModule", parameters);
            while (reader.Read())
            {
                flag = true;
            }
            return flag;
        }
    }
}

