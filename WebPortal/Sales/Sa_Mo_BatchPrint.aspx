<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Mo_BatchPrint.aspx.cs" Inherits="WebPortal.Sales.Sa_Mo_BatchPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
</head>
<body>

    <div id="container">  

    <table class="table_SiteMapPath">
    <tr>
    <td>
    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
          </asp:SiteMapPath>
    </td>
    </tr>
    </table>


    <div id="content"> 


    <form id="form1" runat="server">

    <table>
    <tr>
    <td>
    <asp:Label id="lblInfo" Text="在這個頁面中，可以批次設定需要列印的制單編號" Width ="520px" runat="server"/>
    </td>
    </tr>
    <tr>
    <td>
    <asp:FileUpload ID="fileId" runat="server" Width ="400px" Height ="30px" />
    <asp:Button ID="btnUpload" runat="server" Text="上传" onclick="btnUpload_Click" Width ="60px" Height ="30px" />
    
    </td>
    </tr>
    <tr>
    <td>
    <asp:TextBox id="txtAddMo" Width ="120px" Text="" Height ="25px" runat="server"/>
    <asp:Button id="btnBatch" Text="加入" OnClick="btnBatch_Click" Width="100px"  Height ="30px"  runat="server"/>
    <asp:Button id="btnCleanMo" Text="清空臨時表" OnClick="btnCleanMo_Click" Width="100px"  Height ="30px"  runat="server"/>
    <asp:Button id="btnLoadBatchMo" Text="查看臨時表" OnClick="btnLoadBatchMo_Click" Width="100px"  Height ="30px"  runat="server"/>
    </td>
    </tr>
    </table>
    <asp:GridView ID="gvBatchMo" runat="server" Height="90px" Width="500px"
      BackColor="AntiqueWhite"
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
      onrowdeleting="gvDetails_RowDeleting">
        <Columns>
            <asp:BoundField DataField="mo_id" HeaderText="制單編號" HeaderStyle-Width="120px" >
<HeaderStyle Width="120px" BackColor="White"></HeaderStyle>
            </asp:BoundField>
        </Columns>
        <Columns>
            <asp:BoundField DataField="status_desc" HeaderText="制單狀態" HeaderStyle-Width="100px" >
<HeaderStyle Width="100px" BackColor="White"></HeaderStyle>
            </asp:BoundField>
        </Columns>
        <Columns>
            <asp:BoundField DataField="crusr" HeaderText="建立人" HeaderStyle-Width="100px" >
<HeaderStyle Width="100px" BackColor="White"></HeaderStyle>
            </asp:BoundField>
        </Columns>
        <Columns>
            <asp:BoundField DataField="crtim" HeaderText="建立日期" HeaderStyle-Width="120px" >
<HeaderStyle Width="120px" BackColor="White"></HeaderStyle>
            </asp:BoundField>
            <asp:CommandField ShowDeleteButton="True" >
            <HeaderStyle Width="40px" BackColor="White" />
            </asp:CommandField>
        </Columns>
        <HeaderStyle HorizontalAlign="Center" BackColor="ActiveBorder" Font-Bold="True"></HeaderStyle>

<RowStyle Height="20px"></RowStyle>
    </asp:GridView>

    </form>

    </div>
    </div>
</body>
</html>
