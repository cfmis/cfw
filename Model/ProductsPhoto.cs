using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class ProductsPhoto
    {

        private int _ID;

        public int ID
        {
            get { return _ID; }
            set { _ID = value; }
        }
        private int _ProductsID;

        public int ProductsID
        {
            get { return _ProductsID; }
            set { _ProductsID = value; }
        }
        private string _PhotoUrl;
        
       /// <summary>
       /// 图片地址
       /// </summary>
        public string PhotoUrl
        {
            get { return _PhotoUrl; }
            set { _PhotoUrl = value; }
        }

    }
}
