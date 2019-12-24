using System;
using System.Collections.Generic;
using System.Text;
using Leyp.SQLServerDAL;
using Leyp.Model;
using System.ComponentModel;

namespace Leyp.BLL
{
    [DataObjectAttribute] 
   public class BUserType
    {
       private UserTypeDAL userTypeDAL = null;
       public BUserType()
       {
           this.userTypeDAL = new UserTypeDAL();
       }
        /// <summary>
        /// 得到所有用户类型
        /// </summary>
        /// <returns></returns>
       public List<UserType> getAllUserType()
       {
           return userTypeDAL.getAllUserType();
       }
  
    }
}
