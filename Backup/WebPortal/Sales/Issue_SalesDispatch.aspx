<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_Issue_SalesDispatch" Codebehind="Issue_SalesDispatch.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>发货问题件 处理</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        关联编号：<asp:Label ID="OrderID" runat="server"></asp:Label>&nbsp;<br />
        <br />
        问题描述：<asp:TextBox ID="issueInfo" runat="server" Height="37px" TextMode="MultiLine"
            Width="254px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="issueInfo"
            ErrorMessage="请输入内容"></asp:RequiredFieldValidator><br />
        <br />
        &nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="提交问题" Width="98px" /><br />
        <br />
    </div>
    </form>
</body>
</html>
