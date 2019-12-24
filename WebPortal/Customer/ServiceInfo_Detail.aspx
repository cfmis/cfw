<%@ Page Language="C#" AutoEventWireup="true" Inherits="Customer_ServiceInfo_Detail" Codebehind="ServiceInfo_Detail.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>信息详细页面</title>
    <link href="../css/base.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        问题类型：<asp:Label ID="ServiceName" runat="server" ></asp:Label>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; 受理人员：<asp:Label
            ID="AuditingUser" runat="server"></asp:Label>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <asp:Label ID="IDS" runat="server" Visible="False" ></asp:Label>
        <asp:Label ID="UserName" runat="server" Visible="False" ></asp:Label>
        <br />
        <br />
        <table style="width: 637px">
            <tr>
                <td style="width: 173px">
                    发布人：<asp:Label ID="RealName" runat="server" ></asp:Label></td>
                <td>
                    发布时间:<asp:Label ID="CreateDate" runat="server" ></asp:Label></td>
                <td style="width: 239px">
                    &nbsp;状态：<asp:Label ID="State" runat="server" ></asp:Label></td>
            </tr>
        </table>
        <br />
        <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
            float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 638px;
            border-bottom: #a4d5e3 1px solid; ">
            <h2 style="padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;
                padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;
                border-bottom: #a4d5e3 1px solid">
                题：<asp:Label ID="ServiceTitle" runat="server" Text="Label"></asp:Label></h2>
            <p>
                &nbsp; 
            &nbsp;<asp:Label ID="Content" runat="server" ></asp:Label></p>
            <div style="margin: 5px">
                &nbsp;</div>
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
            float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 638px;
            border-bottom: #a4d5e3 1px solid;">
            <h2 style="padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;
                padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;
                border-bottom: #a4d5e3 1px solid">
                讨论解决：</h2>
            <p>
                
                <asp:Label ID="ReplyInfo" runat="server" ></asp:Label></p>
            <div style="margin: 5px">
                &nbsp;</div>
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
            float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 638px;
            border-bottom: #a4d5e3 1px solid;">
            <h2 style="padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;
                padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;
                border-bottom: #a4d5e3 1px solid">
                留言：</h2>
            <p>
                &nbsp; &nbsp;
                <asp:TextBox ID="TextReplyInfo" runat="server" Height="36px" TextMode="MultiLine" Width="580px"></asp:TextBox>
            </p>
            <p>
                &nbsp; &nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="内容不能为空" ControlToValidate="TextReplyInfo"></asp:RequiredFieldValidator></p>
            <div style="margin: 5px">
                <asp:Button ID="Button1" runat="server" Text="提交" OnClick="Button1_Click" Width="110px" />&nbsp;</div>
        </div>
    
    </div>
    </form>
</body>
</html>
