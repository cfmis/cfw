<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_Products_Photo_Attach" Codebehind="Products_Photo_Attach.aspx.cs" %>
<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>商品附加的图片上传</title>
            <style type="text/css">
    body {
	FONT-SIZE: 12px;
	COLOR: #333;
	FONT-FAMILY: 'Lucida Grande', Verdana, Arial, Sans-Serif;
	background-color: #FFFFFF;
	margin-top: 1px;
	text-align: center;
	margin-bottom: 1px;

	}
a:visited,
a:active,
a:link {
 color:#0279CB;
 text-decoration:none;
 }
a:hover {
 color:#00A4E3;
 text-decoration:none;
 BORDER-BOTTOM: 1px dotted;
}
#page{
text-align:left;
padding-left:10px;
padding-top:2px;
	margin-top:1px;
	margin-bottom:1px;

}
.horizBar
{
	background-color:#E5EEF7;
	width:700px;
	height:20px;
	border-bottom: 1px;
	border-top:1px thin;
	padding-left:10px;
	text-align: left;
	padding-top: 5px;
	margin-top:1px;
	margin-bottom:1px;
}
.title{
FONT-WEIGHT: bold; font: "Times New Roman", Times, serif;
font-size:13px;
color:#0279CB;
}
INPUT
{
   margin-top :1px;
	margin-bottom:1px;
	padding-bottom:1px;
	padding-top:1px;
	
}
 .PreView
    {
        width:150px;
        border-style: double;
        border-color: #333;
    }
    
.preImg{
width:600px;
height:400px;


}
    
    </style>
       <link rel="stylesheet" href="../css/box.css" type="text/css" media="screen" />
    <script type="text/javascript" src="../js/jq.js"></script>
<script type="text/javascript" src="../js/thickbox.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        &nbsp;
        <br />
    
        <div class="horizBar" style="width: 908px; height: 11px">
            <span class="title"><span class="title">
                <br />
                <br />
                <strong><span style="font-size: 9pt; color: #0279cb">商品编号：</span></strong><asp:Label
                    ID="PID" runat="server"></asp:Label><br />
                <br />
                上传附加图片：多个<br />
                <br />
                <asp:HyperLink ID="HyperLink1" runat="server" Visible="False">操作成功！返回列表</asp:HyperLink><br />
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; 上传图片大小不超过2MB<br />
                <br />
                <cc1:imageuploader id="Imageuploader2" runat="server"    PreViewCSSClass="preImg"  onuploaded="Imageuploader2_Uploaded"
                    savebuttontext="上传图片"></cc1:imageuploader>
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                &nbsp;<br />
                <br />
                
                <table border="0" height="35" width="809">
                    <asp:Repeater ID="PhotoList" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    &nbsp;</td>
                                <td>
                                    &nbsp;
                                   <A href="../UploadFiles/Images/<%# Eval("PhotoUrl") %>" title="放大图片" > 
                                    <img  height="200" width="300" src='../UploadFiles/Images/<%# Eval("PhotoUrl") %>' />
                                    
                                    </A>
                                    </td>
                                    
                                     <td>
                                      <a href="Products_Photo_Attach.aspx?action=del&ID=<%# Eval("ID") %>&ProductsID=<%# Eval("ProductsID") %>"><img  alt="" src="../images/Delete.gif" /> </a> 
                                         
                                    </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
                <br />
                <br />
                <br />
            </span></span>
        </div>
    
    </div>
    </form>
</body>
</html>
