<%@ Page Language="C#" AutoEventWireup="true" Inherits="Buy_BuyOrder_Detail" Codebehind="BuyOrder_Detail.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>采购订单详细</title>
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
    var BuyOrderIDs = "";
    BuyOrderIDs=document.getElementById("BuyOrderID").value;
     var xmlHttps=this.createXmlHttp();                       
            xmlHttps.onreadystatechange = function() {
                if (xmlHttps.readyState == 4) {
                   
                      document.getElementById("initSubmitInfo").innerHTML=xmlHttps.responseText;
                      $('.flexme2').flexigrid();
                        $.unblockUI();//
                     
                }
            }
            xmlHttps.open("POST", "AjaxBuyDetail_Add.aspx", true);
            xmlHttps.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttps.send("action=loadDetail&BuyOrderID="+BuyOrderIDs);//  
   

}

</script>
</head>
<body onLoad="initload();">
 
<OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0> 
</OBJECT>
<table style="width:96%;" >
<tr>
<td>

</td>
</tr>
<tr>
<td align="center" class="title">
    采购单明细
</td>

</tr>
</table>
  <form id="form1" runat="server">

<TABLE id="Table1" cellspacing="0" cellpadding="1"  rules="all" bordercolor="Silver" border="1"  style="border-color:Silver;border-width:1px;border-style:solid;width:90%;border-collapse:collapse;">
							<TR height="40px">
								<TH style="width: 78px; height: 40px;">
                                    采购单号：</TH>
								<TD style="width: 132px; height: 40px" ><span id="InstockId">
                                    <asp:TextBox ID="BuyOrderID" runat="server" CssClass="txt_left" Width="154px"></asp:TextBox></span></TD>
								<TH bgcolor=#FFFFFF style="width: 91px; height: 40px">制单日期：</TH>
								<TD bgcolor=#FFFFFF style="width: 114px; height: 40px"><span id="Instockdata">
                                    <asp:TextBox ID="BuyOrderDate" runat="server" CssClass="txt_left"></asp:TextBox></span></TD>
								<TH bgcolor=#FFFFFF style="width: 79px; height: 40px">制 单 人：</TH>
								<TD bgcolor=#FFFFFF style="width: 98px; height: 40px"><span id="zdrLabel">
                                    <asp:TextBox ID="RealName" runat="server" Width="107px" CssClass="txt_left"></asp:TextBox></span></TD>
							</TR>
							<TR height="40px">
								<TH style="width: 78px">
                                    库房/库&nbsp;位：</TH>
								<TD style="width: 132px"><span id="rklbLabel">
                                    <asp:TextBox ID="HouseName" runat="server" CssClass="txt_left"></asp:TextBox></span></TD>
								<TH style="width: 91px" >
                                    业务代表：</TH>
								<TD style="width: 114px" ><span id="jzpzLabel">
                                    <asp:TextBox ID="Delegate" runat="server" CssClass="txt_left"></asp:TextBox></span></TD>
								<TH style="width: 79px" >
                                    状态：</TH>
								<TD style="width: 98px" >							
                                    <asp:Label ID="Label1" runat="server"></asp:Label></TD>
							</TR>
    <tr height="40">
        <th style="width: 78px">
                                    签订日期：</th>
        <td style="width: 132px">
                                    <asp:TextBox ID="SignDate" runat="server" Width="108px" CssClass="txt_left"></asp:TextBox></td>
        <th style="width: 91px">
                                    交货日期：</th>
        <td style="width: 114px">
                                    <asp:TextBox ID="TradeDate" runat="server" Width="107px" CssClass="txt_left"></asp:TextBox></td>
        <th style="width: 79px">
        </th>
        <td style="width: 98px">
        </td>
    </tr>
							<TR height="40px">
								<TH style="width: 78px" >
                                    交货地址:</TH>
								<TD colspan="7">
                                    <asp:TextBox ID="TradeAddress" runat="server" Width="485px" CssClass="txt_left"></asp:TextBox></TD>
							</TR>
							<TR height="40px">
								<TH bgcolor=#FFFFFF style="width: 78px">备&nbsp;&nbsp;&nbsp;&nbsp;注：</TH>
								<TD  colspan="7">
                                    <asp:TextBox ID="Description" runat="server" Width="657px" CssClass="txt_left"></asp:TextBox></TD>
							</TR>
						</TABLE>
						
						<table style="width:90%">
						<tr>
						
						<td>
 <DIV id="initSubmitInfo" style="width:100%">
        
        
</DIV>
						</td>
						</tr>
						
						</table>
						
						

</form>
    <img src="../images/ico5.gif" />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Buy/BuyOrder_Detail_Photo.aspx"
        Target="_blank">该订单商品图片</asp:HyperLink>
</body>
</html>
