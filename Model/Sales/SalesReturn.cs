using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{  

    /// <summary>
    /// 对应数据表
    /// </summary>
   public  class SalesReturn
    {

       private string _SalesReturnID;
       private string _SalesOutID;
        private string _CreateDate;

       private string _ReturnType;

       private int _StoreHouseID;
       private int _HouseDetailID;
       private string _TradeDate;
       private float _TotalPrice;
       private float _Deposits;
        private string _UserName;
        private string _AuditingUser;
        private string _Description;
        private int _State;


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


        #region


       public string SalesOutID
       {
           get { return _SalesOutID; }
           set { _SalesOutID = value; }
       }


       public string SalesReturnID
        {
            get { return _SalesReturnID; }
            set { _SalesReturnID = value; }
        }



        public string CreateDate
        {
            get { return _CreateDate; }
            set { _CreateDate = value; }
        }



       public string ReturnType
        {
            get { return _ReturnType; }
            set { _ReturnType = value; }
        }

     



        ////////////////////////////////////


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



       public float Deposits
        {
            get { return _Deposits; }
            set { _Deposits = value; }


        }


       


        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }


        }


        public string AuditingUser
        {
            get { return _AuditingUser; }
            set { _AuditingUser = value; }


        }


        public string Description
        {
            get { return _Description; }
            set { _Description = value; }


        }

        public int State
        {
            get { return _State; }
            set { _State = value; }


        }




        #endregion


    }
}

