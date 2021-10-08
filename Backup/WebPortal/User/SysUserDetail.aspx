<%@ Page Language="C#" AutoEventWireup="true" Inherits="User_SysUserDetail" Codebehind="SysUserDetail.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>系统用户管理</title>
    
<link href="../css/base.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/ymPrompt.js"></script> 

<script language="javascript" type="text/javascript">
// <!CDATA[

function IMG1_onclick() {

var Url="../Authority/NQ_CommonWindow.aspx";
    var result=window.showModalDialog(Url,'选择群组','dialogWidth:500px;status:no;dialogheight:600px');   
    if(result!=null)
    { 
     document.getElementById("GroupID").value=result;
     document.getElementById("GroupID1").value=result;
     
    }

}



function checkUserName_onclick() {


  var strName=document.getElementById("UserName").value
  
  if(strName.length< 6)
  {

   ymPrompt.alert({message:'请输入不少于6位字符',title:'错误提示',handler:null});
		return;

  }else
  {
  
     var Url="NQ_CheckUserName.aspx?UserName="+strName+"";
    var result=window.showModalDialog(Url,'','dialogWidth:400px;status:no;dialogheight:200px');   
    if(result!=null)
    { 
     
    }
    
  }

}





// ]]>
</script>

<style type="text/css">
<!--
body,td,th {
	font-size: 12px;
}
body {
	margin-left: 20px;
	margin-top: 5px;
}
-->
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align:center">
    
    <div >
        &nbsp;</div>
        <asp:Panel ID="Panel1" runat="server" Height="50px" Width="125px">
            &nbsp;<TABLE cellSpacing=1 cellPadding=2 width="100%" border=0 valign="top">
        <TBODY>
        <TR bgColor=#ffffff>
          <TD align=middle style="width: 120px">
              帐号</TD>
          <TD style="width: 535px" align="left">&nbsp;<asp:TextBox ID="UserName" runat="server" Width="136px" CssClass="txt_left " ReadOnly="True"></asp:TextBox>&nbsp;&nbsp;
              &nbsp;&nbsp;</TD>
        </TR>
        <TR bgColor=#ffffff>
          <TD align=middle style="width: 120px">
              用户类型</TD>
          <TD style="width: 535px" align="left"><span style="font-family: 宋体"> &nbsp;<asp:TextBox ID="UserType" runat="server" CssClass="txt_left "></asp:TextBox></span><span style="font-family: 宋体"> </span>
                                                                        </TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle style="width: 120px">
              用户权限</TD>
          <TD style="width: 535px" align="left">&nbsp;<asp:TextBox ID="GroupID" runat="server" Enabled="False" Width="130px" CssClass="txt_left "></asp:TextBox>
              &nbsp;&nbsp;
          </TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle style="width: 120px"><FONT face=宋体>真实姓名</FONT></TD>
          <TD style="font-family: Times New Roman; width: 535px;" align="left">
                                                        <asp:TextBox ID="RealName" runat="server" Width="143px" CssClass="txt_left "></asp:TextBox>
                                                        </TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman; color: #000000;">
          <TD align=middle style="width: 120px; height: 25px;">
              性别</TD>
          <TD style="width: 535px; height: 25px;" align="left">&nbsp;<asp:TextBox ID="Sex" runat="server" Width="67px" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="height: 19px; width: 120px;">
                    <span style="font-family: 宋体">用户特征</span></td>
                <td style="height: 19px; font-family: 宋体; width: 535px;" align="left">
                    <asp:TextBox ID="Character" runat="server" Width="303px" CssClass="txt_left "></asp:TextBox>&nbsp;</td>
            </tr>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle style="width: 120px">
              联系电话</TD>
          <TD style="width: 535px" align="left">
                                                        <asp:TextBox ID="Tel" runat="server" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle style="width: 120px">
              电子信箱</TD>
          <TD style="width: 535px" align="left">
                                                        <asp:TextBox ID="Email" runat="server" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="width: 120px">
                    Q Q</td>
                <td style="width: 535px" align="left">
                                                        <asp:TextBox ID="QQ" runat="server" CssClass="txt_left "></asp:TextBox>
                </td>
            </tr>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="width: 120px">
                    淘宝(旺旺)</td>
                <td style="width: 535px" align="left">
                                                        <asp:TextBox ID="WangWang" runat="server" CssClass="txt_left "></asp:TextBox></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="width: 120px">
                    公司名称</td>
                <td style="width: 535px" align="left">
                    <asp:TextBox ID="CompanyName" runat="server" CssClass="txt_left "></asp:TextBox></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="width: 120px">
                    <span style="font-family: 宋体">部 门</span></td>
                <td style="width: 535px" align="left">
                    <asp:TextBox ID="Dept" runat="server" CssClass="txt_left "></asp:TextBox></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="height: 18px; width: 120px;">
                    公司状况</td>
                <td style="height: 18px; width: 535px;" align="left">
                    <asp:TextBox ID="CompanyInfo" runat="server" Width="450px" CssClass="txt_left "></asp:TextBox></td>
            </tr>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle style="width: 120px">
              开户银行</TD>
          <TD style="width: 535px" align="left">&nbsp;<asp:TextBox ID="Bankname" runat="server" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle style="width: 120px">
              开户账号</TD>
          <TD style="width: 535px" align="left">&nbsp;<asp:TextBox ID="BankAccount" runat="server" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle height=23 style="width: 120px">
              <span style="font-family: 宋体">通讯地址</span></TD>
          <TD height=23 style="width: 535px" align="left">&nbsp;<asp:TextBox ID="Address" runat="server" Width="376px" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="width: 120px; height: 22px;">
                                                        状&nbsp; 态</td>
                <td style="width: 535px; height: 22px;" align="left">
                    <asp:TextBox ID="State" runat="server" CssClass="txt_left "></asp:TextBox></td>
            </tr>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle style="height: 20px; width: 120px;"><FONT face=宋体>备&nbsp;&nbsp;&nbsp;&nbsp;注：</FONT></TD>
          <TD style="height: 20px; width: 535px;" align="left">&nbsp;<asp:TextBox ID="Description" runat="server" Width="509px" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="height: 20px; width: 120px;">
                </td>
                <td style="height: 20px; width: 535px;">
                    &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                </td>
            </tr>
        </TBODY></TABLE>
        </asp:Panel>
    
        <br />
        &nbsp;</div>
    </form>
</body>
</html>
