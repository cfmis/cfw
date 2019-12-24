<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExportToExcel.aspx.cs" Inherits="WebPortal.ExportToExcel" ValidateRequest="false" %>

<%--当URL中存在“<,>,*,%,&,:,/”特殊字符时，页面会抛出A potentially dangerous Request.Path value was detected from the client异常。
這裡要加入： ValidateRequest="false"--%>

<%--<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>--%>
