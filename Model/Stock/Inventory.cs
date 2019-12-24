using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Stock
{
    /// <summary>
    /// 库存盘点
    /// </summary>
   public  class Inventory
    {
            private string _InventoryID;
            private string _CreateDate;
            private int _StoreHouseID;
            private int _HouseDetailID;
            private int _ProductsID;
            private int _RealityNum;
            private int _AdjustNum;
            private int _BillNum;
            private string _UserName;
            private string _Operator;
            private string _TradeDate;
            private string _Description;
            private string _AuditingUser;
            private int _State;


       public string InventoryID
       {
           get { return _InventoryID; }
           set { _InventoryID = value; }
       }



       public string CreateDate
       {
           get { return _CreateDate; }
           set { _CreateDate = value; }
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



       public int ProductsID
       {
           get { return _ProductsID; }
           set { _ProductsID = value; }
       }



       public int RealityNum
       {
           get { return _RealityNum; }
           set { _RealityNum = value; }
       }

       public int AdjustNum
       {
           get { return _AdjustNum; }
           set { _AdjustNum = value; }
       }


      

       public int BillNum
       {
           get { return _BillNum; }
           set { _BillNum = value; }
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
