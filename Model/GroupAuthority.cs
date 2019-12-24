using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class GroupAuthority
    {
       public GroupAuthority()
       { }

       private int _ID;
       private int _AuthorityID;
       private int _GroupID;

       /// <summary>
       /// 对应数据库表字段 一样名称
       /// </summary>
       public int  ID
       {
           get { return _ID; }
           set { _ID = value; }
       }

       /// <summary>
       /// 对应数据库表字段 一样名称
       /// </summary>
       public int  AuthorityID
       {
           get { return _AuthorityID; }
           set { _AuthorityID = value; }
       }


       /// <summary>
       /// 对应数据库表字段 一样名称
       /// </summary>
       public int  GroupID
       {
           get { return _GroupID; }
           set { _GroupID = value; }
       }


    }
}
