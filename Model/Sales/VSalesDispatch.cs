using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
   public class VSalesDispatch:SalesDispatch
    {
        private string _SalesOrderID;

       /// <summary>
       /// 销售订单
       /// </summary>
        public string SalesOrderID
        {
            get { return _SalesOrderID; }
            set { _SalesOrderID = value; }
        }
        private string _RealName;


       /// <summary>
       /// 委托发货用户名称
       /// </summary>
        public string RealName
        {
            get { return _RealName; }
            set { _RealName = value; }
        }

       private string _DeliveryName;
       

       /// <summary>
       /// 配送名称
       /// </summary>
       public string DeliveryName
       {
           get { return _DeliveryName; }
           set { _DeliveryName = value; }
       }


    }
}
