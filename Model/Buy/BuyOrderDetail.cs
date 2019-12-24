using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Buy
{
   public class BuyOrderDetail
    {

        private int _DetailID;

       private string _BuyOrderID;

       private int _ProductsID;

       private int _SupplierID;

       private int _Quantity = 0;

       private float _Price = float.Parse("0.00");

       private float _TaxRate = float.Parse("0.00");

       private float _DiscountRate = float.Parse("0.00");

       private string _Description;

      
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
       public string BuyOrderID
       {
           get { return _BuyOrderID; }
           set { _BuyOrderID = value; }
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
       /// 供应商ID
        /// </summary>
       public int SupplierID
       {
           get { return _SupplierID; }
           set { _SupplierID = value; }
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
       /// 税率 %
       /// </summary>
       public float TaxRate
       {
           get { return _TaxRate; }
           set { _TaxRate = value; }
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
