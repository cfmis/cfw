using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class UserTypeSubClass
    {

       private int _SubClassID;
       private int _UserTypeID;
       private string _SubClassName;
       private string _State;
        
       /// <summary>
       /// 数据库字段
       /// </summary>
        public int SubClassID
        {
            get { return _SubClassID; }
            set { _SubClassID = value; }
        }
       
       /// <summary>
        /// 数据库字段
       /// </summary>
        public int UserTypeID
        {
            get { return _UserTypeID; }
            set { _UserTypeID = value; }
        }
 
       /// <summary>
        /// 数据库字段
       /// </summary>
        public string SubClassName
        {
            get { return _SubClassName; }
            set { _SubClassName = value; }
        }
       
       /// <summary>
       /// 数据库字段
       /// </summary>
        public string State
        {
            get { return _State; }
            set { _State = value; }
        }

    }
}
