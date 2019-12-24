using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Buy
{
   public class BuyReturn
    {
       private string _BuyReturnID;
       private string _BuyReturnDate;
        private int _StoreHouseID;
        private int _HouseDetailID;
       private string _ReceiptOrderID = "";
        private string _UserName;
        private float _TotalPrice = float.Parse("0.00");
        private float _AlreadyPay = float.Parse("0.00");


        private string _TradeDate;

        private int _Identitys = 0;
        private string _Description;

        private int _State = 0;


        /// <summary>
        /// 
        /// </summary>
       public string BuyReturnID
        {
            get { return _BuyReturnID; }
            set { _BuyReturnID = value; }
        }
        /// <summary>
        /// 制单日期
        /// </summary>
       public string BuyReturnDate
        {
            get { return _BuyReturnDate; }
            set { _BuyReturnDate = value; }
        }
        /// <summary>
        /// 对应仓库ID（
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
        /// 对应采购订单
        /// </summary>
       public string ReceiptOrderID
        {
            get { return _ReceiptOrderID; }
            set { _ReceiptOrderID = value; }
        }


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
        /// 已经支付
        /// </summary>
        public float AlreadyPay
        {
            get { return _AlreadyPay; }
            set { _AlreadyPay = value; }
        }

        /// <summary>
        /// 
        /// 入库日期
        /// </summary>
        public string TradeDate
        {
            get { return _TradeDate; }
            set { _TradeDate = value; }
        }






        /// <summary>
        /// 直接退货1 按进货单0 默认0
        /// </summary>
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



        /// <summary>
        /// 
        /// </summary>
        public int State
        {
            get { return _State; }
            set { _State = value; }
        }
    }
}
