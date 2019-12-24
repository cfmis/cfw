using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.IO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;



//using DevExpress.Web.ASPxClasses.Internal;
//using System.IO;


namespace WebPortal
{
    /// <summary>
    ///Handler1 的摘要描述
    /// </summary>
    public class Handler1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");

            string jaa=Query(context);

            context.Response.Write(jaa);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        private string Query(HttpContext context)
        {


            string para=context.Request["param"];

            string jsonText = @"{""input"" : ""value"", ""output"" : ""result""}";

            JsonReader reader = new JsonTextReader(new StringReader(para));
            while (reader.Read())
            {
                Console.WriteLine(reader.TokenType + "\t\t" + reader.ValueType + "\t\t" + reader.Value);

            }

            string jsonArrayText1 = "[{'a':'a1','b':'b1'},{'a':'a2','b':'b2'}]";
            //jsonArrayText1="[{'id':'2017/12/26','mo_id':'TBE009852'},{'id':'2017/12/26','mo_id':'TBE009852'}]";
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            string jaa = "";
            string jab = "";
            for (int i = 0; i < ja.Count; i++)
            {
                jaa = ja[i]["order_date"].ToString();
                jab += ja[i]["id"].ToString() + "\t\t";
            }

            return jab;

        }


    }
}