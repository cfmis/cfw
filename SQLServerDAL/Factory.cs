namespace Leyp.SQLServerDAL
{
    using System;

    public class Factory
    {
        public static AccountsDAL getAccountsDAL()
        {
            return new AccountsDAL();
        }

        public static AuthorityDAL getAuthorityDAL()
        {
            return new AuthorityDAL();
        }

        public static DeliveryDAL getDeliveryDAL()
        {
            return new DeliveryDAL();
        }

        public static GroupAuthorityDAL getGroupAuthorityDAL()
        {
            return new GroupAuthorityDAL();
        }

        public static GroupDAL getGroupDAL()
        {
            return new GroupDAL();
        }

        public static LogDAL getLogDAL()
        {
            return new LogDAL();
        }

        public static NoticeDAL getNoticeDAL()
        {
            return new NoticeDAL();
        }

        public static PhotoFlowDAL getPhotoFlowDAL()
        {
            return new PhotoFlowDAL();
        }

        public static ProductsBrandDAL getProductsBrandDAL()
        {
            return new ProductsBrandDAL();
        }

        public static ProductsDAL getProductsDAL()
        {
            return new ProductsDAL();
        }

        public static ProductsPhotoDAL getProductsPhotoDAL()
        {
            return new ProductsPhotoDAL();
        }

        public static ProductsStockDAL getProductsStockDAL()
        {
            return new ProductsStockDAL();
        }

        public static ProductsTypeDAL getProductsTypeDAL()
        {
            return new ProductsTypeDAL();
        }

        public static ProductsUserTypeDAL getProductsUserTypeDAL()
        {
            return new ProductsUserTypeDAL();
        }

        public static ServiceInfoDAL getServiceInfoDAL()
        {
            return new ServiceInfoDAL();
        }

        public static ServiceTypeDAL getServiceTypeDAL()
        {
            return new ServiceTypeDAL();
        }

        public static ShopDAL getShopDAL()
        {
            return new ShopDAL();
        }

        public static StoreHouseDAL getStoreHouseDAL()
        {
            return new StoreHouseDAL();
        }

        public static StoreHouseDetailDAL getStoreHouseDetailDAL()
        {
            return new StoreHouseDetailDAL();
        }

        public static SupplierDAL getSupplierDAL()
        {
            return new SupplierDAL();
        }

        public static UserDAL getUserDAL()
        {
            return new UserDAL();
        }

        public static UserTypeDAL getUserTypeDAL()
        {
            return new UserTypeDAL();
        }

        public static UserTypeSubClassDAL getUserTypeSubClassDAL()
        {
            return new UserTypeSubClassDAL();
        }

        public static VProductsDAL getVProductsDAL()
        {
            return new VProductsDAL();
        }

        public static VstoreHouseDAL getVstoreHouseDAL()
        {
            return new VstoreHouseDAL();
        }

        public static VuserDAL getVuserDAL()
        {
            return new VuserDAL();
        }



    }
}

