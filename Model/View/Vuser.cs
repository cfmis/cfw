using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model.View
{ 
    /// <summary>
    /// 用户视图实体类
    /// </summary>
   public  class Vuser :User
    {

        private string _TypeName = "";
       private string _SubClassName = "";
       private string _GroupName = "";

       public string GroupName
       {
           get { return _GroupName; }
           set { _GroupName = value; }
       }


       /// <summary>
       /// 
       /// </summary>
        public string TypeName
        {
            get { return _TypeName; }
            set { _TypeName = value; }
        }

     

        public string SubClassName
        {
            get { return _SubClassName; }
            set { _SubClassName = value; }
        }



    }
}
