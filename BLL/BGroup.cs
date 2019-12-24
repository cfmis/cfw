using System;
using System.Collections.Generic;
using System.Text;
using Leyp.SQLServerDAL;
using Leyp.Model;
using System.ComponentModel;

namespace Leyp.BLL
{
    [DataObjectAttribute] 
   public class BGroup
    {

       private GroupDAL groupDAL = null;

       public BGroup()
       {
           groupDAL = new GroupDAL();
       }


       /// <summary>
       /// 添加一个新的群
       /// </summary>
       /// <param name="g"></param>
       /// <returns></returns>
       public bool insertNewGroup(Group g)
       {
           return groupDAL.insertNewGroup(g);
       }

       /// <summary>
       /// 更新Group 并且更新权限关系
       /// </summary>
       /// <param name="GroupID"></param>
       /// <returns></returns>
       public bool updateGroup(Group g, int[] a)
       { 
          return groupDAL.updateGroup(g, a);
       }

       /// <summary>
       /// 返回所有群组
       /// </summary>
       /// <returns></returns>
       public List<Group> getAllGroup()
       {
           return groupDAL.getAllGroup();

       }

       /// <summary>
       /// 返回一个实体
       /// </summary>
       /// <param name="GroupID"></param>
       /// <returns></returns>
       public Group getByGroupID(int GroupID)
       {
          return groupDAL.getByGroupID(GroupID);

       }




    }
}
