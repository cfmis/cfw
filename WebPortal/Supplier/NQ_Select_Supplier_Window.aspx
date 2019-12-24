<%@ Page Language="C#" AutoEventWireup="true" Inherits="Supplier_NQ_Select_Supplier_Window" Codebehind="NQ_Select_Supplier_Window.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>选择供应商</title>
<style type="text/css">
<!--
body,td,th {
	font-size: 12px;
}
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style>
<script type="text/javascript">
function selected(val)
{
      window.returnValue=val;
       this.window.close();
}

</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <table border="0">
  <tr>
    <td style="height: 27px; width: 586px;">&nbsp;顾客名称 ：<asp:TextBox ID="StrKey" runat="server" OnTextChanged="StrKey_TextChanged"></asp:TextBox>&nbsp;
        <asp:Button ID="SelectButton" runat="server" Text="查 询" OnClick="SelectButton_Click"  />
        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; 
        <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="没有你要的记录" Visible="False"
            Width="86px"></asp:Label></td>
  </tr>
  <tr>
    <td style="width: 586px">
        <asp:GridView ID="SupplierList" runat="server" AutoGenerateColumns="False" BackColor="White"
            BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="100%" OnRowDeleting="SupplierList_RowDeleting" DataKeyNames="SupplierID,SupplierName">
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <Columns>
                <asp:BoundField    DataField="SupplierID" HeaderText="编号"  >
                    <HeaderStyle Width="100px" />
                    <ItemStyle Width="100px" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="供应商">
                    <EditItemTemplate>
                        <asp:TextBox ID="SupplierName" runat="server" Text='<%# Bind("SupplierName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle HorizontalAlign="Center" Width="200px" />
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("SupplierName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField    DataField="Area" HeaderText="地区" >
                    <ItemStyle HorizontalAlign="Center" Width="150px" />
                    <HeaderStyle Width="100px" />
                </asp:BoundField>
                <asp:CommandField ShowDeleteButton="True" DeleteText="选择" >
                    <ItemStyle HorizontalAlign="Center" />
                </asp:CommandField>
            </Columns>
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#E2F3FA" Font-Bold="True" ForeColor="Black" />
        </asp:GridView>
    </td>
  </tr>
  <tr>
    <td style="height: 21px; width: 586px;" align="center">&nbsp;<cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
            backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
            pagesize="10" showfirstlast="true" showpagenumbers="true">
        </cc1:collectionpager></td>
  </tr>
</table>
    
    
    </div>
    </form>
</body>
</html>
