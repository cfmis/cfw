using System;
using System.Collections.Generic;
using System.Text;
using Leyp.SQLServerDAL;
using Leyp.Model;
using System.ComponentModel;
///5/-1/A/s*px
namespace Leyp.BLL
{   
    /// <summary>
    /// 
    /// </summary>
    ///  
    [DataObjectAttribute] 
    public class BLog
    {
        private LogDAL logs = null; //数据库操作类
        public BLog()
        {
            logs = new LogDAL();
        }

        /// <summary>
        /// 添加一条日志
        /// </summary>
        /// <param name="log">日志实体</param>
        /// <returns></returns>
        public bool addLog(Log log)
        {
            return logs.addLog(log);
        }


        /// <summary>
        /// 的得到所有的日志
        /// </summary>
        /// <returns>日志 List</returns>
        public List<Log> getAllLog()
        {
            return logs.getAllLog();

        }

    }
}
