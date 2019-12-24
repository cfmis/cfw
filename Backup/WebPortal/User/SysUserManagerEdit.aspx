<%@ Page Language="C#" AutoEventWireup="true" Inherits="User_SysUserManagerEdit" Codebehind="SysUserManagerEdit.aspx.cs" %>
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
     var val=result.split('$$$');
     document.getElementById("GroupID").value=val[0];
     document.getElementById("GroupID1").value=val[1];
     
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
	margin-left: 4cm;
	margin-top: 5px;
}
-->
</style>


</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <div >
        <br />
        <br />
        <br />
        <br />
        &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" Visible="False" NavigateUrl="~/User/SysUserSearch.aspx" Font-Size="Larger" Height="15px" Width="168px">操作成功！返回用户列表</asp:HyperLink>
    
    </div>
        <asp:Panel ID="Panel1" runat="server" Height="50px" Width="125px">
                                                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="getAllUserType"
                                                            TypeName="Leyp.SQLServerDAL.UserTypeDAL"></asp:ObjectDataSource>
    
    <TABLE cellSpacing=1 cellPadding=2 width="100%" border="1" valign="top">
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
          <TD style="width: 535px; color: #ff0033;" align="left">&nbsp;<asp:DropDownList ID="TypeID" runat="server" AutoPostBack="True" 
                                                                             OnSelectedIndexChanged="TypeID_SelectedIndexChanged" DataSourceID="ObjectDataSource1" DataTextField="TypeName" DataValueField="TypeID">
                                                                        </asp:DropDownList><span style="font-family: 宋体"> &nbsp; &nbsp; &nbsp; &nbsp;</span><span style="font-family: 宋体"> </span>
                                                                        <asp:DropDownList ID="SubClassID" runat="server">
                                                                            <asp:ListItem Value="-1">请选择</asp:ListItem>
                                                                        </asp:DropDownList>
              原信息：<asp:Label ID="TypeName" runat="server"></asp:Label>
              &nbsp; &gt;&gt; &nbsp; &nbsp; &nbsp;
              <asp:Label ID="SubClassName" runat="server" ></asp:Label></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle style="width: 120px">
              用户权限</TD>
          <TD style="width: 535px; color: #ff3333;" align="left">&nbsp;<asp:TextBox ID="GroupID" runat="server" Enabled="False" Width="58px" CssClass="txt_left "></asp:TextBox>
                                                        <img id="IMG1" onclick="return IMG1_onclick()" src="../images/find.png" />
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="GroupID"
                                                            ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator>
                                                        <input id="GroupID1" runat="server" style="width: 16px" type="hidden" />
              原权限组： &nbsp; &nbsp;&nbsp;
              <asp:Label ID="Label3" runat="server" ></asp:Label></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman">
          <TD align=middle style="width: 120px"><FONT face=宋体>真实姓名</FONT></TD>
          <TD style="font-family: Times New Roman; width: 535px;" align="left">
                                                        <asp:TextBox ID="RealName" runat="server" Width="143px" CssClass="txt_left "></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="RealName"
                                                            ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></TD>
        </TR>
        <TR bgColor=#ffffff style="font-family: Times New Roman; color: #000000;">
          <TD align=middle style="width: 120px">
              性别</TD>
          <TD style="width: 535px" align="left">&nbsp;<asp:DropDownList ID="Sex" runat="server">
                                                            <asp:ListItem>男</asp:ListItem>
                                                            <asp:ListItem>女</asp:ListItem>
                                                        </asp:DropDownList></TD>
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
                <td align="middle" height="23" style="width: 120px">
                                                        状&nbsp; 态</td>
                <td height="23" style="width: 535px" align="left">
                                                        <asp:DropDownList ID="State" runat="server">
                                                            <asp:ListItem Value="Y">正常使用</asp:ListItem>
                                                            <asp:ListItem Value="N">停止使用</asp:ListItem>
                                                        </asp:DropDownList></td>
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
                    &nbsp; &nbsp; &nbsp;<asp:ImageButton ID="edit_Submit" runat="server" ImageUrl="~/images/Save.gif" OnClick="edit_Submit_Click" />
                    &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp;&nbsp; &nbsp;
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/User/SysUserSearch.aspx?UserName=&UserTypeID=0&SubClassID=" ImageUrl="~/images/Cancel.gif"></asp:HyperLink>
                    &nbsp; &nbsp; &nbsp; &nbsp;
                </td>
            </tr>
        </TBODY></TABLE>
        </asp:Panel>
    
        <br />
        &nbsp;</div>
    </form>
</body>
</html>