<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_Manager_SalesOutOrder" Codebehind="Manager_SalesOutOrder.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>管理销售出库单</title>
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
         
           window.location.href("Manager_AuditingSalesOut.aspx?action="+action+"&AuditingId="+encodeURIComponent(str)) ;
        }
     
    }
    
    function newAdd()
    {
       window.location.href("SalesOut_Add.aspx");
    }
    //进入发货编辑
 function openwinEdit(text)
    {
 window.open("SalesDispatch_Add.aspx?SalesOutID="+text,null,"height=250,width=950,status=no,toolbar=no,menubar=no,location=no,resizable=no,scroll=no");     
    
    }
    
    //快速生成
function kuaisuCreat()
    {
     var str="";
     var j=0;
     var obj=document.getElementsByName("selOrder");
     var k=obj.length;
     
     var ConsignorId=document.getElementById("DeliveryUserDropList1").value;
     
      if(ConsignorId=="")
     {
       alert("请选择默认配送人员！");
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
         
           document.location.href="SalesDispatchCreateKuai.aspx?Consignor="+ConsignorId+"&AuditingId="+encodeURIComponent(str);
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
  <table width="100%" border="0">
    <tr>
      <td style="width: 440px">
          快递配送人： &nbsp;<cc2:deliveryuserdroplist id="DeliveryUserDropList1" runat="server"></cc2:deliveryuserdroplist>&nbsp;
          <input id="Button4" type="button" onclick="kuaisuCreat()" value="快速生成发货单" style="width: 103px" /></td>
      <td style="height: 21px">
          &nbsp; &nbsp; &nbsp;
          <input id="Button3" type="button" onclick="document.location.href='ManagerAuditingSalesOut.aspx'" value="审核销售开单" style="width: 103px" />
          &nbsp; &nbsp;&nbsp; &nbsp;<input type="button"  name="shenhe" value="删除单据" id="Button1" onclick="javascript:if(!confirm('您确定要删除吗'))return  false;shenheSubmit('delete')" style="width: 73px" />
          &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
          <input type="button"  name="shenhe" value="新添销售出库单" id="Button2" onclick="newAdd()" style="width: 103px" /></td>
    </tr>
  </table>

    <div align="center" >
    <DIV class=bar>
  <table width="900" border="0">
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
      <td style="width: 133px">
          状态：
          &nbsp;&nbsp;
          <asp:DropDownList ID="side" runat="server" Width="58px">
              <asp:ListItem Value="0">全部</asp:ListItem>
              <asp:ListItem Value="1">未审</asp:ListItem>
              <asp:ListItem Value="2">已审</asp:ListItem>
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
    管理销售开单
</td>
</tr>
</table>
    
    <br />
    
    
    <table width="920" >

<tr>
<td align="center">
  <table width="870" border="0"  class="flexme2">
	<thead>
    		<tr>
            	<th width="50">选择</th>
                 
                 <th width="70">编辑发货</th>
                  <th width="70">修改单据</th>
            	<th width="150">
                    单号</th>
            	<th width="100">
                    制单日期</th>
            	<th width="100">
                    出库日期</th>
            	<th width="100">收货人</th>
            	
   
                <th width="100">合计金额</th>
    		    <th width="50">状态</th>
    		    <th width="50"></th>
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	<td><input type="checkbox" name="selOrder" value="<%#Eval("SalesOutID")%>" />
            	
            	</td>
            	
            	<td><img src="../images/tbtn_calendar.gif" alt="编辑发货" onclick="openwinEdit('<%#Eval("SalesOutID")%>')" /></td>
            	
            	<td>
            	
            	<a target="_blank" href="SalesOut_Edit.aspx?SalesOutID=<%#Eval("SalesOutID")%>"><img src="../images/Edit.gif" border="0"  alt="编辑"/> </a></td>
            	
            	<td>
            	<a target="_blank" href="SalesOut_Detail.aspx?SalesOutID=<%#Eval("SalesOutID")%>"><%#Eval("SalesOutID")%></a>
            	
            	</td>
            	<td><%#Eval("CreateDate")%> </td>
            	<td><%#Eval("TradeDate")%></td>
            	<td><%#Eval("Consignee")%></td>
            	
            
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

