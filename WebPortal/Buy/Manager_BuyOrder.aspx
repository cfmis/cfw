<%@ Page Language="C#" AutoEventWireup="true" Inherits="Buy_Manager_BuyOrder" Codebehind="Manager_BuyOrder.aspx.cs" %>
<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>采购订单</title>
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
#Layer1 {
	position:absolute;
	left:439px;
	top:15px;
	width:149px;
	height:21px;
	z-index:1;
}
    
    </style>
    
  <script type="text/javascript">
    
    function shenheSubmit(action)
    {
     var str="";
     var j=0;
     var obj=document.getElementsByName("selOrder");
     var k=obj.length;
     if(k == 1)
     {
      
       if(obj[0].checked==true)
         str=obj[0].value;
     }else
     {
      for( i=0;i<document.all.selOrder.length;i++)
         {
            if(document.all.selOrder[i].checked)
            {
              if( 0==j)
             {
              str=document.all.selOrder[i].value
             }else
             {
              str=str+"#"+document.all.selOrder[i].value;
             }
             j++;
           } 
            document.all.selOrder[i].checked = false;      
         }
     }
        if(str=="")
        {
          
          alert("请选择要操作的选项");
          return false;
        }
        else
        {
          // window.location.replace("Manager_AuditingBuyOrder.aspx?AuditingId="+encodeURIComponent(str)) ;
           window.location.href("Manager_AuditingBuyOrder.aspx?action="+action+"&AuditingId="+encodeURIComponent(str)) ;
        }
    
    }
    
    function newAdd()
    {
    
      window.location.href("BuyOrder_Add.aspx") ;
    }
    </script>
</head>
<body>
   <div id="Layer1" style="left: 750px; top: 70px; width: 252px;"> 
   </div>
    <form id="form2" runat="server">
    <div align="center" ><table style="width:97%;" >
        <tr>
            <td align="left" style="width: 810px; height: 20px;">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>
        <br />
        <br />
    <DIV class=bar>
  <table width="900" border="0">
  <tr>
    <td width="20%" height="37" align="left">订单编号：
    <asp:TextBox ID="BuyOrderID" runat="server" Width="100px"></asp:TextBox>&nbsp;</td>
    <td width="15%" align="left">从:
      <asp:TextBox ID="baginData" runat="server" Width="83px"></asp:TextBox>
    <img src="../images/calendar.gif" onclick="fPopUpCalendarDlg(baginData);return false;" /></td>
    <td align="left" style="width: 16%">至:
          <asp:TextBox ID="endData" runat="server" Width="92px"></asp:TextBox>
    <img src="../images/calendar.gif" onClick="fPopUpCalendarDlg(endData);return false;" /></td>
    <td width="15%" align="left">状态：

          <asp:DropDownList ID="side" runat="server" Width="58px">
              <asp:ListItem Value="0">全部</asp:ListItem>
              <asp:ListItem Value="1">未审</asp:ListItem>
              <asp:ListItem Value="2">已审</asp:ListItem>
    </asp:DropDownList></td>
    <td width="35%" align="left"><asp:Button ID="Select" runat="server"
              Text="查询" OnClick="Select_Click" />
              
              
              <input  type="button" name="shenhe" value="审核" id="Submit1" onclick="shenheSubmit('shenhe')" />
   <input  type="button" name="delOp" value="反审核" id="delOp" onclick="shenheSubmit('rshenhe')" />
   <input  type="button" name="delOp" value="删除" id="Button1" onclick="shenheSubmit('delete')" />
   <input  type="button" name="delOp" value="新添订单" id="Button2" onclick="newAdd()" />
              
              </td>
  </tr>
</table>
</DIV>
<table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px; height: 38px;">
    采购订单
</td>
</tr>
</table>
    
    <br />
  <table width="920" >

<tr>
<td align="center">
    <table width="900"  class="flexme2">
	<thead>
    		<tr>
            	<th width="40">选择</th>
            
            	<th width="120">订单号</th>
            	<th width="100">日期</th>
            	<th width="80">库房</th>
            	<th width="80">库区</th>
            	<th width="100">制单人</th>
            	<th width="100">业务代表</th>
                <th width="130">合计金额</th>
    		    <th width="70">状态</th>
    		    
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	<td><input type="checkbox" name="selOrder" value="<%#Eval("BuyOrderID")%>" />
            	
            	</td>
            	<td>
            	<a target=_blank href="BuyOrder_Detail.aspx?BuyOrderID=<%#Eval("BuyOrderID")%>"><%#Eval("BuyOrderID")%></a>
            	
            	</td>
            	<td><%#Eval("BuyOrderDate")%> </td>
            	<td><%#Eval("HouseName")%></td>
            	<td><%#Eval("SubareaName")%></td>
            	<td><%#Eval("RealName")%></td>
            	<td><%#Eval("Delegate")%></td>
                <td><%#Eval("TotalPrice")%></td>
    		    <td><%# changString(Eval("State").ToString())%></td>
    		   <td></td>
    		</tr>
        
        </ItemTemplate>
        </asp:Repeater>
      
    		
    </tbody>
</table>
</td>
</tr>
</table>
           <div class="pageLink" id="pageLink">
        <cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
            backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
            pagesize="6" showfirstlast="true" showpagenumbers="true"></cc1:collectionpager>
            </div>
          
 <script type="text/javascript">



			$('.flexme2').flexigrid();
			///$('.flexme2').flexigrid({height:'auto',striped:false});


</script>
    
  
    </div>
    </form>
</body>
</html>

