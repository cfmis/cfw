using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Leyp.Components;
using Leyp.Components.Module;
using Leyp.SQLServerDAL;
using System.Text;

namespace WebPortal.Sales
{
    public partial class Sa_OrderTest_Trace_Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void btnExpToExcel_Click(object sender, EventArgs e)
        {
            //string mo_group = selMo_group.Value;
            //string date_from = txtDate_from.Value;
            //string mo_id = txtMo.Value;
            //DataTable dt = Leyp.SQLServerDAL.Sales.Factory_New.SaOrderTestTraceDAL().getRecByMo(mo_group, date_from, date_to, mo_id);
            //AlertMsgAndNoFlush(, "開單日期格式錯誤!");
            //string content = getExcelContent();
            //string css = ".firstTR td{color:blue;width:100px;}.secondTR td{color:blue;width:100px;}";
            //string filename = "制單追蹤表.xls";
            //filename = System.Web.HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
            //clsPublic cl = new clsPublic();
            //cl.ExportToExcel(filename, content, css);
        }

        /// <summary>  
        /// 弹出消息框  
        /// </summary>  
        /// <param name="controlName">控件名称</param>  
        /// <param name="message">消息内容</param>  
        protected static void AlertMsgAndNoFlush(Control controlName, string message)
        {
            //string sMessage = ErrMsg(message);  
            ScriptManager.RegisterClientScriptBlock(controlName, typeof(UpdatePanel), "提示", "alert('" + message + "');", true);
        }

    }
}