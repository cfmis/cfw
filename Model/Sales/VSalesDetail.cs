using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
   public class VSalesDetail : SalesDetail
    {

        private string _ProductsName;

        public string ProductsName
        {
            get { return _ProductsName; }
            set { _ProductsName = value; }
        }
    }
}
