using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;


namespace WebPortal.ashx
{
    /// <summary>
    ///Base_Select 的摘要描述
    /// </summary>
    public class Base_Select : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            GetItem(context);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public void GetItem(HttpContext context)  
      {  
          string ReturnValue = string.Empty;  
           //BasicInformationFacade basicInformationFacade = new BasicInformationFacade();   //实例化基础信息外观  
           DataTable dt = new DataTable();  
           //dt = basicInformationFacade.itemsQuery(); //根据查询条件获取结果  
           dt = Leyp.SQLServerDAL.Sales.Factory_New.SalesQueryPublicDAL().getCpFlag();
           ReturnValue = DataTableJson(dt);  
           context.Response.ContentType = "text/plain";  
           context.Response.Write(ReturnValue);  
           //return ReturnValue;  
       } 


        #region dataTable转换成Json格式  
       /// <summary>       
       /// dataTable转换成Json格式       
       /// </summary>       
       /// <param name="dt"></param>       
       /// <returns></returns>       
       public string DataTableJson(DataTable dt)  
       {  
           StringBuilder jsonBuilder = new StringBuilder();  
            jsonBuilder.Append("{\"");  
            jsonBuilder.Append(dt.TableName.ToString());  
            jsonBuilder.Append("\":[");  
            for (int i = 0; i < dt.Rows.Count; i++)  
            {  
                jsonBuilder.Append("{");  
                for (int j = 0; j < dt.Columns.Count; j++)  
                {  
                    jsonBuilder.Append("\"");  
                    jsonBuilder.Append(dt.Columns[j].ColumnName);  
                    jsonBuilder.Append("\":\"");  
                    jsonBuilder.Append(dt.Rows[i][j].ToString());  
                    jsonBuilder.Append("\",");  
                }  
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);  
                jsonBuilder.Append("},");  
            }  
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);  
            jsonBuilder.Append("]");  
            jsonBuilder.Append("}");  
            return jsonBuilder.ToString();  
        }  
#endregion  



    }
}