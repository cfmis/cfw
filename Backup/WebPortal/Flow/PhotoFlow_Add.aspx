<%@ Page Language="C#" AutoEventWireup="true" Inherits="Flow_PhotoFlow_Add" Codebehind="PhotoFlow_Add.aspx.cs" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>无标题页</title>
    
    <link href="Css.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    body {
	FONT-SIZE: 12px;
	COLOR: #333;
	FONT-FAMILY: 'Lucida Grande', Verdana, Arial, Sans-Serif;
	background-color: #FFFFFF;
	margin-top: 1px;
	text-align: center;
	margin-bottom: 1px;

	}
a:visited,
a:active,
a:link {
 color:#0279CB;
 text-decoration:none;
 }
a:hover {
 color:#00A4E3;
 text-decoration:none;
 BORDER-BOTTOM: 1px dotted;
}
#page{
text-align:left;
padding-left:10px;
padding-top:2px;
	margin-top:1px;
	margin-bottom:1px;

}
.horizBar
{
	background-color:#E5EEF7;
	width:700px;
	height:20px;
	border-bottom: 1px;
	border-top:1px thin;
	padding-left:10px;
	text-align: left;
	padding-top: 5px;
	margin-top:1px;
	margin-bottom:1px;
}
.title{
FONT-WEIGHT: bold; font: "Times New Roman", Times, serif;
font-size:13px;
color:#0279CB;
}
INPUT
{
   margin-top :1px;
	margin-bottom:1px;
	padding-bottom:1px;
	padding-top:1px;
	
}

    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div id="page">
    <div class="horizBar" id="DIV1" style="width: 673px"><span class="title">
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Flow/PhotoFlow_List.aspx">返回列表</asp:HyperLink></span></div> <br />
        标题:<asp:TextBox ID="txtTitle" runat="server" Width="307px" CssClass="ButtonCss" Height="19px"></asp:TextBox>
        &nbsp; &nbsp; 
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitle"
            ErrorMessage="请输入标题"></asp:RequiredFieldValidator>
        &nbsp;&nbsp;<br />
        &nbsp;<br />
        
        <div class="horizBar" style="width: 683px"><span class="title">内容</span></div><input type="hidden" name="content" id="content" value="" runat="server"> <br />
       <iframe ID="eWebEditor1" src="../ewebeditor/ewebeditor.asp?id=content&style=s_mini" frameborder="0" scrolling="no" width="650" HEIGHT="300"></iframe>
        <br />
        <br />
        <asp:Button ID="btnSubmit" runat="server"  Text="发　表" CssClass="ButtonCss" OnClick="btnSubmit_Click" />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <input id="Reset1" type="reset" value="重　置" class="ButtonCss" /></div>
    
    </div>
    </form>
</body>
</html>

