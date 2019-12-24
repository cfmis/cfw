namespace Leyp.SQLServerDAL.Buy
{
    using System;

    public class Factory
    {
        public static BuyOrderDAL getBuyOrderDAL()
        {
            return new BuyOrderDAL();
        }

        public static BuyOrderDetailDAL getBuyOrderDetailDAL()
        {
            return new BuyOrderDetailDAL();
        }

        public static BuyPayDAL getBuyPayDAL()
        {
            return new BuyPayDAL();
        }

        public static BuyReceiptDAL getBuyReceiptDAL()
        {
            return new BuyReceiptDAL();
        }

        public static BuyReceiptDetailDAL getBuyReceiptDetailDAL()
        {
            return new BuyReceiptDetailDAL();
        }

        public static BuyReturnDAL getBuyReturnDAL()
        {
            return new BuyReturnDAL();
        }

        public static BuyReturnDetailDAL getBuyReturnDetailDAL()
        {
            return new BuyReturnDetailDAL();
        }
    }
}

