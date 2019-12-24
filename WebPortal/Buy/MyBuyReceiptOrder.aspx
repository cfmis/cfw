<%@ Page Language="C#" AutoEventWireup="true" Inherits="Buy_MyBuyReceiptOrder" Codebehind="MyBuyReceiptOrder.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>我的订单</title>
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
	margin-top: 10px;
}
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center" >
    <DIV class=bar>
  <table width="100%" border="0">
    <tr>
     <td style="width: 175px">入库编号：<asp:TextBox ID="BuyOrderID" runat="server" Width="105px"></asp:TextBox></td>
     <td style="width: 129px">
     从:
         <asp:TextBox ID="baginData" runat="server" Width="83px"></asp:TextBox>
          <img src="../images/calendar.gif" onclick="fPopUpCalendarDlg(baginData);return false;" /> </td>
      <td style="width: 138px"> 
      至:
          <asp:TextBox ID="endData" runat="server" Width="92px"></asp:TextBox>
          <img src="../images/calendar.gif" onClick="fPopUpCalendarDlg(endData);return false;" />
      </td>
      <td style="width: 104px">
          &nbsp;&nbsp;
          <asp:DropDownList ID="side" runat="server" Width="58px">
              <asp:ListItem Value="0">全部</asp:ListItem>
              <asp:ListItem Value="1">未审</asp:ListItem>
              <asp:ListItem Value="2">已审</asp:ListItem>
          </asp:DropDownList></td>
      <td style="width: 228px">
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Button ID="Select" runat="server"
              Text="查询" OnClick="Select_Click" />
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp;
          <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Buy/BuyReceip_Add.aspx">新加采购入库</asp:HyperLink></td>
    </tr>
  </table>
</DIV>
<table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px">
    采购入库单
</td>
</tr>
</table>
    
    <br />
    <br />

    <table width="915"  class="flexme2">
	<thead>
    		<tr>
            	<th width="115">操作</th>
            	<th width="165">订单号</th>
            	<th width="115">日期</th>
            	<th width="82">库房</th>
            	<th width="82">库区</th>
            	<th width="121">业务代表</th>
                <th width="128">合计金额</th>
    		    <th width="71">状态</th>
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	<td>
            <a href="BuyOrder_Add.aspx" >	<img alt="修改"  border="0" src="../images/tbtn_amend.gif" /> </a>&nbsp;&nbsp;<a href="MyBuyOrderDel.aspx" ><img alt="删除" border="0" src="../images/tbtn_delete.gif" /> </a>
            	</td>
            	<td><%#Eval("BuyOrderID")%></td>
            	<td><%#Eval("BuyOrderDate")%> </td>
            	<td><%#Eval("HouseName")%></td>
            	<td><%#Eval("SubareaName")%></td>
            	<td><%#Eval("Delegate")%></td>
                <td><%#Eval("TotalPrice")%></td>
    		    <td><%# changString(Eval("State").ToString())%></td>
    		</tr>
        
        </ItemTemplate>
        </asp:Repeater>
      
    		
    </tbody>
</table>
           <div class="pageLink" id="pageLink">
        <cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
            backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
            pagesize="10" showfirstlast="true" showpagenumbers="true"></cc1:collectionpager>
            </div>
          
 <script type="text/javascript">



			$('.flexme2').flexigrid();
			//$('.flexme2').flexigrid({height:'auto',striped:false});
</script>
    
  
    </div>
    </form>
</body>
</html>
