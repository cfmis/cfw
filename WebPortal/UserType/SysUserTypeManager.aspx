<%@ Page Language="C#" AutoEventWireup="true" Inherits="UserType_SysUserTypeManager" Codebehind="SysUserTypeManager.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>用户类型管理</title>
        <style type="text/css">
    body,td,th {
	font-size: 12px;
}
    
    </style>
        <style type="text/css">
<!--

.lbg2 {
	BACKGROUND-IMAGE: url(../images/line.gif); BACKGROUND-REPEAT: repeat-x
}
.mc {
	PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 0px; WORD-BREAK: break-all; LINE-HEIGHT: 20px; PADDING-TOP: 0px
}
.t3 {
	FONT-WEIGHT: bolder; FONT-SIZE: 12px; MARGIN-LEFT: 15px; COLOR: #003473; margin-down: -20px
}
.mc1 {	PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 0px; WORD-BREAK: break-all; LINE-HEIGHT: 20px; PADDING-TOP: 0px
}
-->
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:SiteMapPath ID="SiteMapPath1" runat="server">
        </asp:SiteMapPath>
        <br />
        <table style="width: 862px; height: 193px">
            <tr>
                <td style="width: 32px; height: 105px">
                </td>
                <td style="width: 498px; height: 105px" valign="top">
                    &nbsp;<asp:Label ID="Pageaction" runat="server" Text="view" Visible="False"></asp:Label>&nbsp;&nbsp;
                    <asp:Label ID="editSubClassID" runat="server" Visible="False"></asp:Label>
                    &nbsp;
                    <asp:Panel ID="Panel1" runat="server"  Width="125px">
                        <br />
                    <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
                        float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 777px;
                        border-bottom: #a4d5e3 1px solid; ">
                        <h2 style="padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;
                            padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;
                            border-bottom: #a4d5e3 1px solid">
                            &nbsp;</h2>
                        <div style="margin: 5px">
                            <table style="width: 734px; height: 43px">
                                <tr>
                                    <td style="width: 13%; height: 43px">
                                        上级类型</td>
                                    <td style="width: 21%; height: 43px">
                                        <asp:DropDownList ID="UserTypeDropDownList" runat="server">
                                        </asp:DropDownList></td>
                                    <td style="width: 16%; height: 43px">
                                        类型名称</td>
                                    <td style="width: 41%; height: 43px">
                                        &nbsp;<asp:TextBox ID="SubTypeName" runat="server" Width="103px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="SubTypeName"
                                            ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></td>
                                    <td style="width: 13%; height: 43px">
                                        &nbsp;状态</td>
                                    <td style="height: 43px; width: 45px;">
                                        &nbsp;<asp:DropDownList ID="DropDownList1" runat="server">
                                            <asp:ListItem Value="Y">正常</asp:ListItem>
                                            <asp:ListItem Value="N">停用</asp:ListItem>
                                        </asp:DropDownList>
                                        &nbsp;&nbsp;
                                    </td>
                                    <td style="width: 36%; height: 43px">
                                        &nbsp;<asp:Button ID="updateButton" runat="server" OnClick="updateButton_Click" Text="新  添"
                                            Width="87px" /></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                        <br />
                    <table bgcolor="#9bc8ff" border="0" cellpadding="0" cellspacing="1" style="width: 775px;">
                        <tbody>
                            <tr>
                                <td bgcolor="#f7fdff" style=" height: 244px;">
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tbody>
                                            <tr>
                                                <td class="lbg2" height="27" width="354">
                                                    <span class="t3">用户类型列表 注：状态 Y为正在使用 N为停止使用</span></td>
                                                <td class="lbg2" style="width: 23px">
                                                    <img border="0" height="17" src="../images/bot2.gif" width="17" /></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <table border="0" cellpadding="0" cellspacing="0" style="width: 772px; height: 182px;">
                                        <tr>
                                            <td class="mc" height="202" valign="top" align="center">
                                                &nbsp;
                                                <table border="0" style="width: 631px; height: 18px;">
                                                    <tr>
                                                        <td style="width: 221px; height: 35px">
                                                            顶级类型</td>
                                                        <td style="width: 358px; height: 35px">
                                                            二级类型</td>
                                                        <td style="width: 167px; height: 35px">
                                                            状态</td>
                                                              <td style="width: 167px; height: 35px">
                                                            编辑</td>
                                                            <td style="width: 167px; height: 35px">
                                                            删除</td>
                                                    </tr>
                                                    <asp:Repeater ID="listType" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                  <%# Eval("TypeName")%></td>
                                                                <td>
                                                                    <%# Eval("SubClassName")%>
                                                                </td>
                                                                <td>
                                                                    <%# Eval("State")%>
                                                                </td>
                                                                  <td>
                                                                <a href="?action=edit&SubClassID=<%# Eval("SubClassID")%>" > <img src=  "../images/Edit.gif"  border="0" alt="点击编辑"/></a>
                                                                </td>
                                                                
                                                                 <td>
                                                                  <a href="?action=del&SubClassID=<%# Eval("SubClassID")%>" >  <img  alt="" border="0"  src="../images/Delete.gif" /> </a>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </table>
                                                <cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
                                                    backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
                                                    pagesize="15" showfirstlast="true" showpagenumbers="true"></cc1:collectionpager>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                        <br />
                        <br />
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td style="width: 32px">
                </td>
                <td style="width: 498px">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="width: 32px; height: 18px;">
                </td>
                <td style="width: 498px; height: 18px;" align="center">
                    <asp:HyperLink ID="HyperLink1" runat="server" Visible="False" NavigateUrl="~/UserType/SysUserTypeManager.aspx">操作成功！返回列表</asp:HyperLink></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
