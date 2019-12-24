namespace Leyp.SQLServerDAL.Service
{
    using Leyp.Model;
    using Leyp.Model.Stock;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Stock;
    using System;

    public class TransferringService
    {
        public bool AuditingTransferring(string ID)
        {
            bool flag = false;
            try
            {
                ProductsStockDAL kdal = new ProductsStockDAL();
                VTransferringOrder order = new TransferringOrderDAL().getByID(ID);
                if (order == null)
                {
                    return false;
                }
                int outHouseID = order.OutHouseID;
                int inHouseID = order.InHouseID;
                int productsID = order.ProductsID;
                int quantity = order.Quantity;
                ProductsStock stock = kdal.getByProductsIDStockID(productsID, outHouseID);
                ProductsStock stock2 = kdal.getByProductsIDStockID(productsID, inHouseID);
                if (stock == null)
                {
                    return false;
                }
                if (quantity > stock.Num)
                {
                    return false;
                }
                ProductsStock p = new ProductsStock();
                p.HouseDetailID = outHouseID;
                p.ProductsID = productsID;
                p.Num = quantity;
                ProductsStock stock4 = new ProductsStock();
                stock4.HouseDetailID = inHouseID;
                stock4.ProductsID = productsID;
                stock4.Num = quantity;
                if (kdal.updateCutNum(p))
                {
                    if (stock2 == null)
                    {
                        kdal.insertNewEitity(stock4);
                    }
                    else
                    {
                        kdal.updateAddNum(stock4);
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

