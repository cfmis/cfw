using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class StoreHouseDetail
    {

        private int _ID;
        private int _HouseID;
        private string _SubareaName;
        private string _Description;
        private string _State;

        public string State
        {
            get { return _State; }
            set { _State = value; }
        }

  


       public int ID
       {
           get { return _ID; }
           set { _ID = value; }
       }



       public int HouseID
       {
           get { return _HouseID; }
           set { _HouseID = value; }
       }



       public string SubareaName
       {
           get { return _SubareaName; }
           set { _SubareaName = value; }
       }


       public string Description
       {
           get { return _Description; }
           set { _Description = value; }
       }





    }
}
