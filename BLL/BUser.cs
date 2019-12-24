using System;
using System.Collections.Generic;
using System.Text;
using Leyp.SQLServerDAL;
using Leyp.Model;
using System.ComponentModel;

namespace Leyp.BLL
{
    public class BUser
    {

        private UserDAL users = null;//数据库操作类
        public BUser()
        {
            this.users = new UserDAL();
        }

        /// <summary>
        /// 添加一个User 实体
        /// </summary>
        /// <param name="u">User 实体</param>
        /// <returns>bool</returns>
        public bool insertNewUser(User u)
        {
            return users.insertNewUser(u);
        }

        /// <summary>
        /// 更新一个用户信息
        /// </summary>
        /// <param name="u"></param>
        /// <returns>bool</returns>
        public bool updateUser(User u)
        {
            return users.updateUser(u);
        }

        /// <summary>
        /// 根据用户名 删除一个用户
        /// </summary>
        /// <param name="LoginName">用户名 /ID</param>
        /// <returns>bool</returns>
        public bool deleteUser(string UserName)
        {

            return users.deleteUser(UserName);
        }


        /// <summary>
        /// 根据用户名 锁定一个用户，即设置State 为N
        /// </summary>
        /// <param name="LoginName">用户名 /ID</param>
        /// <returns>bool</returns>
        public bool lockUser(string UserName)
        {
            return users.lockUser(UserName);
        }

        //----------------------------------------------------------------------------------------

        /// <summary>
        /// 是否已经存在用户名
        /// </summary>
        /// <param name="LoginName">用户名</param>
        /// <returns>bool</returns>
        public bool isExistsUserName(string UserName)
        {
            return users.isExistsUserName(UserName);
        }

        /// <summary>
        /// 根据用户名和密码实现验证，两者都相等是返回真
        /// </summary>
        /// <param name="LoginName">用户名</param>
        /// <param name="PassWord">密码</param>
        /// <returns>bool</returns>
        public bool isLoginValidate(string UserName, string PassWord)
        {
            return users.isLoginValidate(UserName, PassWord);
        }

        /// <summary>
        /// 根据GroupID 得到相应的用户集
        /// </summary>
        /// <param name="GroupID">群ID</param>
        /// <returns>list</returns>
        public List<User> getUserListByGroup(int GroupID)
        {
            return users.getUserListByGroup(GroupID);
        }

        /// <summary>
        /// 根据RealName 搜索得到用户集
        /// </summary>
        /// <param name="RealName">RealName</param>
        /// <returns>list</returns>
        public List<User> getSearchByRealName(string RealName)
        {
            return users.getSearchByRealName(RealName);
        }

        /// <summary>
        /// 返回全部用户
        /// </summary>
        /// <returns>list</returns>
        public List<User> getAllUser()
        {
            return users.getAllUser();

        }

        
        /// <summary>
        /// 返回一个用户实体
        /// </summary>
        /// <param name="UserName">用户ID</param>
        /// <returns></returns>
        public User getByUserName(string UserName)
        {
            return users.getByUserName(UserName);
        }


    }
}
