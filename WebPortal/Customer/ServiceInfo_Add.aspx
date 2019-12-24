<%@ Page Language="C#" AutoEventWireup="true" Inherits="Customer_ServiceInfo_Add" Codebehind="ServiceInfo_Add.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc1" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>信息添加</title>
    
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
    <div  id="DIV1" style="width: 905px">
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Customer/My_ServiceInfoList.aspx">返回列表</asp:HyperLink></div>
        <asp:Panel ID="Panel1" runat="server" Width="100%">
        
        
    <div id="page">
     <br />
        问题主题:<asp:TextBox ID="ServiceTitle" runat="server" Width="307px" CssClass="ButtonCss" Height="19px"></asp:TextBox>
        &nbsp; &nbsp; 
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ServiceTitle"
            ErrorMessage="请输入标题"></asp:RequiredFieldValidator>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
        <br />
        问题类型 &nbsp; &nbsp;<cc1:ServiceTypeDropDownList ID="ServiceTypeDropDownList1" runat="server">
        </cc1:ServiceTypeDropDownList><br />
        <br />
        关联销售订单 &nbsp; &nbsp;&nbsp;
        <asp:TextBox ID="SalesOrderID" runat="server" Width="210px"></asp:TextBox>
        &nbsp; 若无不用填写<br />
        <br />
        
        <div class="horizBar" style="width: 670px"><span class="title">内容</span></div>
        <br />
        &nbsp;<asp:TextBox ID="Content" runat="server" Height="133px" TextMode="MultiLine"
            Width="672px"></asp:TextBox><br />
        &nbsp;
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Content"
            ErrorMessage="请输入内容"></asp:RequiredFieldValidator><br />
        <br />
        <asp:Button ID="btnSubmit" runat="server"  Text="发　表" CssClass="ButtonCss" OnClick="btnSubmit_Click" /><br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp;
    </div>
        
        
        </asp:Panel>
        
        
        
        <asp:Panel ID="Panel2" runat="server" Visible="false" Height="50px" Width="100%">
        
           添加成功
        </asp:Panel>
    </div>
    </form>
</body>
</html>


