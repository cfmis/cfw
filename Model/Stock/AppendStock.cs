using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Stock
{  
    /// <summary>
    /// 入库表
    /// </summary>
    public class AppendStock
    {
        private string _AppendID;
        private string _CreateDate;
        private int _AppendType;
        private int _StoreHouseID;
        private int _HouseDetailID;
        private string _UserName;
        private string _TradeDate;
        private float _TotalPrice;
        private float _AlreadyPay;
        private string _Description;
        private string _AuditingUser;
        private int _State;


        public string AppendID
        {
            get { return _AppendID; }
            set { _AppendID = value; }
        }
        public string CreateDate
        {
            get { return _CreateDate; }
            set { _CreateDate = value; }
        }

        public int AppendType
        {
            get { return _AppendType; }
            set { _AppendType = value; }
        }


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


        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }

        ////////////////////////////////////////////////////////

        public string TradeDate
        {
            get { return _TradeDate; }
            set { _TradeDate = value; }
        }


        public float TotalPrice
        {
            get { return _TotalPrice; }
            set { _TotalPrice = value; }
        }


        public float AlreadyPay
        {
            get { return _AlreadyPay; }
            set { _AlreadyPay = value; }
        }

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        public string AuditingUser
        {
            get { return _AuditingUser; }
            set { _AuditingUser = value; }
        }

        //////////////////////////////////////////////////////////
        public int  State
        {
            get { return _State; }
            set { _State = value; }
        }

    }
  
}
