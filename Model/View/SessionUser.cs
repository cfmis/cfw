using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.View
{ 
    /// <summary>
    /// 保存在Session 中的用户实体
    /// </summary>
   public class SessionUser
    {
       public string _UserName;
       public int _GroupID;
       private int _SubClassID;

     
       public int _TypeID;
       public string _Lang;

        /// <summary>
        /// 用户的ID
        /// </summary>
        public string UserName
       {
           get { return _UserName; }
           set { _UserName = value; }
       }


       /// <summary>
       ///用户的群ID
       /// </summary>
       public int GroupID
       {
           get { return _GroupID; }
           set { _GroupID = value; }
       }

       /// <summary>
       /// 二级用户类型ID
       /// </summary>
       public int SubClassID
       {
           get { return _SubClassID; }
           set { _SubClassID = value; }
       }

       /// <summary>
       /// 用户的类型 ID
       /// </summary>
       public int TypeID
       {
           get { return _TypeID; }
           set { _TypeID = value; }
       }

        /// <summary>
        /// 語言
        /// </summary>
        public string Lang
        {
            get { return _Lang; }
            set { _Lang = value; }
        }

    }
}
