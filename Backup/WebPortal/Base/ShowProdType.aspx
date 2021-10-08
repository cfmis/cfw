<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowProdType.aspx.cs" Inherits="cfoa.ShowProdType" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>產品類型</title>
    <base target="_self" />
    <script type="text/javascript" >
        function cc(infor_id, infor_name, infor_psw) //参数分别为id,name和password
        {
            window.returnValue = infor_id + "'" + infor_name + "'" + infor_psw; //返回值 
            window.close();
        }
    </script>
</head>
<body style="background-color:#FAEBD7">
    <form id="form1" runat="server">
    <div>
    <asp:Label id="lblPrdCode" Text="Prod(代號)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    <asp:Textbox id="txtPrdCode" Text="" Width="60px" Height ="20px" Font-Size="11px"  runat="server"/>
    <asp:Label id="lblName" Text="Name(名稱)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    <asp:Textbox id="txtName" Text="" Width="80px" Height ="20px" Font-Size="11px"  runat="server"/>
    <asp:Label id="lblEname" Text="English Name(名稱)" Width="100px" Height ="20px" Font-Size="11px"  runat="server"/>
    <asp:Textbox id="txtEname" Text="" Width="80px" Height ="20px" Font-Size="11px"  runat="server"/>
    <asp:Button id="btnFind" Text="Find" OnClick="btnFind_Click" Width="80px" Height ="30px" Visible="false"  runat="server"/>
    <asp:GridView ID="gvDetails" runat="server" Height="90px" Width="600px" 
      BackColor="BlanchedAlmond"
      BorderColor="Black" 
      CellPadding="3"
      Font-Name="宋体"
      Font-Size="9pt"
      HeaderStyle-BackColor="ActiveBorder"
      HeaderStyle-Font-Bold="true"
      EnableViewState="False"
      HeaderStyle-HorizontalAlign="Center"
      HeaderStyle-Height="20px"
      RowStyle-Height="20px"
      AutoGenerateColumns="False" Font-Names="宋体"
      AllowPaging="true" PageSize ="50"
      onrowdatabound="gvDetails_RowDataBound"
      onselectedindexchanged="gvDetails_SelectedIndexChanged"
      onpageindexchanging="gvDetails_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="代號(ID)" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="name" HeaderText="描述(Name)" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="english_name" HeaderText="英文描述(English Name)" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="ActiveBorder" Font-Bold="True"></HeaderStyle>
        
<RowStyle Height="20px"></RowStyle>
        
    </asp:GridView>
    </div>
    </form>
</body>
</html>
