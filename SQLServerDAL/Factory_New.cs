namespace Leyp.SQLServerDAL
{
    using System;

    public class Factory_New
    {
        
        public static ProductsStockDAL_New getProductsStockDAL()
        {
            return new ProductsStockDAL_New();
        }

        public static ProductsMoArrangeDAL getProductsMoArrangeDAL()
        {
            return new ProductsMoArrangeDAL();
        }

        public static ProductsMoArrangeDAL queryProductStatus()
        {
            return new ProductsMoArrangeDAL();
        }
        public static BaseDataDAL BaseDataDAL()
        {
            return new BaseDataDAL();
        }
    }
}
