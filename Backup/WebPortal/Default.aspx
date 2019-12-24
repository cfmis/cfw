<%@ Page Language="C#" AutoEventWireup="true" Inherits="_Default" Codebehind="Default.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>酘晚粕等</title>
<style type="text/css">
<!--
BODY {
	FONT-SIZE: 12px
}
TD {
	FONT-SIZE: 12px
}
.menu_box_pad {
	PADDING-RIGHT: 2px; PADDING-LEFT: 2px; BACKGROUND: #fdf9d5; PADDING-BOTTOM: 2px; PADDING-TOP: 0px
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
	COLOR: #ff6; TEXT-DECORATION: underline
}

-->
</style>
 <SCRIPT language=javascript>
      
function $(s){return document.getElementById(s);}
function swap(s,a,b,c){$(s)[a]=$(s)[a]==b?c:b;}
function hide(s){$(s).style.display=$(s).style.display=="none"?"":"none";}

function openjsj()
{
  window.open("Tool/jsj.htm",null,"height=100%,width=540,status=yes,toolbar=yes,menubar=yes,location=yes,resizable=yes,scroll=yes");

}
      </SCRIPT>
</head>
<body>
    <form id="form1" runat="server">
    <div><TABLE class=ctrl_menu cellSpacing=0 cellPadding=0 width=205 
            border=0>
              <TBODY>
              <tr>
              <td style="height: 10px; width: 203px;">
           
              
              </td>
              
              </tr>
              <TR>
                <TD align=center style="width: 203px" valign="top"><!-- 辦厒籵耋 -->
                  <TABLE class=ctrl_menu_title_bg cellSpacing=0 cellPadding=0 
                  width=195 border=0>
                    <TBODY>
                    <TR class=hand onClick="hide('hideMenuFunc0')">
                      <TD class=ctrl_menu_title width=174>
                          系統菜單</TD>
                      <TD width=21><IMG id=MenuFunc0 
                        src="Images/menu_title_up.gif"></TD></TR>
                    <TR id=hideMenuFunc0>
                      <TD class=menu_box_pad align=left colSpan=2>
                        <TABLE class=menu_box cellSpacing=5 cellPadding=0 
                        width="100%" border=0>
                          <TBODY>
                          <TR>
                            <TH>&nbsp;</TH>
                            <TD><A  href="Products/NewsProducts.aspx" 
                              target="MainFrame">新建立產品</A></TD></TR>
                          <TR>
                            <TH>&nbsp;</TH>
                            <TD><A  href="Products/ShowProductsList.aspx" 
                              target="MainFrame">顯示通知</A></TD>
                          </TR>
                          <TR>
                            <TH>&nbsp;</TH>
                            <TD>
                               <A  href="Notice/NoticeList.aspx" 
                              target="MainFrame">通知列表</A></TD></TR>
                              <tr>
                                  <th style="height: 22px">
                                  </th>
                                  <td style="height: 22px">
                                     <A  href="Customer/My_ServiceInfoList.aspx" 
                              target="MainFrame">我的信息</A></td>
                              </tr>
                              <tr>
                                  <th>
                                  </th>
                                  <td>
                                     <A  href="User/SysUser_Reset_PassWord.aspx" 
                              target="MainFrame">還原密碼
                              </A>
                              
                              </td>
                              </tr>
                              <tr>
                                  <th>
                                  </th>
                                  <td>
                                     <A  href="Sales/FindSalesOrder_DispatchState.aspx" 
                              target="MainFrame">查找銷售</A></td>
                              </tr>
                          </TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR>
              <TR>
                <TD align=center  valign="top" style="width: 203px; height: 48px" ><TABLE class=ctrl_menu_title_bg cellSpacing=0 cellPadding=0 
                  width=195 border=0>
                    <TBODY>
                        <TR class=hand onClick="hide('Tr1')">
                            <TD class=ctrl_menu_title width=174>
                                訂單管理</td>
                            <TD width=21>
                                <IMG id=Img1 
                        src="Images/menu_title_up.gif"></td>
                        </tr>
                        <TR id="Tr1">
                            <TD class=menu_box_pad align=left colSpan=2>
                                <TABLE class=menu_box cellSpacing=5 cellPadding=0 
                        width="100%" border=0>
                                    <TBODY>
                                        <TR>
                                            <TH>
                                                &nbsp;</th>
                                            <TD>
                                                <A  href="Buy_Index.aspx" 
                              target="MainFrame">
                          採購管理</a></td>
                                        </tr>
                                        <TR>
                                            <TH>
                                                &nbsp;</th>
                                            <TD>
                                                <A  href="Sales_Index.aspx" 
                              target="MainFrame">
                                    銷售管理</a></td>
                                        </tr>
                                        <TR>
                                            <TH>
                                                &nbsp;</th>
                                            <TD>
                                                <A  href="Stock_Index.aspx" 
                              target="MainFrame">
                                      庫存管理</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th style="height: 22px">
                                            </th>
                                            <td style="height: 22px">
                                                <A  href="Flow_Index.aspx" 
                              target="MainFrame">管理流程</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>
                                            </th>
                                            <td>
                                                <A  href="SysConfig.aspx" 
                              target="MainFrame">
                                   系統設置</a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
                  </TD></TR>
              <TR>
                <TD align=middle style="width: 203px"><!-- BLOG陓洘 --></TD>
              </TR>
              </TBODY></TABLE>
    
    </div>
    </form>
</body>
</html>


