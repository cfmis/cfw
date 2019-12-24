using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Buy
{
   public class BuyOrder
    {
           private string _BuyOrderID;
           private string _BuyOrderDate;
           private int _StoreHouseID;
           private int _HouseDetailID;
           private string _Delegate;
       private string _UserName;
       private float _TotalPrice = float.Parse("0.00");
       private string _SignDate;
       private string _TradeDate;
   private string _TradeAddress;
   private int _Identitys = 0;
   private string _Description;
   private int _State = 0;
      
       /// <summary>
       /// 
       /// </summary>
       public string BuyOrderID
       {
           get { return _BuyOrderID; }
           set { _BuyOrderID = value; }
       }
        /// <summary>
       /// 制单日期
        /// </summary>
       public string BuyOrderDate
       {
           get { return _BuyOrderDate; }
           set { _BuyOrderDate = value; }
       }
       /// <summary>
       /// 对应仓库ID（采购决定仓库
       /// </summary>

       public int StoreHouseID
       {
           get { return _StoreHouseID; }
           set { _StoreHouseID = value; }
       }
      /// <summary>
       /// 对应仓库分区
      /// </summary>
       public int HouseDetailID
       {
           get { return _HouseDetailID; }
           set { _HouseDetailID = value; }
       }
           /// <summary>
            /// 业务代表
           /// </summary>
       public string Delegate
       {
           get { return _Delegate; }
           set { _Delegate = value; }
       }

  /////////////////////////////////////////////////////////////////////////////
     
       /// <summary>
       /// 制单人
       /// </summary>
       public string UserName
       {
           get { return _UserName; }
           set { _UserName = value; }
       }


        /// <summary>
       /// 合计金额
        /// </summary>
       public float TotalPrice 
       {
           get { return _TotalPrice; }
           set { _TotalPrice = value; }
       }
        
       /// <summary>
       /// 签订日期
       /// </summary>
       public string SignDate
       {
           get { return _SignDate; }
           set { _SignDate = value; }
       }


        /// <summary>
        /// 
       /// 交货日期
        /// </summary>
       public string TradeDate
       {
           get { return _TradeDate; }
           set { _TradeDate = value; }
       }



   


       /// <summary>
       /// 交货地址
       /// </summary>
       public string TradeAddress
       {
           get { return _TradeAddress; }
           set { _TradeAddress = value; }
       }


       public int Identitys
       {
           get { return _Identitys; }
           set { _Identitys = value; }
       }


       
       /// <summary>
       /// 描述
       /// </summary>
       public string Description
       {
           get { return _Description; }
           set { _Description = value; }
       }


       public int  State
       {
           get { return _State; }
           set { _State = value; }
       }


    }
}
