using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
   public class SalesDispatch
    {
       private int  _DispatchID;
       private string _SalesOutID;
       private string _CreateDate;
       private string _DeliveryType;
       private string _DeliveryDate;
       private string _SentDate;
       private string _Consignor;
       private string _UserName;
       private float _Postage;
       private int _PrintFlag;
       private string _Description;
       private int _State=0;





       public float Postage
       {
           get { return _Postage; }
           set { _Postage = value; }
       }

       public int PrintFlag
       {
           get { return _PrintFlag; }
           set { _PrintFlag = value; }
       }


       /// <summary>
       /// 1
       /// </summary>
       public int DispatchID
       {
           get { return _DispatchID; }
           set { _DispatchID = value; }
       }


        /// <summary>
        /// 2
        /// </summary>
       public string SalesOutID
       {
           get { return _SalesOutID; }
           set { _SalesOutID = value; }
       }




       /// <summary>
       /// 3
       /// </summary>
       public string CreateDate
       {
           get { return _CreateDate; }
           set { _CreateDate = value; }
       }



       /// <summary>
       /// 4
       /// </summary>
       public string DeliveryType
       {
           get { return _DeliveryType; }
           set { _DeliveryType = value; }
       }




       /// <summary>
       /// 5
       /// </summary>
       public string DeliveryDate
       {
           get { return _DeliveryDate; }
           set { _DeliveryDate = value; }
       }



       /// <summary>
       /// 6
       /// </summary>
       public string SentDate
       {
           get { return _SentDate; }
           set { _SentDate = value; }
       }




       /// <summary>
       /// 7
       /// </summary>
       public string Consignor
       {
           get { return _Consignor; }
           set { _Consignor = value; }
       }



       /// <summary>
       /// 8
       /// </summary>
       public string UserName
       {
           get { return _UserName; }
           set { _UserName = value; }
       }




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
