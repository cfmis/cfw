<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_PrintSalesSentOrder_ST" Codebehind="PrintSalesSentOrder_ST.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>申通快递单打印</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
 


    
        <asp:DataList ID="DataList1" runat="server">
            <ItemTemplate>
               <table width="769px" height="480" border="0" background="../images/shenTong.jpg">
  
  <tr>
    <td><table width="769px" border="0" style="height: 451px">
      <tr　style="height: 68px">
        <td height="68" rowspan="2" style="width: 102px">&nbsp;</td>
        <td rowspan="2" style="width: 276px" align="left" valign="top">
        <strong> NO:</strong><%#Eval("SalesOutID")%>
        </td>
        <td width="420" style="height: 38px">&nbsp;</td>
        <td width="49" rowspan="2">&nbsp;</td>
      </tr>
      <tr>
        <td style="height: 31px" >
        </td>
      </tr>
      <tr>
        <td style="height: 113px; width: 102px;" >&nbsp;</td>
        <td style=" width: 276px; height: 113px;">乐易拍.广州1号仓
            <br />
          2009.1.14 广州白云区平英新村<br />
            <br />
            团购批发/学生兼职（QQ350401）</td>
        <td  valign="top" style="height: 113px">
            <table style="width: 298px; height: 128px">
                <tr>
                    <td colspan="2" style="height: 40px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 28px; height: 48px" align="left">
                    </td>
                    <td style="width: 197px; height: 48px" align="left">　<strong><%#Eval("DeliveryPlace")%></strong>
                    </td>
                </tr>
                <tr>
                    <td style="width: 28px; height: 33px;">
                    </td>
                    <td style="width: 197px; height: 33px;">   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%#Eval("CustomerName")%>
                    </td>
                </tr>
            </table>
            <br />

            
            
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%#Eval("CustomerTel")%>
        
        
        </td>
        <td style="height: 113px" >&nbsp;</td>
      </tr>
      <tr>
        <td style="width: 102px; height: 87px;">&nbsp;</td>
        <td style="width: 276px; height: 87px"></td>
        <td valign="top" style="height: 87px">
        </td>
        <td style="height: 87px">&nbsp;</td>
      </tr>
      <tr>
        <td style="width: 102px">&nbsp;</td>
        <td style="width: 276px">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td style="width: 102px">&nbsp;</td>
        <td style="width: 276px">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
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
    </form>
</body>
</html>

