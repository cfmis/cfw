using System;
using System.Collections.Generic;
using System.Text;
using Leyp.SQLServerDAL;
using Leyp.Model;
using System.ComponentModel;

namespace Leyp.BLL
{

    [DataObjectAttribute] 
    public class BGroupAuthority
    {

        public GroupAuthorityDAL groupAuthority = null;//数据库操作类
        public BGroupAuthority()
       {
           groupAuthority = new GroupAuthorityDAL();

       }

       /// <summary>
       /// 添加一个关系
       /// </summary>
       /// <param name="g">实体</param>
       public void insertNode(GroupAuthority g)
       {
           groupAuthority.insertNode(g);
       }

       /// <summary>
       /// 根据GroupID 返回权限组
       /// </summary>
       /// <param name="GroupID">GroupID</param>
       /// <returns>list</returns>
        public List<GroupAuthority> getALLGroupAuthorityByGroupID(int GroupID)
       {
           return groupAuthority.getALLGroupAuthorityByGroupID(GroupID);
       }

       
    }
}
