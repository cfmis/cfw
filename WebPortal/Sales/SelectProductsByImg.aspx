<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_SelectProductsByImg" Codebehind="SelectProductsByImg.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>捡货图示打印</title>
    

           <link rel="stylesheet" href="../css/box.css" type="text/css" media="screen" />
          <link rel="stylesheet" href="../css/base.css" type="text/css" media="screen" />
    <script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/thickbox.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        &nbsp; &nbsp; &nbsp;&nbsp; 
        <p class="p0" style="margin-top: 0pt; margin-bottom: 0pt">
            <span style="font-size: 10pt; font-family: '宋体'; mso-spacerun: 'yes'"><font face="宋体">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;按应配送</font></span>发货时间
        <asp:TextBox ID="selectImgData" runat="server" ReadOnly="True" Width="83px"></asp:TextBox>
        <img onclick="fPopUpCalendarDlg(selectImgData);return false;" src="../images/calendar.gif" />&nbsp;&nbsp;
            &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="不能为空" ControlToValidate="selectImgData"></asp:RequiredFieldValidator>
            &nbsp; &nbsp; &nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click"
                Text="捡货图示打印" />
            （销售发货）等待发货的图片<br />
        <br />
        <br />
        <asp:DataList ID="DataList1" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
            >
            <ItemTemplate>
                
                    <table style="width: 184px; height: 169px">
                        <tr>
                            <td style="width: 132px; height: 90px" valign="top">
                                <a class="thickbox" href='..\UploadFiles\Images\<%#Eval("PhotoUrl")  %>' title="大图">
                                    <img border="0" src='..\UploadFiles\Images\<%#Eval("PhotoUrl")  %>' style="width: 173px;
                                        height: 126px" /></a></td>
                        </tr>
                        <tr>
                            <td style="width: 132px" valign="top">
                                商品名称：<%#Eval("ProductsName")%></td>
                        </tr>
                        <tr>
                            <td style="width: 132px" valign="top">
                                捡货数量：<%#Eval("Quantity")  %></td>
                        </tr>
                    </table>
               
            </ItemTemplate>
        </asp:DataList></p>
    </div>
    </form>
</body>
</html>
