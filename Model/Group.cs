using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
    public class Group
    {

        private int _GroupID;
        private string _GroupName;
        private string _Description;

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public int GroupID
        {
            get { return _GroupID; }
            set { _GroupID = value; }
        }

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string GroupName
        {
            get { return _GroupName; }
            set { _GroupName = value; }
        }

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

    }
}
///5-1/a/s/pX