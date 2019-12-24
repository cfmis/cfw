using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Stock
{
  public  class VTransferringOrder : TransferringOrder
    {
        private string _ProductsName;

        public string ProductsName
        {
            get { return _ProductsName; }
            set { _ProductsName = value; }
        }
        private string _RealName;

        public string RealName
        {
            get { return _RealName; }
            set { _RealName = value; }
        }

      private string _OutHouseName;

        /// <summary>
        /// Out仓库
        /// </summary>
        public string OutHouseName
        {
            get { return _OutHouseName; }
            set { _OutHouseName = value; }
        }

      private string _OutSubareaName;

        /// <summary>
        /// Out库区名称
        /// </summary>
        public string OutSubareaName
        {
            get { return _OutSubareaName; }
            set { _OutSubareaName = value; }
        }


      private string _InHouseName;

        /// <summary>
        /// In仓库
        /// </summary>
      public string InHouseName
        {
            get { return _InHouseName; }
            set { _InHouseName = value; }
        }

      private string _InSubareaName;

        /// <summary>
        /// Out库区名称
        /// </summary>
      public string InSubareaName
        {
            get { return _InSubareaName; }
            set { _InSubareaName = value; }
        }
    }
}
