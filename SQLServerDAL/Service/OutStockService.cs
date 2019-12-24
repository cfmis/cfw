namespace Leyp.SQLServerDAL.Service
{
    using Leyp.Model;
    using Leyp.Model.Stock;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Stock;
    using System;
    using System.Collections.Generic;

    public class OutStockService
    {
        public bool AuditingOutStockOrder(string OutStockID)
        {
            bool flag = false;
            try
            {
                VOutStock stock = new VOutStock();
                List<VOutStockDetail> list = new List<VOutStockDetail>();
                ProductsStockDAL kdal = new ProductsStockDAL();
                stock = new OutStockDAL().getByID(OutStockID);
                list = new OutStockDetailDAL().getListByOutID(OutStockID);
                for (int i = 0; i < list.Count; i++)
                {
                    ProductsStock stock2;
                    OutStockDetail detail = list[i];
                    if (kdal.isHaveEitity(stock.HouseDetailID, detail.ProductsID))
                    {
                        stock2 = new ProductsStock();
                        stock2.HouseDetailID = stock.HouseDetailID;
                        stock2.ProductsID = detail.ProductsID;
                        stock2.Num = detail.Quantity;
                        kdal.updateCutNum(stock2);
                    }
                    else
                    {
                        stock2 = new ProductsStock();
                        stock2.HouseDetailID = stock.HouseDetailID;
                        stock2.ProductsID = detail.ProductsID;
                        stock2.Num = -detail.Quantity;
                        kdal.insertNewEitity(stock2);
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

