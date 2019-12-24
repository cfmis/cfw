namespace Leyp.SQLServerDAL.Service
{
    using Leyp.Model;
    using Leyp.Model.Buy;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Buy;
    using System;
    using System.Collections.Generic;

    public class BuyReceiptService
    {
        public bool AuditingBuyReceiptOrder(string ReceiptOrderID)
        {
            bool flag = false;
            try
            {
                BuyReceipt receipt = new BuyReceipt();
                List<VBuyReceiptDetail> list = new List<VBuyReceiptDetail>();
                ProductsStockDAL kdal = new ProductsStockDAL();
                receipt = new BuyReceiptDAL().getByID(ReceiptOrderID);
                list = new BuyReceiptDetailDAL().getBuyReceiptDetailByReceiptOrderID(ReceiptOrderID);
                for (int i = 0; i < list.Count; i++)
                {
                    ProductsStock stock;
                    BuyReceiptDetail detail = list[i];
                    if (kdal.isHaveEitity(receipt.HouseDetailID, detail.ProductsID))
                    {
                        stock = new ProductsStock();
                        stock.HouseDetailID = receipt.HouseDetailID;
                        stock.ProductsID = detail.ProductsID;
                        stock.Num = detail.Quantity;
                        kdal.updateAddNum(stock);
                    }
                    else
                    {
                        stock = new ProductsStock();
                        stock.HouseDetailID = receipt.HouseDetailID;
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

