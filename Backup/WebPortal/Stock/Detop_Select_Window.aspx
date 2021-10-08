<%@ Page Language="C#" AutoEventWireup="true" Inherits="Stock_Detop_Select_Window" Codebehind="Detop_Select_Window.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="bar"> 
 <table>
 <tr>
  <td WIDTH="10"></td>
 <td>
     库房选择</td>
  <td colspan="2"></td>
  <td style="width: 209px">
  <div id="loading">
      &nbsp;<cc1:StoreHouseDropDownList ID="StoreHouse" AutoPostBack="True" OnSelectedIndexChanged="StoreHouse_SelectedIndexChanged" runat="server">
      </cc1:StoreHouseDropDownList></div>
  </td>
 </tr>
 
 
 </table>
 
  </div> 
  
<table WIDTH=" 300px">
 <tr>
  <td>
  <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; FLOAT: LEFT; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 300px! important; BORDER-BOTTOM: #a4d5e3 1px solid">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">
          编号 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;库房名称：
      </H2>
     
      <DIV style="MARGIN: 5px" id="customerList">
          <asp:GridView ID="GridView1"   runat="server" AutoGenerateColumns="False" OnRowDeleting="GridView1_RowDeleting"
              Width="289px" DataKeyNames="ID,HouseID">
              <Columns>
                  <asp:BoundField HeaderText="编号" ShowHeader="False" DataField="ID">
                      <ItemStyle Width="50px" />
                  </asp:BoundField>
                  <asp:BoundField HeaderText="库区名称" ShowHeader="False" DataField="SubareaName">
                      <ItemStyle Width="100px" />
                  </asp:BoundField>
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
