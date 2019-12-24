<%@ Page Language="C#" AutoEventWireup="true" Inherits="Customer_SysServiceType" Codebehind="SysServiceType.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>发货方式</title>
        <style type="text/css">
    body,td,th {
	font-size: 12px;
}
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:SiteMapPath ID="SiteMapPath1" runat="server">
        </asp:SiteMapPath>
        <br />
        <table style="width: 849px">
            <tr>
                <td style="width: 22px; height: 1px">
                </td>
                <td style="width: 470px; height: 1px">
                </td>
            </tr>
            <tr>
                <td style="width: 22px">
                </td>
                <td style="width: 470px">
                    <asp:Panel ID="editPanel" runat="server"  Visible="False" Width="100%">
                        <br />
                        <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
                            float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 638px;
                            border-bottom: #a4d5e3 1px solid; ">
                            <h2 style="padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;
                                padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;
                                border-bottom: #a4d5e3 1px solid">
                                &nbsp;</h2>
                            <div style="margin: 5px">
                                <table style="width: 489px">
                                    <tr>
                                        <td style="width: 43%; height: 43px">
                                            <p class="p0" style="margin-top: 0pt; margin-bottom: 0pt">
                                                服务类型</p>
                                        </td>
                                        <td style="width: 50%; height: 43px">
                                            <asp:TextBox ID="ShopName_edit" runat="server" Width="140px"></asp:TextBox>
                                            <asp:Label ID="EditID" runat="server" Visible="False"></asp:Label>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ShopName_edit"
                                                ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></td>
                                        <td style="width: 40%; height: 43px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 43%; height: 17px">
                                            描述：</td>
                                        <td style="width: 50%; height: 17px">
                                            <asp:TextBox ID="Description_edit" runat="server" Height="50px" TextMode="MultiLine"
                                                Width="308px"></asp:TextBox></td>
                                        <td style="width: 40%; height: 17px">
                                            <asp:Button ID="updateButton" runat="server" OnClick="updateButton_Click" Text="更　新"
                                                Width="87px" /></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        &nbsp;&nbsp;
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td style="width: 22px; height: 121px">
                </td>
                <td align="left" style="width: 470px; height: 121px">
                    <asp:Panel ID="viewPanel" runat="server"  Width="125px">
                        <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
                            float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 638px;
                            border-bottom: #a4d5e3 1px solid; ">
                            <h2 style="padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;
                                padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;
                                border-bottom: #a4d5e3 1px solid">
                                &nbsp;</h2>
                            <div style="margin: 5px">
                                <table style="width: 489px">
                                    <tr>
                                        <td style="width: 29%; height: 43px">
                                            <span></span><span style="font-size: 9pt;">服务类型</span></td>
                                        <td style="width: 50%; height: 43px">
                                            <asp:TextBox ID="ShopName_New" runat="server" Width="95px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ShopName_New"
                                                ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator>&nbsp;
                                        </td>
                                        <td style="width: 40%; height: 43px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 29%; height: 17px">
                                            描述：</td>
                                        <td style="width: 50%; height: 17px">
                                            <asp:TextBox ID="Description_new" runat="server" Height="46px" TextMode="MultiLine"
                                                Width="309px"></asp:TextBox></td>
                                        <td style="width: 40%; height: 17px">
                                            <asp:Button ID="submit" runat="server" OnClick="submit_Click" Text="添　加" Width="87px" /></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <br />
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="White"
                            BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="639px">
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <Columns>
                                <asp:BoundField DataField="TypeID" HeaderText="编号"  >
                                    <ControlStyle Width="100px" />
                                    <HeaderStyle Width="80px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ServiceName" HeaderText="名称"  >
                                    <ControlStyle Width="150px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Description" HeaderText="描述"  />
                                <asp:HyperLinkField DataNavigateUrlFields="TypeID" DataNavigateUrlFormatString="SysServiceType.aspx?action=edit&amp;TypeID={0}"
                                    HeaderText="编辑" Text="&lt;img border=0 src=../images/Edit.gif /&gt;">
                                    <ItemStyle Width="30px" />
                                </asp:HyperLinkField>
                                <asp:HyperLinkField DataNavigateUrlFields="TypeID" DataNavigateUrlFormatString="SysServiceType.aspx?action=del&amp;TypeID={0}"
                                    HeaderText="删除" Text="&lt;img border=0 src=../images/Delete.gif /&gt;">
                                    <ItemStyle Width="30px" />
                                </asp:HyperLinkField>
                            </Columns>
                            <RowStyle BackColor="White" ForeColor="#003399" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <HeaderStyle BackColor="#E2F3FA" Font-Bold="True" ForeColor="Black" />
                        </asp:GridView>
                        &nbsp; &nbsp;<br />
                        &nbsp;
                        <table style="width: 631px; height: 36px">
                            <tr>
                                <td style="width: 474px">
                                    <cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
                                        backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
                                        pagesize="10" showfirstlast="true" showpagenumbers="true"></cc1:collectionpager>
                                </td>
                            </tr>
                        </table>
                        <br />
                    </asp:Panel>
                    <br />
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td style="width: 22px; height: 121px">
                </td>
                <td align="center" style="width: 470px; height: 121px">
                    &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Customer/SysServiceType.aspx"
                        Visible="False">操作成功！返回列表</asp:HyperLink></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>

