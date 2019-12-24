<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowMatCode.aspx.cs" Inherits="cfoa.ShowMatCode" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Material(材質)</title>
    <base target="_self" />
    <script type="text/javascript" >
        function cc(infor_id, infor_name, infor_psw) //参数分别为id,name和password
        {
            window.returnValue = infor_id + "'" + infor_name + "'" + infor_psw; //返回值 
            window.close();
        }
</script>


</head>
<body>
    <form id="form1" runat="server">
    <div>
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
            <asp:BoundField DataField="id" HeaderText="ID" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="name" HeaderText="Name" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="english_name" HeaderText="English Name" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="datum" HeaderText="Datum" >
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
