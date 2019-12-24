namespace Leyp.SQLServerDAL.Stock
{
    using System;

    public class Factory
    {
        public static TransferringOrderDAL gerTransferringOrderDAL()
        {
            return new TransferringOrderDAL();
        }

        public static AppendStockDAL getAppendStockDAL()
        {
            return new AppendStockDAL();
        }

        public static AppendStockDetailDAL getAppendStockDetailDAL()
        {
            return new AppendStockDetailDAL();
        }

        public static InventoryDAL getInventoryDAL()
        {
            return new InventoryDAL();
        }

        public static OutStockDAL getOutStockDAL()
        {
            return new OutStockDAL();
        }

        public static OutStockDetailDAL getOutStockDetailDAL()
        {
            return new OutStockDetailDAL();
        }
    }
}

