using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
   public class SalesRecord
    {
        private int _ID;

        public int ID
        {
            get { return _ID; }
            set { _ID = value; }
        }

       private int _PlatformID;

       public int PlatformID
       {
           get { return _PlatformID; }
           set { _PlatformID = value; }
       }




       private string _CustomerID;

       public string CustomerID
       {
           get { return _CustomerID; }
           set { _CustomerID = value; }
       }



       private string _SalesOrderID;

       public string SalesOrderID
       {
           get { return _SalesOrderID; }
           set { _SalesOrderID = value; }
       }




       private string _Description;

       public string Description
       {
           get { return _Description; }
           set { _Description = value; }
       }

       private string _CreateDate;

       public string CreateDate
       {
           get { return _CreateDate; }
           set { _CreateDate = value; }
       }

       private string _UserName;

       public string UserName
       {
           get { return _UserName; }
           set { _UserName = value; }
       }



    }
}
