using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
    public class VSalesRecord : SalesRecord
    {
        private string _PlatformName;

        public string PlatformName
        {
            get { return _PlatformName; }
            set { _PlatformName = value; }
        }
    }
}
