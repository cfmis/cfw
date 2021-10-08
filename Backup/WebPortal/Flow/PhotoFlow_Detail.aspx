<%@ Page Language="C#" AutoEventWireup="true" Inherits="Flow_PhotoFlow_Detail" Codebehind="PhotoFlow_Detail.aspx.cs" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
        <link href="../css/base.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>

   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/jquery.blockUI.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
	<script type="text/javascript" src="../js/jquery.blockUI.js"></script>
	
<STYLE type=text/css> 
{
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px
}
HTML {
	HEIGHT: 100%; TEXT-ALIGN: center
}
BODY {
	margin-left: 10px; FONT: 12px 'Lucida Grande', Verdana, Arial, Sans-Serif; COLOR: #646464; HEIGHT: 100%; BACKGROUND-COLOR: #fff; TEXT-ALIGN: left
}
A:link {
	COLOR: #646464; TEXT-DECORATION: none
}
A:visited {
	COLOR: #646464; TEXT-DECORATION: none
}
A:active {
	COLOR: #fff; BACKGROUND-COLOR: #ff6600; TEXT-DECORATION: none
}
A:hover {
	COLOR: #f60; BACKGROUND-COLOR: #fff; TEXT-DECORATION: none
}
.bar {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 4px; WIDTH: auto; PADDING-TOP: 4px; BORDER-BOTTOM: #efefef 1px solid; HEIGHT: 20px; BACKGROUND-COLOR: #fafafa
}
.title
{
	font-weight: bolder;
	font-size: 18pt;
	color: black;
	line-height: 150%;
	font-family: 楷体_GB2312;
	text-decoration: underline;
}

.RowHeader2 {
	FONT-WEIGHT: 400; PADDING-TOP: 0.5em; BORDER-BOTTOM: #b7c0c7 1px solid; HEIGHT: 25px; BACKGROUND-COLOR: #f2f6ff
}

TD.MenuLeft {
	WHITE-SPACE: nowrap
}

.Indent1 {
	BORDER-TOP: #ddd 1px solid; PADDING-LEFT: 20px
}

.Normal {
	BORDER-TOP: #ddd 1px solid
}.txt_center
{
	border-right: gray 0px solid;
	border-top: gray 0px solid;
	border-left: gray 0px solid;
	border-bottom: gray 0px solid;
	height: 19px;
	font-size: 9pt;
	vertical-align: baseline;
	cursor: text;
	line-height: 150%;
	background-color: transparent;
	text-align: center;
	text-decoration: none;
}
</STYLE>


<script type="text/javascript">

function initload()
{
     $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
    var BuyOrderIDs = "";
    BuyOrderIDs=document.getElementById("BuyOrderID").value;
     var xmlHttps=this.createXmlHttp();                       
            xmlHttps.onreadystatechange = function() {
                if (xmlHttps.readyState == 4) {
                   
                      document.getElementById("initSubmitInfo").innerHTML=xmlHttps.responseText;
                      $('.flexme2').flexigrid();
                        $.unblockUI();//
                     
                }
            }
            xmlHttps.open("POST", "AjaxBuyDetail_Add.aspx", true);
            xmlHttps.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttps.send("action=loadDetail&BuyOrderID="+BuyOrderIDs);//  
   

}

</script>
</head>
<body onLoad="initload();">
 
<OBJECT id=WebBrowser classid=CLSID:8856F961-340A-11D0-A96B-00C04FD705A2 height=0 width=0> 
</OBJECT>
<table style="width:96%;" >
<tr>
<td style="width: 890px">

</td>
</tr>
<tr>
<td align="center" class="title" style="width: 890px">
    图片修改计划详细</td>

</tr>
</table>
  <form id="form1" runat="server"><table style="width:96%;" >
      <tr>
          <td style="width: 890px">
              <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
          <td align="center" >
              <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></td>
      </tr>
  </table>
						
						

</form>
    <br />
    <table style="width:96%;" >
        <tr>
            <td style="width: 890px">
                <input id="content" runat="server" name="content" type="hidden" /></td>
        </tr>
        <tr>
            <td align="center" >
                <iframe id="eWebEditor1" frameborder="0" height="450" scrolling="no" src="ewebeditor/ewebeditor.asp?id=content&style=s_mini"
                    width="650"></iframe>
                <br />
                <br />
                <asp:Button ID="Button1" runat="server" Text="Button" Width="196px" /></td>
        </tr>
    </table>
</body>
</html>

