using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.View
{
   public class VProductsStock : ProductsStock
    {

        private string _ProductsName;

       private string _HouseName;

       private string _SubareaName;

       private int _HouseID;


       /// <summary>
       /// 商品名
       /// </summary>
       public string ProductsName
       {
           get { return _ProductsName; }
           set { _ProductsName = value; }
       }

        /// <summary>
        /// 库房
        /// </summary>
       public string HouseName
       {
           get { return _HouseName; }
           set { _HouseName = value; }
       }

       /// <summary>
       /// 库区
       /// </summary>
       public string SubareaName
       {
           get { return _SubareaName; }
           set { _SubareaName = value; }
       }


       public int HouseID
       {
           get { return _HouseID; }
           set { _HouseID = value; }
       }


    }
}
