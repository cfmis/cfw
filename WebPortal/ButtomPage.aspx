<%@ Page Language="C#" AutoEventWireup="true" Inherits="ButtomPage" Codebehind="ButtomPage.aspx.cs" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta  http-equiv="refresh"   content="50; url=ButtomPage.aspx"/>
<title>每300秒自动刷新，为提示短信息</title>
    <link href="css/base.css" rel="stylesheet" type="text/css" />
<STYLE type=text/css> 
{
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px
}
HTML {
	HEIGHT: 100%; TEXT-ALIGN: center
}
BODY {
	MARGIN: 0px; FONT: 12px 'Lucida Grande', Verdana, Arial, Sans-Serif; COLOR: #646464; HEIGHT: 100%; BACKGROUND-COLOR: #fff; TEXT-ALIGN: left
}
.TopTxt{padding-top:7px; padding-left:3px; padding-right:3px;filter:Dropshadow(color=#E1F0FF,offX=1,offY=1);height:20px;}
.TopBg{background:url(images/top-3.gif) repeat-x;}

</STYLE>

<SCRIPT language="JavaScript">
<!--
//时间显示
function tick() {
	var hours, minutes, seconds, xfile;
	var intHours, intMinutes, intSeconds, intYear, intMonth, intDay;
	var today;
	today = new Date();
	intYear = today.getFullYear();//today.getYear();
	intMonth = today.getMonth()+1;
	intDay = today.getDate();
	intHours = today.getHours();
	intMinutes = today.getMinutes();
	intSeconds = today.getSeconds();
	if (intHours == 0) {
		hours = "12点";
		xfile = "午夜";
	} else if (intHours < 12) {
		hours = intHours+"点";
		xfile = "上午";
	} else if (intHours == 12) {
		hours = "12点";
		xfile = "正午";
	} else {
		intHours = intHours - 12
		hours = intHours + "点";
		xfile = "下午";
	}
	if (intMinutes < 10) {
		minutes = "0"+intMinutes+"分";
	} else {
		minutes = intMinutes+"分";
	}
	if (intSeconds < 10) {
		seconds = "0"+intSeconds+"秒";
	} else {
		seconds = intSeconds+"秒";
	}
	var strdate;
	strdate=" "+intYear + "年" + intMonth + "月" + intDay + "日  ";
	timeString =  strdate + xfile+hours+minutes+seconds;
	CLOCK.innerHTML = timeString ;
	window.setTimeout("tick();", 1000);
}
window.onload=tick;
-->
</SCRIPT>
<%
        if (getNotRealIssue() > 0)
        {

         %>
         
         <bgsound src="images/jjj0.mp3" loop="1">
         
         <%
            
        }
              %>
</head>
<body>
    <form id="form1" runat="server">
    
    <div>
  
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				
				<td class="TopBg">
					  <table style="width: 100%; height: 100%;" cellpadding="0" cellspacing="0" border="0">
						<tr style="height: 100%;">
							<td class="TopTxt" style="width:80px; height: 20px;" ><a href="../OnlineUser.do" target="MainFrame">  </a></td>
							<td class="TopTxt" style="width:60px; height: 20px;">&nbsp;</td>
							<td class="TopTxt" style="width:300px; height: 20px;"><SPAN id="CLOCK"></SPAN></td>
							<td class="TopTxt" style="height: 20px" >
                                <a  href="Tool/jsj.htm" target="_blank" >科学计算器 </a>  
                            </td>  

						</tr>
					 </table>		
				</td>
				
			 </tr>
		</table>
    
    </div>
       
    </form>
</body>
</html>
