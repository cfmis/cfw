using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.BLL.View
{
   public class Factory
    {

       public static BvUser getBvUser()
       {
           return new BvUser();
       }
    }
}
