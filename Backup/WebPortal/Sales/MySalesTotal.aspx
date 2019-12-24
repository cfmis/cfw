<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_MySalesTotal" Codebehind="MySalesTotal.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>我的销售统计</title>
        <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
	


	
	
      <style type="text/css">
    #addMian_b {width:980px;height:450px;background:#000;-moz-opacity:0.2; filter:alpha(opacity=25);margin:-30px 10 0 10px; position:absolute;}
#addMian_t { z-index:20;border:1px solid #a4d5e3;width:960px;height:450px;background:#FFF;margin:-15px 0 0 5px; position:absolute;}
body {
	margin-left: 10px;
	margin-top: 0px;
}
    
    </style>
    
  <script type="text/javascript">
    
  function checkDate()
  {
    var str1=document.getElementById("baginData").value;
    var str2=document.getElementById("endData").value;
    
    if(str1=="" || str2=="")
    {
       alert("请选择起始日期 和 结束日期 ！");
       return false;
    }
    if(str1 > str2)
    {
       alert("起始日期 应该大于 结束日期 ！");
       return false;
    }
    
   return true;
  }
    

    </script>
</head>
<body>
    <br />
    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
    </asp:SiteMapPath>
    <br />

    <form id="form2" runat="server" >
    <div align="center" >
    <DIV class=bar>
  <table width="900" border="0">
    <tr>
     <td style="width: 16px"></td>
     <td style="width: 153px">
     从:
         <asp:TextBox ID="baginData" runat="server" Width="83px"></asp:TextBox>
          <img src="../images/calendar.gif" onclick="fPopUpCalendarDlg(baginData);return false;" /> </td>
      <td style="width: 166px"> 
      至:
          <asp:TextBox ID="endData" runat="server" Width="92px"></asp:TextBox>
          <img src="../images/calendar.gif" onClick="fPopUpCalendarDlg(endData);return false;" />
      </td>
      <td style="width: 133px">
          &nbsp;<asp:Button ID="Total" runat="server"
              Text="统计" OnClientClick="return checkDate()"  Width="77px" OnClick="Total_Click" /></td>
      <td style="width: 228px" align="left">
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;&nbsp;</td>
    </tr>
  </table>
</DIV>
<table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px; height: 38px;">
    我的销售统计
</td>
</tr>
</table>
    
    <br /><table style="width:97%;" >
        <tr>
            <td align="center"  style="width: 900px;">
                <asp:Panel ID="Panel1" runat="server"  Width="500px" Visible="False">
                
                <table width="490" height="161" border="1">
  <tr>
    <td width="130">起始时间：</td>
    <td width="344">
        <asp:Label ID="Btime" runat="server" Text=""></asp:Label>&nbsp;</td>
  </tr>
  <tr>
    <td>结束时间：</td>
    <td>
        <asp:Label ID="Etime" runat="server" Text=""></asp:Label>&nbsp;</td>
  </tr>
  <tr>
    <td>订单数量：</td>
    <td>
        <asp:Label ID="OrderNum" runat="server" Text=""></asp:Label>&nbsp;</td>
  </tr>
  <tr>
    <td>销售总额：</td>
    <td>
        <asp:Label ID="TotoalCost" runat="server" Text=""></asp:Label>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
                </asp:Panel>
            </td>
        </tr>
    </table>
           <div class="pageLink" id="pageLink">
               &nbsp;</div>
 
    
  
    </div>
    </form>
</body>
</html>


