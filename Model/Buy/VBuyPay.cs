using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Buy
{
    public class VBuyPay : BuyPay
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
    }
}
