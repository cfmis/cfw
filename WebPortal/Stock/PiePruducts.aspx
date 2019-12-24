<%@ Page Language="C#" AutoEventWireup="true" Inherits="Stock_PiePruducts" Codebehind="PiePruducts.aspx.cs" %>
<%@ Register assembly="Chartlet" namespace="FanG" tagprefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>图形统计</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Stock/Stock_ProductsView.aspx">返回上一页统计</asp:HyperLink><br />
        <br />
        <br />
    
     <cc1:Chartlet ID="Chartlet1" runat="server" ChartType="Pie" />
    </div>
    </form>
</body>
</html>
