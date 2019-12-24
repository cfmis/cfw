namespace Leyp.SQLServerDAL.Service
{
    using Leyp.Model;
    using Leyp.Model.Stock;
    using Leyp.SQLServerDAL;
    using Leyp.SQLServerDAL.Stock;
    using System;

    public class InventoryService
    {
        public bool AuditingInventoryOrder(string InventoryID)
        {
            bool flag = false;
            try
            {
                ProductsStock stock;
                VInventory inventory = new VInventory();
                ProductsStockDAL kdal = new ProductsStockDAL();
                inventory = new InventoryDAL().getByID(InventoryID);
                if (kdal.isHaveEitity(inventory.HouseDetailID, inventory.ProductsID))
                {
                    stock = new ProductsStock();
                    stock.HouseDetailID = inventory.HouseDetailID;
                    stock.ProductsID = inventory.ProductsID;
                    stock.Num = inventory.AdjustNum;
                    kdal.updateEitityNum(stock);
                }
                else
                {
                    stock = new ProductsStock();
                    stock.HouseDetailID = inventory.HouseDetailID;
                    stock.ProductsID = inventory.ProductsID;
                    stock.Num = inventory.AdjustNum;
                    kdal.insertNewEitity(stock);
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

