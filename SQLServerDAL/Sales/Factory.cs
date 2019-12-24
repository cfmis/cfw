namespace Leyp.SQLServerDAL.Sales
{
    using System;

    public class Factory
    {
        public static SalesDetailDAL getSalesDetailDAL()
        {
            return new SalesDetailDAL();
        }

        public static SalesDispatchDAL getSalesDispatchDAL()
        {
            return new SalesDispatchDAL();
        }

        public static SalesOrderDAL getSalesOrderDAL()
        {
            return new SalesOrderDAL();
        }

        public static SalesOutDAL getSalesOutDAL()
        {
            return new SalesOutDAL();
        }

        public static SalesOutDetailDAL getSalesOutDetailDAL()
        {
            return new SalesOutDetailDAL();
        }

        public static SalesPlatformDAL getSalesPlatformDAL()
        {
            return new SalesPlatformDAL();
        }

        public static SalesRecordDAL getSalesRecordDAL()
        {
            return new SalesRecordDAL();
        }

        public static SalesReturnDAL getSalesReturnDAL()
        {
            return new SalesReturnDAL();
        }

        public static SalesReturnDetailDAL getSalesReturnDetailDAL()
        {
            return new SalesReturnDetailDAL();
        }
    }
}

