using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class ProductsUserType
    {
        private int _ID;
        private int  _ProductsID;
       private int _SubClassID;
       private double _Price;

       /// <summary>
       ///  
       /// </summary>
       public int ID
       {
           get { return _ID; }
           set { _ID = value; }
       }
       /// <summary>
       /// 
       /// </summary>
       public int ProductsID
        {
            get { return _ProductsID; }
            set { _ProductsID = value; }
        }

       /// <summary>
       /// 
       /// </summary>
       public int SubClassID
       {
           get { return _SubClassID; }
           set { _SubClassID = value; }
       }

       /// <summary>
       /// 
       /// </summary>
       public double Price
       {
           get { return _Price; }
           set { _Price = value; }
       }

      

    }
}
