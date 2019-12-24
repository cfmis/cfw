<%@ Page Language="C#" AutoEventWireup="true" Inherits="Flow_PhotoFlow_List" Codebehind="PhotoFlow_List.aspx.cs" %>

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
<table style="width:97%;" >

<tr>
<td align="right">
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Flow/PhotoFlow_Add.aspx">新添计划</asp:HyperLink></td>
</tr>
</table>
        <table style="width:97%;" >
            <tr>
                <td align="center" class="title" style="width: 810px; height: 33px;">
    商品图片修改计划&nbsp;&nbsp;&nbsp;</td>
            </tr>
        </table>
        <br />
    
    <br />

    <table width="850"  class="flexme2">
	<thead>
    		<tr>
            	<th width="60">选择</th>
            
            	<th width="300">
                    标题</th>
 
            	<th width="100">
                    制单时间</th>
            	<th width="150">
                    发布人</th>
    	
    		    <th width="100">
                    状态</th>
    		    <th width="200"></th>
    		    
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	<td><input type="checkbox" name="selOrder" value="<%#Eval("FlowID")%>" /> </td>
            	<td><%#Eval("FlowTitle")%></td>
                <td><%#Eval("CreateDate")%></td>
            	<td><%#Eval("UserName")%></td>
    		     <td><%#Eval("State")%></td>
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


