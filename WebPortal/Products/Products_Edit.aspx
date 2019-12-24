<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_Products_Edit" Codebehind="Products_Edit.aspx.cs" %>
<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>无标题页</title>
    
        <style type="text/css">
    body {
	FONT-SIZE: 12px;
	COLOR: #333;
	FONT-FAMILY: 'Lucida Grande', Verdana, Arial, Sans-Serif;
	background-color: #FFFFFF;
	margin-top: 1px;
	text-align: center;
	margin-bottom: 1px;

	}
a:visited,
a:active,
a:link {
 color:#0279CB;
 text-decoration:none;
 }
a:hover {
 color:#00A4E3;
 text-decoration:none;
 BORDER-BOTTOM: 1px dotted;
}
#page{
text-align:left;
padding-left:10px;
padding-top:2px;
	margin-top:1px;
	margin-bottom:1px;

}
.horizBar
{
	background-color:#E5EEF7;
	width:700px;
	height:20px;
	border-bottom: 1px;
	border-top:1px thin;
	padding-left:10px;
	text-align: left;
	padding-top: 5px;
	margin-top:1px;
	margin-bottom:1px;
}
.title{
FONT-WEIGHT: bold; font: "Times New Roman", Times, serif;
font-size:13px;
color:#0279CB;
}
INPUT
{
   margin-top :1px;
	margin-bottom:1px;
	padding-bottom:1px;
	padding-top:1px;
	
}
 .PreView
    {
        width:150px;
        border-style: double;
        border-color: #333;
    }
    
    </style>
<script language="javascript" type="text/javascript">
// <!CDATA[

function fPopUpCalendarDlg(ctrlobj) {
	var showx, showy, newWINwidth, retval;
	showx = event.screenX - event.offsetX - 4 - 210; // + deltaX;
	showy = event.screenY - event.offsetY + 18; // + deltaY;
	newWINwidth = 210 + 4 + 18;
	retval = window.showModalDialog("../CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:no; directories:yes;scrollbars:no;Resizable=no; ");
	if (retval != null) {
		ctrlobj.value = retval;
	} else {
					//alert("canceled");
	}
}

// ]]>
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div id="page">
    <div class="horizBar" style="width: 720px; height: 11px;">
        <span class="title"><span class="title"> 编辑商品信息 &nbsp; &nbsp; 编号：<asp:Label ID="PID"
            runat="server"></asp:Label></span></span></div>

        <br />

        <br />
       

      
        <div class="horizBar" style="width: 722px">
            <asp:Panel ID="Panel1" runat="server">
         
          
            <span class="title">
                <fieldset style="padding-bottom: 5px; width: 96%">
                    <legend align="left" class="small" style="font-family: Times New Roman"><b>
                        基本<span>信息</span></b> </legend>&nbsp; &nbsp; &nbsp;&nbsp;
            <TABLE cellSpacing=1 cellPadding=2 width="100%" border=0 valign="top">
        <TBODY>
        <TR bgColor=#ffffff>
          <TD align=middle style="height: 30px; width: 107px;">
              商品名称：</TD>
            <td style="width: 242px; height: 30px;">
                <asp:TextBox ID="ProductsName" runat="server" Width="146px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="ProductsName"
                    ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></td>
          <TD style="width: 95px; height: 30px;">
              商品类型</TD>
            <td style="height: 30px">
                <cc2:ProductsTypeDropDownList ID="ProductsTypeDropDownList1" runat="server">
                </cc2:ProductsTypeDropDownList>
            </td>
        </TR>
        <TR bgColor=#ffffff>
          <TD align=middle style="height: 27px; width: 107px;">
              商品品牌：</TD>
            <td style="width: 242px; height: 27px;">
                <cc2:ProductsBrandDropDownList ID="ProductsBrandDropDownList1" runat="server">
                </cc2:ProductsBrandDropDownList>
            </td>
          <TD style="width: 95px; height: 27px;">
              颜 色</TD>
            <td style="height: 27px">
                <asp:TextBox ID="Color" runat="server"></asp:TextBox></td>
        </tr>
            <tr bgcolor="#ffffff">
                <td align="middle" style="width: 107px; height: 27px">
                    单 位</td>
                <td style="width: 242px; height: 27px">
                    <asp:TextBox ID="ProductsUints" runat="server" Width="93px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="ProductsUints"
                        ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></td>
                <td style="width: 95px; height: 27px">
                    成 本</td>
                <td style="height: 27px">
                    <asp:TextBox ID="Cost" runat="server" Width="78px"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Cost"
                        ErrorMessage="信息输入有误" ValidationExpression="^[0-9]*\.?[0-9]{0,2}$"></asp:RegularExpressionValidator></td>
            </tr>
            <TR bgColor=#ffffff>
                <TD align=middle style="width: 107px; height: 27px">
                    <span style="font-family: 宋体">重 量</span></td>
                <td style="width: 242px; height: 27px;">
                    &nbsp;
                <asp:TextBox ID="Weight" runat="server" Width="104px"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="Weight"
                    ErrorMessage="信息输入有误" ValidationExpression="^[0-9]*\.?[0-9]{0,2}$"></asp:RegularExpressionValidator></td>
          <TD style="width: 95px; height: 27px;"><FONT face=宋体>售 价</FONT></TD>
            <td style="height: 27px">
                &nbsp;<asp:TextBox ID="Price" runat="server" Width="78px"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="Price"
                    ErrorMessage="信息输入有误" ValidationExpression="^[0-9]*\.?[0-9]{0,2}$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Price"
                    ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></td>
            </tr>
            <TR bgColor=#ffffff>
                <TD align=middle style="width: 107px; height: 30px">
                    <span style="font-family: 宋体">规 格</span>：</TD>
            <td style="width: 242px; height: 30px;">
                <asp:TextBox ID="Spec" runat="server"></asp:TextBox></td>
          <TD style="width: 95px; height: 30px;">
              材 质</TD>
            <td style="height: 30px">
                <asp:TextBox ID="Material" runat="server"></asp:TextBox></td>
        </TR>
            <tr bgcolor="#ffffff">
                <td align="middle" style="width: 107px; height: 30px">
                    库存上限</td>
                <td style="width: 242px; height: 30px">
                    <asp:TextBox ID="UpperLimit" runat="server" Width="79px">100</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UpperLimit"
                        ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="UpperLimit"
                        ErrorMessage="输入有误" MaximumValue="100000" MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
                <td style="width: 95px; height: 30px">
                    库存下限</td>
                <td style="height: 30px">
                    <asp:TextBox ID="LowerLimit" runat="server" Width="57px">0</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="LowerLimit"
                        ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="LowerLimit"
                        ErrorMessage="输入有误" MaximumValue="10000" MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
            </tr>
        </tbody>
            </table>
                </fieldset>
                <br />
                <br />
                <br />
                <fieldset style="padding-bottom: 5px; width: 96%; height: 211px">
                    <legend align="left" class="small" style="font-family: Times New Roman">高级信息 </legend>
                    &nbsp; &nbsp; &nbsp;&nbsp;
                    <TABLE cellSpacing=1 cellPadding=2 width="100%" border=0 valign="top">
                        <TBODY>
                            <TR bgColor=#ffffff>
                                <TD align=middle style="height: 30px; width: 92px;">
                                    第一次入库：</td>
                                <td style="width: 211px; height: 30px;">
                                    <asp:TextBox ID="BeginEnterDate" runat="server"></asp:TextBox>
                                    <img src="../images/calendar.gif" id="IMG1" onclick="fPopUpCalendarDlg(BeginEnterDate);return false;" /></td>
                                <TD style="width: 111px; height: 30px;">
                                    最后入库时间</td>
                                <td style="height: 30px">
                                    <asp:TextBox ID="FinalEnterDate" runat="server"></asp:TextBox>
                                    <img src="../images/calendar.gif" id="IMG2" onclick="fPopUpCalendarDlg(FinalEnterDate);return false;" /></td>
                            </tr>
                            <TR bgColor=#ffffff>
                                <TD align=middle style="height: 27px; width: 92px;">
                                    上架日期：</td>
                                <td style="width: 211px; height: 27px; font-family: 宋体;">
                                    <asp:TextBox ID="LoadingDate" runat="server"></asp:TextBox><img src="../images/calendar.gif" onclick="fPopUpCalendarDlg(LoadingDate);return false;" /></td>
                                <TD style="width: 111px; height: 27px; font-family: 宋体;">
                                    最近缺货时间</td>
                                <td style="height: 27px">
                                    <asp:TextBox ID="LatelyOFSDate" runat="server"></asp:TextBox>
                                    <img src="../images/calendar.gif" onclick="fPopUpCalendarDlg(LatelyOFSDate);return false;" /></td>
                            </tr>
                            <TR bgColor=#ffffff>
                                <TD align=middle style="width: 92px; height: 27px">
                                    下架日期：</td>
                                <td style="width: 211px; height: 27px;">
                                    <asp:TextBox ID="UnshelveDate" runat="server"></asp:TextBox>
                                    <img src="../images/calendar.gif" onclick="fPopUpCalendarDlg(UnshelveDate);return false;" /></td>
                                <TD style="width: 111px; height: 27px;">
                                    <FONT face=宋体><span style="font-family: Verdana"></span></font>
                                </td>
                                <td style="font-family: Verdana; height: 27px">
                                </td>
                            </tr>
                            <TR bgColor=#ffffff style="font-family: Verdana">
                                <TD align=middle style="width: 92px; height: 32px">
                                    <span style="font-family: 宋体">其它描述：</span></td>
                                <td colspan="3" style="height: 32px">
                                    <asp:TextBox ID="Description" runat="server" TextMode="MultiLine" Width="313px"></asp:TextBox></td>
                            </tr>
                        </TBODY></TABLE>
                </fieldset>
                <br />
                &nbsp;
                &nbsp;
                &nbsp;&nbsp;&nbsp;<span style="font-size: 9pt; color: #333333">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Button
                        ID="NextButton" runat="server" Text="提  交" Width="132px" OnClick="NextButton_Click" />&nbsp; &nbsp;</span><br />
            </span>
              </asp:Panel>
           
            </div>
    
        <br />
         

        <asp:Panel ID="Panel2" runat="server" Height="50px" Visible="False" Width="125px">
            <div class="horizBar" style="width: 720px; height: 11px;">
                <span class="title"><span class="title"><br />
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<asp:HyperLink
                        ID="HyperLink1" runat="server">操作成功</asp:HyperLink>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Products/SysProductsList.aspx">返回商品列表</asp:HyperLink>&nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; </span></span></div>
        </asp:Panel>
        <br />
        

        <br />
          
        <br />
        <br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</div>
    
    </div>
    </form>
</body>
</html>