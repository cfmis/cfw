<%@ Page Language="C#" AutoEventWireup="true" Inherits="Index_Left_Menu" Codebehind="Index_Left_Menu.aspx.cs" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>左边菜单</title>
<style type="text/css">
<!--
BODY {
	FONT-SIZE: 12px
}
TD {
	FONT-SIZE: 12px
}
.menu_box_pad {
	PADDING-RIGHT: 2px; PADDING-LEFT: 2px; BACKGROUND: #E4EEF3; PADDING-BOTTOM: 2px; PADDING-TOP: 0px
}
.menu_box {
	BORDER-RIGHT: #d6d6d6 1px solid; BORDER-TOP: #ababab 1px solid; BORDER-LEFT: #ababab 1px solid; BORDER-BOTTOM: #d6d6d6 1px solid
}
.menu_box TH {
	BACKGROUND: url(images/menu_list_icon.gif) no-repeat center 50%; WIDTH: 10px; LINE-HEIGHT: 22px
}
.menu_box TD {
	BACKGROUND: url(images/menu_list_split.gif) no-repeat left bottom; LINE-HEIGHT: 20px
}
.menu_box A {
	COLOR: #000; TEXT-DECORATION: none
}
.menu_box A:hover {
	TEXT-DECORATION: underline
}
.hand {
	CURSOR: pointer
}
.ctrl_menu {
	BORDER-RIGHT: #767676 1px solid; BACKGROUND: #B8D6F3; BORDER-LEFT: #767676 1px solid; BORDER-BOTTOM: #767676 1px solid
}
.ctrl_menu_title {
	PADDING-LEFT: 15px; FONT-WEIGHT: bold; LINE-HEIGHT: 25px
}
.ctrl_menu_title_bg {
	BACKGROUND: url(images/menu_title_bg.gif)
}
.top_bg {
	BACKGROUND: url(images/top_bg.gif)
}
.logo_bg {
	BACKGROUND: url(images/logo_bg.gif)
}
.a01 A:link {
	COLOR: #000; TEXT-DECORATION: underline
}
.a01 A:visited {
	COLOR: #000; TEXT-DECORATION: underline
}
.a01 A:active {
	COLOR: #000; TEXT-DECORATION: none
}
.a01 A:hover {
	COLOR: #000; TEXT-DECORATION: none
}
#top_nav_menu {
	COLOR: #fff
}
#top_nav_menu A {
	COLOR: #fff; TEXT-DECORATION: none
}
#top_nav_menu A:hover {
	COLOR:#ff6; TEXT-DECORATION: underline
}

-->
</style>
 <script type="text/javascript" language="javascript">
      
function $(s){return document.getElementById(s);}
function swap(s,a,b,c){$(s)[a]=$(s)[a]==b?c:b;}
function hide(s){$(s).style.display=$(s).style.display=="none"?"":"none";}

function openjsj()
{
  window.open("Tool/jsj.htm",null,"height=100%,width=540,status=yes,toolbar=yes,menubar=yes,location=yes,resizable=yes,scroll=yes");

}


function loadload()
{
    var guanlis6 = document.getElementById("Hidden6").value;
   var guanlis5=document.getElementById("Hidden5").value;
    var guanlis4=document.getElementById("Hidden4").value;
     var guanlis3=document.getElementById("Hidden3").value;
      var guanlis2=document.getElementById("Hidden2").value;
      var guanlis1 = document.getElementById("Hidden1").value;
   if (guanlis6 == "0") {
          this.document.getElementById("guanlimenu").style.display = 'none';
   }
   if(guanlis5=="0")
   {
     this.document.getElementById("guanlimenu").style.display='none';
   }
    if(guanlis4=="0")
   {
     this.document.getElementById("StockMenuTable").style.display='none';
   }
   
    if(guanlis3=="0")
   {
     this.document.getElementById("salesMenu").style.display='none';
   }
   
    if(guanlis2=="0")
   {
     this.document.getElementById("calgouMenu").style.display='none';
   }
   
   
    if(guanlis1=="0")
   {
     this.document.getElementById("systemSetMenu").style.display='none';
   }
}

      </script>
</head>
<body onload="loadload()">
    <form id="form1" runat="server">
    <div><table class="ctrl_menu" cellspacing="0" cellpadding="0" width="205"
            border="0">
              <tbody>
              <tr>
              <td style="height: 10px; width: 203px;">
           
              
              </td>
              
              </tr>
              <tr>
                <td align="center" style="width: 203px" valign="top"><!-- 快速通道 -->
                  <table class="ctrl_menu_title_bg" cellspacing="0" cellpadding="0"
                  width="195" border="0">
                    <tbody>
                    <tr class="hand" onclick="hide('hideMenuFunc0')">
                      <td class="ctrl_menu_title" width="174">
                          常用資料</td>
                      <td width="21"><img id="MenuFunc0"
                        src="Images/menu_title_up.gif"></td></tr>
                    <tr id="hideMenuFunc0">
                      <td class="menu_box_pad" align="left" colspan="2">
                        <table class="menu_box" cellspacing="5" cellpadding="0"
                        width="100%" border=0>
                          <tbody>
                          <tr>
                            <th>&nbsp;</th>
                            <td><a  href="javascript:void(0)" 
                              target="MainFrame"> 物料編號</a></td></tr>
                          <tr>
                            <th>&nbsp;</th>
                            <td><a  href="javascript:void(0)" 
                              target="MainFrame">圖樣查詢</a></td>
                          </tr>
                          <tr>
                            <th>&nbsp;</th>
                            <td>
                               <a  href="javascript:void(0)" 
                              target="MainFrame"> 生產狀態瀏覽 </a></td></tr>
                              <tr>
                                  <th style="height: 22px">
                                  </th>
                                  <td style="height: 22px">
                                     <a  href="javascript:void(0)" 
                              target="MainFrame"> 庫存狀態 </a></td>
                              </tr>
                              <tr>
                                  <th>
                                  </th>
                                  <td>
                                     <a  href="javascript:void(0)" 
                              target="MainFrame"> 訂單查詢
                              </a>
                              
                              </td>
                              </tr>
                              <tr>
                                  <th>
                                  </th>
                                  <td>
                                     <a  href="javascript:void(0)" 
                              target="MainFrame">  发货查询 </a></td>
                              </tr>
                          </tbody></table></td></tr></tbody></table></td></tr>
              <tr>
                <td align="center"  valign="top" style="width: 203px; height: 48px" ><table border="0" id="guanlimenu" cellpadding="0" cellspacing="0" class="ctrl_menu_title_bg" width="195">
                              <tr class="hand" onclick="hide('hideMenuFunc9')">
                                  <td class="ctrl_menu_title" width="174">
                                      生產管理</td>
                                  <td width="21">
                                      <img id="Img5" src="Images/menu_title_down.gif" /></td>
                              </tr>
                              <tr id="hideMenuFunc9" style="display:">
                                  <td align="left" class="menu_box_pad" colspan="2" style="height: 17px">
                                      <table border="0" cellpadding="0" cellspacing="5" class="menu_box" width="100%">
                                          <asp:Repeater ID="FlowRepeater" runat="server">
                                              <ItemTemplate>
                                                  <tr>
                                                      <th>
                                                          &nbsp;</th>
                                                      <td>
                                                          <a href=" <%# Eval("WebUrl")%>" target="MainFrame">
                                                              <%# Eval("AuthorityName")%>
                                                          </a>
                                                      </td>
                                                  </tr>
                                              </ItemTemplate>
                                          </asp:Repeater>
                                      </table>
                                  </td>
                              </tr>
                          </table>
                  </td></tr>
                
              <tr style="height:5">
                <td style="height: 4px; width: 203px;" valign="top" align="center">
                    <table class="ctrl_menu_title_bg" id="salesMenu" cellspacing="0" cellpadding="0"
                  width="195" border="0">
                        <tbody>
                            <tr class="hand" onclick="hide('hideMenuFunc4')">
                                <td class="ctrl_menu_title" width="174">
                                    訂單管理</td>
                                <td width="21">
                                    <img id="Img1"
                        src="Images/menu_title_down.gif"></td>
                            </tr>
                            <tr id="hideMenuFunc4" style="display:">
                                <td class="menu_box_pad" align="left" colspan="2" style="height: 17px" >
                                    <table class="menu_box" cellspacing="5" cellpadding="0"
                        width="100%" border="0">
                                        <tbody>
                                            <asp:Repeater ID="SalesMenu" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <th>
                                                            &nbsp;</th>
                                                        <td>
                                                            <a target="MainFrame" href=" <%# Eval("WebUrl")%>" >
                                                                <%# Eval("AuthorityName")%>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td></tr>
                  <tr style="height:5">
                      <td style="width: 203px; height: 4px" align="center" valign="top"><table class="ctrl_menu_title_bg" id="StockMenuTable" cellspacing="0" cellpadding="0"
                  width="195" border="0">
                          <tbody>
                              <tr class="hand" onclick="hide('hideMenuFunc5')">
                                  <td class="ctrl_menu_title" width="174">
                                      庫存管理</td>
                                  <td width="21">
                                      <img id="Img2"
                        src="Images/menu_title_down.gif"></td>
                              </tr>
                              <tr id="hideMenuFunc5"style="display:">
                                  <td class="menu_box_pad" align="left" colspan="2" style="height: 17px" >
                                      <table class="menu_box" cellspacing="5" cellpadding="0"
                        width="100%" border="0">
                                          <tbody>
                                              <asp:Repeater id="StockMenu" runat="server">
                                                  <ItemTemplate>
                                                      <tr>
                                                          <th>
                                                              &nbsp;</th>
                                                          <td>
                                                              <a target="MainFrame" href=" <%# Eval("WebUrl")%>" >
                                                                  <%# Eval("AuthorityName")%>
                                                              </a>
                                                          </td>
                                                      </tr>
                                                  </ItemTemplate>
                                              </asp:Repeater>
                                          </tbody>
                                      </table>
                                  </td>
                              </tr>
                          </tbody>
                      </table>
                      </td>
                  </tr>
                  <tr>
                      <td align="center" style="width: 203px; height: 15px" valign="top">
                          
                          <table class="ctrl_menu_title_bg" id="calgouMenu" cellspacing="0" cellpadding="0"
                  width="195" border="0">
                    <tbody>
                    <tr class="hand" onclick="hide('hideMenuFunc3')">
                      <td class="ctrl_menu_title" width="174">
                          銷售管理</td>
                      <td width="21"><img id="MenuFunc3"
                        src="Images/menu_title_down.gif"></td></tr>
                    <tr id="hideMenuFunc3" style="display:">
                      <td class="menu_box_pad" align="left" colspan="2" >
                        <table class="menu_box" cellspacing="5" cellpadding="0"
                        width="100%" border="0">
                          <tbody>
                      
                          
                          <asp:Repeater id="purchaseMenu" runat="server">
        <ItemTemplate>
                        <tr>
                            <th>&nbsp;</th>
                            <td>
                              <a target="MainFrame" href=" <%# Eval("WebUrl")%>" > <%# Eval("AuthorityName")%></a>
                               </td>
                          </tr>
        
        </ItemTemplate>
        </asp:Repeater>
                          
                          </tbody></table></td></tr></tbody></table>

                          
                      </td>
                  </tr>
              <tr>
                <td align="center" style="width: 203px; height: 15px;" valign="top"><!-- 好友信息 -->
                    &nbsp;<table class="ctrl_menu_title_bg" id="systemSetMenu" cellspacing="0" cellpadding="0" 
                  width="195" border="0">
                        <tbody>
                            <tr class="hand" onclick="hide('hideMenuFunc6')">
                                <td class="ctrl_menu_title" width="174" align="center">
                                    系统设置</td>
                                <td width="21">
                                    <img id="Img3"
                        src="Images/menu_title_down.gif"></td>
                            </tr>
                            <tr id="hideMenuFunc6" style="display:">
                                <td class="menu_box_pad" align="left" colspan="2" style="height: 17px" >
                                    <table class="menu_box" cellspacing="5" cellpadding="0"
                        width="100%" border="0">
                                        <tbody>
                                            <asp:Repeater id="SystemSet" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <th>
                                                            &nbsp;</th>
                                                        <td>
                                                            <a target="MainFrame" href=" <%# Eval("WebUrl")%>" >
                                                                <%# Eval("AuthorityName")%>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                  <!-- /好友信息 --></td>
              </tr>



              <tr style="height:5">
                <td style="width: 203px; height: 5px;" align="center">
                    &nbsp;
                </td></tr>
              <tr>
                <td align="middle" style="width: 203px"><!-- BLOG信息 --></TD>
              </tr>
              </tbody></table>
    
    </div>
        <input id="Hidden1" type="hidden" value="0" runat="server" />
        <br />
        <input id="Hidden2" type="hidden" value="0" runat="server" />
        <br />
        <input id="Hidden3" type="hidden" value="0" runat="server" /><br />
        <input id="Hidden4" type="hidden" value="0" runat="server" /><br />
        <input id="Hidden5" type="hidden" value="0" runat="server" /><br />
        <input id="Hidden6" type="hidden" value="0" runat="server" />
    </form>
</body>
</html>
