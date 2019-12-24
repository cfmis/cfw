<%@ Page Language="C#" AutoEventWireup="true" Inherits="User_SysUserManager" Codebehind="SysUserManager.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
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
     var val=result.split('$$$');
     document.getElementById("GroupID").value=val[0];
     document.getElementById("GroupID1").value=val[1];
     
    }

}



function checkUserName_onclick() {


  var strName=document.getElementById("UserName").value
  
  if(strName.length< 6)
  {
       alert("请输入不少于6位字符");
      //ymPrompt.alert({message:'请输入不少于6位字符',title:'错误提示',handler:null});
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
body {
	margin-left: 4cm;
}
-->
</style>
</head>
<body>
    &nbsp;
    &nbsp;&nbsp;<table style="width: 693px;">
        <tr>
            <td style="width: 77px">
            </td>
            <td style="width: 137px" class="title">
                添加用户</td>
            <td style="width: 102px">
</td>
        </tr>
    </table>
    &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <asp:HyperLink ID="HyperLink1" runat="server" Visible="False" NavigateUrl="~/User/SysUserSearch.aspx">操作成功！返回用户列表</asp:HyperLink>
    
    <form id="form1" runat="server">
    <div >
        <asp:Panel ID="Panel1" runat="server" Height="50px" Width="125px">
                                                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="getAllUserType"
                                                            TypeName="Leyp.SQLServerDAL.UserTypeDAL"></asp:ObjectDataSource>
    
    <TABLE cellSpacing=1 cellPadding=2 width="100%" border=1 valign="top">
        <TBODY>
        <TR bgColor=#ffffff>
          <TD align=middle width=120>
              帐号：</TD>
          <TD align="left">&nbsp;<asp:TextBox ID="UserName" runat="server" Width="136px" CssClass="txt_left "></asp:TextBox>&nbsp;
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="UserName"
                                                                ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator>
              &nbsp;
                                                            &nbsp;
<input id="checkUserName" name="Submit" onclick="return checkUserName_onclick()" type="button" value="检查用户名">
              不少于6位数字和英文组合&nbsp;
                                                        </TD>
        </TR>
        <TR bgColor=#ffffff>
          <TD align=middle>
              密码：</TD>
          <TD align="left">&nbsp;<asp:TextBox ID="PassWord" runat="server" TextMode="Password" CssClass="txt_left "></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="PassWord"
                                                                ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator>
              </TD>
        </TR>
        <TR bgColor=#ffffff style="color: #000000">
          <TD align=middle>
              密码验证：</TD>
          <TD align="left">&nbsp;<asp:TextBox ID="PassWord1" runat="server" TextMode="Password" CssClass="txt_left "></asp:TextBox>
                                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="PassWord"
                                                                ControlToValidate="PassWord1" ErrorMessage="<img src=../images/false.gif  />两次密码不一样"
                                                                Width="209px"></asp:CompareValidator></TD>
        </TR>
        <TR bgColor=#ffffff>
          <TD align=middle>
              用户类型：</TD>
          <TD align="left">&nbsp;<asp:DropDownList ID="TypeID" runat="server" AutoPostBack="True" 
                                                                             OnSelectedIndexChanged="TypeID_SelectedIndexChanged" DataSourceID="ObjectDataSource1" DataTextField="TypeName" DataValueField="TypeID">
                                                                        </asp:DropDownList><span style="font-family: 宋体"> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</span>
              &nbsp; <span style="font-family: 宋体">&nbsp; </span>
                                                                        <asp:DropDownList ID="SubClassID" runat="server">
                                                                            <asp:ListItem Value="-1">请选择</asp:ListItem>
                                                                        </asp:DropDownList>
          </TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle>
              用户权限：</TD>
          <TD align="left">&nbsp;<asp:TextBox ID="GroupID" runat="server" Enabled="False" Width="110px" CssClass="txt_left "></asp:TextBox>
                                                        <img id="IMG1" onclick="return IMG1_onclick()" src="../images/find.png" />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="GroupID"
                                                            ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator>
                                                        <input id="GroupID1" runat="server" style="width: 22px" type="hidden" /></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle><FONT face=宋体>真实姓名：</FONT></TD>
          <TD style="font-family: Times New Roman" align="left">
                                                        <asp:TextBox ID="RealName" runat="server" Width="143px" CssClass="txt_left "></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="RealName"
                                                            ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman; color: #000000;">
          <TD align=middle>
              性别：</TD>
          <TD align="left">&nbsp;<asp:DropDownList ID="Sex" runat="server">
                                                            <asp:ListItem>男</asp:ListItem>
                                                            <asp:ListItem>女</asp:ListItem>
                                                        </asp:DropDownList></TD>
        </TR>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="height: 19px">
                    <span style="font-family: 宋体">
                    用户特征:</span></td>
                <td style="height: 19px; font-family: 宋体;" align="left">
                    <asp:TextBox ID="Character" runat="server" Width="303px" CssClass="txt_left "></asp:TextBox>&nbsp;</td>
            </tr>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle>联系电话：</TD>
          <TD align="left">
                                                        <asp:TextBox ID="Tel" runat="server" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle>电子信箱：</TD>
          <TD align="left">
                                                        <asp:TextBox ID="Email" runat="server" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle">
                    Q Q</td>
                <td align="left">
                                                        <asp:TextBox ID="QQ" runat="server" CssClass="txt_left "></asp:TextBox>
                </td>
            </tr>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle">
                    淘宝(旺旺)</td>
                <td align="left">
                                                        <asp:TextBox ID="WangWang" runat="server" CssClass="txt_left "></asp:TextBox></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle">
                    公司名称：</td>
                <td align="left">
                    <asp:TextBox ID="CompanyName" runat="server" CssClass="txt_left "></asp:TextBox></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="height: 21px">
                    部&nbsp; 门</td>
                <td style="height: 21px" align="left">
                    <asp:TextBox ID="Dept" runat="server" CssClass="txt_left "></asp:TextBox></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="height: 18px">
                    公司状况：</td>
                <td style="height: 18px" align="left">
                    <asp:TextBox ID="CompanyInfo" runat="server" Width="528px" CssClass="txt_left "></asp:TextBox></td>
            </tr>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle>开户银行：</TD>
          <TD align="left">&nbsp;<asp:TextBox ID="Bankname" runat="server" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle>开户账号：</TD>
          <TD align="left">&nbsp;<asp:TextBox ID="BankAccount" runat="server" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle height=23>
              <span style="font-family: 宋体">通讯地址</span>：</TD>
          <TD height=23 align="left">&nbsp;<asp:TextBox ID="Address" runat="server" Width="376px" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" height="23">
                                                        状&nbsp; 态</td>
                <td height="23" align="left">
                                                        <asp:DropDownList ID="State" runat="server">
                                                            <asp:ListItem Value="Y">正常使用</asp:ListItem>
                                                            <asp:ListItem Value="N">停止使用</asp:ListItem>
                                                        </asp:DropDownList></td>
            </tr>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle style="height: 20px"><FONT face=宋体>备&nbsp;&nbsp;&nbsp;&nbsp;注：</FONT></TD>
          <TD style="height: 20px" align="left">&nbsp;<asp:TextBox ID="Description" runat="server" Width="509px" CssClass="txt_left "></asp:TextBox></TD>
        </TR>
            <tr bgcolor="#ffffff" style="font-family: Times New Roman">
                <td align="middle" style="height: 20px">
                </td>
                <td style="height: 20px">
                                                        <asp:Button ID="Add_Submit" runat="server" Height="32px" OnClick="Add_Submit_Click"
                                                            Text="添加用户" Width="105px" /></td>
            </tr>
        </TBODY></TABLE>
        </asp:Panel>
    
        <br />
        &nbsp;</div>
    </form>
</body>
</html>
