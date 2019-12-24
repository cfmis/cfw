using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class ProductsStock
    {
       private int _ID;

       private int _HouseDetailID;

       private int _ProductsID;

       private int _Num;

       public int ID
       {
           get { return _ID; }
           set { _ID = value; }
       }

       public int HouseDetailID
       {
           get { return _HouseDetailID; }
           set { _HouseDetailID = value; }
       }



       public int ProductsID
       {
           get { return _ProductsID; }
           set { _ProductsID = value; }
       }



       public int Num
       {
           get { return _Num; }
           set { _Num = value; }
       }


    }
}
