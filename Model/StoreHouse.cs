using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class StoreHouse
    {
                private int  _HouseID;
                private string _HouseName;

               
                private string _Phone="";
                private string _UserName ;
                private string _Description="";

       
       
              
   /// <summary>
   /// 库房ID
   /// </summary>
   public int  HouseID
   {
       get { return _HouseID; }
       set { _HouseID = value; }
   }

       /// <summary>
       /// 库房名称
       /// </summary>
   public string HouseName
   {
       get { return _HouseName; }
       set { _HouseName = value; }
   }


       /// <summary>
       /// 库房电话
       /// </summary>
   public string Phone
   {
       get { return _Phone; }
       set { _Phone = value; }
   }


       /// <summary>
       /// 库房管理员标识
       /// </summary>
   public string UserName
   {
       get { return _UserName; }
       set { _UserName = value; }
   }

       /// <summary>
       /// 库房描述
       /// </summary>
   public string Description
   {
       get { return _Description; }
       set { _Description = value; }
   }
         
    }
}
