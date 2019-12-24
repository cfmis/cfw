<%@ Page Language="C#" AutoEventWireup="true" Inherits="Buy_BuyOrder_Detail_Photo" Codebehind="BuyOrder_Detail_Photo.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>采购单明细列表 商品图片</title>
    <link href="../css/base.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="890" height="40" border="0">
  <tr>
    <td width="128" height="36">&nbsp;</td>
    <td width="400" align="center" class="title">采购订单商品图片列表</td>
    <td width="58">单号：</td>
    <td width="286">&nbsp;<asp:Label ID="Label1" runat="server"></asp:Label></td>
  </tr>
</table>
    
     <table border="1" height="35" width="95%">
                      <tr>
                                <td width="100">
                                 商品编号
                                 </td>
                                <td>
                                    商品图片
                                   </td>
                                    
                                  <td>
                                      
                                  </td>
                      </tr>
                    <asp:Repeater ID="PhotoList" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                   <%# Eval("ProductsID") %>
                                   
                                   </td>
                                <td>
                                    &nbsp;
                                   
                                    <img  border="0" src='../UploadFiles/Images/<%# Eval("PhotoUrl") %>' />
                                    
                              
                                    </td>
                                    
                                     <td>
                                      
                                         
                                    </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
    </div>
        </DIV>
    </form>
</body>
</html>
