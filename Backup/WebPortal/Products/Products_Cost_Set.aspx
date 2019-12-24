<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_Products_Cost_Set" Codebehind="Products_Cost_Set.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>商品对应不同用户的标价</title>
    <link href="../css/base.css" rel="stylesheet" type="text/css" />
</head>
<body style="vertical-align: super">
    <form id="form1" runat="server">
    <div>
        <table style="width: 732px">
            <tr>
                <td colspan="3" style="height: 36px">
                    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                    </asp:SiteMapPath>
                </td>
            </tr>
            <tr>
                <td style="width: 52px; height: 36px;">
                </td>
                <td style="width: 568px; height: 36px;">
                    商品编号：<asp:Label ID="PID" runat="server"></asp:Label>
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 用于：不同二级用户类型看到的商品价格</td>
                <td style="width: 168px; height: 36px;">
                </td>
            </tr>
            <tr>
                <td style="width: 52px">
                </td>
                <td style="width: 568px">
                    <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
                        float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 638px;
                        border-bottom: #a4d5e3 1px solid; ">
                        <h2 style="padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;
                            padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;
                            border-bottom: #a4d5e3 1px solid">
                            &nbsp;</h2>
                        <div style="margin: 5px">
                        <div class="Sdiv">
                            <asp:GridView SkinID="NewSkin" ID="PriceList"  CssClass="Gv1" runat="server" AutoGenerateColumns="False" OnRowCancelingEdit="PriceList_RowCancelingEdit" OnRowEditing="PriceList_RowEditing" OnRowUpdating="PriceList_RowUpdating" DataKeyNames="SubClassID">
                                <Columns>
                                    <asp:BoundField HeaderText="一级类型" DataField="TypeName" ReadOnly="True">
                                        <HeaderStyle Width="120px" />
                                    </asp:BoundField>
                                    <asp:BoundField HeaderText="二级类型" DataField="SubClassName" ReadOnly="True">
                                        <HeaderStyle Width="100px" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="显示标价">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("price") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("price") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField CancelText="&lt;img border=0 src=&quot;../images/Cancel.gif&quot; /&gt;"
                                        EditText="&lt;img border=0 src=&quot;../images/Edit.gif&quot; /&gt;     " HeaderText="操作" ShowEditButton="True"
                                        UpdateText="&lt;img border=0 src=&quot;../images/tbtn_saveas.gif&quot; /&gt;保存">
                                        <HeaderStyle Width="150px" />
                                    </asp:CommandField>
                                </Columns>
                            </asp:GridView>
                            &nbsp;</div>
                    </div>
                </td>
                <td style="width: 168px">
                </td>
            </tr>
            <tr>
                <td style="width: 52px; height: 17px;">
                </td>
                <td style="width: 568px; height: 17px;">
                </td>
                <td style="width: 168px; height: 17px;">
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
