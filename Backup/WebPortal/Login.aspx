<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebPortal.Login" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">--%>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>CF辦公輔助系統</title>
		<meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/login/jquery.js"></script>
<script type="text/javascript">
    $(function () {
        $('.loginbox').css({ 'position': 'absolute', 'left': ($(window).width() - 692) / 2 });
        $(window).resize(function () {
            $('.loginbox').css({ 'position': 'absolute', 'left': ($(window).width() - 692) / 2 });
        })
    });  
</script> 
<script src="js/login/cloud.js" type="text/javascript"></script>
</head>
<body style="background-color:#1c77ac; background-image:url(images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
        <div id="mainBody">
      <div id="cloud1" class="cloud"></div>
      <div id="cloud2" class="cloud"></div>
    </div>  
    <div class="logintop">    
    <span>歡迎登錄CF辦公輔助系統</span>    
    <ul>
    <li><a href="#">我的</a></li>
    <li><a href="#">帮助</a></li>
    <li><a href="#">关于</a></li>
    </ul>    
    </div>
    <div class="loginbody">
    
    <span class="systemlogo"></span> 
        <div class="loginbox">            
            <form id="loginform"   runat="server">
				 
                
                
                 <ul>
                <li><input id="inputName"  class="loginuser"  runat="server" type="text" placeholder="用户名" /></li>
                     
              
         
            <li> <input id="inputPassword"  class="loginpwd" runat="server" type="password" placeholder="密码" /></li>
  
                    
            
                   <li>     <asp:button ID="Button1"  type="submit" runat="server" class="loginbtn"  Text="登录" 
                   onclick="Button1_Click" Width="97px"></asp:button> 
                   <label><input name="" type="checkbox" value="" checked="checked" />记住密码</label><label><a href="#">忘记密码？</a></label> </li>

                   
                       
      </ul>
            </form>

            <div class="loginbuttom">
            
      
            <div class="loginbutton_label" align="center"><font color="White" style="font-size:small">精豐鈕釦有限公司版權所有 2017-2018  版本 V1.0<br/>请使用IE6.0 
SP1以上浏览器，最佳显示分辨率1024×768</font></div>
            </div>
         
        </div>

        

     </div>     

     
 
    </body>
</html>
