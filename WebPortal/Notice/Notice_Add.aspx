<%@ Page Language="C#"  ValidateRequest="false" AutoEventWireup="true" Inherits="Notice_Notice_Add" Codebehind="Notice_Add.aspx.cs" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>信息添加</title>
    

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
        <br />
        <asp:SiteMapPath ID="SiteMapPath1" runat="server">
        </asp:SiteMapPath>
        <br />
        <br />
    <div class="horizBar" id="DIV1" style="width: 673px"><span class="title">
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Flow/PhotoFlow_List.aspx">返回列表</asp:HyperLink></span></div> <br />
        标题:<asp:TextBox ID="txtTitle" runat="server" Width="307px" CssClass="ButtonCss" Height="19px"></asp:TextBox>
        &nbsp; &nbsp; 
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitle"
            ErrorMessage="请输入标题"></asp:RequiredFieldValidator>
        &nbsp;&nbsp;&nbsp;&nbsp;<br />
        <br />
        信息类型 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:DropDownList ID="NewType"
            runat="server">
            <asp:ListItem Value="a">请选择</asp:ListItem>
            <asp:ListItem Value="0">通知</asp:ListItem>
            <asp:ListItem Value="1">热销</asp:ListItem>
            <asp:ListItem Value="2">内部会议</asp:ListItem>
        </asp:DropDownList><br />
        <br />
        
        <div class="horizBar" style="width: 683px"><span class="title">内容</span></div> <br />
       <!-- 
       
       <iframe ID="eWebEditor1" src="../ewebeditor/ewebeditor.asp?id=content&style=s_mini" frameborder="0" scrolling="no" width="650" HEIGHT="350"></iframe>
       -->
        <asp:TextBox ID="contents" runat="server" Height="116px" TextMode="MultiLine" Width="678px"></asp:TextBox><br />
        <br />
        <asp:Button ID="btnSubmit" runat="server"  Text="发　表" CssClass="ButtonCss" OnClick="btnSubmit_Click" />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp;
    </div>
    
    </div>
    </form>
</body>
</html>


