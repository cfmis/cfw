<%@ Page Language="C#" AutoEventWireup="true" Inherits="User_SysUserEdit" Codebehind="SysUserEdit.aspx.cs" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>系统用户管理</title>
    
<link href="../css/base.css" rel="stylesheet" type="text/css" />

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
  alert("请输入6位字符");

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
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <table width="100%" border="0">
  <tr>
      <td style="width: 30px">
      </td>
    <td>&nbsp;<table bgcolor="#9bc8ff" border="0" cellpadding="0" cellspacing="1" style="width: 800px">
            <tbody>
                <tr>
                    <td bgcolor="#f7fdff" >
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tbody>
                                <tr>
                                    <td class="lbg2" height="27" width="945">
                                        <span class="t3">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                            <asp:HyperLink ID="HyperLink1" runat="server" Visible="False" NavigateUrl="~/User/SysUserSearch.aspx?UserName=&UserTypeID=0&SubClassID=">操作成功！返回用户列表</asp:HyperLink></span></td>
                                    <td class="lbg2" width="23">
                                        <img border="0" height="17" src="../images/bot2.gif" width="17" /></td>
                                </tr>
                            </tbody>
                        </table>
                        <table border="0" cellpadding="0" cellspacing="0" style="width: 773px">
                            <!-- 联系信息 -->
                            <tr>
                                <td class="mc" valign="top" style="color: red" >
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp;<br />
                                    <asp:Panel ID="Panel0" runat="server" Height="50px" Width="125px">
                                  
                                    <fieldset style="padding-bottom: 5px; width: 98%">
                                        <legend align="left" class="small" style="font-family: Times New Roman"><b>
                                                            <asp:Label ID="UserName" runat="server"></asp:Label>
                                            &nbsp; 基本<span style="font-family: 宋体">信息修改</span></b> </legend>
                                        <table border="0" cellpadding="0" cellspacing="2" height="73" width="904" style="font-family: Times New Roman">
                                            <tr>
                                                <td height="17" width="76">
                                                    部门名称</td>
                                                <td width="406">
                                                    <label>
                                                            &nbsp;<asp:TextBox ID="Dept" runat="server"></asp:TextBox></label></td>
                                                <td width="81">
                                                    <p>
                                                        真实姓名</p>
                                                </td>
                                                <td width="331">
                                                    <label>
                                                        &nbsp;<asp:TextBox ID="RealName" runat="server" Width="143px"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="RealName"
                                                            ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></label></td>
                                            </tr>
                                            <tr style="color: #000000">
                                                <td height="31">
                                                    <p>
                                                        QQ</p>
                                                </td>
                                                <td>
                                                    <label>
                                                        &nbsp;<asp:TextBox ID="QQ" runat="server"></asp:TextBox></label></td>
                                                <td>
                                                    <p>
                                                            电话</p>
                                                </td>
                                                <td>
                                                    <label>
                                                        &nbsp;<asp:TextBox ID="Tel" runat="server"></asp:TextBox>
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 35px">
                                                    电子邮件&nbsp;</td>
                                                <td style="height: 35px">
                                                    <label>
                                                        &nbsp;<asp:TextBox ID="Email" runat="server"></asp:TextBox></label></td>
                                                <td style="height: 35px">
                                                    淘宝号</td>
                                                <td style="height: 35px">
                                                    &nbsp;<asp:TextBox ID="WangWang" runat="server"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td style="height: 35px">
                                                            相关描述</td>
                                                <td style="height: 35px">
                                                        <asp:TextBox ID="Description" runat="server" Height="46px" TextMode="MultiLine" Width="194px"></asp:TextBox></td>
                                                <td style="height: 35px">
                                                            </td>
                                                <td style="height: 35px">
                                                            <asp:DropDownList ID="Sex" runat="server">
                                                            <asp:ListItem>男</asp:ListItem>
                                                            <asp:ListItem>女</asp:ListItem>
                                                        </asp:DropDownList>
                                                        
                                                            <asp:Label ID="usertypeLabel1" runat="server" Visible="False" ></asp:Label>
                                                            <asp:Label ID="subclassLabel2" runat="server" Visible="False" ></asp:Label>
                                                            <asp:Label ID="groupLabel3" runat="server" Visible="False"></asp:Label>
                                                    <asp:Label ID="StateLabel4" runat="server" Visible="False" ></asp:Label></td>
                                            </tr>
                                        </table>
                                        &nbsp; &nbsp; &nbsp;&nbsp;
                                    </fieldset>
                                    </asp:Panel>
                                    &nbsp;<br />
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Panel ID="Panel1" runat="server" Height="50px" Width="125px" Visible="False">
                                        <fieldset style="padding-bottom: 5px; width: 98%">
                                            <legend align="left" class="small"><b>权限信息修改</b> </legend>
                                            <table border="0" cellpadding="0" cellspacing="2" height="73" width="904">
                                                <tr>
                                                    <td style="height: 23px" width="76">
                                                            用户类型</td>
                                                    <td colspan="3" style="height: 23px">
                                                        <label>
                                                        </label>
                                                        <label>
                                                            <table style="width: 348px">
                                                                <tr>
                                                                    <td style="width: 46px; height: 24px;">
                                                                        一级</td>
                                                                    <td style="width: 67px; height: 24px;">
                                                                        <asp:DropDownList ID="TypeID" runat="server" AutoPostBack="True" DataSourceID="ObjectDataSource1"
                                                                            DataTextField="TypeName" DataValueField="TypeID" OnSelectedIndexChanged="TypeID_SelectedIndexChanged">
                                                                        </asp:DropDownList></td>
                                                                    <td style="width: 57px; height: 24px;">
                                                                        二级</td>
                                                                    <td style="width: 69px; height: 24px;">
                                                                        <asp:DropDownList ID="SubClassID" runat="server">
                                                                            <asp:ListItem Value="-1">请选择</asp:ListItem>
                                                                        </asp:DropDownList></td>
                                                                </tr>
                                                            </table>
                                                        </label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 40px">
                                                        <p>
                                                        用户权限组</p>
                                                    </td>
                                                    <td style="height: 40px; width: 430px;">
                                                        <label>
                                                        &nbsp;<asp:TextBox ID="GroupID" runat="server" Enabled="False" Width="18px"></asp:TextBox>
                                                        <img id="Img1" alt="点击选择权限" onclick="return IMG1_onclick()" src="../images/find.png" />&nbsp;
                                                        <input id="GroupID1" runat="server" style="width: 52px" type="hidden" /></label></td>
                                                    <td style="height: 40px; width: 39px;">
                                                        <p>
                                                        状&nbsp; 态</p>
                                                    </td>
                                                    <td style="height: 40px">
                                                        <label>
                                                            &nbsp;<asp:DropDownList ID="State" runat="server">
                                                            <asp:ListItem Value="Y">正常使用</asp:ListItem>
                                                            <asp:ListItem Value="N">停止使用</asp:ListItem>
                                                        </asp:DropDownList>
                                                            </label></td>
                                                </tr>
                                            </table>
                                                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                                            SelectMethod="getAllUserType" TypeName="Leyp.BLL.BUserType"></asp:ObjectDataSource>
                                        </fieldset>
                                     
                                    </asp:Panel>
                                    &nbsp;&nbsp;
                                    <asp:Panel ID="Panel2" runat="server" Height="50px" Width="125px">
                                        &nbsp;
                                        <table style="width: 742px">
                                            <tr>
                                                <td style="width: 133px">
                                                </td>
                                                <td>
                                    <asp:CheckBox ID="AuthorityBox" runat="server" OnCheckedChanged="AuthorityBox_CheckedChanged"
                                        Text="修改权限" AutoPostBack="True" /><span style="color: red"> &nbsp; 选中表示确认修改权限
                                    &nbsp; &nbsp; </span>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 133px">
                                                </td>
                                                <td>
                                                        <asp:Button ID="Add_Submit" runat="server" Height="32px" OnClick="Add_Submit_Click"
                                                            Text="提交修改" Width="105px" /></td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 133px">
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
    </td>
      <td>
      </td>
  </tr>
  <tr>
      <td style="width: 30px">
      </td>
    <td>&nbsp;
        </td>
      <td>
      </td>
  </tr>
</table>
    
    </div>
    </form>
</body>
</html>