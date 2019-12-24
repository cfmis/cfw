using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class Accounts
    {
        private string _AccountsID;

       	
      private string  _AccountsName	;
       private string _Description;


       public string AccountsID
       {
           get { return _AccountsID; }
           set { _AccountsID = value; }
       }

       public string AccountsName
       {
           get { return _AccountsName; }
           set { _AccountsName = value; }
       }

       public string Description
       {
           get { return _Description; }
           set { _Description = value; }
       }

    }
}
