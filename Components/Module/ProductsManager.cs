using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Leyp.Model;
using Leyp.Model.View;
using Leyp.SQLServerDAL;

namespace Leyp.Components.Module
{

    /// <summary>
    /// 商品信息模块
    /// </summary>
   public class ProductsManager : BasePage
    {

       protected override void OnInit(EventArgs e)
       {

           base.OnInit(e);
       }

       /// <summary>
       /// 
       /// </summary>
       /// <param name="p"></param>
       /// <returns></returns>
       protected bool addNewProducts(Products p)
       {
           return Leyp.SQLServerDAL.Factory.getProductsDAL().insertNewProducts(p);
       }
          
       /// <summary>
       /// 字符处理
       /// </summary>
       /// <param name="str"></param>
       /// <returns></returns>
       public string getStrValue(string str)
       {
           if (str == null)
           {
               return "";
           }
           else
           {
               return str;

           }
       }
    }
}
