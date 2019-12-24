
namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;
    

    public class UserDAL
    {
        public bool deleteUser(string UserName)
        {
            SqlParameter[] commandParameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar) };
            commandParameters[0].Value = UserName;
            int num = SQLHelper.ExecuteNonQuery(SQLHelper.strCon, CommandType.StoredProcedure, "p_user_deleateUser", commandParameters);
            return (1 == num);
        }

        public List<User> getAllUser()
        {
            return null;
        }

        public User getByUserName(string UserName)
        {
            User user = new User();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = UserName;
            SqlDataReader reader = SQLHelper.RunProcedure("p_user_getByUserName", parameters);
            while (reader.Read())
            {
                user.Dept = reader.GetString(reader.GetOrdinal("Dept"));
                user.Description = reader.GetString(reader.GetOrdinal("Description"));
                user.Email = reader.GetString(reader.GetOrdinal("Email"));
                user.GroupID = reader.GetInt32(reader.GetOrdinal("GroupID"));
                user.TypeID = reader.GetInt32(reader.GetOrdinal("TypeID"));
                user.SubClassID = reader.GetInt32(reader.GetOrdinal("SubClassID"));
                user.QQ = reader.GetString(reader.GetOrdinal("QQ"));
                user.RealName = reader.GetString(reader.GetOrdinal("RealName"));
                user.Password = reader.GetString(reader.GetOrdinal("Password"));
                user.Sex = reader.GetString(reader.GetOrdinal("Sex"));
                user.State = reader.GetString(reader.GetOrdinal("State"));
                user.WangWang = reader.GetString(reader.GetOrdinal("WangWang"));
                user.Tel = reader.GetString(reader.GetOrdinal("Tel"));
                user.UserName = reader.GetString(reader.GetOrdinal("UserName"));
            }
            return user;
        }

        public User getUserInfo(string uname)
        {
            SQLHelp sh = new SQLHelp();
            User user = new User();
            string strSql = "Select uname,uname_desc,t_TypeID,t_SubClassID,t_GroupID,pwd,email,qq,rid_oa,language From tb_sy_user Where uname ='" + uname + "'";
            DataTable dtUser = sh.ExecuteSqlReturnDataTable(strSql);
            if (dtUser.Rows.Count > 0)
            {
                DataRow dr = dtUser.Rows[0];
                user.Dept = "";
                user.Description = dr["uname_desc"].ToString();
                user.Email = dr["uname"].ToString().Trim() + "@chingfung.com";
                user.GroupID = Convert.ToInt32(dr["t_GroupID"]);// Convert.ToInt32(dr["user_id"].ToString());
                user.TypeID = Convert.ToInt32(dr["t_TypeID"]);
                user.SubClassID = Convert.ToInt32(dr["t_SubClassID"]);
                user.QQ = dr["qq"].ToString();
                user.RealName = dr["uname_desc"].ToString();
                user.Password = dr["pwd"].ToString();
                user.Sex = "";
                user.State = "Y";
                user.WangWang = "";
                user.Tel = "";
                user.UserName = dr["uname"].ToString().Trim();
                user.Lang = dr["language"].ToString().Trim();
            }
            return user;
        }

        public List<User> getSearchByRealName(string RealName)
        {
            return null;
        }

        public List<User> getUserListByGroup(int GroupID)
        {
            return null;
        }

        public bool insertNewUser(User u)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@Password", SqlDbType.NVarChar), new SqlParameter("@TypeID", SqlDbType.Int, 4), new SqlParameter("@RealName", SqlDbType.NVarChar), new SqlParameter("@Sex", SqlDbType.NVarChar), new SqlParameter("@GroupID", SqlDbType.Int), new SqlParameter("@Tel", SqlDbType.NVarChar), new SqlParameter("@Email", SqlDbType.NVarChar), new SqlParameter("@QQ", SqlDbType.NVarChar), new SqlParameter("@WangWang", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.NVarChar), new SqlParameter("@Dept", SqlDbType.NVarChar), new SqlParameter("@SubClassID", SqlDbType.Int), new SqlParameter("@Character", SqlDbType.NVarChar), new SqlParameter("@Address", SqlDbType.NVarChar), 
                new SqlParameter("@CompanyName", SqlDbType.NVarChar), new SqlParameter("@CompanyInfo", SqlDbType.NVarChar), new SqlParameter("@Bankname", SqlDbType.NVarChar), new SqlParameter("@BankAccount", SqlDbType.NVarChar), new SqlParameter("@LatelyLogin", SqlDbType.NVarChar)
             };
            parameters[0].Value = u.UserName;
            parameters[1].Value = u.Password;
            parameters[2].Value = u.TypeID;
            parameters[3].Value = u.RealName;
            parameters[4].Value = u.Sex;
            parameters[5].Value = u.GroupID;
            parameters[6].Value = u.Tel;
            parameters[7].Value = u.Email;
            parameters[8].Value = u.QQ;
            parameters[9].Value = u.WangWang;
            parameters[10].Value = u.Description;
            parameters[11].Value = u.State;
            parameters[12].Value = u.Dept;
            parameters[13].Value = u.SubClassID;
            parameters[14].Value = u.Character;
            parameters[15].Value = u.Address;
            parameters[0x10].Value = u.CompanyName;
            parameters[0x11].Value = u.CompanyInfo;
            parameters[0x12].Value = u.Bankname;
            parameters[0x13].Value = u.BankAccount;
            SQLHelper.RunProcedure("p_user_insertNewUser", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool isExistsUserName(string UserName)
        {
            bool flag = false;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = UserName;
            SqlDataReader reader = SQLHelper.RunProcedure("p_user_isExistsUserName", parameters);
            while (reader.Read())
            {
                flag = true;
            }
            return flag;
        }

        public bool isLoginValidate(string UserName, string PassWord)
        {
            if (this.isExistsUserName(UserName))
            {
                User user = this.getByUserName(UserName);
                if (PassWord.Equals(user.Password))
                {
                    if (user.State.Equals("N"))
                    {
                        return false;
                    }
                    return true;
                }
                return false;
            }
            return false;
        }
        public bool isLoginValid(string uname, string password)
        {
            SQLHelp sh = new SQLHelp();
            PublicAppDAL pba = new PublicAppDAL();

            string strSql = "Select user_id,user_name,password From dgerp2.cferp.dbo.sys_user Where user_id ='" + uname + "' and typeid ='U'";
            DataTable dtUser = sh.ExecuteSqlReturnDataTable(strSql);
            if (dtUser.Rows.Count > 0)
            {
                if (pba.GeoEncrypt(password) == dtUser.Rows[0]["password"].ToString())//dr.GetString(dr.GetOrdinal("password")))
                    return true;
                else
                    return false;
            }
            return false;
        }
        public bool lockUser(string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = UserName;
            int num2 = SQLHelper.RunProcedure("p_user_lockUser", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool resetPassWord(string oldPwd, string newPwd, string UserName)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@oldPwd", SqlDbType.NVarChar), new SqlParameter("@newPwd", SqlDbType.NVarChar), new SqlParameter("@UserName", SqlDbType.NVarChar) };
            parameters[0].Value = oldPwd;
            parameters[1].Value = newPwd;
            parameters[2].Value = UserName;
            SQLHelper.RunProcedure("p_user_resetPassword", parameters, out rowsAffected);
            return (1 == rowsAffected);
        }

        public bool updateUser(User u)
        {
            int rowsAffected = 0;
            SqlParameter[] parameters = new SqlParameter[] { 
                new SqlParameter("@UserName", SqlDbType.NVarChar), new SqlParameter("@TypeID", SqlDbType.Int, 4), new SqlParameter("@RealName", SqlDbType.NVarChar), new SqlParameter("@Sex", SqlDbType.NVarChar), new SqlParameter("@GroupID", SqlDbType.Int), new SqlParameter("@Tel", SqlDbType.NVarChar), new SqlParameter("@Email", SqlDbType.NVarChar), new SqlParameter("@QQ", SqlDbType.NVarChar), new SqlParameter("@WangWang", SqlDbType.NVarChar), new SqlParameter("@Description", SqlDbType.NVarChar), new SqlParameter("@State", SqlDbType.NVarChar), new SqlParameter("@SubClassID", SqlDbType.Int), new SqlParameter("@Character", SqlDbType.NVarChar), new SqlParameter("@Address", SqlDbType.NVarChar), new SqlParameter("@CompanyName", SqlDbType.NVarChar), new SqlParameter("@CompanyInfo", SqlDbType.NVarChar), 
                new SqlParameter("@Bankname", SqlDbType.NVarChar), new SqlParameter("@BankAccount", SqlDbType.NVarChar), new SqlParameter("@LatelyLogin", SqlDbType.NVarChar)
             };
            parameters[0].Value = u.UserName;
            parameters[1].Value = u.TypeID;
            parameters[2].Value = u.RealName;
            parameters[3].Value = u.Sex;
            parameters[4].Value = u.GroupID;
            parameters[5].Value = u.Tel;
            parameters[6].Value = u.Email;
            parameters[7].Value = u.QQ;
            parameters[8].Value = u.WangWang;
            parameters[9].Value = u.Description;
            parameters[10].Value = u.State;
            parameters[11].Value = u.SubClassID;
            parameters[12].Value = u.Character;
            parameters[13].Value = u.Address;
            parameters[14].Value = u.CompanyName;
            parameters[15].Value = u.CompanyInfo;
            parameters[0x10].Value = u.Bankname;
            parameters[0x11].Value = u.BankAccount;
            int num2 = SQLHelper.RunProcedure("p_user_UpdateUser", parameters, out rowsAffected);
            return (1 == num2);
        }
    }
}

