<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_PrintSalesSentOrder_YT" Codebehind="PrintSalesSentOrder_YT.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>圆通快递单打印</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
    
    
        <asp:DataList ID="DataList1" runat="server">
            <ItemTemplate>
               <table width="200" border="0">
  <tr>
    <td>
       <strong> NO:</strong><%#Eval("SalesOutID")%></td>
  </tr>
  <tr>
    <td>
	
	<table width="867" height="480" border="0" background="../images/yuanTong.jpg">
  
  <tr>
    <td><table width="851" border="0" style="height: 451px">
      <tr　style="height: 68px">
        <td height="68" rowspan="2" style="width: 137px">&nbsp;</td>
        <td rowspan="2" style="width: 229px">&nbsp;</td>
        <td width="420" style="height: 38px">&nbsp;</td>
        <td width="49" rowspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td style="height: 34px" valign="bottom" >&nbsp;&nbsp;&nbsp;　　<strong><%#Eval("CustomerName")%></strong>
        </td>
      </tr>
      <tr>
        <td style="height: 21px; width: 137px;">&nbsp;</td>
        <td style="height: 21px; width: 229px;"><strong>乐易拍.广州1号仓
          2009.1.14 广州白云区平英新村</strong></td>
        <td style="height: 21px">&nbsp;&nbsp;&nbsp;　　<strong>　<%#Eval("DeliveryPlace")%></strong></td>
        <td style="height: 21px">&nbsp;</td>
      </tr>
      <tr>
        <td style="width: 137px; height: 87px;">&nbsp;</td>
        <td style="width: 229px; height: 87px"><strong>团购批发/学生兼职（QQ：350401）</strong></td>
        <td valign="top" style="height: 87px">
            <table style="width: 306px; height: 45px">
                <tr>
                    <td style="width: 33px">
                    </td>
                    <td style="width: 59px">
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;　　<strong><%#Eval("CustomerTel")%></strong>
                    </td>
                </tr>
            </table>
        </td>
        <td style="height: 87px">&nbsp;</td>
      </tr>
      <tr>
        <td style="width: 137px">&nbsp;</td>
        <td style="width: 229px">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td style="width: 137px">&nbsp;</td>
        <td style="width: 229px">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table></td>
  </tr>
</table>
            </ItemTemplate>
        </asp:DataList>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="确认这些单据已经打印"
            Width="229px" />&nbsp;
        <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
        &nbsp;
        <br />
        <br />
    </form>
</body>
</html>
