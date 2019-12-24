namespace Leyp.SQLServerDAL
{
    using Leyp.Model.View;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class VuserDAL
    {
        public List<Vuser> getAllVuser()
        {
            List<Vuser> list = new List<Vuser>();
            SqlDataReader reader = SQLHelper.RunProcedure("pv_vUser_getAll", null);
            while (reader.Read())
            {
                Vuser item = new Vuser();
                item.Dept = reader.GetString(reader.GetOrdinal("Dept"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.Email = reader.GetString(reader.GetOrdinal("Email"));
                item.GroupID = reader.GetInt32(reader.GetOrdinal("GroupID"));
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.SubClassID = reader.GetInt32(reader.GetOrdinal("SubClassID"));
                item.QQ = reader.GetString(reader.GetOrdinal("QQ"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.Password = reader.GetString(reader.GetOrdinal("Password"));
                item.Sex = reader.GetString(reader.GetOrdinal("Sex"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                item.WangWang = reader.GetString(reader.GetOrdinal("WangWang"));
                item.Tel = reader.GetString(reader.GetOrdinal("Tel"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                item.SubClassName = reader.GetString(reader.GetOrdinal("SubClassName"));
                item.GroupName = reader.GetString(reader.GetOrdinal("GroupName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<Vuser> getSearchByUserTypeID(int UserTypeID)
        {
            List<Vuser> list = new List<Vuser>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserTypeID", SqlDbType.Int, 4) };
            parameters[0].Value = UserTypeID;
            SqlDataReader reader = SQLHelper.RunProcedure("pv_vUser_SearchByUserType", parameters);
            while (reader.Read())
            {
                Vuser item = new Vuser();
                item.Dept = reader.GetString(reader.GetOrdinal("Dept"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.Email = reader.GetString(reader.GetOrdinal("Email"));
                item.GroupID = reader.GetInt32(reader.GetOrdinal("GroupID"));
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.SubClassID = reader.GetInt32(reader.GetOrdinal("SubClassID"));
                item.QQ = reader.GetString(reader.GetOrdinal("QQ"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.Password = reader.GetString(reader.GetOrdinal("Password"));
                item.Sex = reader.GetString(reader.GetOrdinal("Sex"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                item.WangWang = reader.GetString(reader.GetOrdinal("WangWang"));
                item.Tel = reader.GetString(reader.GetOrdinal("Tel"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                item.SubClassName = reader.GetString(reader.GetOrdinal("SubClassName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public List<Vuser> getSearchUser(string key, int UserTypeID, int SubClassID)
        {
            List<Vuser> list = new List<Vuser>();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Key", SqlDbType.NVarChar), new SqlParameter("@UserTypeID", SqlDbType.Int), new SqlParameter("@SubClassID", SqlDbType.Int) };
            parameters[0].Value = key;
            parameters[1].Value = UserTypeID;
            parameters[2].Value = SubClassID;
            SqlDataReader reader = SQLHelper.RunProcedure("pv_vUser_SearchList", parameters);
            while (reader.Read())
            {
                Vuser item = new Vuser();
                item.Dept = reader.GetString(reader.GetOrdinal("Dept"));
                item.Description = reader.GetString(reader.GetOrdinal("Description"));
                item.Email = reader.GetString(reader.GetOrdinal("Email"));
                item.GroupID = reader.GetInt32(reader.GetOrdinal("GroupID"));
                item.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                item.SubClassID = reader.GetInt32(reader.GetOrdinal("SubClassID"));
                item.QQ = reader.GetString(reader.GetOrdinal("QQ"));
                item.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                item.Password = reader.GetString(reader.GetOrdinal("Password"));
                item.Sex = reader.GetString(reader.GetOrdinal("Sex"));
                item.State = reader.GetString(reader.GetOrdinal("State"));
                item.WangWang = reader.GetString(reader.GetOrdinal("WangWang"));
                item.Tel = reader.GetString(reader.GetOrdinal("Tel"));
                item.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                item.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                item.SubClassName = reader.GetString(reader.GetOrdinal("SubClassName"));
                list.Add(item);
            }
            reader.Close();
            return list;
        }

        public Vuser getUserViewByID(string UserName)
        {
            Vuser vuser = new Vuser();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = UserName;
            SqlDataReader reader = SQLHelper.RunProcedure("pv_vUser_getByUserName", parameters);
            while (reader.Read())
            {
                vuser.Dept = reader.GetString(reader.GetOrdinal("Dept"));
                vuser.Description = reader.GetString(reader.GetOrdinal("Description"));
                vuser.Email = reader.GetString(reader.GetOrdinal("Email"));
                vuser.GroupID = reader.GetInt32(reader.GetOrdinal("GroupID"));
                vuser.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                vuser.SubClassID = reader.GetInt32(reader.GetOrdinal("SubClassID"));
                vuser.QQ = reader.GetString(reader.GetOrdinal("QQ"));
                vuser.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                vuser.Password = reader.GetString(reader.GetOrdinal("Password"));
                vuser.Sex = reader.GetString(reader.GetOrdinal("Sex"));
                vuser.State = reader.GetString(reader.GetOrdinal("State"));
                vuser.WangWang = reader.GetString(reader.GetOrdinal("WangWang"));
                vuser.Tel = reader.GetString(reader.GetOrdinal("Tel"));
                vuser.UserName = reader.GetString(reader.GetOrdinal("UserName"));
                vuser.TypeName = reader.GetString(reader.GetOrdinal("TypeName"));
                vuser.SubClassName = reader.GetString(reader.GetOrdinal("SubClassName"));
                vuser.GroupName = reader.GetString(reader.GetOrdinal("GroupName"));
                vuser.Address = reader.GetString(reader.GetOrdinal("Address"));
                vuser.BankAccount = reader.GetString(reader.GetOrdinal("BankAccount"));
                vuser.Bankname = reader.GetString(reader.GetOrdinal("Bankname"));
                vuser.Character = reader.GetString(reader.GetOrdinal("Character"));
                vuser.CompanyInfo = reader.GetString(reader.GetOrdinal("CompanyInfo"));
                vuser.CompanyName = reader.GetString(reader.GetOrdinal("CompanyName"));
                vuser.LatelyLogin = reader.GetString(reader.GetOrdinal("LatelyLogin"));
            }
            return vuser;
        }
    }
}

