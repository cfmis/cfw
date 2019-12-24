using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class Delivery
    {
        private int _DeliveryID;

        public int DeliveryID
        {
            get { return _DeliveryID; }
            set { _DeliveryID = value; }
        }

        private string _DeliveryName;

        public string DeliveryName
        {
            get { return _DeliveryName; }
            set { _DeliveryName = value; }
        }

        private string _Description;

        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        private int _Default=0;

        public int Default
        {
            get { return _Default; }
            set { _Default = value; }
        }


    }
}
