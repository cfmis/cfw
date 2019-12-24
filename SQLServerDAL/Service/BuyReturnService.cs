namespace Leyp.SQLServerDAL.Service
{
    using Leyp.Model;
    using Leyp.Model.Buy;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Buy;
    using System;
    using System.Collections.Generic;

    public class BuyReturnService
    {
        public bool AuditingBuyReturnOrder(string BuyReturnID)
        {
            bool flag = false;
            try
            {
                List<VBuyReturnDetail> list = new List<VBuyReturnDetail>();
                ProductsStockDAL kdal = new ProductsStockDAL();
                BuyReturn return2 = new BuyReturnDAL().getByID(BuyReturnID);
                if (return2 == null)
                {
                    return false;
                }
                list = new BuyReturnDetailDAL().getBuyReturnDetailByBuyReturnID(BuyReturnID);
                for (int i = 0; i < list.Count; i++)
                {
                    ProductsStock stock;
                    BuyReturnDetail detail = list[i];
                    if (kdal.isHaveEitity(return2.HouseDetailID, detail.ProductsID))
                    {
                        stock = new ProductsStock();
                        stock.HouseDetailID = return2.HouseDetailID;
                        stock.ProductsID = detail.ProductsID;
                        stock.Num = detail.Quantity;
                        kdal.updateCutNum(stock);
                    }
                    else
                    {
                        stock = new ProductsStock();
                        stock.HouseDetailID = return2.HouseDetailID;
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

