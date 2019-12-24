<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_ShowProductsList" Codebehind="ShowProductsList.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>商品列表</title>
    <style type="text/css" >
    .x7 {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 5px; WIDTH: 607px; PADDING-TOP: 25px; BORDER-BOTTOM: #cdcdcd 1px dashed
}
.x7 A {
	COLOR: #cc0066
}
.x7 A:hover {
	COLOR: #cc0066
}
.x7 A IMG {
	BORDER-RIGHT: #c9caca 1px solid; BORDER-TOP: #c9caca 1px solid; FLOAT: left; BORDER-LEFT: #c9caca 1px solid; WIDTH: 100px; BORDER-BOTTOM: #c9caca 1px solid; HEIGHT: 100px
}
.x7 B {
	DISPLAY: block; PADDING-LEFT: 8px; FONT-WEIGHT: normal; FONT-SIZE: 14px; FLOAT: left; WIDTH: 486px
}
.x7 U {
	PADDING-RIGHT: 0px; DISPLAY: block; PADDING-LEFT: 8px; FLOAT: left; PADDING-BOTTOM: 0px; WIDTH: 486px; LINE-HEIGHT: 32px; PADDING-TOP: 5px; TEXT-DECORATION: none
}
.x7 P {
	PADDING-LEFT: 8px; FLOAT: left; WIDTH: 486px; LINE-HEIGHT: 26px
}
.x7 I {
	CLEAR: both; DISPLAY: block; LINE-HEIGHT: 36px; FONT-STYLE: normal; TEXT-ALIGN: right
}
.x7 I A {
	COLOR: #000
}
.x7 I A:hover {
	COLOR: #cc0066
}
    
    
    
    </style>
 <link rel="stylesheet" href="../css/box.css" type="text/css" media="screen" />
          <link rel="stylesheet" href="../css/base.css" type="text/css" media="screen" />
    <script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/thickbox.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
    <table style="width:97%;" >
        <tr>
            <td align="left" style="width: 810px; height: 20px;">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table> 
        <br />
        <table style="width: 877px; height: 30px">
            <tr>
                <td>
                    &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; 商品类型&nbsp; 
                    <asp:DropDownList ID="DropDownList0" runat="server">
                    </asp:DropDownList>
                    &nbsp; &nbsp; &nbsp; &nbsp;商品品牌&nbsp;
                    <asp:DropDownList ID="DropDownList1" runat="server">
                    </asp:DropDownList>
                    &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;
                    &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; 关键字 &nbsp;
                    <asp:TextBox ID="Key" runat="server" Width="79px"></asp:TextBox>
                    &nbsp; &nbsp; &nbsp; &nbsp;<asp:ImageButton ID="searchButton" runat="server" ImageUrl="~/images/sub_search.gif"
                        OnClick="searchButton_Click" />
                    &nbsp;</td>
            </tr>
        </table>
                                <asp:Label ID="Label1" runat="server" Text="没有您要的数据" Visible="False"></asp:Label><br />
    
    <TABLE cellSpacing=0 cellPadding=0 width=850 align=center>
  <TBODY>
  <TR>
    <TD vAlign=top width=648>
      <TABLE cellSpacing=0 cellPadding=0 width=649>
        <TBODY>
        <TR>
          <TD width="643">
              <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="getAllProductsType" TypeName="Leyp.SQLServerDAL.ProductsTypeDAL"></asp:ObjectDataSource>
              <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                  SelectMethod="getAllProductsBrand" TypeName="Leyp.SQLServerDAL.ProductsBrandDAL">
              </asp:ObjectDataSource>
              &nbsp;</TD>
        </TR>
        <TR>
          <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%">
              <TBODY>
              <TR>
                <TD>
                  <TABLE cellSpacing=0 cellPadding=0 width="100%">
                    <TBODY>
                    <TR>
                      <TD bgColor=#0b67d0 style="height: 2px"></TD></TR>
                    <TR>
                      <TD style="height: 144px">
                        <TABLE cellSpacing=0 cellPadding=0 width="100%" 
border=0>
                          <TBODY>
                          <TR>
                            <TD colSpan=8 style="height: 10px">
                                &nbsp;</TD></TR>
                          <TR vAlign=top>
                            <TD width="1%" bgColor=#e3e3e3><IMG height=1 
                              src="../images/blank.gif" 
                              width=1></TD>
                          </TBODY></TABLE>
                          <asp:DataList ID="SearchResult" runat="server">
                              <ItemTemplate>
                                  <DIV class=x7>
                                  
                                  <A href="..\UploadFiles\Images\<%#Eval("PhotoUrl")  %>" title="大图" class="thickbox">
<img  src="..\UploadFiles\Images\<%#Eval("PhotoUrl")  %>" border=0 width=136 style="height: 94px" /></A>

 
<B><STRONG></STRONG><A style="FONT-WEIGHT: bold" 
href="ShowProductsInfo.aspx?ProductsID=<%#Eval("ProductsID")  %>" target="_blank"><%#Eval("ProductsName")  %></A>


</B>
<P><span style="FONT-WEIGHT: bold;COLOR: #cc0066"  >类型：</span>
<%#Eval("TypeName")%>
<span style="FONT-WEIGHT: bold;COLOR: #cc0066"  >品牌：</span>
<%#Eval("BrandName")%>
<span style="FONT-WEIGHT: bold;COLOR: #cc0066"  >颜色：</span>
<%#Eval("Color")%>
<br />
<span style="FONT-WEIGHT: bold;COLOR: #cc0066"  >重量：</span> <%#Eval("Weight")%>
<span style="FONT-WEIGHT: bold;COLOR: #cc0066"  >材质：</span> <%#Eval("Material")%>
<span style="FONT-WEIGHT: bold;COLOR: #cc0066"  >规格：</span> <%#Eval("Spec")%>
<br />
<span style="FONT-WEIGHT: bold"  >相关描述：</span> <%# getStringOfChar(Eval("Description").ToString())%>

</P>
</DIV>
                              </ItemTemplate>
                          </asp:DataList></TD></TR></TBODY></TABLE></TD></TR>
              <TR>
                <TD style="height: 15px">
                    <cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
                        backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
                        pagesize="15" showfirstlast="true" showpagenumbers="true">
                    </cc1:collectionpager>
                    &nbsp;</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD>
    <TD vAlign=top style="width: 210px">
      <TABLE cellSpacing=0 cellPadding=0>
        <TBODY>
        <TR>
          <TD>
            <TABLE cellSpacing=0 cellPadding=0>
              <TBODY>
              <TR>
                <TD><IMG height=39 
                  src="../images/detail_rightbg01_05.gif" 
                  width=192></TD></TR>
              <TR>
                <TD 
                background=../images/detail_rightbg_04.gif><BR></TD></TR>
              <TR>
                <TD><IMG height=10 
                  src="../images/detail_rightbg_05.gif" 
                  width=192></TD></TR></TBODY></TABLE><BR></TD>
        </TR>
        <TR>
          <TD><BR></TD></TR>
        <TR>
      <TD>&nbsp;</TD></TR></TBODY></TABLE></TD>
  </TR></TBODY></TABLE>
    
    </div>
    </form>
</body>
</html>
