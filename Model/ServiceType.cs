using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
    /// <summary>
    /// 服务类型
    /// </summary>
   public class ServiceType
    {
        private int _TypeID;

        public int TypeID
        {
            get { return _TypeID; }
            set { _TypeID = value; }
        }
        private string _ServiceName;

        public string ServiceName
        {
            get { return _ServiceName; }
            set { _ServiceName = value; }
        }
        private string _Description;

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }
    }
}
