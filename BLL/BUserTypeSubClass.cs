using System;
using System.Collections.Generic;
using System.Text;
using Leyp.SQLServerDAL;
using Leyp.Model;
using System.ComponentModel;

namespace Leyp.BLL
{
    [DataObjectAttribute] 
   public class BUserTypeSubClass
    {
       private UserTypeSubClassDAL userTypeSubClassDAL = null;
       public BUserTypeSubClass()
       {
           userTypeSubClassDAL = new UserTypeSubClassDAL();
       }


       /// <summary>
       /// 添加一个新的子类
       /// </summary>
       /// <param name="g"></param>
       /// <returns></returns>
       public bool insertNewUserTypeSubClass(UserTypeSubClass u)
       {
           return userTypeSubClassDAL.insertNewUserTypeSubClass(u);
          
       }

       /// <summary>
       /// 根据上级ID 得到实体列表
       /// </summary>
       /// <param name="UserTypeID"></param>
       /// <returns>list</returns>
       public List<UserTypeSubClass> getSubClassByUserTypeID(int UserTypeID)
       {
           return userTypeSubClassDAL.getSubClassByUserTypeID(UserTypeID);

       }


        /// <summary>
        /// 返回全部
        /// </summary>
        /// <returns></returns>

       public List<UserTypeSubClass> getAllUserTypeSubClass()
       {

           return userTypeSubClassDAL.getAllUserTypeSubClass();

       }

        /// <summary>
       /// 返回一个实体 UserTypeSubClass
        /// </summary>
        /// <returns></returns>
       public UserTypeSubClass getByID(int SubClassID)
       {
           return userTypeSubClassDAL.getByID(SubClassID);
       
       }


    }
}
