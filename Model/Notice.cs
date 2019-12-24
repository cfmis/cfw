using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public  class Notice
    {
       private int _NoticeID;

      
       private int _Type;
       private string _Title;
       private string _UserName;
       private string _CreateDate;
       private string _Info;
       private int _State = 0;


       public int NoticeID
       {
           get { return _NoticeID; }
           set { _NoticeID = value; }
       }



       public int Type
       {
           get { return _Type; }
           set { _Type = value; }
       }



       public string Title
       {
           get { return _Title; }
           set { _Title = value; }
       }


       public string UserName
       {
           get { return _UserName; }
           set { _UserName = value; }
       }


       public string CreateDate
       {
           get { return _CreateDate; }
           set { _CreateDate = value; }
       }


       public string Info
       {
           get { return _Info; }
           set { _Info = value; }
       }

       public int State
       {
           get { return _State; }
           set { _State = value; }
       }


    }
}
 