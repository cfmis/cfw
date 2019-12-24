<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_PrintOrderInfo" Codebehind="PrintOrderInfo.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>打印发货单信息</title>
</head>
<body>
    <form id="form1" runat="server">
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Sales/Manager_SalesDispatchOrder.aspx">返回列表</asp:HyperLink>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 等待发货发货单打印<br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <table border="1" style="width: 701px">
            <tr>
                <td style="width: 144px; height: 53px">
                    圆通快递</td>
                <td style="width: 608px; height: 53px">
                    
                    <asp:HyperLink ID="YTButton" runat="server" NavigateUrl="~/Sales/PrintSalesSentOrder_YT.aspx" Target="_blank">[YTButton]</asp:HyperLink></td>
                <td style="height: 53px">
                    </td>
            </tr>
            <tr>
                <td style="width: 144px; height: 80px">
                    平邮快递</td>
                <td style="width: 608px; height: 80px">
                    
                    <asp:HyperLink ID="PYButton" runat="server" NavigateUrl="~/Sales/PrintSalesSentOrder_PY.aspx" Target="_blank">[PYButton]</asp:HyperLink></td>
                <td style="height: 80px">
                </td>
            </tr>
            <tr>
                <td style="width: 144px; height: 63px">
                    申通快递</td>
                <td style="width: 608px; height: 63px">
                   
                    <asp:HyperLink ID="STButton" runat="server" NavigateUrl="~/Sales/PrintSalesSentOrder_ST.aspx" Target="_blank">[STButton]</asp:HyperLink></td>
                <td style="height: 63px">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
