namespace Leyp.SQLServerDAL.Service
{
    using Leyp.Model;
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Sales;
    using System;
    using System.Collections.Generic;

    public class SalesOutService
    {
        public bool AuditingSalesOutOrder(string SalesOutID)
        {
            bool flag = false;
            try
            {
                VSalesOut @out = new VSalesOut();
                List<VSalesOutDetail> list = new List<VSalesOutDetail>();
                ProductsStockDAL kdal = new ProductsStockDAL();
                @out = new SalesOutDAL().getByID(SalesOutID);
                list = new SalesOutDetailDAL().getBySalesOutID(SalesOutID);
                for (int i = 0; i < list.Count; i++)
                {
                    ProductsStock stock;
                    SalesOutDetail detail = list[i];
                    if (kdal.isHaveEitity(detail.HouseDetailID, detail.ProductsID))
                    {
                        stock = new ProductsStock();
                        stock.HouseDetailID = detail.HouseDetailID;
                        stock.ProductsID = detail.ProductsID;
                        stock.Num = detail.Quantity;
                        kdal.updateCutNum(stock);
                    }
                    else
                    {
                        stock = new ProductsStock();
                        stock.HouseDetailID = detail.HouseDetailID;
                        stock.ProductsID = detail.ProductsID;
                        stock.Num = -detail.Quantity;
                        kdal.insertNewEitity(stock);
                    }
                }
                flag = true;
            }
            catch
            {
            }
            return flag;
        }
    }
}

