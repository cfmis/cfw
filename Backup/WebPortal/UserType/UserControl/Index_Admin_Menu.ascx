<%@ Control Language="C#" AutoEventWireup="true" Inherits="UserControl_Index_Admin_Menu" Codebehind="Index_Admin_Menu.ascx.cs" %>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style>
<asp:Panel ID="Panel1" runat="server" Height="50px" Width="125px">
<table border="0" cellpadding="0" cellspacing="0" class="ctrl_menu_title_bg" width="195">
    <tbody>
        <tr class="hand" onclick="hide('hideMenuFunc1')">
            <td class="ctrl_menu_title" width="174">
                管理员专区</td>
            <td width="21">
                <img id="MenuFunc1" src="images/menu_title_down.gif" /></td>
        </tr>
        <tr id="hideMenuFunc1">
            <td align="left" class="menu_box_pad" colspan="2">
                <table border="0" cellpadding="0" cellspacing="5" class="menu_box" width="100%">
                    <tbody>
                        <tr>
                            <th style="height: 19px">&nbsp;
                                </th>
                            <td style="height: 19px">
                                <asp:HyperLink ID="HyperLink1" runat="server" Width="105px" NavigateUrl="~/User/SysUserSearch.aspx" Target="MainFrame">管理用户</asp:HyperLink></td>
                        </tr>
                        <tr>
                            <th>&nbsp;
                                </th>
                            <td>
                                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Authority/GroupManager.aspx?module=GroupManager&action=view"
                                    Target="MainFrame" Width="105px">管理群组</asp:HyperLink></td>
                        </tr>
                        <tr>
                            <th>&nbsp;
                                </th>
                            <td>
                                <asp:HyperLink ID="HyperLink9" runat="server" NavigateUrl="~/Stock/DetopManager.aspx"
                                    Target="MainFrame" Width="105px">仓库设置</asp:HyperLink><a
                                    href="Articles_List.aspx" onclick="scroll_to_top()" target="mainFrame"></a></td>
                        </tr>
                        <tr>
                            <th>
                            </th>
                            <td>
                                <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/UserType/SysUserTypeManager.aspx"
                                    Target="MainFrame" Width="105px">管理用户类型</asp:HyperLink></td>
                        </tr>
                        <tr>
                            <th>
                            </th>
                            <td>
                                <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="~/Supplier/SysSupplierManager.aspx"
                                    Target="MainFrame" Width="105px">供应商</asp:HyperLink></td>
                        </tr>
                        <tr>
                            <th style="height: 20px">
                            </th>
                            <td style="height: 20px">
                                <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/Products/SysProductsTypeManager.aspx"
                                    Target="MainFrame" Width="105px">商品类型</asp:HyperLink></td>
                        </tr>
                        <tr>
                            <th style="height: 20px">
                            </th>
                            <td style="height: 20px">
                                <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/Products/SysProductsBrandManager.aspx"
                                    Target="MainFrame" Width="105px">商品品牌</asp:HyperLink></td>
                        </tr>
                        <tr>
                            <th style="height: 20px">
                            </th>
                            <td style="height: 20px">
                                <asp:HyperLink ID="HyperLink8" runat="server" NavigateUrl="~/Products/SysProductsList.aspx"
                                    Target="MainFrame" Width="105px">商品</asp:HyperLink></td>
                        </tr>
                        <tr>
                            <th style="height: 20px">
                            </th>
                            <td style="height: 20px">
                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/System_Log.aspx" Target="MainFrame"
                                    Width="105px">系统日志</asp:HyperLink></td>
                        </tr>
                    </tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table>
</asp:Panel>