<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_NewsProducts" Codebehind="NewsProducts.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
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
    <div align=center>
        <br /><table style="width:97%;"  >
        <tr >
            <td align="left" style="width: 810px; height: 20px;">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>
        <br />
        <asp:DataList ID="SearchResult" runat="server" Width="686px">
            <ItemTemplate>
                <div class="x7">
                    <a class="thickbox" href='..\UploadFiles\Images\<%#Eval("PhotoUrl")  %>' title="大图">
                        <img border="0" src='..\UploadFiles\Images\<%#Eval("PhotoUrl")  %>' style="height: 94px"
                            width="136" /></a> <b><strong></strong><a href='ShowProductsInfo.aspx?ProductsID=<%#Eval("ProductsID")  %>'
                                style="font-weight: bold" target="_blank">
                                <%#Eval("ProductsName")  %>
                            </a></b>
                    <p>
                        <span style="font-weight: bold; color: #cc0066">类型：</span>
                        <%#Eval("TypeName")%>
                        <span style="font-weight: bold; color: #cc0066">品牌：</span>
                        <%#Eval("BrandName")%>
                        <span style="font-weight: bold; color: #cc0066">颜色：</span>
                        <%#Eval("Color")%>
                        <br />
                        <span style="font-weight: bold; color: #cc0066">重量：</span>
                        <%#Eval("Weight")%>
                        <span style="font-weight: bold; color: #cc0066">材质：</span>
                        <%#Eval("Material")%>
                        <span style="font-weight: bold; color: #cc0066">规格：</span>
                        <%#Eval("Spec")%>
                        <br />
                        <span style="font-weight: bold">相关描述：</span>
                        <%# Eval("Description")%>
                    </p>
                </div>
            </ItemTemplate>
        </asp:DataList>&nbsp;</div>
    </form>
</body>
</html>
