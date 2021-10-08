<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_PrintSalesSentOrder_PY" Codebehind="PrintSalesSentOrder_PY.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>平邮快递单打印</title>
</head>
<body>
    <form id="form1" runat="server">
        
        <br />
        
        
        <asp:DataList ID="DataList1" runat="server">
        <ItemTemplate>
        <table  width="748"  background="../images/pingyou.jpg" >
            <tr>
                <td style="width: 47px; height: 76px" align="left" valign="bottom">
                </td>
                <td style="width: 303px; height: 76px" align="left" valign="bottom">
                    </td>
                <td style="height: 76px; width: 237px;" align="left" valign="bottom">
                </td>
                <td style="height: 76px" align="left" valign="bottom">
                </td>
            </tr>
            <tr>
                <td style="width: 47px; height: 212px" valign="bottom">
                </td>
                <td style="width: 303px; height: 212px" valign="bottom">
                <div style="width:220; height:15; left:85; position:relative; font-size:24px; letter-spacing:19pt;"><%#Eval("CustomerPost")%></div>
                    <table style="width: 300px; height: 129px;">
                        <tr>
                            <td colspan="3" style="height: 58px"><%#Eval("DeliveryPlace")%>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="height: 38px"><%#Eval("CustomerName")%>
                            </td>
                            <td align="right" colspan="2" style="height: 38px"><%#Eval("CustomerTel")%>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="height: 212px; width: 237px;" valign="bottom">
                    <table style="width: 217px; height: 114px">
                        <tr>
                            <td style="font-size: 12pt; width: 22px; height: 9px">
                               <strong> NO:</strong></td>
                            <td colspan="2" style="font-size: 10pt;width: 133px; height: 9px">
                            <%#Eval("SalesOutID")%> &nbsp;( <% =DateTime.Now.ToString("yyyy-MM-dd")%>)
                                </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 37px" valign="top">
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="height: 212px" valign="bottom">
                </td>
            </tr>
            <tr>
                <td style="width: 47px; height: 117px">
                </td>
                <td style="width: 303px; height: 117px" valign="middle">
                    <table style="width: 300px; height: 99px;">
                        <tr>
                            <td colspan="3" style="font-size: 15px; height: 44px;">
                                广州白云区三元里平英新村北八巷八号6楼</td>
                        </tr>
                        <tr>
                            <td align="center" colspan="3" style="height: 29px">
                                陈淳 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 12px">
                            </td>
                            <td style="height: 12px; width: 151px;">
                            </td>
                            <td align="right" style="width: 93px; height: 12px">
                                510400</td>
                        </tr>
                    </table>
                </td>
                <td style="width: 237px; height: 117px" valign="middle">
                    <table style="width: 197px">
                        <tr>
                            <td style="width: 27px">
                            </td>
                            <td style="font-weight: bold; font-size: 20pt; text-transform: capitalize">
                                √</td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 27px">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 27px">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="height: 117px" valign="middle">
                </td>
            </tr>
            <tr>
                <td style="height: 46px; width: 47px;">
                </td>
                <td style="width: 303px; height: 46px">
                </td>
                <td style="height: 46px; width: 237px;">
                </td>
                <td style="height: 46px">
                </td>
            </tr>
        </table>
        
        </ItemTemplate>
        </asp:DataList>
        <br />
        <br />
        <br /><asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="确认这些单据已经打印"
            Width="229px" />&nbsp;
        <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
    </form>
</body>
</html>

