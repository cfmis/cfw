using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Stock
{

    /// <summary>
    /// 库存调拨表
    /// </summary>
   public class TransferringOrder
    {

        private string _ID;
        private string _Date;	
        private int _OutHouseID	;
        private int _InHouseID	;
        private int _ProductsID	;
        private int _Quantity;
        private float _Price	;
        private string _UserName;
        private string _Operator	;
       private string _TradeDate;
        private string _Ticket="";
        private string _Description;
        private string _AuditingUser="";
        private int _State=0;



       public string ID
       {
           get { return _ID; }
           set { _ID = value; }
       }



       public string Date
       {
           get { return _Date; }
           set { _Date = value; }
       }



       public int OutHouseID
       {
           get { return _OutHouseID; }
           set { _OutHouseID = value; }
       }



       public int InHouseID
       {
           get { return _InHouseID; }
           set { _InHouseID = value; }
       }


       public int ProductsID
       {
           get { return _ProductsID; }
           set { _ProductsID = value; }
       }


       public int Quantity
       {
           get { return _Quantity; }
           set { _Quantity = value; }
       }



       public float Price
       {
           get { return _Price; }
           set { _Price = value; }
       }


       public string UserName
       {
           get { return _UserName; }
           set { _UserName = value; }
       }


       public string Operator
       {
           get { return _Operator; }
           set { _Operator = value; }
       }

       public string TradeDate
       {
           get { return _TradeDate; }
           set { _TradeDate = value; }
       }

       

       public string Ticket
       {
           get { return _Ticket; }
           set { _Ticket = value; }
       }


       //////////////////////
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

 

       public int  State
       {
           get { return _State; }
           set { _State = value; }
       }


     
    }
}
