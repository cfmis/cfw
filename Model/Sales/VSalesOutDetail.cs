using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
    public class VSalesOutDetail : SalesOutDetail
    {

        private string _ProductsName;

        public string ProductsName
        {
            get { return _ProductsName; }
            set { _ProductsName = value; }
        }

        private string _PhotoUrl;

        public string PhotoUrl
        {
            get { return _PhotoUrl; }
            set { _PhotoUrl = value; }
        }

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
    }
}
