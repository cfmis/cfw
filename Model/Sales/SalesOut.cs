using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
   public class SalesOut
    {
       private string _SalesOutID;
       private string _SalesOrderID;
        private string _CreateDate;
  
        private string _Consignee;


       private string _TradeDate;
       private float _TotalPrice;
       private float _Deposits;
        private string _UserName;
        private string _AuditingUser;
        private string _Description;
        private int _State;

        private int _DeliveryID;//配送类型

        private string _AccountsID;//财务帐号

      



        #region

       public string AccountsID
       {
           get { return _AccountsID; }
           set { _AccountsID = value; }
       }


       public int DeliveryID
       {
           get { return _DeliveryID; }
           set { _DeliveryID = value; }
       }



       public string SalesOutID
       {
           get { return _SalesOutID; }
           set { _SalesOutID = value; }
       }


        public string SalesOrderID
        {
            get { return _SalesOrderID; }
            set { _SalesOrderID = value; }
        }



        public string CreateDate
        {
            get { return _CreateDate; }
            set { _CreateDate = value; }
        }



       public string Consignee
        {
            get { return _Consignee; }
            set { _Consignee = value; }
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
