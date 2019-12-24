<%@ Page Language="C#" AutoEventWireup="true" Inherits="Supplier_SupplierDetail" Codebehind="SupplierDetail.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>供应商信息</title>
        <style type="text/css">
    P {
	FONT-SIZE: 9pt; LINE-HEIGHT: 150%
}
TD {
	FONT-SIZE: 9pt; COLOR: black; LINE-HEIGHT: 150%
}
    
    </style>
    <LINK href="../css/base.css" type=text/css 
rel=stylesheet>
</head>
<body>
    <form id="form1" runat="server">
    <div >
        <br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Supplier/SysSupplierManager.aspx">返回供应商列表</asp:HyperLink><br />
        <br />
        <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
            float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 560px;
            border-bottom: #a4d5e3 1px solid; height: 98px">
            <div style="margin: 5px">
                <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 96%">
                    <tbody>
                        <tr bgcolor="#ffffff">
                            <td style="width: 715px; height: 455px">
                                <table border="0" cellpadding="2" cellspacing="1" valign="top" width="100%">
                                    <tbody>
                                        <tr bgcolor="#ffffff">
                                            <td align="middle">
                                                供应商全称：</td>
                                            <td align="left">
                                                <asp:TextBox ID="SupplierName" runat="server" CssClass="txt_left"></asp:TextBox>&nbsp;
                                            </td>
                                        </tr>
                                        <tr bgcolor="#ffffff" style="color: #000000">
                                            <td align="middle">
                                                所属地<span style="font-family: 宋体">区：</span></td>
                                            <td align="left" style="font-family: 宋体">
                                                <asp:TextBox ID="Area" runat="server" CssClass="txt_left"></asp:TextBox>&nbsp;
                                            </td>
                                        </tr>
                                        <tr bgcolor="#ffffff" style="font-family: 宋体">
                                            <td align="middle">
                                                <span style="font-family: Times New Roman">邮政编码：</span></td>
                                            <td align="left" style="font-family: Times New Roman">
                                                <font face="宋体">
                                                    <asp:TextBox ID="Postcode" runat="server" CssClass="txt_left"></asp:TextBox></font></td>
                                        </tr>
                                        <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                                            <td align="middle">
                                                <font face="宋体">通讯地址：</font></td>
                                            <td align="left">
                                                <font face="宋体">
                                                    <asp:TextBox ID="Address" runat="server" CssClass="txt_left"></asp:TextBox></font></td>
                                        </tr>
                                        <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                                            <td align="middle">
                                                <font face="宋体">联 系<span> 人：</span></font></td>
                                            <td align="left" style="font-family: Times New Roman">
                                                <font face="宋体">
                                                    <asp:TextBox ID="Linkman" runat="server" CssClass="txt_left"></asp:TextBox>
                                                    </font></td>
                                        </tr>
                                        <tr bgcolor="#ffffff" style="color: #000000">
                                            <td align="middle">
                                                联系电话：</td>
                                            <td align="left">
                                                <asp:TextBox ID="Tel" runat="server" CssClass="txt_left"></asp:TextBox></td>
                                        </tr>
                                        <tr bgcolor="#ffffff">
                                            <td align="middle" style="height: 28px">
                                                企业网址：</td>
                                            <td align="left" style="height: 28px">
                                                <font face="宋体">
                                                    <asp:TextBox ID="WebUrl" runat="server" CssClass="txt_left"></asp:TextBox></font></td>
                                        </tr>
                                        <tr bgcolor="#ffffff">
                                            <td align="middle">
                                                <span style="font-family: 宋体">电子信箱：</span></td>
                                            <td align="left" style="font-family: 宋体">
                                                <asp:TextBox ID="Email" runat="server" CssClass="txt_left"></asp:TextBox></td>
                                        </tr>
                                        <tr bgcolor="#ffffff" style="font-family: 宋体">
                                            <td align="middle">
                                                纳 税 号：</td>
                                            <td align="left">
                                                <asp:TextBox ID="TaxNum" runat="server" CssClass="txt_left"></asp:TextBox></td>
                                        </tr>
                                        <tr bgcolor="#ffffff">
                                            <td align="middle" height="23">
                                                <span style="font-family: 宋体">关系建立日：</span></td>
                                            <td align="left" height="23" style="font-family: 宋体">
                                                <asp:TextBox ID="CreateDate" runat="server" CssClass="txt_left"></asp:TextBox></td>
                                        </tr>
                                        <tr bgcolor="#ffffff">
                                            <td align="middle" height="23">
                                                状 &nbsp;&nbsp; 态</td>
                                            <td align="left" height="23">
                                                </td>
                                        </tr>
                                        <tr bgcolor="#ffffff">
                                            <td align="middle">
                                                <font face="宋体">备 &nbsp; &nbsp;注：</font></td>
                                            <td align="left">
                                                <asp:TextBox ID="Description" runat="server" CssClass="txt_left" Height="51px" TextMode="MultiLine"
                                                    Width="271px"></asp:TextBox></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <br />
    
    </div>
    </form>
</body>
</html>
