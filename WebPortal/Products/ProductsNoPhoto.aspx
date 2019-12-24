<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_ProductsNoPhoto" Codebehind="ProductsNoPhoto.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未拍照 未上传相片</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="width: 97%">
            <tr>
                <td align="left" style="width: 810px; height: 20px">
                    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                    </asp:SiteMapPath>
                </td>
            </tr>
        </table>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br />
        <br />
        <br />
        <br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<asp:ImageButton ID="ImageButton1"
            runat="server" Height="57px" ImageUrl="~/images/nonoPhoto.gif" OnClick="ImageButton1_Click"
            Width="176px" />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    
    </div>
    </form>
</body>
</html>
