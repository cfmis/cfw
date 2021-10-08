<%@ Page Language="C#" AutoEventWireup="true" Inherits="Authority_GroupManager" Codebehind="GroupManager.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>群组管理</title>
    <style type="text/css">
    body,td,th {
	font-size: 12px;
}

.bga {
	background-color: #ffffff;
}
.bgb {
	background-color: #DAEEFE;
}

    
    </style>

</head>
<body>
  <form id="form1" runat="server">
     <div>
        &nbsp;<asp:SiteMapPath ID="SiteMapPath1" runat="server">
         </asp:SiteMapPath>
         <table style="width: 849px">
            <tr>
                <td style="width: 22px; height: 1px;">
                </td>
                <td style="width: 470px; height: 1px;">
                </td>
            </tr>
            <tr>
                <td style="width: 22px">
                </td>
                <td style="width: 470px">
                    <asp:Panel ID="editPanel" runat="server" Height="100%" Width="100%" Visible="False">
                        <br />
                        &nbsp;<asp:HyperLink ID="HyperLink2" runat="server" Font-Size="Small" NavigateUrl="~/Authority/GroupManager.aspx">返回群组列表</asp:HyperLink>
                        &nbsp; &nbsp;注：ID：4为流程管理&nbsp; 3库存开单 2销售开单 1采购开单类 0系统设置<br />
                    
                  
     
                    
                        <table style="width: 152px; height: 254px">
                            <tr>
                                <td style="height: 202px">
                        <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(../images/content_bg1.gif) repeat-x 50% bottom; FLOAT: left; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 701px; BORDER-BOTTOM: #a4d5e3 1px solid; ">
                            <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">
                                &nbsp;</h2>
                            <DIV style="MARGIN: 5px">
                                <table style="width: 587px; height: 111px;">
                                    <tr>
                                        <td style="width: 22%; height: 43px;">
                                            群组名称：</td>
                                        <td style="width: 50%; height: 43px;" >
                                            <asp:TextBox ID="GroupName_edit" runat="server" Width="140px"></asp:TextBox>
                                            <asp:Label ID="GroupID" runat="server" Visible="False"></asp:Label></td>
                                        <td style="width: 40%; height: 43px;">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 22%; height: 17px">
                                            描述：</td>
                                        <td style="width: 50%; height: 17px">
                                            <asp:TextBox ID="Description_edit" runat="server" Height="50px" TextMode="MultiLine" Width="308px"></asp:TextBox></td>
                                        <td style="width: 40%; height: 17px">
                                            <asp:Button ID="updateButton" runat="server" Text="更　新" Width="87px" OnClick="updateButton_Click" /></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
     <asp:Button ID="ResetSelect" runat="server" OnClick="ResetSelect_Click" Text="重新选择"/></td>
                            </tr>
                        </table>    
          <asp:GridView ID="AuthorityList" runat="server" Width="639px" 
          AutoGenerateColumns="False"  BorderColor="#3366CC" BorderStyle="None"
           BorderWidth="1px" CellPadding="4" DataKeyNames="AuthorityID"
           
             OnRowDataBound="AuthorityList_RowDataBound" >
              <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
              <Columns>
                  <asp:TemplateField HeaderText="ID">
                      <EditItemTemplate>
                          <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TypeID") %>'></asp:TextBox>
                      </EditItemTemplate>
                      <ItemStyle Width="20px" />
                      <HeaderStyle Width="20px" />
                      <ItemTemplate>
                          <asp:Label ID="Label1" runat="server" Text='<%# Bind("TypeID") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="选取">
                      <ItemStyle Width="50px" />
                      <ItemTemplate >
                          <asp:CheckBox ID="CheckBox1" runat="server" BorderColor="#000000" BorderWidth="1px" />
                      </ItemTemplate>
                     </asp:TemplateField>
                     
                            <asp:BoundField DataField="AuthorityName" HeaderText="权限名称" SortExpression="AuthorityName">
                                <ItemStyle Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Description" HeaderText="权限描述" SortExpression="Description" />
                        </Columns>  
                            <RowStyle ForeColor="#003399" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <HeaderStyle BackColor="#E2F3FA" Font-Bold="True" ForeColor="Black" />
              
                         
              
          </asp:GridView>
                        
                        &nbsp;
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td style="width: 22px; height: 121px">
                </td>
                <td style="width: 470px; height: 121px" align="left">
                    <asp:Panel ID="viewPanel" runat="server"  Visible="False">
     <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(../images/content_bg1.gif) repeat-x 50% bottom; FLOAT: left; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 638px; BORDER-BOTTOM: #a4d5e3 1px solid; ">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">
          &nbsp;</H2>
      <DIV style="MARGIN: 5px">
        
            <table style="width: 580px; height: 104px;">
                <tr>
                    <td style="width: 22%; height: 43px;">
                        群组名称：</td>
                    <td style="width: 50%; height: 43px;" >
                        <asp:TextBox ID="GroupName_New" runat="server" Width="140px"></asp:TextBox>
                        </td>
                    <td style="width: 40%; height: 43px;">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 22%; height: 17px">
                        描述：</td>
                    <td style="width: 50%; height: 17px">
                        <asp:TextBox ID="Description_new" runat="server" Height="46px" TextMode="MultiLine" Width="309px"></asp:TextBox></td>
                    <td style="width: 40%; height: 17px">
                        <asp:Button ID="submit" runat="server" Text="添　加" Width="87px" OnClick="submit_Click" /></td>
                </tr>
            </table>
       
      </DIV></DIV> 
                        <br />
                        <asp:GridView ID="GridView1" runat="server"  Width="639px" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" >
                            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                            <Columns>
                                <asp:BoundField DataField="GroupID" HeaderText="编号" SortExpression="GroupID" />
                                <asp:BoundField DataField="GroupName" HeaderText="群名" SortExpression="GroupName" />
                                <asp:BoundField DataField="Description" HeaderText="描述" SortExpression="Description" />
                                
                               <asp:HyperLinkField HeaderText="编辑" Text="&lt;img border=0 src=../images/Edit.gif /&gt;" DataNavigateUrlFields="GroupID"  DataNavigateUrlFormatString="GroupManager.aspx?module=GroupManager&action=edit&GroupID={0}" >
                               <ItemStyle Width="30px" />
                              </asp:HyperLinkField>
                                
                              <asp:HyperLinkField HeaderText="删除" Text="&lt;img border=0 src=../images/Delete.gif /&gt;" DataNavigateUrlFields="GroupID"  DataNavigateUrlFormatString="GroupManager.aspx?module=GroupManager&action=del&GroupID={0}" >
                               <ItemStyle Width="30px" />
                              </asp:HyperLinkField>
                              
                            
                
                            </Columns>
                            <RowStyle BackColor="White" ForeColor="#003399" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                            <HeaderStyle BackColor="#E2F3FA" Font-Bold="True" ForeColor="Black" />
                        </asp:GridView>
                        &nbsp;&nbsp;&nbsp;<br />
                        &nbsp;
                        <table style="width: 631px; height: 36px">
                            <tr>
                                <td style="width: 474px">
                                    <cc1:collectionpager id="CollectionPager1" runat="server" 　　ShowPageNumbers="true" ShowFirstLast="true" PageSize="15" PageNumbersSeparator="-" NextText="下一页" LastText="最后一页" LabelText="第" FirstText="第一页" BackText="上一页" BackNextLinkSeparator=" "></cc1:collectionpager>
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
                    &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Authority/GroupManager.aspx?module=GroupManager&action=view"
                        Visible="False">操作成功！返回群列表</asp:HyperLink></td>
            </tr>
        </table>
  
    </div>
      <br />
      &nbsp;
    </form>
</body>
</html>
