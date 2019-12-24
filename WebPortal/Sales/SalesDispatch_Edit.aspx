<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_SalesDispatch_Edit" Codebehind="SalesDispatch_Edit.aspx.cs" %>
<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>编辑修改出库单</title>
        <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../js/skin/qq/ymPrompt.css" /> 
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
    <script type="text/javascript" src="../js/ymPrompt.js"></script> 
   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/jquery.blockUI.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
   
    <style type="text/css">
    #addMian_b {width:940px;height:275px;background:#000;-moz-opacity:0.2; filter:alpha(opacity=25);margin:-30px 10 0 10px; position:absolute;}
#addMian_t { z-index:20;border:1px solid #a4d5e3;width:920px;height:275px;background:#FFF;margin:-15px 0 0 5px; position:absolute;}
body {
	margin-left: 10px;
	margin-top: 10px;
}
    
    </style>
    
            <script type="text/javascript">
              
           
            //选择销售出库单
            function gysSelectIn()
            {
                    var Url="NQ_SalesOut_CommonWindows.aspx";
                    var result=window.showModalDialog(Url,'','dialogWidth:1000px;status:no;dialogheight:600px');   
                    if(result!=null)
                    { 
                    document.getElementById("SalesOutID").value=result; 

                    }else
                    {
                    
                    }
            
            }
            
            ///选择用户
            function userSelect()
            {
            
                var Url="../User/NQ_User_CommonWindows.aspx";
                var result=window.showModalDialog(Url,'','dialogWidth:700px;status:no;dialogheight:500px');   
                if(result!=null)
                { 
         
                document.getElementById("Consignor").value=result; 

                }else
                {

                }
            
            }
            
        function check()
        {
           
            var  str0 = document.getElementById("DispatchID");
            var  str1=document.getElementById("SalesOutID");
            var  str2 = document.getElementById("DeliveryID");
            var  str3 = document.getElementById("DeliveryDate");
            var  str4 = document.getElementById("SentDate");
            var  str5 = document.getElementById("Consignor");
            var  str6 = document.getElementById("Description");
            var  str7 = document.getElementById("StateDropDownList");
           
            if(str0.value=="")
            {
             alert("初始化失败！");
             showresult("");
             return false;
            }
             
            if(str2.value=="")
            {
             alert("请选择配送方式！");
             return false;
            }
            
            if(str5.value=="")
            {
             alert("请选择销发货人或 承担人 ！");
             return false;
            }
             $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
             var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   
                     showresult(xmlHttp.responseText);
                     
                      $.unblockUI();// 
                     
                }
            }
            xmlHttp.open("POST", "AjaxSalesDispatch.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=edit&SalesOutID="+str1.value+"&DispatchID="+str0.value+"&DeliveryType="+str2.value+"&DeliveryDate="+str3.value+"&SentDate="+str4.value+"&Consignor="+str5.value+"&Description="+str6.value+"&State="+str7.value+"");//        
            
        }
        
        
function showresult(text) {

             this.document.getElementById("addModlue").style.display='none'; 
             this.document.getElementById("gotoList").style.display=''; 
         }
function initLoad()
{
    this.document.getElementById("gotoList").style.display='none'; 
}

function newWindow(){

   window.location.href("Manager_SalesDispatchOrder.aspx");

}
    
            </script>
</head>
<body onload="initLoad()">
    <form id="form2" runat="server">
        
    <div>

    <div id="addMian_t" style="left: 0px; top: 10px; height: 248px">
      <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 100%! important; BORDER-BOTTOM: #a4d5e3 1px solid; height: 171px;">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">&nbsp;
      
      </H2>
     
      <DIV style="MARGIN: 5px">
   
 
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 style="height: 202px" >
  <TBODY>
  <TR>
    <TD class=title align=middle style="height: 39px"> 修 改 销 售 发 货</TD></TR>
  <TR>
    <TD bgColor=#ffffff style="height: 118px" valign="top" align="center">
      <TABLE  id="addModlue" cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD bgColor=#ffffff style="width: 297px; height: 9px;" align="left">
              销售出库单：<asp:TextBox ID="SalesOutID" runat="server" Width="150px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              </TD>
          <TD bgColor=#ffffff style="width: 270px; height: 9px;" align="left">制单日期：
              <asp:TextBox ID="CreateDate" runat="server" Width="99px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              </TD>
          <TD bgColor=#ffffff style="height: 9px; width: 418px;" align="left">
              配送方式： &nbsp;&nbsp;&nbsp;
              <asp:TextBox ID="DeliveryID" runat="server" CssClass="txt_left"  Width="116px"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="DeliveryID"
                  ErrorMessage="不能为空"></asp:RequiredFieldValidator></TD>
          <TD bgColor=#ffffff style="height: 9px"></TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 12px" align="left">
              <p class="p0" style="margin-top: 0pt; margin-bottom: 0pt">
                  <span style="font-size: 10pt; font-family: '宋体'; mso-spacerun: 'yes'"><font face="宋体">
                      应配送日期&nbsp;<asp:TextBox ID="DeliveryDate" runat="server" Width="116px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>&nbsp;&nbsp;<IMG 
            style="CURSOR: hand" 
            onclick="fPopUpCalendarDlg(DeliveryDate);return false;" height=16 
            alt=弹出日历下拉菜单 src="../images/calendar.gif" width=16>&nbsp;</font></span></p>
              <!--EndFragment-->
          </TD>
          <TD bgColor=#ffffff style="height: 12px; width: 418px;" align="left">实际配送日期：<asp:TextBox ID="SentDate" runat="server" Width="90px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>&nbsp;
              <IMG 
            style="CURSOR: hand" 
            onclick="fPopUpCalendarDlg(SentDate);return false;" height=16 
            alt=弹出日历下拉菜单 src="../images/calendar.gif" width=16 /></TD>
          <TD bgColor=#ffffff style="height: 12px"> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 24px" align="left">
              <p class="p0" style="margin-top: 0pt; margin-bottom: 0pt">
                  <span style="font-size: 10pt; font-family: '宋体'; mso-spacerun: 'yes'"><font face="宋体">
                      委托发货用户
              <asp:TextBox ID="Consignor" runat="server" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              <INPUT class="input" onclick="userSelect()" type=button value=引用  id="Button1"/>
                   </font></span></p>
              <!--EndFragment-->
          </TD>
          <TD bgColor=#ffffff style="height: 24px; width: 418px;" align="left">
              &nbsp;发货状态：
              <asp:DropDownList ID="StateDropDownList" runat="server" >
                  <asp:ListItem Value="0">待发货</asp:ListItem>
                  <asp:ListItem Value="1">已发货</asp:ListItem>
                  <asp:ListItem Value="2">问题件</asp:ListItem>
              </asp:DropDownList></TD>
          <TD bgColor=#ffffff style="height: 24px"> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=3 style="height: 28px" align="left">备&nbsp;&nbsp;&nbsp;&nbsp;注： &nbsp;&nbsp;&nbsp;
              <asp:TextBox ID="Description" runat="server" Width="609px" CssClass="txt_left"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 28px"> </TD></TR>
            <tr>
                <td align="center" bgcolor="#ffffff" colspan="3" style="height: 28px">
                    <input id="DispatchID" style="width: 73px" type="hidden" runat="server" />
                 <input id="Button2" onclick="check()"type="button" value="提 交"" />
                    </td>
                <td align="center" bgcolor="#ffffff" style="height: 28px">
                </td>
            </tr>
        </TBODY></TABLE>
        <input id="gotoList" onclick="newWindow()"type="button" value="返回列表" /></TD></TR>
  </TBODY></TABLE>
    
      </DIV></DIV>
      
   </div>
   
    <div id="addMian_b"   >
  </div>
  

  
  <asp:Panel ID="Panel2" Visible="false" runat="server" Height="50px" Width="125px">
  
            
      <asp:HyperLink ID="HyperLink1"  NavigateUrl="~/Stock/Manager_TransferringOrder.aspx" runat="server">操作成功 返回列表</asp:HyperLink></asp:Panel>
    </div>
    </form>
</body>
</html>

