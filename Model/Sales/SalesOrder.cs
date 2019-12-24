using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
   public  class SalesOrder
    {

                private string   _SalesOrderID	;
                private string   _CreateDate;
                private int _SalesType;
                private int    _ShopID;	
                private string   _CustomerID="";	
                private string   _DeliveryType;	
                private string   _DeliveryPlace;
                private string   _ClosingType;	
                private string   _ClosingDate;	
                private float   _SalesIncome;
                private float _AttachPay;
                private string   _UserName;	
                private string   _AuditingUser;
                private string _Description;
                private int _State=-1;

                private float _Discount = float.Parse("0.00");

               //最后新加
       private string _CustomerName;
       private string _CustomerTel;
       private string _CustomerPost;
       private string _CustomerArea;
       private int _PlatformID;





 #region
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


       public int  SalesType
       {
           get { return _SalesType; }
           set { _SalesType = value; }
       }

       public int  ShopID
       {
           get { return _ShopID; }
           set { _ShopID = value; }
       }


       public string CustomerID
        {
            get { return _CustomerID; }
            set { _CustomerID = value; }
        }

       public string DeliveryType
        {
            get { return _DeliveryType; }
            set { _DeliveryType = value; }


        }




       ////////////////////////////////////


       public string DeliveryPlace
       {
           get { return _DeliveryPlace; }
           set { _DeliveryPlace = value; }


       }



       public string ClosingType
       {
           get { return _ClosingType; }
           set { _ClosingType = value; }


       }



       public string ClosingDate
       {
           get { return _ClosingDate; }
           set { _ClosingDate = value; }


       }


       public float SalesIncome
       {
           get { return _SalesIncome; }
           set { _SalesIncome = value; }


       }


       public float AttachPay
       {
           get { return _AttachPay; }
           set { _AttachPay = value; }


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

       /// <summary>
       /// 折让金额
       /// </summary>

       public float Discount
       {
           get { return _Discount; }
           set { _Discount = value; }
       }

 #endregion


    



       public string CustomerName
       {
           get { return _CustomerName; }
           set { _CustomerName = value; }
       }



       public string CustomerTel
       {
           get { return _CustomerTel; }
           set { _CustomerTel = value; }
       }



       public string CustomerPost
       {
           get { return _CustomerPost; }
           set { _CustomerPost = value; }
       }



       public string CustomerArea
       {
           get { return _CustomerArea; }
           set { _CustomerArea = value; }
       }


       public int PlatformID
       {
           get { return _PlatformID; }
           set { _PlatformID = value; }
       }
         






    }
}
