using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Leyp.Model.Sales
{
    public class SaOrderTrace
    {
        private string _id;

        public string id
        {
            get { return _id; }
            set { _id = value; }
        }
        private string _order_date;

        public string order_date
        {
            get { return _order_date; }
            set { _order_date = value; }
        }
        private string _it_customer;

        public string it_customer
        {
            get { return _it_customer; }
            set { _it_customer = value; }
        }
    }
}
