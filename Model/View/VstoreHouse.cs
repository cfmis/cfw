using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.View
{
   public class VstoreHouse:StoreHouseDetail
    {
        private string _HouseName;

        public string HouseName
        {
            get { return _HouseName; }
            set { _HouseName = value; }
        }
    }
}
