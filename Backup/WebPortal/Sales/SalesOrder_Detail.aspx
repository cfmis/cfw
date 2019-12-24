<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_SalesOrder_Detail" Codebehind="SalesOrder_Detail.aspx.cs" %>

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
    IDs=document.getElementById("SalesOrderID").value;
     var xmlHttps=this.createXmlHttp();                       
            xmlHttps.onreadystatechange = function() {
                if (xmlHttps.readyState == 4) {
                   
                      document.getElementById("initSubmitInfo").innerHTML=xmlHttps.responseText;
                      $('.flexme2').flexigrid();
                        $.unblockUI();//
                     
                }
            }
            xmlHttps.open("POST", "AjaxSalesOrderLoad.aspx", true);
            xmlHttps.setRequestHeader("Content-type","application/x-www-form-urlencoded");
           xmlHttps.send("action=LoadDetail_Detail&SalesOrderID="+IDs);//   
   

}

function init2()
{
 var str=trim(document.getElementById("CustomerID").value);
 var sLength=str.length;
 if(sLength < 3)
 {
  return;
 }
 var checkstr=str.substring(0,2);
 var lastStr=str.substring(3,sLength);

 if(checkstr=="QQ")
 {
   document.getElementById("CustomerID").value="QQ号:"+lastStr;
 }else if(checkstr=="WW")
 {
   document.getElementById("CustomerID").value="旺旺号:"+lastStr;
 }else
 {
  document.getElementById("CustomerID").value="其它标识：:"+lastStr;
 
 }
 
 

}

//去左右空格; 
function trim(s){
     return rtrim(ltrim(s)); 
}
//去左空格; 
function ltrim(s){
     return s.replace( /^\s*/, ""); 
} 
//去右空格; 
function rtrim(s){ 
     return s.replace( /\s*$/, ""); 
}


</script>
</head>
<body onLoad="initload();init2()">

<table style="width:96%;" >
<tr>
<td>

</td>
</tr>
<tr>
<td align="center" class="title">
    销售订单明细
</td>

</tr>
</table>
  <form id="form1" runat="server">

<TABLE id="Table1" cellspacing="0" cellpadding="1"  rules="all" bordercolor="Silver" border="1"  style="border-color:Silver;border-width:1px;border-style:solid;width:90%;border-collapse:collapse;">
							<TR height="40px">
								<TH style="width: 85px; height: 40px;">
                                    单号：</TH>
								<TD style="width: 132px; height: 40px" ><span id="InstockId">
                                    <asp:TextBox ID="SalesOrderID" runat="server" Width="174px" CssClass="txt_left" ReadOnly="True"></asp:TextBox></span></TD>
								<TH bgcolor=#FFFFFF style="width: 91px; height: 40px; font-family: Verdana;">
                                    <p class="p0" style="margin-top: 0pt; margin-bottom: 0pt">
                                        <span >制 单 人：</span></p>
                                </TH>
								<TD bgcolor=#FFFFFF style="width: 114px; height: 40px"><span id="Instockdata">
                                    <asp:Label ID="RealName" runat="server" Text=""></asp:Label></span></TD>
								<TH bgcolor=#FFFFFF style="width: 79px; height: 40px">
                                    状态：</TH>
								<TD bgcolor=#FFFFFF style="width: 98px; height: 40px"><span id="zdrLabel">
                                    <asp:Label ID="State" runat="server" Text=""></asp:Label></span></TD>
							</TR>
    <tr height="40">
        <th style="width: 85px; height: 40px">
            订单类型</th>
        <td style="width: 132px; height: 40px">
            <asp:Label ID="SalesTypeName" runat="server" Text=""></asp:Label>&nbsp;</td>
        <th bgcolor="#ffffff" style="width: 91px; height: 40px">
            制单日期</th>
        <td bgcolor="#ffffff" style="width: 114px; height: 40px">
            &nbsp;<asp:Label ID="CreateDate" runat="server" Text=""></asp:Label></td>
        <th bgcolor="#ffffff" style="width: 79px; height: 40px">
            店铺号</th>
        <td bgcolor="#ffffff" style="width: 98px; height: 40px">
            <asp:Label ID="ShopID" runat="server" Text="无记录"></asp:Label></td>
    </tr>
							<TR height="40px">
								<TH style="width: 85px">
                                    交货方式</TH>
								<TD style="width: 132px"><span id="rklbLabel">
                                   
                                    <asp:Label ID="DeliveryType" runat="server" ></asp:Label></span></TD>
								<TH style="width: 91px" >
                                    <p class="p0" style="margin-top: 0pt; margin-bottom: 0pt">
                                        <span style="font-size: 10pt; font-family: 'Times New Roman'; mso-spacerun: 'yes'">结算方式</span></p>
                                    <!--EndFragment-->
                                </TH>
								<TD style="width: 114px" ><span id="jzpzLabel">
                                    <asp:Label ID="ClosingType" runat="server" Text=""></asp:Label></span></TD>
								<TH style="width: 79px" >
            消费平台</TH>
								<TD style="width: 98px" >							
            <asp:Label ID="PlatformName" runat="server" Text=""></asp:Label></TD>
							</TR>
    <tr height="40">
        <th style="width: 85px">
            顾客聊号</th>
        <td style="width: 132px">
           
            <asp:TextBox ID="CustomerID" CssClass="txt_left" runat="server" Width="135px" ReadOnly="True">无记录</asp:TextBox></td>
        <th style="width: 91px">
            顾客所在地区</th>
        <td style="width: 114px">
            <asp:Label ID="CustomerArea" runat="server" Text=""></asp:Label></td>
        <th style="width: 79px">
            </th>
        <td style="width: 98px">
            </td>
    </tr>
    <tr height="40">
        <th style="width: 85px">
            顾客电话</th>
        <td style="width: 132px">
            <asp:Label ID="CustomerTel" runat="server" Text=""></asp:Label></td>
        <th style="width: 91px">
            顾客邮编</th>
        <td style="width: 114px">
            <asp:Label ID="CustomerPost" runat="server" Text=""></asp:Label></td>
        <th style="width: 79px">
        </th>
        <td style="width: 98px">
        </td>
    </tr>
    <tr height="40">
        <th style="width: 85px; height: 40px;">
            交货地点：</th>
        <td colspan="5" style="height: 40px">
            <asp:Label ID="DeliveryPlace" runat="server" Text=""></asp:Label>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
            <!--EndFragment-->
        </td>
    </tr>
							<TR height="40px">
								<TH bgcolor=#FFFFFF style="width: 85px">备&nbsp;&nbsp;&nbsp;&nbsp;注：</TH>
								<TD  colspan="7">
                                    <asp:Label ID="Description" runat="server" Text=""></asp:Label></TD>
							</TR>
						</TABLE>
      <br />
      附加金额（运费）: &nbsp; &nbsp;
      <asp:Label ID="Label2" runat="server" ></asp:Label>
      &nbsp; &nbsp; &nbsp; &nbsp;折让金额： &nbsp;<asp:Label ID="Discount" runat="server" ></asp:Label>
      &nbsp; &nbsp;
    合计金额：<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
						
						<table style="width:90%">
						<tr>
						
						<td>
 <DIV id="initSubmitInfo" style="width:100%">
        
        
</DIV>
						</td>
						</tr>
						
						</table>
						
						

</form>
</body>
</html>


