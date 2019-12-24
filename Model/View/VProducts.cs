using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.View
{
   public class VProducts :Products
    {

        private string _TypeName;

        public string TypeName
        {
            get { return _TypeName; }
            set { _TypeName = value; }
        }
        private string _BrandName;

        public string BrandName
        {
            get { return _BrandName; }
            set { _BrandName = value; }
        }

    }
}
