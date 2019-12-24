using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
    public class VSalesOut : SalesOut
    {
        
        private string _RealName;

        /// <summary>
        /// 制单人姓名
        /// </summary>
        public string RealName
        {
            get { return _RealName; }
            set { _RealName = value; }
        }

        private string _DeliveryName;

        /// <summary>
        /// 配送方式
        /// </summary>
        public string DeliveryName
        {
            get { return _DeliveryName; }
            set { _DeliveryName = value; }
        }

    }
}
