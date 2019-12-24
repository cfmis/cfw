<%@ Page Language="C#" AutoEventWireup="true" Inherits="Notice_Notice_Detail" Codebehind="Notice_Detail.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>详细</title>
        <link href="../css/base.css" rel="stylesheet" type="text/css" />

  
	
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


</script>
</head>
<body >
    系统公布
      <asp:HyperLink ID="HyperLink1" runat="server" ImageUrl="~/images/Delete.gif">HyperLink</asp:HyperLink><br />
    <br />
 

<table style="width:96%;" >
<tr>
<td style="height: 39px" align="center">
    
        <asp:Label ID="titles" runat="server"></asp:Label>
    <br />
    <hr />


</td>
</tr>
    <tr>
        <td style="height: 45px">
            发布时间：<asp:Label ID="CreateDate" runat="server" Text=""></asp:Label>&nbsp; 发布用户
            ：&nbsp;
            <asp:Label ID="User" runat="server" Text="Label"></asp:Label><br />
            <hr />
        </td>
    </tr>
<tr>
<td align="center" style="height: 82px" >
    <asp:Label ID="Infos" runat="server" Text=""></asp:Label></td>

</tr>
</table>
  <form id="form1" runat="server">
						
						&nbsp;
						
						

&nbsp;&nbsp; &nbsp;
						
						

</form>
</body>
</html>
