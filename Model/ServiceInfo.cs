using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
  public class ServiceInfo
    {
        private int _ID;
        private int _TypeID;
        private string _ServiceTitle;
        private string _CreateDate;	
        private string  _SalesOrderID;	
        private string _Content;
        private string _ReplyInfo;	
        private string _AuditingUser;	
        private string _UserName;
        private int _State;



      public int ID
      {
          get { return _ID; }
          set { _ID = value; }
      }



      public int TypeID
      {
          get { return _TypeID; }
          set { _TypeID = value; }
      }


      public string ServiceTitle
      {
          get { return _ServiceTitle; }
          set { _ServiceTitle = value; }
      }




      public string CreateDate
      {
          get { return _CreateDate; }
          set { _CreateDate = value; }

      }
      public string SalesOrderID
      {
          get { return _SalesOrderID; }
          set { _SalesOrderID = value; }
      }


      public string Content
      {
          get { return _Content; }
          set { _Content = value; }
      }



      public string ReplyInfo
      {
          get { return _ReplyInfo; }
          set { _ReplyInfo = value; }
      }



      public string AuditingUser
      {
          get { return _AuditingUser; }
          set { _AuditingUser = value; }
      }



      public string UserName
      {
          get { return _UserName; }
          set { _UserName = value; }
      }

      public int  State
      {
          get { return _State; }
          set { _State = value;}
      }

    

    }
}
