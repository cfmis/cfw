using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class ShopUser
    {
       private int _ID;
       private int  _ShopID;
        private string _UserName;



        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public int  ID
        {
            get { return _ID; }
            set { _ID = value; }
        }

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public int ShopID
        {
            get { return _ShopID; }
            set { _ShopID = value; }
        }



        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }


    }
}
