<%@ Page Language="C#" AutoEventWireup="true" Inherits="User_NQ_Select_UserWindows" Codebehind="NQ_Select_UserWindows.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>无标题页</title>
    
    <link href="../css/base.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="bar" style="width: 594px; height: 12px"> 
 <table style="width: 521px">
 <tr>
  <td style="width: 144px"></td>
 <td>
     用户类型</td>
  <td colspan="2" style="width: 4px"></td>
  <td style="width: 209px">
  <div id="loading">
      &nbsp;<cc1:UserTypeDropDownList ID="UserTypeDropDownList1"  AutoPostBack="true" OnSelectedIndexChanged="selUserType" runat="server">
      </cc1:UserTypeDropDownList></div>
  </td>
 </tr>
 
 
 </table>
 
  </div> 
  
<table style="width: 531px">
 <tr>
  <td style="width: 347px">
  <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; FLOAT: LEFT; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 589px; BORDER-BOTTOM: #a4d5e3 1px solid">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;帐号 &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; 姓名 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp;公司名称</H2>
     
      <DIV style="MARGIN: 5px" id="customerList">
          <asp:GridView ID="GridView1"   runat="server" AutoGenerateColumns="False" OnRowDeleting="GridView1_RowDeleting" 
              Width="576px" DataKeyNames="UserName,RealName" ShowHeader="False">
              <Columns>
                  <asp:HyperLinkField Text="&lt;img border=0 src=../images/View.gif /&gt;" DataNavigateUrlFields="UserName" DataNavigateUrlFormatString="SysUserDetail.aspx?UserName={0}" Target="_blank">
                      <ItemStyle Width="60px" />
                      <HeaderStyle Width="50px" />
                  </asp:HyperLinkField>
                  <asp:BoundField HeaderText="编号" ShowHeader="False" DataField="UserName">
                      <ItemStyle Width="100px" />
                  </asp:BoundField>
                  <asp:BoundField HeaderText="姓名" ShowHeader="False" DataField="RealName">
                      <ItemStyle Width="100px" />
                  </asp:BoundField>
                  <asp:BoundField DataField="CompanyName" HeaderText="公司" />
                  <asp:CommandField DeleteText="&lt;img border=0 src=&quot;../images/Select.gif&quot; /&gt; "
                      ShowDeleteButton="True">
                      <ItemStyle Width="40px" />
                  </asp:CommandField>
              </Columns>
          </asp:GridView>
      
     
     
    
      </DIV></DIV>
      
  </td>
 </tr>
 </table>
  


    </div>
    </form>
</body>
</html>
