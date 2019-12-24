using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
   public class SalesOutDetail
    {
        private int _DetailID;

       private string _SalesOutID;

        private int _ProductsID;

        private int _Quantity = 0;

        private int _StoreHouseID;

     

        private int _HouseDetailID;
        private float _Price = float.Parse("0.00");

        private float _DiscountRate = float.Parse("0.00");

        private string _Description;



       public int StoreHouseID
       {
           get { return _StoreHouseID; }
           set { _StoreHouseID = value; }
       }

       public int HouseDetailID
       {
           get { return _HouseDetailID; }
           set { _HouseDetailID = value; }
       }

        /// <summary>
        /// 标识主键
        /// </summary>
        public int DetailID
        {
            get { return _DetailID; }
            set { _DetailID = value; }
        }

        /// <summary>
        /// 对应简明表ID
        /// </summary>
       public string SalesOutID
        {
            get { return _SalesOutID; }
            set { _SalesOutID = value; }
        }

        /// <summary>
        /// 商品ID
        /// </summary>
        public int ProductsID
        {
            get { return _ProductsID; }
            set { _ProductsID = value; }
        }





        /// <summary>
        /// 数量
        /// </summary>
        public int Quantity
        {
            get { return _Quantity; }
            set { _Quantity = value; }
        }




        /////////////////////////////////////////////////////////////////////////////

        /// <summary>
        /// 标准价
        /// </summary>
        public float Price
        {
            get { return _Price; }
            set { _Price = value; }
        }



        /// <summary>
        /// 折扣率 %
        /// </summary>
        public float DiscountRate
        {
            get { return _DiscountRate; }
            set { _DiscountRate = value; }
        }


        /// <summary>
        /// 摘要
        /// </summary>
        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }


    }
}
