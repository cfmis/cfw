<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_NQ_Select_Products_Window" Codebehind="NQ_Select_Products_Window.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc2" %>
<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>商品基本维护</title>
    <link href="../css/base.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
        <table border="0" width="100%">
            <tr>
                <td class="title" style="width: 769px">
                    选择引用商品</td>
                <td>
                </td>
            </tr>
            <tr style="width:800px;">
                
                <td style="width: 769px">
                    条件： 
                    <cc2:productstypedropdownlist id="ProductsTypeDropDownList1" runat="server"></cc2:productstypedropdownlist>
                    &nbsp; &nbsp; &nbsp; &nbsp;<cc2:productsbranddropdownlist id="ProductsBrandDropDownList1" runat="server"></cc2:productsbranddropdownlist>关键字 &nbsp;
                    <asp:TextBox ID="Key" runat="server" Width="79px" OnTextChanged="Key_TextChanged"></asp:TextBox>
                    &nbsp; &nbsp; &nbsp; &nbsp;<asp:ImageButton ID="searchButton" runat="server" ImageUrl="~/images/sub_search.gif" OnClick="searchButton_Click" />
                    &nbsp; &nbsp; 
                    <asp:Label ID="Label1" runat="server" Text="没有您要的信息" Visible="False" ForeColor="Red"></asp:Label>
                    &nbsp;
                    &nbsp;&nbsp;</td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 769px">
                    &nbsp; &nbsp; &nbsp; &nbsp;<asp:GridView ID="SearchResult" runat="server" AutoGenerateColumns="False"
                        BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px"
                        CellPadding="4" Width="538px" OnRowDeleting="SearchResult_RowDeleting" DataKeyNames="ProductsID,ProductsName">
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="ProductsID" DataNavigateUrlFormatString="ShowproductsInfo.aspx?ProductsID={0}"
                                HeaderText="商品编号" Target="_blank" Text="&lt;img border=0 src=../images/View.gif /&gt;" >
                                <ItemStyle Width="60px" />
                            </asp:HyperLinkField>
                            <asp:BoundField DataField="ProductsID" HeaderText="商品编号" SortExpression="ProductsID" >
                                <ItemStyle Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ProductsName" HeaderText="商品名称"  >
                                <ItemStyle Width="300px" />
                            </asp:BoundField>
                            <asp:CommandField DeleteText="&lt;img border=0 src=../images/Select.gif /&gt;" ShowDeleteButton="True" />
                        </Columns>
                        <RowStyle BackColor="White" ForeColor="#003399" />
                        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                        <HeaderStyle BackColor="#E2F3FA" Font-Bold="True" ForeColor="Black" />
                    </asp:GridView>
                    <cc1:CollectionPager ID="CollectionPager1" runat="server" BackNextLinkSeparator=" "
                        BackText="上一页" FirstText="第一页" LabelText="第" LastText="最后一页" NextText="下一页" PageNumbersSeparator="-"
                        PageSize="15" ShowFirstLast="true" ShowPageNumbers="true">
                    </cc1:CollectionPager>
                    &nbsp;
                    
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td align="center" style="height: 17px; width: 769px;">
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="getAllProductsType" TypeName="Leyp.SQLServerDAL.ProductsTypeDAL"></asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="getAllProductsBrand" TypeName="Leyp.SQLServerDAL.ProductsBrandDAL">
                    </asp:ObjectDataSource>
                    &nbsp; &nbsp;
                </td>
                <td style="height: 17px">
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
