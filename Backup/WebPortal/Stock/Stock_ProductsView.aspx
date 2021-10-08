<%@ Page Language="C#" AutoEventWireup="true" Inherits="Stock_Stock_ProductsView" Codebehind="Stock_ProductsView.aspx.cs" %>


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
    
   
    function check()
    {
       var val=document.getElementById("ProductsID");
       
        if(!/^\d+$/.test(val.value))
            {
              alert("商品编号应该是整数");
			   return false;
            }else
            {
             return true;
            }
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
     <td style="width: 49px">
         </td>
     <td style="width: 66px">
         商品编号：</td>
      <td style="width: 119px" > 
          <asp:TextBox ID="ProductsID" runat="server" Width="93px"></asp:TextBox><asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="ProductsID"
                        ErrorMessage="输入有误" MaximumValue="90000000" MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
      <td style="width: 228px" align="left">
          &nbsp; &nbsp; &nbsp;<asp:Button ID="Select" runat="server"
              Text="查询" OnClientClick="return check();" OnClick="Select_Click" />
          &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
          <asp:Button ID="Button1" runat="server"
              Text="图形查询" OnClick="Button1_Click"  />
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;&nbsp;</td>
    </tr>
  </table>
</DIV>
<table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px; height: 38px;">
    商品库存分布情况
</td>
</tr>
</table><table style="width:810px;" >
    <tr>
        <td align="center"  style="width: 800px; height: 38px;">

    <table width="800"  class="flexme2">
	<thead>
    		<tr>
            	<th width="120" style="height: 16px">
                    库房</th>
            
            	<th width="120" style="height: 16px">
                    库区</th>
            	
    		    <th width="100" style="height: 16px">
                    现存量</th>
    		    <th width="500" style="height: 16px"></th>
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
    
    <br />
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

