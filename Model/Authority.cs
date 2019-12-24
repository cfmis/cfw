using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
    public class Authority
    {
        private int  _AuthorityID;
        private int _TypeID;
        private string _AuthorityName;
        private string _ModuleUrl;
        private string _WebUrl;
        private string _Description;

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public int  AuthorityID
        {
            get { return _AuthorityID; }
            set { _AuthorityID = value; }
        }

         /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public int TypeID
        {
            get { return _TypeID; }
            set { _TypeID = value; }
        }



        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string AuthorityName
        {
            get { return _AuthorityName; }
            set { _AuthorityName = value; }
        }

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string ModuleUrl
        {
            get { return _ModuleUrl; }
            set { _ModuleUrl = value; }
        }


        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string WebUrl
        {
            get { return _WebUrl; }
            set { _WebUrl = value; }
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
