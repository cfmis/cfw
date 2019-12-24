using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
    public class VSalesReturn : SalesReturn
    {

        private string _HouseName;

        /// <summary>
        /// 仓库
        /// </summary>
        public string HouseName
        {
            get { return _HouseName; }
            set { _HouseName = value; }
        }

        private string _SubareaName;

        /// <summary>
        /// 库区名称
        /// </summary>
        public string SubareaName
        {
            get { return _SubareaName; }
            set { _SubareaName = value; }
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
