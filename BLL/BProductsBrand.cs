using System;
using System.Collections.Generic;
using System.Text;
using Leyp.SQLServerDAL;
using Leyp.Model;
using System.ComponentModel;

namespace Leyp.BLL
{
   public class BProductsBrand
    {
       private ProductsBrandDAL productsBrandDAL = null;

       public BProductsBrand()
       {
           this.productsBrandDAL = new ProductsBrandDAL();
       }

       /// <summary>
        /// 添加一个实体
        /// </summary>
        /// <param name="pb"></param>
        /// <returns></returns>
        public bool insertNewProductsBrand(ProductsBrand pb)
        {
            return productsBrandDAL.insertNewProductsBrand(pb);
        }
        
       /// <summary>
        /// 删除一个实体
        /// </summary>
        /// <param name="brandID"></param>
        /// <returns></returns>
       public bool deleteByBrandID(int brandID)
       {
           return productsBrandDAL.deleteByBrandID(brandID);
       }

       /// <summary>
        /// 返回所有的品牌
        /// </summary>
        /// <returns></returns>
       public List<ProductsBrand> getAllProductsBrand()
       {
           return productsBrandDAL.getAllProductsBrand();
       }


       /// <summary>
        /// 通过ID返回一个实体
        /// </summary>
        /// <param name="BrandID"></param>
        /// <returns></returns>
       public ProductsBrand getByBrandID(int BrandID)
       {
           return productsBrandDAL.getByBrandID(BrandID);
       }
    }
}
