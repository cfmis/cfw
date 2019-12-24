<%@ Page Language="C#" AutoEventWireup="true" Inherits="Index" Codebehind="Index.aspx.cs" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>CF辦公輔助系統</title>
    <link href="css/Index.css" rel="stylesheet" type="text/css" />
	  <script type="text/javascript" language="javascript">
      
function $(s){return document.getElementById(s);}
function swap(s,a,b,c){$(s)[a]=$(s)[a]==b?c:b;}
function hide(s){$(s).style.display=$(s).style.display=="none"?"":"none";
                 var isup=document.getElementById("up_down");
                 isup.src=$(s).style.display==""?"images/up.gif":"images/down.gif";
 }
      </script>



      <script type="text/javascript">

          function setIframeHeight(iframeId){  
   var cwin = document.getElementById(iframeId);   
   if (document.getElementById){  
       if (cwin && !window.opera){  
           if (cwin.contentDocument && cwin.contentDocument.body.offsetHeight){  
               cwin.height = cwin.contentDocument.body.offsetHeight + 20; //FF NS   
           }  
           else if(cwin.Document && cwin.Document.body.scrollHeight){  
               cwin.height = cwin.Document.body.scrollHeight + 10;//IE   
            }  
        }else{  
            if(cwin.contentWindow.document && cwin.contentWindow.document.body.scrollHeight)   
            cwin.height = cwin.contentWindow.document.body.scrollHeight;//Opera   
        }  
    }   
}


</script>


 <style type="text/css" media="pring">   
  .Noprint{display:none;}   
  .PageNext{page-break-after:   always;}   
  </style>  
</head>
<body>
<form id="form1" runat="server">
<center   class="Noprint"   > 
</center>
    
  <table style="width: 100%; height: 100%; table-layout: fixed" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td height="31">
		<table cellpadding="0" cellspacing="0" border="0" width="100%" class="Noprint">
			<tr>
				<td class="TopLeft">&nbsp;&nbsp;&nbsp;  </td>
				<td class="TopBg">
					<table cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td class="TopAle" nowrap="nowrap"></td>
							<td class="TopTxt" nowrap="nowrap"><a href="Desk.aspx" target="MainFrame">桌面</a></td>
							<td class="TopAle" nowrap="nowrap"></td>
							<td class="TopTxt" nowrap="nowrap"><a href="javascript:history.go(-1);">后退</a></td>  
							<td class="TopAle" nowrap="nowrap"></td>
							<td class="TopTxt" nowrap="nowrap"><a href="javascript:history.go(1);">前进</a></td>
							<td class="TopAle" nowrap="nowrap"></td>
							<td class="TopTxt" nowrap="nowrap"><a href="Logout.aspx" target="MainFrame">注销</a></td>
							<td class="TopAle" nowrap="nowrap"></td>
							<td class="TopTxt" nowrap="nowrap"><a href="javascript:if(confirm('你确定要退出本系统吗?'))window.close();">退出</a></td>
						</tr>
					</table>		
				</td>
				<td class="TopRightImg"></td>
				<td class="TopRightBg"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr >
		<td>
			<table cellpadding="0" cellspacing="0" border="0" width="100%" style="height:100%" >
				<tr>
					<td style="width:188px; vertical-align:top; background:#E7F5FD;" id="frmleft">
                        <iframe src="EntryLeft.aspx" style="width: 100%; height: 100%" scrolling="No" noresize="noresize" frameborder="0"></iframe>

					</td>
					<td style="width:6px; background:url(images/switchbg.gif); vertical-align:middle; white-space:nowrap;"  id="splitBar">
						<img class="Noprint" src="images/splitBar.gif" id="switchPoint" onclick="switchSysBar()" style="CURSOR:hand" title="关闭/打开左边导航栏">
					</td>
					<td style="height:100%">
                    
						<table cellpadding="0" cellspacing="0" border="0" style="height:100%" width="100%">
							<tr>								
								<td>
									<iframe  name="MainFrame" id="mainfrm" src="Desk.aspx" style="width: 100%; height: 100%; " frameborder="0"> </iframe>
								</td>
							</tr>
							<tr >
		                     <td height="30px"  >
		 	                    <iframe class="Noprint"  src="ButtomPage.aspx" scrolling="no"   style="width: 100%; height:30px" frameborder="0"> </iframe>
		                    </td>
	                    </tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
  </table>

<script type="text/javascript" language="javascript">
    if(window.top.location.href != window.location.href)
    {
        window.top.location.href = window.location.href;
    }
	function switchSysBar(){
		var frmleft1=document.getElementById("frmleft");
		var switchPoint1=document.getElementById("switchPoint");
		frmleft1.style.display=frmleft1.style.display==""?"none":"";
		switchPoint1.src=frmleft1.style.display==""?"images/splitBar.gif":"images/splitBar2.gif";
	}	


</script>
</form>
</body>
</html>
