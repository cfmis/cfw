<%@ Page Language="C#" AutoEventWireup="True" Inherits="Test" Codebehind="Test.aspx.cs" %>

<%@ Register assembly="Chartlet" namespace="FanG" tagprefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>

</head>
<body>
    <form id="form1" runat="server">

  <cc1:Chartlet ID="Chartlet1" runat="server" ChartType="Pie" />
    

    </form>
</body>
</html>
