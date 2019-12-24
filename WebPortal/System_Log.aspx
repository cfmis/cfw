<%@ Page Language="C#" AutoEventWireup="true" Inherits="System_Log" Codebehind="System_Log.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>系统日志</title>
    

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
    <form id="form2" runat="server">
    <div>
    <div id="page">
        <br />
        <asp:SiteMapPath ID="SiteMapPath1" runat="server">
        </asp:SiteMapPath>
        <br />
        <br />
    <div class="horizBar" id="DIV1" style="width: 684px"><span class="title" style="font-size: 9pt; color: #333333">&nbsp; &nbsp;&nbsp; &nbsp;
        &nbsp; <span style="font-size: 13px; color: #0279cb">系统日志</span> &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; </span></div> <br />
        <div class="horizBar" style="width: 683px">
            <span class="title" >id &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                操作时间 &nbsp;
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp;相关信息 &nbsp;&nbsp;</span>
                <br />
                <asp:DataList ID="DataList1" runat="server" Width="667px">
                    <ItemTemplate>
                        <table style="width:100%">
                            <tr>
                                <td width=10%>
                                    <%# Eval("LogID")%></td>
                                <td width=20%>
                                    <%# Eval("LogTime")%></td>
                                <td width=70%>
                                    <%# Eval("Description")%></td>
                             
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList><br />
                <br />
                <span style="font-size: 9pt; color: #333333">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<cc1:collectionpager
                        ID="CollectionPager1" runat="server" BackNextLinkSeparator=" " BackText="上一页"
                        FirstText="第一页" LabelText="第" LastText="最后一页" NextText="下一页" PageNumbersSeparator="-"
                        PageSize="15" ShowFirstLast="true" ShowPageNumbers="true"></cc1:collectionpager></span><br />
            </div>
        <br />
         <script type="text/javascript" src="../KindEditor.js"></script>
        <br />
        

        <br />
          
        <br />
        <br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</div>
    
    </div>
    </form>
</body>
</html>
