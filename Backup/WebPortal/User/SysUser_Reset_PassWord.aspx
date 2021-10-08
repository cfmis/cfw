<%@ Page Language="C#" AutoEventWireup="true" Inherits="user_SysUser_Reset_PassWord" Codebehind="SysUser_Reset_PassWord.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>重新设置密码</title>
    <style type="text/css">
<!--
BODY {
	FONT-SIZE: 12px
}
-->
</style>
</head>
<body>
    <form id="form1" runat="server">
     <div>
     <table style="width:97%;" >
        <tr>
            <td align="left" style="width: 810px; height: 20px;">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>
        &nbsp;<table style="width: 849px; height: 262px">
            <tr>
                <td style="width: 105px; height: 21px">
                </td>
                <td style="height: 21px; width: 470px;">
                </td>
            </tr>
            <tr>
                <td style="width: 105px; height: 258px;">
                </td>
                <td style="width: 470px; height: 258px;">
                    <br />
                    <asp:Panel ID="Panel1" runat="server"  Width="125px">
     <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(../images/content_bg1.gif) repeat-x 50% bottom; FLOAT: left; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 618px; BORDER-BOTTOM: #a4d5e3 1px solid">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">
          <span style="color: #0000ff; text-decoration: underline"></span>&nbsp;</H2>
      <DIV style="MARGIN: 5px">
        <p>
            <table style="width: 489px; height: 118px;">
                <tr>
                    <td style="width: 30%; height: 43px;">
                        原密码：</td>
                    <td style="width: 30%; height: 43px;" >
                        <asp:TextBox ID="oldpwd" runat="server" TextMode="Password" Width="140px"></asp:TextBox></td>
                    <td style="width: 40%; height: 43px;">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="oldpwd"
                            ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></td>
                </tr>
                <tr style="color: #000000">
                    <td >
                        新密码：</td>
                    <td >
                        <asp:TextBox ID="newpwd" runat="server" TextMode="Password"></asp:TextBox></td>
                    <td >
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="newpwd"
                            ErrorMessage="<img src=../images/false.gif  />不少于6位"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td >
                        确认密码</td>
                    <td >
                        <asp:TextBox ID="rnewpwd" runat="server" TextMode="Password"></asp:TextBox></td>
                    <td style="width: 46px">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rnewpwd"
                            ErrorMessage="<img src=../images/false.gif  />"></asp:RequiredFieldValidator></td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td >
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="<img src=../images/false.gif  />两次密码不一样"
                            Width="209px" ControlToCompare="newpwd" ControlToValidate="rnewpwd"></asp:CompareValidator></td>
                    <td>
                    </td>
                </tr>
            </table>
        </p>
        <p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
            <asp:Button ID="submit" runat="server" Text="提　交" Width="87px" OnClick="submit_Click" /></p>
      </DIV></DIV>
                    </asp:Panel>
                    <asp:Label ID="Label1" runat="server" Text="操作成功" Visible="False"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 105px">
                </td>
                <td style="width: 470px">
                </td>
            </tr>
        </table>
  
    </div>
    </form>
</body>
</html>
