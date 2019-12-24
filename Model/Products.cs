using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
    public class Products
    {
        private int  _ProductsID;
        private string _ProductsName;
        private int _TypeID;
        private int _BrandID;
        private string _BeginEnterDate;
        private string _FinalEnterDate;
        private string _LatelyOFSDate;
        private string _LoadingDate;
        private float _Cost;
        private float _Price;

       

        private int _UpperLimit;
        private int _LowerLimit;



        private string _UnshelveDate;
        private string _Color;
        private string _Weight;
        private string _Material;
        private string _Spec;
        private int _TotalSalesNum;
        private int _StocksNum;
        private string _Description;
        private string _ProductsUints;

        public string ProductsUints
        {
            get { return _ProductsUints; }
            set { _ProductsUints = value; }
        }
        private string _PhotoUrl;

        public string PhotoUrl
        {
            get { return _PhotoUrl; }
            set { _PhotoUrl = value; }
        }

        /// <summary>
        /// 商品ID
        /// </summary>
        public int  ProductsID
        {
            set { this._ProductsID = value; }
            get { return this._ProductsID; }
        }

        /// <summary>
        /// 商品名称
        /// </summary>
        public string ProductsName 
        {
            set { this._ProductsName = value; }
            get { return this._ProductsName; }
        }

        /// <summary>
        /// 类型ID
        /// </summary>
        public int TypeID
        {
            set { this._TypeID = value; }
            get { return this._TypeID; }
        }
        /// <summary>
        /// 品牌ID
        /// </summary>
        public int BrandID
        {
            set { this._BrandID = value; }
            get { return this._BrandID; }
        }

        /// <summary>
        /// 第一次入库时间
        /// </summary>
        public string BeginEnterDate
        {
            set { this._BeginEnterDate = value; }
            get { return this._BeginEnterDate; }
        }

        /// <summary>
        /// 最后一次入库
        /// </summary>
        public string FinalEnterDate
        {
            set { this._FinalEnterDate = value; }
            get { return this._FinalEnterDate; }
        }

        /// <summary>
        /// 最近缺货一次时间
        /// </summary>
        public string LatelyOFSDate
        {
            set { this._LatelyOFSDate = value; }
            get { return this._FinalEnterDate; }
        }
        /// <summary>
        /// 上架
        /// </summary>
        public string LoadingDate
        {
            get { return _LoadingDate; }
            set { _LoadingDate = value; }
        }

        /// <summary>
        /// 上限
        /// </summary>
        public int UpperLimit
        {
            get { return _UpperLimit; }
            set { _UpperLimit = value; }
        }

        /// <summary>
        /// 下限
        /// </summary>
        public int LowerLimit
        {
            get { return _LowerLimit; }
            set { _LowerLimit = value; }
        }

        /// <summary>
        /// 成本
        /// </summary>
        public float Cost
        {
            get { return _Cost; }
            set { _Cost = value; }
        }

        /// <summary>
        /// 建议出售价
        /// </summary>
        public float Price
        {
            get { return _Price; }
            set { _Price = value; }
        }

       
        /// <summary>
        /// 下架日
        /// </summary>
        public string UnshelveDate
        {
            set { this._UnshelveDate = value; }
            get { return this._UnshelveDate; }
        }

        /// <summary>
        /// 颜色
        /// </summary>
        public string Color
        {
            set { this._Color = value; }
            get { return this._Color; }
        }

        /// <summary>
        /// 重量
        /// </summary>
        public string Weight
        {
            set { this._Weight = value; }
            get { return this._Weight; }
        }

        /// <summary>
        /// 材质
        /// </summary>
        public string Material
        {
            set { this._Material = value; }
            get { return this._Material; }
        }

        /// <summary>
        /// 规格
        /// </summary>
        public string Spec
        {
            set { this._Spec = value; }
            get { return this._Spec; }
        }

        /// <summary>
        /// 总销售量
        /// </summary>
        public int TotalSalesNum
        {
            set { this._TotalSalesNum = value; }
            get { return this._TotalSalesNum; }
        }

        /// <summary>
        /// 现库存量
        /// </summary>
        public int StocksNum
        {
            set { this._StocksNum = value; }
            get { return this._StocksNum; }
        }

        /// <summary>
        /// 商品描述
        /// </summary>
        public string Description
        {
            set { this._Description = value; }
            get { return this._Description; }
        }

    }
}
