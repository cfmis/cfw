using System;
using System.Collections.Generic;
using System.Text;
using Leyp.Model.View;
using System.ComponentModel;
using Leyp.SQLServerDAL;

namespace Leyp.BLL.View
{

    [DataObjectAttribute] 
   public class BvUser
    {
       private VuserDAL vuserDAL = null;

       public BvUser()
       {
           this.vuserDAL = new VuserDAL();

       }


       /// <summary>
       /// 的得到所有
       /// </summary>
       /// <returns></returns>
       public List<Vuser> getAllVuser()
       {

           return vuserDAL.getAllVuser();

       }

        /// <summary>
       /// 根据用户类型搜索数据
       /// </summary>
       /// <param name="UserTypeID"></param>
       /// <returns></returns>
       public List<Vuser> getSearchByUserTypeID(int UserTypeID)
       {

           return vuserDAL.getSearchByUserTypeID(UserTypeID);

       }


    }
}
