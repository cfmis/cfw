<%@ Page Language="C#" AutoEventWireup="true" Inherits="Customer_SalesRecordList" Codebehind="SalesRecordList.aspx.cs" %>
<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>管理审核采购订单</title>
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
    
    function del()
    {
     var str="";
     var j=0;
     if(document.all.selOrder.length == 1)
     {
       str=document.getElementById("selOrder").value;
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
         
           window.location.href("SalesRecord_Del.aspx?AuditingId="+encodeURIComponent(str)) ;
        }
     
    }
    
    
   
    function newAdd()
    {
       window.location.href("SalesRecord_Add.aspx");
    }
    </script>
</head>
<body>

    <form id="form2" runat="server" >
    <div align="center" >
    <DIV class=bar>
  <table width="100%" border="0">
    <tr>
     <td >
         客户编号：<asp:TextBox ID="OrderID" runat="server" Width="105px"></asp:TextBox></td>
     <td >
         消费平台<asp:DropDownList ID="PlatformIDDropDownList" runat="server" DataSourceID="ObjectDataSource1"
             DataTextField="PlatformName" DataValueField="PlatformID">
         </asp:DropDownList>
     </td>
      <td  align="left">
          &nbsp; &nbsp; &nbsp;<asp:Button ID="Select" runat="server"
              Text="查询" OnClick="Select_Click" />
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <asp:Button ID="Button1" runat="server" Text="全部" OnClick="Button1_Click" />
          &nbsp;&nbsp; 
          <input type="button"  name="shenhe" value="新添" id="Button2" onclick="newAdd()" style="width: 56px" />
          
          <input id="Button3" type="button" onclick="javascript:if(!confirm('您确定要审核通过这些订单吗'))return  false;del()" value="删除记录" style="width: 73px" />
          
          </td>
    </tr>
  </table>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="getList" TypeName="Leyp.SQLServerDAL.Sales.SalesPlatformDAL"></asp:ObjectDataSource>
</DIV>
<table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px; height: 38px;">
    客户购买记录&nbsp;</td>
</tr>
</table>
    
    <br />

    <table width="850"  class="flexme2">
	<thead>
    		<tr>
            	<th width="60">选择</th>
            
            	<th width="100">
                    平台</th>
 
            	<th width="100">
                    制单时间</th>
            	<th width="150">
                    顾客ID</th>
            	<th width="150">
                    销售订单</th>
          
                <th width="100">
                    制单人</th>
    	
    		    <th width="200">地区描述</th>
    		    <th width="20"></th>
    		    
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	<td><input type="checkbox" name="selOrder" value="<%#Eval("ID")%>" /> </td>
            	<td><%#Eval("PlatformName")%></td>
                <td><%#Eval("CreateDate")%></td>
            	<td><%#Eval("CustomerID")%></td>
                <td><%#Eval("SalesOrderID")%></td>
                <td><%#Eval("UserName")%></td>
    		     <td><%#Eval("Description")%></td>
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
			///$('.flexme2').flexigrid({height:'auto',striped:false});


</script>
    
  
    </div>
    </form>
</body>
</html>

