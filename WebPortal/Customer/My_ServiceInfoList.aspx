<%@ Page Language="C#" AutoEventWireup="true" Inherits="Customer_My_ServiceInfoList" Codebehind="My_ServiceInfoList.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
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
     
 var url="Manager_SalesDispatchOrder.aspx";
 window.open("MySalesDispatchEditSent.aspx?DispatchID="+text+"&fromUrl="+url,null,"height=200,width=500,status=no,toolbar=no,menubar=no,location=yes,resizable=no,scroll=no");     
    
    }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table style="width:97%;" >
        <tr>
            <td align="left" style="width: 810px; height: 20px;">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>
        <table style="width: 940px; height: 33px">
            <tr>
                <td>
                </td>
                <td style="width: 605px">
                </td>
                <td>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Customer/ServiceInfo_Add.aspx"
                        Width="87px">新添问题</asp:HyperLink></td>
            </tr>
        </table>
        <br />
    
  <table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px; height: 38px;">
    我的问题管理</td>
</tr>
</table>
<table style="width:890px;" >
    <tr>
        <td align="center" style="width: 796px" >

    <table width="840"  class="flexme2">
	<thead>
    		<tr>
               <th width="50">选择</th>
            	<th width="300">信息主题</th>
            	<th width="100">发布日期</th>
            	<th width="100">信息类型</th>
            	<th width="100">发布人</th>
            	<th width="80" >状态</th>
    		    <th width="100" ></th>
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	
            	<td> <input type="checkbox" name="selOrder" value="<%#Eval("ID")%>" />
            	    </td>
            	<td><a target="_blank" href="ServiceInfo_Detail.aspx?ServiceID=<%#Eval("ID")%>" ><%#Eval("ServiceTitle")%></a>
            	</td>
            	<td><%#Eval("CreateDate")%> </td>
            	<td><%#Eval("ServiceName")%> </td>
            	<td><%#Eval("RealName")%> </td>
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

