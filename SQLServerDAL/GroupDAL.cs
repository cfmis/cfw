namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.Data;
    using System.Data.SqlClient;

    [DataObject]
    public class GroupDAL
    {
        private GroupAuthorityDAL groupAuthorityDAL = null;

        public GroupDAL()
        {
            this.groupAuthorityDAL = new GroupAuthorityDAL();
        }

        public bool deleteNode(int GroupID)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@GroupID", SqlDbType.Int, 4) };
            parameters[0].Value = GroupID;
            SQLHelper.RunProcedure("p_Group_deleteNode", parameters, out rowsAffected);
            return (0 < rowsAffected);
        }

        public List<Group> getAllGroup()
        {
            List<Group> list = new List<Group>();
            SqlDataReader reader = SQLHelper.RunProcedure("p_Group_getALL", null);
            while (reader.Read())
            {
                Group item = new Group();
                item.GroupID = reader.GetInt32(reader.GetOrdinal("GroupID"));
                item.GroupName = reader.GetString(reader.GetOrdinal("GroupName"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public Group getByGroupID(int GroupID)
        {
            Group group = new Group();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@GroupID", SqlDbType.Int, 4) };
            parameters[0].Value = GroupID;
            SqlDataReader reader = SQLHelper.RunProcedure("p_Group_getByID", parameters);
            while (reader.Read())
            {
                group.GroupID = reader.GetInt32(reader.GetOrdinal("GroupID"));
                group.GroupName = reader.GetString(reader.GetOrdinal("GroupName"));
                group.Description = reader.GetString(reader.GetOrdinal("Description"));
            }
            return group;
        }

        public void insertGroupAuthority(int GroupID, int[] a)
        {
            for (int i = 0; i < a.Length; i++)
            {
                GroupAuthority g = new GroupAuthority();
                g.GroupID = GroupID;
                g.AuthorityID = a[i];
                this.groupAuthorityDAL.insertNode(g);
            }
        }

        public bool insertNewGroup(Group g)
        {
            SqlParameter[] commandParameters = new SqlParameter[] { new SqlParameter("@GroupName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
            commandParameters[0].Value = g.GroupName;
            commandParameters[1].Value = g.Description;
            return (SQLHelper.ExecuteNonQuery(SQLHelper.strCon, CommandType.StoredProcedure, "p_Group_insertNewGroup", commandParameters) == 1);
        }

        public bool updateGroup(Group g, int[] a)
        {
            try
            {
                SqlParameter[] commandParameters = new SqlParameter[] { new SqlParameter("@GroupID", SqlDbType.Int, 4), new SqlParameter("@GroupName", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar) };
                commandParameters[0].Value = g.GroupID;
                commandParameters[1].Value = g.GroupName;
                commandParameters[2].Value = g.Description;
                int num = SQLHelper.ExecuteNonQuery(SQLHelper.strCon, CommandType.StoredProcedure, "p_Group_update", commandParameters);
                this.insertGroupAuthority(g.GroupID, a);
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}

