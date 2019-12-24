using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
    public class ProductsBrand
    {
        private int _BrandID;
        private string _BrandName;
        private string _Description="";
        private string _State;

        /// <summary>
        /// 标识主键
        /// </summary>
        public int BrandID
        {
            set { this._BrandID = value; }
            get { return this._BrandID; }
        }

        /// <summary>
        /// 记录时间
        /// </summary>
        public string BrandName
        {
            set { this._BrandName = value; }
            get { return this._BrandName; }
        }
        /// <summary>
        /// 描述
        /// </summary>
        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }
        /// <summary>
        /// 可用吗？Y ：N
        /// </summary>
        public string State
        {
            set { this._State = value; }
            get { return this._State; }
        }
    }
}
