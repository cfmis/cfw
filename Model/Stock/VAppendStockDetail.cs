using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Stock
{
    public class VAppendStockDetail : AppendStockDetail
    {

        private string _ProductsName;

        public string ProductsName
        {
            get { return _ProductsName; }
            set { _ProductsName = value; }
        }


        private string _SupplierName;

        public string SupplierName
        {
            get { return _SupplierName; }
            set { _SupplierName = value; }
        }
    }
}
