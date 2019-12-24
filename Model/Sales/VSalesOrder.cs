using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.Sales
{
   public class VSalesOrder:SalesOrder
    {

       private string _ShopName;

       private string _SalesTypeName;

       private string _RealName;

       private string _PlatformName;
        
       /// <summary>
       /// 店铺名称
       /// </summary>
       public string ShopName
       {
           get { return _ShopName; }
           set { _ShopName = value; }
       }



       /// <summary>
       /// 销售订单类型名
       /// </summary>
       public string SalesTypeName
       {
           get { return _SalesTypeName; }
           set { _SalesTypeName = value; }
       }

       /// <summary>
       /// 制单人姓名
       /// </summary>
       public string RealName
       {
           get { return _RealName; }
           set { _RealName = value; }
       }


       /// <summary>
       /// 消费平台
       /// </summary>
       public string PlatformName
       {
           get { return _PlatformName; }
           set { _PlatformName = value; }
       }



    }
}
