using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
    public class ProductsType
    {
        private int _TypeID;
        private string _TypeName;
        private string _State;
        private string _Description;

        /// <summary>
        /// 标识主键
        /// </summary>
        public int TypeID
        {
            set { this._TypeID = value; }
            get { return this._TypeID; }
        }

        /// <summary>
        /// 记录时间
        /// </summary>
        public String TypeName
        {
            set { this._TypeName = value; }
            get { return this._TypeName; }
        }

  
        /// <summary>
        /// State
        /// </summary>
        public String State
        {
            set { this._State = value; }
            get { return this._State; }
        }

        /// <summary>
        /// 描述
        /// </summary>
        public String Description
        {
            set { this._Description = value; }
            get { return this._Description; }
        }
    
    }
}
