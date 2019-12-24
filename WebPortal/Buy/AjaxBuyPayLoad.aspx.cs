using System;
using System.Data;
using System.Text;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model.Buy;

public partial class Buy_AjaxBuyPayLoad : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

     if (!IsPostBack)
        {
            init();
        }
    }

    protected void init()
    {
        string ID = Request.Form["BuyReceiptID"].ToString();

        List<VBuyPay> list = new List<VBuyPay>();
        list = Leyp.SQLServerDAL.Buy.Factory.getBuyPayDAL().getByBuyReceiptID(ID);
        float tatal = float.Parse("0.00");
        StringBuilder sb = new StringBuilder();


        sb.Append("<table   class=\"flexme2\"><thead><tr><th width=\"100\">票  号</th><th width=\"100\">制单日期</th><th width=\"90\">制 单 人</th><th width=\"80\">付款方式 </th><th width=\"100\">实付金额</th><th width=\"120\">附加支出金额 </th><th width=\"70\">状态</th><th width=\"150\">摘要 </th></tr>");
        sb.Append("	</thead><tbody>");
        for (int i = 0; i < list.Count; i++)
        {
            VBuyPay v = new VBuyPay();
            v = list[i];
            sb.Append("<tr>");
            sb.Append("	<td>" + v.Ticket + "</td>");
            sb.Append("	<td>" + v.CreateDate + "</td>");
            sb.Append("	<td>" + v.RealName + "</td>");
            sb.Append("	<td>" + v.PayType + "</td>");
            sb.Append("	<td>" + v.RealPay.ToString() + "</td>");
            sb.Append("	<td>" + v.AttachPay.ToString() + "</td>");
            sb.Append("	<td>" + changString(v.State.ToString()) + "</td>");
            sb.Append("	<td>" + v.Description.ToString() + "</td>");
            sb.Append("</tr>");

        }
        sb.Append("</tbody></table>");
        Response.Write(sb.ToString());
        Response.End();


    }
    public string changString(string str)
    {
        if (str.Equals("0"))
        {
            return "<font color=\"#FF0000\">未审</font>";
        }
        else if (str.Equals("1"))
        {
            return "<font color=\"#009933\">已审</font>";
        }
        else if (str.Equals("2"))
        {
            return "<font color=\"#666666\">未知</font>";
        }
        else
        {
            return str;
        }


    }

}
