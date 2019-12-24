<%@ Page Language="C#" AutoEventWireup="true" Inherits="Customer_SalesRecord_Add" Codebehind="SalesRecord_Add.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
        <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../js/skin/qq/ymPrompt.css" /> 
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
    <script type="text/javascript" src="../js/ymPrompt.js"></script> 
   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/jquery.blockUI.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
   
    <style type="text/css">
    #addMian_b {width:940px;height:205px;background:#000;-moz-opacity:0.2; filter:alpha(opacity=25);margin:-30px 10 0 10px; position:absolute;}
#addMian_t { z-index:20;border:1px solid #a4d5e3;width:920px;height:205px;background:#FFF;margin:-15px 0 0 5px; position:absolute;}
body {
	margin-left: 10px;
	margin-top: 10px;
}
    
    </style>
    
          
</head>
<body>
    <form id="form1" runat="server">
        
    <div>
    <asp:Panel ID="Panel1" runat="server">
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
    <TD class=title align=middle style="height: 39px"> 客户购买记录添加</TD></TR>
  <TR>
    <TD bgColor=#ffffff style="height: 118px" valign="top">
      <TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD bgColor=#ffffff style="width: 188px; height: 39px;">
              消费平台： &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
              <asp:DropDownList ID="Platform" runat="server" DataSourceID="ObjectDataSource1" DataTextField="PlatformName" DataValueField="PlatformID">
              </asp:DropDownList>&nbsp;
          </TD>
          <TD bgColor=#ffffff style="width: 248px; height: 39px;">
              客户账户：
              <asp:TextBox ID="CustomerID" runat="server" Width="99px" CssClass="txt_left"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CustomerID"
                  ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></TD>
          <TD bgColor=#ffffff style="height: 39px; width: 275px;">
              销售订单： &nbsp;&nbsp;
              <asp:TextBox ID="SalesOrderID" runat="server" CssClass="txt_left"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="SalesOrderID"
                  ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></TD>
          <TD bgColor=#ffffff style="height: 39px">
              制单日期<asp:TextBox ID="CreateDate" runat="server" CssClass="txt_left"></asp:TextBox></TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=3 style="height: 43px">
              顾客所在城市：&nbsp;
           
               <select name="select" id="Description" runat="server">
        <option value="安徽">安徽</option>
        <option value="北京">北京</option>
        <option value="福建">福建</option>
        <option value="甘肃">甘肃</option>
        <option value="广东">广东</option>
        <option value="广西">广西</option>
        <option value="贵州">贵州</option>
        <option value="海南">海南</option>
        <option value="河北">河北</option>
        <option value="河南">河南</option>
        <option value="黑龙江">黑龙江</option>
        <option value="湖北">湖北</option>
        <option value="湖南">湖南</option>
        <option value="吉林">吉林</option>
        <option value="江苏">江苏</option>
        <option value="江西">江西</option>
        <option value="辽宁">辽宁</option>
        <option value="内蒙">内蒙</option>
        <option value="宁夏">宁夏</option>
        <option value="青海">青海</option>
        <option value="山东">山东</option>
        <option value="山西">山西</option>
        <option value="陕西">陕西</option>
        <option value="上海">上海</option>
        <option value="四川">四川</option>
        <option value="天津">天津</option>
        <option value="西藏">西藏</option>
        <option value="新疆">新疆</option>
        <option value="云南">云南</option>
        <option value="浙江">浙江</option>
        <option value="重庆">重庆</option>
      </select>
              </TD>
          <TD bgColor=#ffffff style="height: 43px"> </TD></TR>
            <tr>
                <td align="center" bgcolor="#ffffff" colspan="3" style="height: 28px">
                    <asp:Button ID="AddSubmit" runat="server" Text="提 交" Width="122px"  OnClick="AddSubmit_Click" /></td>
                <td align="center" bgcolor="#ffffff" style="height: 28px">
                </td>
            </tr>
        </TBODY></TABLE>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="getList" TypeName="Leyp.SQLServerDAL.Sales.SalesPlatformDAL"></asp:ObjectDataSource>
    </TD></TR>
  </TBODY></TABLE>
    
      </DIV></DIV>
      
   </div>
   
    <div id="addMian_b"   >
  </div>
  
  </asp:Panel>
  
  <asp:Panel ID="Panel2" Visible="false" runat="server" Height="50px" Width="125px">
  
            
      <asp:HyperLink ID="HyperLink1"  NavigateUrl="~/Stock/Manager_TransferringOrder.aspx" runat="server">操作成功 返回列表</asp:HyperLink></asp:Panel>
    </div>
    </form>
</body>
</html>

