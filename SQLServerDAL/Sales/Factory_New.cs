
namespace Leyp.SQLServerDAL.Sales
{using System;

    public class Factory_New
    {
        public static SalesQueryPublicDAL SalesQueryPublicDAL()
        {
            return new SalesQueryPublicDAL();
        }
        public static SaOrderTestTraceDAL SaOrderTestTraceDAL()
        {
            return new SaOrderTestTraceDAL();
        }
        public static SaColorGroupFindDAL SaColorGroupFindDAL()
        {
            return new SaColorGroupFindDAL();
        }
        public static SaQuotationQueryDAL SaQuotationQueryDAL()
        {
            return new SaQuotationQueryDAL();
        }
    }
}
