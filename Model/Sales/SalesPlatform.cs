using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
   public class SalesPlatform
    {

        private int _PlatformID;

        public int PlatformID
        {
            get { return _PlatformID; }
            set { _PlatformID = value; }
        }

       private string _PlatformName;

       public string PlatformName
       {
           get { return _PlatformName; }
           set { _PlatformName = value; }
       }

       private string _Description;

       public string Description
       {
           get { return _Description; }
           set { _Description = value; }
       }


    }
}
