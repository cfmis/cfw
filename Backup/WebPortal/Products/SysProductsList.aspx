<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_SysProductsList" Codebehind="SysProductsList.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>商品基本维护</title>
    <link href="../css/base.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div align="center"><table style="width:97%;" >
        <tr>
            <td align="left" style="width: 810px; height: 20px;">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>
        <br />
        <table border="0" style="width: 990px">
            <tr>
                <td class="title" style="width: 934px">
                    商品基本维护</td>
            </tr>
            <tr style="width:800px;">
                
                <td style="width: 934px">
                    搜索条件： &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    <asp:CheckBox ID="TypeCheckBox" runat="server" Text="启用商品类型" />&nbsp;
                    <asp:DropDownList ID="proType" runat="server" DataSourceID="ObjectDataSource1" DataTextField="TypeName" DataValueField="TypeID">
                    </asp:DropDownList>
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:CheckBox ID="BrandCheckBox" runat="server" Text="启用商品品牌" />&nbsp;
                    &nbsp; &nbsp; &nbsp;&nbsp;<asp:DropDownList ID="proBrand" runat="server" DataSourceID="ObjectDataSource2" DataTextField="BrandName" DataValueField="BrandID">
                    </asp:DropDownList>
                    &nbsp; &nbsp;&nbsp; 关键字 &nbsp;
                    <asp:TextBox ID="Key" runat="server" Width="79px"></asp:TextBox>
                    &nbsp; &nbsp; &nbsp; &nbsp;<asp:ImageButton ID="searchButton" runat="server" ImageUrl="~/images/sub_search.gif" OnClick="searchButton_Click" />
                    &nbsp; &nbsp; &nbsp; <input id="Button1" onclick="window.location.replace('Products_Add.aspx')" type="button"
                        value="添加商品" /></td>
            </tr>
            <tr>
                <td style="width: 934px">
                    <asp:Label ID="Label1" runat="server" Text="没有您要的信息" Visible="False"></asp:Label>
                    &nbsp;
                    &nbsp; &nbsp;&nbsp;<asp:GridView ID="SearchResult" runat="server" AutoGenerateColumns="False"
                        BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px"
                        CellPadding="4" Width="906px">
                        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                        <Columns>
                            <asp:HyperLinkField DataNavigateUrlFields="ProductsID" DataNavigateUrlFormatString="ShowproductsInfo.aspx?ProductsID={0}"
                                HeaderText="商品编号" Target="_blank" Text="&lt;img border=0 src=../images/View.gif /&gt;" />
                            <asp:BoundField DataField="ProductsID" HeaderText="商品编号" SortExpression="ProductsID" />
                            <asp:BoundField DataField="ProductsName" HeaderText="商品名称"  />
                            <asp:BoundField DataField="BeginEnterDate" HeaderText="入库时间" />
                            <asp:BoundField DataField="UpperLimit" HeaderText="库存上限" />
                            <asp:BoundField DataField="LowerLimit" HeaderText="库存下限" />
                            <asp:BoundField DataField="Cost" HeaderText="成本" />
                            <asp:HyperLinkField HeaderText="调价" Text="&lt;img border=0 src=../images/refresh2.gif /&gt;" DataNavigateUrlFields="ProductsID" DataNavigateUrlFormatString="Products_Cost_Set.aspx?ProductsID={0}" />
                            <asp:HyperLinkField HeaderText="上传图片" Text="&lt;img border=0 src=../images/generic.gif /&gt;" DataNavigateUrlFields="ProductsID" DataNavigateUrlFormatString="Products_Photo.aspx?ProductsID={0}">
                                <HeaderStyle Width="60px" />
                            </asp:HyperLinkField>
                            <asp:HyperLinkField DataNavigateUrlFields="ProductsID" DataNavigateUrlFormatString="Products_Edit.aspx?ProductsID={0}"
                                HeaderText="编辑" Text="&lt;img border=0 src=../images/Edit.gif /&gt;">
                                <ItemStyle Width="30px" />
                            </asp:HyperLinkField>
                            <asp:HyperLinkField DataNavigateUrlFields="ProductsID" DataNavigateUrlFormatString="Products_Delete.aspx?ProductsID={0}"
                                HeaderText="删除"   Text="&lt;img border=0 src=../images/Delete.gif /&gt;">
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
                        PageSize="15" ShowFirstLast="true" ShowPageNumbers="true">
                    </cc1:CollectionPager>
                    &nbsp;
                    
                </td>
            </tr>
            <tr>
                <td align="center" style="height: 17px; width: 934px;">
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="getAllProductsType" TypeName="Leyp.SQLServerDAL.ProductsTypeDAL"></asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="getAllProductsBrand" TypeName="Leyp.SQLServerDAL.ProductsBrandDAL">
                    </asp:ObjectDataSource>
                    &nbsp; &nbsp;
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
