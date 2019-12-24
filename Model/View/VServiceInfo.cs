using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.View
{
   public class VServiceInfo : ServiceInfo
    {
        private string _ServiceName;

        public string ServiceName
        {
            get { return _ServiceName; }
            set { _ServiceName = value; }
        }

       private string _RealName;

        /// <summary>
        /// 制单人姓名
        /// </summary>
        public string RealName
        {
            get { return _RealName; }
            set { _RealName = value; }
        }

    }
}
