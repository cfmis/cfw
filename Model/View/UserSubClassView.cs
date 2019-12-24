using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.View
{
   public class UserSubClassView : UserTypeSubClass
    {


        private string _TypeName="";

        /// <summary>
        /// 组成视图 实现基类UserType 的TypeName
        /// </summary>
        public string TypeName
        {
            get { return _TypeName; }
            set { _TypeName = value; }
        }
    }
}
