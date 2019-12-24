<%@ Page Language="C#" AutoEventWireup="true" Inherits="Logout" Codebehind="Logout.aspx.cs" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>注销登录</title>
     <link href="Style/main.css" rel="stylesheet" type="text/css">
    <link href="Style/window.css" rel="stylesheet" type="text/css">
    
  <style type="text/css">
   .wtabtitleleft{ height: 26PX;background: url(images/title.PNG) no-repeat left top; width:50%;}
.wtabtitleright{ height: 26PX;background: url(images/title.PNG) no-repeat right top; }
.wtabtitletxt{ padding: 6px 0px 0px 24px; font-weight: bold; color: #222222; }
.wtabcontent{ vertical-align:top; border-left: 1px solid #BBBBBB;border-right: 1px solid #BBBBBB;padding:10 10;line-height:22px;}
.wtabbuttomleft{ height: 6PX;background: url(images/title_b.png) no-repeat left top;}
.wtabbuttomright{ height: 6PX;background: url(images/title_b.png) no-repeat right top;}
body,td,th ,div{
	font-size: 12px;
	color: #111111;
	font-family: Geneva, Arial, Helvetica, sans-serif;
}
  
  </style>
    <script type="text/javascript">
        function reopen()
        {
			ALLgoToURL('parent','Login.aspx');
        } 
        function ALLgoToURL() { 
          var i, args=ALLgoToURL.arguments; 
          document.MM_returnValue = false;
          for (i=0; i<(args.length-1); i+=2) 
            eval(args[i]+".location='"+args[i+1]+"'");
        }     
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <p style="margin:10%;"></p>
    <table cellpadding="0" cellspacing="0" border="0" width="350" bgcolor="#FFFFFF" align="center">
	<tr>
		<td class="wtabtitleleft wtabtitletxt" nowrap="nowrap">登陆注销</td>
		<td class="wtabtitleright"></td>
	</tr>
	<tr>
		<td class="wtabcontent" colspan="2" style="height:100">
		<div style="float:left;width:80px;">
		<img src="images/logout.gif" border="0" align="absmiddle" />
		</div>
		<div style="float:left; margin:10px; text-align:center;">
		    你确定要注销当前登陆用户吗？<br /><br />
           <asp:Button ID="btnOK" runat="server" CssClass="button60" OnClick="btnOK_Click" Text="确定" />&nbsp;
        <asp:Button ID="btnCancel" runat="server" CssClass="button60" OnClick="btnCancel_Click" Text="放弃" />
         
         </div>
		</td>
	</tr>
	<tr>
		<td class="wtabbuttomleft" ></td>
		<td width="80%" class="wtabbuttomright"></td>
	</tr>
</table>
        

    </form>
</body>
</html>
