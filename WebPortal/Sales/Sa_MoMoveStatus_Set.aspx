<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_MoMoveStatus_Set.aspx.cs" Inherits="WebPortal.Sales.Sa_MoMoveStatus_Set" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <%--當使用bootstrap格式時，建議配對使用：ScriptManager，不然出現兼容性錯誤。--%>

    <style type="text/css"> 
        .divShowQueryImg{ border:1px solid #000; height:80px;overflow:hidden;} 
        .divShowQueryImg img{max-width:60px;_width:expression(this.width > 300 ? "300px" : this.width);} 
    </style> 

</head>
<body style="background-color:#FAEBD7">
    
    <table style="width: 97%">
        <tr>
            <td align="left" style="width: 810px; height: 20px">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>

    <form id="form1" runat="server">
    <div>
    <asp:Button id="btnShowOc" Text="返回" OnClick="btnShowOc_Click" Width="100px"  Height ="30px"  runat="server"/>
    <p>
    <asp:Label id="lblInfo" Text="在這個頁面中，可以批次設定需要列印的制單編號" Width ="520px" runat="server"/>
   
    <br />
    <asp:Label id="lblDep" Text="發貨部門" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtDep" Width ="80px" Text="" runat="server"/>
    <asp:Label id="lblDate" Text="統計日期" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtDate" Width ="100px" Text="" AutoPostBack="false" runat="server"/>
    <asp:Button id="btnLoadBatchMo" Text="查看臨時表" OnClick="btnLoadBatchMo_Click" Width="100px"  Height ="30px"  runat="server"/>
    <asp:Label id="Label1" Text="不輸入日期，可以查看全部" Width ="200px" runat="server"/>
    <br />
    <asp:FileUpload ID="fileId" runat="server" Width ="400px" Height ="30px" />
    <asp:Button ID="btnUpload" runat="server" Text="上传" onclick="btnUpload_Click" Width ="60px" Height ="30px" /> 
    <br />
    <asp:TextBox id="txtAddMo" Width ="120px" Text="" Height ="25px" runat="server"/>
    <asp:Button id="btnCleanMo" Text="清空臨時表" OnClick="btnCleanMo_Click" Width="100px"  Height ="30px"  runat="server"/>
    
    
    </p>

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
                    <asp:BoundField DataField="id" HeaderText="序號" HeaderStyle-Width="40px" >
<HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>
                    <asp:BoundField DataField="out_id" HeaderText="外發單號" HeaderStyle-Width="100px" >
<HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="prd_mo" HeaderText="制單編號" HeaderStyle-Width="80px" >
<HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="prd_item" HeaderText="物料編號" HeaderStyle-Width="120px" >
<HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="count_date" HeaderText="統計日期" HeaderStyle-Width="80px" >
<HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>

            <asp:CommandField ShowDeleteButton="True" >
            <HeaderStyle Width="40px" />
            </asp:CommandField>
        </Columns>
        <HeaderStyle HorizontalAlign="Center" BackColor="ActiveBorder" Font-Bold="True"></HeaderStyle>

<RowStyle Height="20px"></RowStyle>
    </asp:GridView>
    </div>
    </form>
</body>
</html>
