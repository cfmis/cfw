using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Leyp.SQLServerDAL;
using Leyp.SQLServerDAL.Sales;
using Leyp.Components;
using Leyp.Components.Module;
using System.Web.Services;
using System.IO;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebPortal.Sales
{
    public partial class Sa_Order_Trace_Excel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod] 
        private void Excel()
        {
            StrHelper StrHlp = new StrHelper();
            StrHlp.WebMessageBox(this.Page, "開單日期格式錯誤!");
        }
        [WebMethod]  
        public static string SayHello()
        {


            return "Hello Ajax!";


        }

        [WebMethod]
        public static string GetStr(string str, string str2)
        {
            return str + str2;
        }


        [WebMethod]
        public static string GetJson(string str)
        {
            return str;
        }
        
    }
}