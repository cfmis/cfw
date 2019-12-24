<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_ManagerAuditingSalesOut" Codebehind="ManagerAuditingSalesOut.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>订单详细</title>
        <link href="../css/base.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>

   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/jquery.blockUI.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
	<script type="text/javascript" src="../js/jquery.blockUI.js"></script>
	
<STYLE type=text/css> 
{
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px
}
HTML {
	HEIGHT: 100%; TEXT-ALIGN: center
}
BODY {
	margin-left: 10px; FONT: 12px 'Lucida Grande', Verdana, Arial, Sans-Serif; COLOR: #646464; HEIGHT: 100%; BACKGROUND-COLOR: #fff; TEXT-ALIGN: left
}
A:link {
	COLOR: #646464; TEXT-DECORATION: none
}
A:visited {
	COLOR: #646464; TEXT-DECORATION: none
}
A:active {
	COLOR: #fff; BACKGROUND-COLOR: #ff6600; TEXT-DECORATION: none
}
A:hover {
	COLOR: #f60; BACKGROUND-COLOR: #fff; TEXT-DECORATION: none
}
.bar {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 4px; WIDTH: auto; PADDING-TOP: 4px; BORDER-BOTTOM: #efefef 1px solid; HEIGHT: 20px; BACKGROUND-COLOR: #fafafa
}
.title
{
	font-weight: bolder;
	font-size: 18pt;
	color: black;
	line-height: 150%;
	font-family: 楷体_GB2312;
	text-decoration: underline;
}

.RowHeader2 {
	FONT-WEIGHT: 400; PADDING-TOP: 0.5em; BORDER-BOTTOM: #b7c0c7 1px solid; HEIGHT: 25px; BACKGROUND-COLOR: #f2f6ff
}

TD.MenuLeft {
	WHITE-SPACE: nowrap
}

.Indent1 {
	BORDER-TOP: #ddd 1px solid; PADDING-LEFT: 20px
}

.Normal {
	BORDER-TOP: #ddd 1px solid
}.txt_center
{
	border-right: gray 0px solid;
	border-top: gray 0px solid;
	border-left: gray 0px solid;
	border-bottom: gray 0px solid;
	height: 19px;
	font-size: 9pt;
	vertical-align: baseline;
	cursor: text;
	line-height: 150%;
	background-color: transparent;
	text-align: center;
	text-decoration: none;
}
</STYLE>


<script type="text/javascript">

function initload()
{
     $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
    var IDs = "";
    IDs=document.getElementById("SalesOutID").value;
     var xmlHttps=this.createXmlHttp();                       
            xmlHttps.onreadystatechange = function() {
                if (xmlHttps.readyState == 4) {
                   
                      document.getElementById("initSubmitInfo").innerHTML=xmlHttps.responseText;
                      $('.flexme2').flexigrid();
                        $.unblockUI();//
                     
                }
            }
            xmlHttps.open("POST", "AjaxSalesOutDetail_load_Add_Edit_Del.aspx", true);
            xmlHttps.setRequestHeader("Content-type","application/x-www-form-urlencoded");
           xmlHttps.send("action=LoadDetail&SalesOutID="+IDs);//   
   

}

function check()
{
  var str=document.getElementById("TradeDate").value;
  var str1=document.getElementById("Consignee").value;
  
  if(str=="")
  {
  alert("发货日期不能空");
  return false;
  }
  
  if(str1=="")
  {
  alert("请填写领取货物人员");
  return false;
  }
  
  return true;

}

</script>
</head>
<body onLoad="initload();">
<div align="center"  >
  <form id="form1" runat="server">
    <br /><table  width="800" >
        <tr>
            <td align="left"  style="height: 20px">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                未审核单据数量:<asp:Label ID="AuditingCount" runat="server" Text="0"></asp:Label></td>
        </tr>
    </table>
    <br />

<table  width="800" >
<tr>
<td align="center" class="title">
    销售开单明细
</td>

</tr>
</table>


<TABLE id="Table1" cellspacing="0" cellpadding="1" width="800"  rules="all" bordercolor="Silver" border="1"  >
							<TR height="40px">
								<TH style="width: 85px; height: 40px;">
                                    开单单号：</TH>
								<TD style="width: 132px; height: 40px" ><span id="InstockId">
                                    <asp:TextBox ID="SalesOutID" runat="server" CssClass="txt_left" Width="173px" ReadOnly="True"></asp:TextBox></span></TD>
								<TH bgcolor=#FFFFFF style="width: 91px; height: 40px">
                                制单日期
                                </TH>
								<TD bgcolor=#FFFFFF style="width: 105px; height: 40px"><span id="Instockdata">
                                    <asp:TextBox ID="CreateDate" runat="server" CssClass="txt_left"></asp:TextBox></span></TD>
								<TH bgcolor=#FFFFFF style="width: 79px; height: 40px">制 单 人：</TH>
								<TD bgcolor=#FFFFFF style="width: 98px; height: 40px"><span id="zdrLabel">
                                    <asp:TextBox ID="RealName" runat="server" Width="107px" CssClass="txt_left"></asp:TextBox></span></TD>
							</TR>
    <tr height="40">
        <th style="width: 85px; height: 40px">
            销售订单</th>
        <td style="width: 132px; height: 40px">
            &nbsp;<asp:TextBox ID="SalesOrderID" runat="server" CssClass="txt_left" Width="169px"></asp:TextBox></td>
        <th bgcolor="#ffffff" style="width: 91px; height: 40px">
            <span style="font-size: 9pt;">
            收款帐号&nbsp;</span></th>
        <td bgcolor="#ffffff" style="width: 105px; height: 40px">
            <asp:TextBox ID="AccountsName" runat="server" CssClass="txt_left" Width="170px"></asp:TextBox></td>
        <th bgcolor="#ffffff" style="width: 79px; height: 40px">
            &nbsp;&nbsp; 
                                    状态：</th>
        <td bgcolor="#ffffff" style="width: 98px; height: 40px">
            &nbsp;<asp:Label ID="State" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr height="40">
        <th style="width: 85px; height: 40px">
            配送方式<!--EndFragment--></th>
        <td style="width: 132px; height: 40px" align="left">
            <asp:Label ID="DeliveryName0" runat="server"></asp:Label></td>
        <th bgcolor="#ffffff" style="width: 91px; height: 40px" align="center">
            &nbsp;顾客电话</th>
        <td bgcolor="#ffffff" style="width: 105px; height: 40px" align="left">
            <asp:Label ID="CustomerTel" runat="server" Text=""></asp:Label></td>
        <th bgcolor="#ffffff" style="width: 79px; height: 40px" align="left">
            顾客所在地区</th>
        <td bgcolor="#ffffff" style="width: 98px; height: 40px" align="left">
            <asp:Label ID="CustomerArea" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr height="40">
        <th style="width: 85px">
            顾客聊号</th>
        <td style="width: 132px">
            <asp:TextBox ID="CustomerID" runat="server" CssClass="txt_left" ReadOnly="True" Width="135px">无记录</asp:TextBox></td>
        <th style="width: 91px">
            顾客邮编</th>
        <td style="width: 114px" align="left">
            <asp:Label ID="CustomerPost" runat="server" Text=""></asp:Label></td>
        <th style="width: 79px">
        </th>
        <td style="width: 98px">
        </td>
    </tr>
    <tr height="40">
        <th style="width: 85px; height: 40px;">
            送达地址：</th>
        <td colspan="5" style="height: 40px" align="left">
                                    <asp:TextBox ID="TradePlace" runat="server" Width="536px" CssClass="txt_left"></asp:TextBox>
            &nbsp; &nbsp; 
        </td>
    </tr>
							<TR height="40px">
								<TH bgcolor=#FFFFFF style="width: 85px">备&nbsp;&nbsp;&nbsp;&nbsp;注：</TH>
								<TD  colspan="7" align="left">
                                    <asp:Label ID="Description" runat="server" Text=""></asp:Label></TD>
							</TR>
						</TABLE>
      <br />
    合计金额：<asp:Label ID="TotalPrice" runat="server" ></asp:Label>
      &nbsp; = &nbsp;<asp:Label ID="ProductsPrice" runat="server"></asp:Label>
      &nbsp;- （折扣金额：
      <asp:Label ID="Discount" runat="server" ></asp:Label>） &nbsp; + （ 附加费（运费）：<asp:Label
          ID="AttachPay" runat="server"></asp:Label>
      ）<table  width="600">
						<tr>
						
						<td style="height: 30px">
 <DIV id="initSubmitInfo" style="width:100%">
        
        
</DIV>
						</td>
						</tr>
						
						</table>
      <br />
      <table style="width:96%;" >
          <tr>
              <td align="center" >
                  <span style="font-size: 10pt; font-family: Times New Roman">发货</span>日期 &nbsp; &nbsp;
                  <asp:TextBox ID="TradeDate" runat="server" CssClass="txt_left"></asp:TextBox>
                  &nbsp; &nbsp;
                  <img alt="弹出日历下拉菜单" height="16" onclick="fPopUpCalendarDlg(TradeDate);return false;"
                      src="../images/calendar.gif" style="cursor: hand" width="16" />&nbsp;
            领货人
            <asp:TextBox ID="Consignee" runat="server" CssClass="txt_left"></asp:TextBox></td>
          </tr>
      </table>
      <br />
  <table style="width:96%;" >
        <tr>
            <td align="center" >
                <asp:Button ID="shenhe" runat="server"　　 OnClientClick="return check()" Text="审核并浏览下一个" OnClick="shenhe_Click" />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
                <asp:Button ID="deleteButton" OnClientClick="javascript:if(!confirm('您确定要删除订单吗'))return  false;" runat="server" Text="删除单据并浏览下一个" OnClick="deleteButton_Click" Width="197px" /></td>
        </tr>
    </table>
						
						

</form>
    </div>
</body>
</html>


