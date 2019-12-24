<%@ Page Language="C#" AutoEventWireup="true" Inherits="Supplier_SysSupplierManager" Codebehind="SysSupplierManager.aspx.cs" %>
<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加供应商信息</title>
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
    <div style="text-align:center">
    <table style="width:97%;" >
        <tr>
            <td align="left" style="width: 810px; height: 20px;">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>
        <asp:Panel ID="addPanel" runat="server" Height="50px" Width="125px">
        <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
            float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 560px;
            border-bottom: #a4d5e3 1px solid; height: 98px">
            
            <div style="margin: 5px">
            
            <TABLE cellSpacing=0 cellPadding=0 align=center border=1 style="width: 96%">
  <TBODY>
  <TR bgColor=#ffffff>
    <TD  style="height: 455px; width: 715px;">
      <TABLE cellSpacing=1 cellPadding=2 width="100%" border=0 valign="top">
        <TBODY>
        <TR bgColor=#ffffff>
          <TD align=middle>供应商全称：</TD>
          <TD align="left" style="width: 411px">
              <asp:TextBox ID="SupplierName" runat="server" CssClass="txt_left"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="SupplierName"
                  ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator>
              <asp:TextBox ID="SupplierIDs" runat="server" Visible="False" Width="38px"></asp:TextBox></TD></TR>
        <TR bgColor=#ffffff style="color: #000000">
          <TD align=middle>所属地区：</TD>
          <TD align="left" style="width: 411px">
              <asp:TextBox ID="Area" runat="server" CssClass="txt_left"></asp:TextBox>
              <asp:TextBox ID="act" runat="server" Visible="False" Width="31px"></asp:TextBox>
              
              </TD></TR>
        <TR bgColor=#ffffff>
          <TD align=middle>
              <span style="font-family: 宋体">邮政编码：</span></TD>
          <TD style="font-family: 宋体; width: 411px;" align="left"><FONT face=宋体>
              <asp:TextBox ID="Postcode" runat="server" CssClass="txt_left"></asp:TextBox></FONT></TD></TR>
        <TR bgColor=#ffffff style="font-family: 宋体">
          <TD align=middle><FONT face=宋体>通讯地址：</FONT></TD>
          <TD align="left" style="width: 411px"><FONT face=宋体>
              <asp:TextBox ID="Address" runat="server" CssClass="txt_left"></asp:TextBox></FONT></TD></TR>
        <TR bgColor=#ffffff>
          <TD align=middle><FONT face=宋体>联 系<span style="font-family: Times New Roman"> 人：</span></FONT></TD>
          <TD style="font-family: Times New Roman; width: 411px;" align="left"><FONT face=宋体>
              <asp:TextBox ID="Linkman" runat="server" CssClass="txt_left"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Linkman"
                  ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></FONT></TD></TR>
        <TR bgColor=#ffffff style="color: #000000">
          <TD align=middle>联系电话：</TD>
          <TD align="left" style="width: 411px">
              <asp:TextBox ID="Tel" runat="server" CssClass="txt_left"></asp:TextBox></TD></TR>
        <TR bgColor=#ffffff>
          <TD align=middle style="height: 28px">企业网址：</TD>
          <TD style="height: 28px; width: 411px;" align="left"><FONT face=宋体>
              <asp:TextBox ID="WebUrl" runat="server" CssClass="txt_left"></asp:TextBox></FONT></TD></TR>
        <TR bgColor=#ffffff>
          <TD align=middle>电子信箱：</TD>
          <TD align="left" style="width: 411px">
              <asp:TextBox ID="Email" runat="server" CssClass="txt_left"></asp:TextBox></TD></TR>
        <TR bgColor=#ffffff>
          <TD align=middle>纳 税 号：</TD>
          <TD align="left" style="width: 411px">
              <asp:TextBox ID="TaxNum" runat="server" CssClass="txt_left"></asp:TextBox></TD></TR>
        <TR bgColor=#ffffff>
          <TD align=middle height=23>
              <span style="font-family: 宋体">关系建立日：</span></TD>
          <TD height=23 style="font-family: 宋体; width: 411px;" align="left">
              <asp:TextBox ID="CreateDate" runat="server" CssClass="txt_left"></asp:TextBox></TD></TR>
            <tr bgcolor="#ffffff">
                <td align="middle" height="23">
                    状 &nbsp;&nbsp; 态</td>
                <td height="23" align="left" style="width: 411px">
                    <asp:DropDownList ID="State" runat="server">
                        <asp:ListItem Value="Y">正常使用</asp:ListItem>
                        <asp:ListItem Value="N">停止使用</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
        <TR bgColor=#ffffff>
          <TD align=middle><FONT face=宋体>备&nbsp;&nbsp;&nbsp;&nbsp;注：</FONT></TD>
          <TD align="left" style="width: 411px">
              <asp:TextBox ID="Description" runat="server" Height="51px" TextMode="MultiLine" Width="271px" CssClass="txt_left"></asp:TextBox></TD></TR></TBODY></TABLE></TD></TR>
  <TR>
    <TD height=10 style="width: 715px"></TD></TR>
  <TR vAlign=bottom>
    <TD align=middle width="100%" colSpan=2>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <asp:Button ID="AddButton" runat="server" Height="30px" OnClick="AddButton_Click"
            Text="提　交" Width="109px" /></TD></TR>
  <TR>
    <TD colSpan=2 height=20><INPUT id=sourceTxt 
      style="WIDTH: 0px; HEIGHT: 0px" value=gysxxwh 
name=sourceTxt></TD></TR></TBODY></TABLE>
            </div>
        </div>
        </asp:Panel>
        <br />
        <asp:Panel ID="ViewPanel" runat="server" Height="50px" Width="100%">
            <br />
            <table width="1005">
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td class="title">
                        供应商维护</td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
                        &nbsp;
                        <input  onclick="window.location.replace('SysSupplierManager.aspx?action=add')" type="button" value="添加供应商">
                    </td>
                </tr>
            </table>
            <br />
        <asp:GridView ID="SupplierList" runat="server" AutoGenerateColumns="False" BackColor="White"
            BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="95%" OnRowDeleting="SupplierList_RowDeleting" DataKeyNames="SupplierID">
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <Columns>
                <asp:TemplateField HeaderText="查看" ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1"   CausesValidation="False" CommandName="Delete" runat="server"  
                            Text="<img border=0 src=../images/View.gif />" ></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="SupplierName" HeaderText="供应商" SortExpression="GroupID" />
                <asp:BoundField DataField="Area" HeaderText="地区" SortExpression="GroupName" />
                <asp:BoundField HeaderText="联系人" DataField="Linkman" />
                <asp:BoundField DataField="Email" HeaderText="电子信箱" SortExpression="Description" />
                <asp:HyperLinkField DataNavigateUrlFields="SupplierID" DataNavigateUrlFormatString="SysSupplierManager.aspx?action=edit&amp;SupplierID={0}"
                    HeaderText="编辑" Text="&lt;img border=0 src=../images/Edit.gif /&gt;">
                    <ItemStyle Width="30px" />
                </asp:HyperLinkField>
                <asp:HyperLinkField DataNavigateUrlFields="SupplierID" DataNavigateUrlFormatString="SysSupplierManager.aspx?action=del&amp;SupplierID={0}"
                    HeaderText="删除" Text="&lt;img border=0 src=../images/Delete.gif /&gt;">
                    <ItemStyle Width="30px" />
                </asp:HyperLinkField>
            </Columns>
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#E2F3FA" Font-Bold="True" ForeColor="Black" />
        </asp:GridView>
        <cc1:CollectionPager ID="CollectionPager1" runat="server" BackNextLinkSeparator=" "
            BackText="上一页" FirstText="第一页" LabelText="第" LastText="最后一页" NextText="下一页" PageNumbersSeparator="-"
            PageSize="10" ShowFirstLast="true" ShowPageNumbers="true">
        </cc1:CollectionPager>
        </asp:Panel>
        &nbsp;&nbsp;&nbsp;<br />
        &nbsp;&nbsp;<br />
        &nbsp;&nbsp;
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Supplier/SysSupplierManager.aspx"
            Visible="False" Width="320px">操作成功！ 返回列表</asp:HyperLink></div>
    </form>
</body>
</html>
