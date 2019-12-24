using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Buy
{
   public class BuyPay
    {
            private int _PayID;
            private string _BuyReceiptID;	
            private string _Ticket	;
            private string _CreateDate	;
            private string _UserName;	
            private string _PayType	;
            private float _RealPay;
            private float _AttachPay;
            private string _Description;
            private string _AuditingUser;
            private int _State;
      
       /// <summary>
       /// 
       /// </summary>
       public int PayID
            {
                get { return _PayID; }
                set { _PayID = value; }
            }
          /// <summary>
          /// 
          /// </summary>
       public string BuyReceiptID
       {
           get { return _BuyReceiptID; }
           set { _BuyReceiptID = value; }
       }
 
       /// <summary>
       /// 
       /// </summary>
       public string Ticket
       {
           get { return _Ticket; }
           set { _Ticket = value; }
       }
             /// <summary>
             /// 
             /// </summary>
       public string CreateDate
       {
           get { return _CreateDate; }
           set { _CreateDate = value; }
       }

       public string UserName
       {
           get { return _UserName; }
           set { _UserName = value; }
       }

       public string PayType
       {
           get { return _PayType; }
           set { _PayType = value; }
       }

       public float RealPay
       {
           get { return _RealPay; }
           set { _RealPay = value; }
       }


       public float AttachPay
       {
           get { return _AttachPay; }
           set { _AttachPay = value; }
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

       public int State
       {
           get { return _State; }
           set { _State = value; }
       }


      
       


    }
}
