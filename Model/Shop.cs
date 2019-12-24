using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class Shop
    {

       private int _ShopID;
       private string _ShopName;
       private string _ShopUrl;
       private int _PlatformID;
       private string _Description;

       ///5-1/a/s/p-X     
///////////////////////////////////////////////数据库表没有的

       private string _PlatformName;


       /// <summary>
       /// 视图关联
       /// </summary>
       public string PlatformName
       {
           get { return _PlatformName; }
           set { _PlatformName = value; }
       }


/////////////////////////////////////////////////////////////////
       /// <summary>
       /// 对应数据库表字段 一样名称
       /// </summary>
       public int ShopID
       {
           get { return _ShopID; }
           set { _ShopID = value; }
       }


       /// <summary>
       /// 对应数据库表字段 一样名称
       /// </summary>
       public string ShopName
       {
           get { return _ShopName; }
           set { _ShopName = value; }
       }


       /// <summary>
       /// 对应数据库表字段 一样名称ShopUrl
       /// </summary>
       public string ShopUrl
       {
           get { return _ShopUrl; }
           set { _ShopUrl = value; }
       }



       public int PlatformID
       {
           get { return _PlatformID; }
           set { _PlatformID = value; }
       }


       /// <summary>
       /// 对应数据库表字段 一样名称
       /// </summary>
       public string Description
       {
           get { return _Description; }
           set { _Description = value; }
       }

    }
}
