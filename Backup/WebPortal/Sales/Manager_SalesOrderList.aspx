<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_Manager_SalesOrderList" Codebehind="Manager_SalesOrderList.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>管理审核销售订单</title>
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
         
           window.location.href("Manager_AuditingSalesOrder.aspx?action="+action+"&AuditingId="+encodeURIComponent(str)) ;
        }
     
    }
    
function newAdd()
    {
       window.location.href("SalesOrder_Add.aspx");
   
    }
    
function kuaiSuShengch()
    {
     var str="";
     var j=0;
     var obj=document.getElementsByName("selOrder");
     var k=obj.length;
     
     var Delivery=document.getElementById("DeliveryID").value;
     
     if(Delivery=="")
     {
       alert("请选择默认配送方式！");
          return false;
     }
     
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
         
           window.location.href("SalesOutCreateKuai.aspx?DeliveryID="+Delivery+"&AuditingId="+encodeURIComponent(str)) ;
        }
     
    }

    
    </script>
</head>
<body>
    <table style="width: 97%">
        <tr>
            <td align="left" style="width: 810px; height: 20px">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>
    <br />
<form id="form1" runat="server" >
  <table width="900" border="0">
    <tr>
      <td style="width: 505px; height: 22px;">
          默认配送：<cc2:deliverydropdownlist id="DeliveryID"  runat="server"></cc2:deliverydropdownlist><input type="button"  name="Kuaishenhe" value="快速生成销售开单" id="Button5" onclick="javascript:if(!confirm('您确定要生成销售开单吗'))return  false;kuaiSuShengch()" style="width: 134px" /></td>
      <td style="height: 22px">
          &nbsp; &nbsp; &nbsp;
          <input id="Button3" type="button" onclick="document.location.href='ManagerAuditingSalesOrder.aspx'" value="审核销售订单" style="width: 86px" />
          <input id="Button4" type="button" onclick="javascript:if(!confirm('您确定要反审核这些订单吗'))return  false;shenheSubmit('rshenhe')" value="反审核" />
          &nbsp;&nbsp;<input type="button"  name="shenhe" value="删除单据" id="Button1" onclick="javascript:if(!confirm('您确定要删除吗'))return  false;shenheSubmit('delete')" style="width: 73px" />
          &nbsp; &nbsp;&nbsp;
          <input type="button"  name="shenhe" value="新添销售订单" id="Button2" onclick="newAdd()" style="width: 82px" /></td>
    </tr>
  </table>
    <br />

    
    <div align="center" >
    <DIV class=bar>
  <table width="880" border="0">
    <tr>
     <td style="width: 175px">单据编号：<asp:TextBox ID="OrderID" runat="server" Width="105px"></asp:TextBox></td>
     <td style="width: 129px">
     从:
         <asp:TextBox ID="baginData" runat="server" Width="83px"></asp:TextBox>
          <img src="../images/calendar.gif" onclick="fPopUpCalendarDlg(baginData);return false;" /> </td>
      <td style="width: 138px"> 
      至:
          <asp:TextBox ID="endData" runat="server" Width="92px"></asp:TextBox>
          <img src="../images/calendar.gif" onClick="fPopUpCalendarDlg(endData);return false;" />
      </td>
      <td style="width: 153px">
          状态：
          &nbsp;&nbsp;
          <asp:DropDownList ID="side" runat="server" Width="88px">
              <asp:ListItem Value="-1">显示未交款的</asp:ListItem>
              <asp:ListItem Value="0">显示未审核的</asp:ListItem>
              <asp:ListItem Value="1">显示已审核的</asp:ListItem>
          </asp:DropDownList></td>
      <td style="width: 228px" align="left">
          &nbsp; &nbsp; &nbsp;<asp:Button ID="Select" runat="server"
              Text="查询" OnClick="Select_Click" />
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;&nbsp;</td>
    </tr>
  </table>
</DIV>
<table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px; height: 38px;">
    管理销售订单
</td>
</tr>
</table>
    
    <br />

    <table style="width:97%;" >
    <tr>
        <td align="center"  style="width: 910px; ">

    <table width="900"  class="flexme2">
	<thead>
    		<tr>
            	<th width="35">选择</th>
            
            	<th width="150">订单号</th>
            	<th width="100">日期</th>
            	<th width="100">交货方式</th>
            	<th width="100">结算方式</th>
            
   
                <th width="280">发货地址</th>
    		    <th width="100">状态</th>
    		    <th width="20"></th>
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	<td><input type="checkbox" id="selOrder" name="selOrder" value="<%#Eval("SalesOrderID")%>" />
            	
            	</td>
            	<td>
            	<a target="_blank" href="SalesOrder_Detail.aspx?SalesOrderID=<%#Eval("SalesOrderID")%>"><%#Eval("SalesOrderID")%></a>
            	
            	</td>
            	<td><%#Eval("CreateDate")%> </td>
            	<td><%#Eval("DeliveryType")%></td>
            	<td><%#Eval("ClosingType")%></td>
            
                <td><%#Eval("DeliveryPlace")%></td>
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
        <br />
           <div class="pageLink" id="pageLink">
        <cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
            backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
            pagesize="10" showfirstlast="true" showpagenumbers="true"></cc1:collectionpager>
            </div>
          
 <script type="text/javascript">



			$('.flexme2').flexigrid();
			///$('.flexme2').flexigrid({height:'auto',striped:false});


</script>
    
  
    </div>
    </form>
</body>
</html>
