using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class UserType
    {
       private int _TypeID;
       private string _TypeName;
       private string _State;

       /// <summary>
       /// 对应数据库表字段 一样名称
       /// </summary>
       public int  TypeID
       {
           get { return _TypeID; }
           set { _TypeID = value; }
       }


       /// <summary>
       /// 对应数据库表字段 一样名称
       /// </summary>
       public string TypeName
       {
           get { return _TypeName; }
           set { _TypeName = value; }
       }


       /// <summary>
       /// 对应数据库表字段 一样名称
       /// </summary>
       public string State
       {
           get { return _State; }
           set { _State = value; }
       }


    }
}
