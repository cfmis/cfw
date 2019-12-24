namespace Leyp.SQLServerDAL.Service
{
    using Leyp.Model;
    using Leyp.Model.Stock;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Stock;
    using System;
    using System.Collections.Generic;

    public class AppendStockService
    {
        public bool AuditingAppendStockOrder(string AppendID)
        {
            bool flag = false;
            try
            {
                VAppendStock stock = new VAppendStock();
                List<VAppendStockDetail> list = new List<VAppendStockDetail>();
                ProductsStockDAL kdal = new ProductsStockDAL();
                stock = new AppendStockDAL().getByID(AppendID);
                list = new AppendStockDetailDAL().getListByAppendID(AppendID);
                for (int i = 0; i < list.Count; i++)
                {
                    ProductsStock stock2;
                    AppendStockDetail detail = list[i];
                    if (kdal.isHaveEitity(stock.HouseDetailID, detail.ProductsID))
                    {
                        stock2 = new ProductsStock();
                        stock2.HouseDetailID = stock.HouseDetailID;
                        stock2.ProductsID = detail.ProductsID;
                        stock2.Num = detail.Quantity;
                        kdal.updateAddNum(stock2);
                    }
                    else
                    {
                        stock2 = new ProductsStock();
                        stock2.HouseDetailID = stock.HouseDetailID;
                        stock2.ProductsID = detail.ProductsID;
                        stock2.Num = detail.Quantity;
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

