<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_Products_Photo" Codebehind="Products_Photo.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
        
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
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <table style="width:100%">
            <tr>
                <td align="left">
        <asp:SiteMapPath ID="SiteMapPath1" runat="server">
        </asp:SiteMapPath>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
        </table>
    
        <div class="horizBar" style="width: 908px; height: 11px">
            <span class="title"><span class="title">
                <br />
                商品编号：<asp:Label ID="PID" runat="server" ></asp:Label>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                <asp:HyperLink ID="HyperLink2" runat="server">上传附加图片</asp:HyperLink><br />
                <br />
                上传主要标志图片（每一个商品只有一个）上传图片大小不超过2MB<br />
                <cc1:imageuploader id="ImageUploader1" runat="server"
                
                PreViewCSSClass="PreView"  ThumbMaxHeight="160" ThumbMaxWidth="150"
            Visible="true"  IsGenerateThumb="true" IsRename="true"
             OnUploaded="ImageUploader1_Uploaded" SaveButtonText="上传图片"></cc1:imageuploader>
                <br />
                <asp:HyperLink ID="HyperLink1" runat="server" Visible="False">操作成功！返回列表</asp:HyperLink><br />
                <br />
                
               
             
            </span></span></div>
    
    </div>
    </form>
</body>
</html>
