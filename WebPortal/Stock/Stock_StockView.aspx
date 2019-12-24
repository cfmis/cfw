<%@ Page Language="C#" AutoEventWireup="true" Inherits="Stock_Stock_StockView" Codebehind="Stock_StockView.aspx.cs" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>库存情况</title>
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
      str=document.getElementById("selOrder").value;
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
          // window.location.replace("Manager_AuditingBuyOrder.aspx?AuditingId="+encodeURIComponent(str)) ;
           window.location.href("Manager_AuditingAppendStockOrder.aspx?action="+action+"&AuditingId="+encodeURIComponent(str)) ;
        }
     
    }
    
    function newAdd()
    {
       window.location.href("AppendStock_Add.aspx");
    }
    </script>
</head>
<body>

    <form id="form2" runat="server" >
    <div align="center" >
        <table style="width: 97%">
            <tr>
                <td align="left" style="width: 810px; height: 20px">
                    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                    </asp:SiteMapPath>
                </td>
            </tr>
        </table>
        <br />
    <DIV class=bar>
  <table width="100%" border="0">
    <tr>
     <td style="width: 181px">
         选择库房</td>
     <td style="width: 178px">
         <asp:DropDownList ID="StoreHouseDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="StoreHouseDropDownList_SelectedIndexChanged">
         </asp:DropDownList></td>
      <td style="width: 138px"> 选择库区</td>
      <td style="width: 133px">
          <asp:DropDownList ID="SubareaNameDropDownList" runat="server">
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
    库存情况
</td>
</tr>
</table>
    
    <br />


<table width="850px">

<tr>
<td >
  <table width="800"  class="flexme2">
	<thead>
    		<tr>
            	<th width="70">
                    库房</th>
            
            	<th width="100">
                    库区</th>
            	<th width="100">
                    商品编号</th>
            	<th width="150">
                    商品名称</th>
            	
            	<th width="100">
                    库存上限</th>
   
                <th width="100">
                    库存下限</th>
                <th width="100">
                    成本&nbsp;</th>
    		    <th width="100">
                    现存量</th>
    		    <th width="30"></th>
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	<td><%#Eval("HouseName")%>
            	
            	</td>
            	<td>
            	<%#Eval("SubareaName")%>
            	
            	</td>
            
            	<td><%#Eval("ProductsID")%></td>
            	<td><%#Eval("ProductsName")%></td>
                <td><%#Eval("UpperLimit")%></td>
                	<td><%#Eval("LowerLimit")%> </td>
                	<td><%#Eval("Cost").ToString()%></td>
    		    <td><%# Eval("Num")%></td>
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
               &nbsp;</div>
          
 <script type="text/javascript">



			$('.flexme2').flexigrid();
			///$('.flexme2').flexigrid({height:'auto',striped:false});


</script>
    
  
    </div>
    </form>
</body>
</html>
