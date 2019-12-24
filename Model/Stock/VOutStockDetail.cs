using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Stock
{
    public class VOutStockDetail : OutStockDetail
    {
        private string _ProductsName;

        public string ProductsName
        {
            get { return _ProductsName; }
            set { _ProductsName = value; }
        }


       
    }
}
