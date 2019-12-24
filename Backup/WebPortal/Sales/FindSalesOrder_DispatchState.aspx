<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_FindSalesOrder_DispatchState" Codebehind="FindSalesOrder_DispatchState.aspx.cs" %>
<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>快递公司业务处理</title>
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
    
  <script type="text/javascript">
  function openwinEdit(text)
    {
     
 var url=window.parent["MainFrame"].document.location;
 window.open("MySalesDispatchEditSent.aspx?DispatchID="+text+"&fromUrl="+url,null,"height=200,width=500,status=no,toolbar=no,menubar=no,location=yes,resizable=no,scroll=no");     
    
    }
    
    </script>
</head>
<body>
    <form id="form2" runat="server">
    <div align="center" >
    <table style="width:97%;" >
        <tr>
            <td align="left" style="width: 810px; height: 20px;">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>
    <DIV class=bar>
  <table width="900" border="0">
    <tr>
     <td style="width: 80px; height: 14px;" align="right">
         销售订单</td>
     <td style="width: 141px; height: 14px;" align="left">
         <asp:TextBox ID="SalesOrderID" runat="server" Width="151px"></asp:TextBox></td>
      <td style="width: 138px; height: 14px;" align="left"> &nbsp;<asp:Button ID="Select" runat="server"
              Text="查询" OnClick="Select_Click" /></td>
      <td style="width: 200px; height: 14px;" align="left">
          &nbsp; </td>
      <td style="width: 228px; height: 14px;">
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</td>
    </tr>
  </table>
</DIV>
<table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px; height: 38px;">
    已发货单查询
</td>
</tr>
</table>
<table style="width:710px;" >
    <tr>
        <td align="center" >

    <table width="700"  class="flexme2">
	<thead>
    		<tr>

            	<th width="140"  >
                    销售出库单</th>
            	<th width="100">
                    应发日期</th>

            	<th width="100"  >配送方式</th>
            	<th width="100" >状态</th>
                <th width="180"  >备注描述</th>
    		    <th width="50"  ></th>
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	
            	<td> <a target="_blank" href="SalesOut_Detail.aspx?SalesOutID=<%#Eval("SalesOutID")%>"><%#Eval("SalesOutID")%></a>
            	</td>
            	<td><%#Eval("DeliveryDate")%> </td>
            	<td><%#Eval("DeliveryName")%></td>
            	<td><%# changString(Eval("State").ToString())%></td>
            	<td><%#Eval("Description")%></td>
            

                <td></td>
          
    	
    		</tr>
        
        </ItemTemplate>
        </asp:Repeater>
      
    		
    </tbody>
</table>
        </td>
    </tr>
</table>
    
    <br />
    <br />
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



