using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class Log
    {
        private int _LogID;
        private string _LogTime;
        private string _Description;

       /// <summary>
        /// 对应数据库表字段 LogID
       /// </summary>
        public int LogID
        {
            get { return _LogID; }
            set { _LogID = value; }
        }
       /// <summary>
        /// 对应数据库表字段 LogTime
       /// </summary>
       public string LogTime
       {
           get { return _LogTime; }
           set { _LogTime = value; }
       }
       /// <summary>
       /// 对应数据库表字段 Description
       /// </summary>
       public string Description
       {
           get { return _Description; }
           set { _Description = value; }
       }


    }
}
