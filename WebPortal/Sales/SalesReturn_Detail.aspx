<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_SalesReturn_Detail" Codebehind="SalesReturn_Detail.aspx.cs" %>

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
    IDs=document.getElementById("SalesReturnID").value;
     var xmlHttps=this.createXmlHttp();                       
            xmlHttps.onreadystatechange = function() {
                if (xmlHttps.readyState == 4) {
                   
                      document.getElementById("initSubmitInfo").innerHTML=xmlHttps.responseText;
                      $('.flexme2').flexigrid();
                        $.unblockUI();//
                     
                }
            }
            xmlHttps.open("POST", "AjaxSalesReturn_load_Add_Edit_Del.aspx", true);
            xmlHttps.setRequestHeader("Content-type","application/x-www-form-urlencoded");
           xmlHttps.send("action=LoadDetail&SalesReturnID="+IDs);//   
   

}

</script>
</head>
<body onLoad="initload();">

<table style="width:96%;" >
<tr>
<td>

</td>
</tr>
<tr>
<td align="center" class="title">
    销售退货明细
</td>

</tr>
</table>
  <form id="form1" runat="server">

<TABLE id="Table1" cellspacing="0" cellpadding="1"  rules="all" bordercolor="Silver" border="1"  style="border-color:Silver;border-width:1px;border-style:solid;width:880;border-collapse:collapse;">
							<TR height="40px">
								<TH style="width: 85px; height: 40px;">
                                    单号：</TH>
								<TD style="width: 132px; height: 40px" ><span id="InstockId">
                                    <asp:TextBox ID="SalesReturnID" runat="server" CssClass="txt_left" ></asp:TextBox></span></TD>
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
            库房/库区</th>
        <td style="width: 132px; height: 40px">
            &nbsp;<asp:TextBox ID="house" runat="server" CssClass="txt_left"></asp:TextBox></td>
        <th bgcolor="#ffffff" style="width: 91px; height: 40px">
            <span style="font-size: 10pt; font-family: Times New Roman">执行</span>日期</th>
        <td bgcolor="#ffffff" style="width: 105px; height: 40px">
            <asp:TextBox ID="TradeDate" runat="server" CssClass="txt_left"></asp:TextBox></td>
        <th bgcolor="#ffffff" style="width: 79px; height: 40px">
            &nbsp;&nbsp; 
                                    状态：</th>
        <td bgcolor="#ffffff" style="width: 98px; height: 40px">
            &nbsp;<asp:Label ID="State" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr height="40">
        <th style="width: 85px; height: 40px">
       订金
            <!--EndFragment-->
        </th>
        <td style="width: 132px; height: 40px">
            <asp:TextBox ID="Deposits" runat="server" CssClass="txt_left"></asp:TextBox></td>
        <th bgcolor="#ffffff" style="width: 91px; height: 40px">
            退库方式&nbsp;</th>
        <td bgcolor="#ffffff" style="width: 105px; height: 40px">
            <asp:TextBox ID="ReturnType" runat="server" CssClass="txt_left"></asp:TextBox></td>
        <th bgcolor="#ffffff" style="width: 79px; height: 40px">
            销售出单</th>
        <td bgcolor="#ffffff" style="width: 98px; height: 40px">
            <asp:TextBox ID="SalesOutID" runat="server" CssClass="txt_left" Width="150px" ></asp:TextBox></td>
    </tr>
							<TR height="40px">
								<TH bgcolor=#FFFFFF style="width: 85px">备&nbsp;&nbsp;&nbsp;&nbsp;注：</TH>
								<TD  colspan="7">
                                    <asp:TextBox ID="Description" runat="server" Width="657px" CssClass="txt_left"></asp:TextBox></TD>
							</TR>
						</TABLE>
      <br />
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



