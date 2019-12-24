namespace Leyp.SQLServerDAL.Service
{
    using Leyp.Model;
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Sales;
    using System;
    using System.Collections.Generic;

    public class SalesReturnService
    {
        public bool AuditingSalesOutOrder(string SalesReturnID)
        {
            bool flag = false;
            try
            {
                VSalesReturn return2 = new VSalesReturn();
                List<VSalesReturnDetail> list = new List<VSalesReturnDetail>();
                ProductsStockDAL kdal = new ProductsStockDAL();
                return2 = new SalesReturnDAL().getByID(SalesReturnID);
                list = new SalesReturnDetailDAL().getBySalesReturnID(SalesReturnID);
                for (int i = 0; i < list.Count; i++)
                {
                    ProductsStock stock;
                    SalesReturnDetail detail = list[i];
                    if (kdal.isHaveEitity(return2.HouseDetailID, detail.ProductsID))
                    {
                        stock = new ProductsStock();
                        stock.HouseDetailID = return2.HouseDetailID;
                        stock.ProductsID = detail.ProductsID;
                        stock.Num = detail.Quantity;
                        kdal.updateAddNum(stock);
                    }
                    else
                    {
                        stock = new ProductsStock();
                        stock.HouseDetailID = return2.HouseDetailID;
                        stock.ProductsID = detail.ProductsID;
                        stock.Num = detail.Quantity;
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

