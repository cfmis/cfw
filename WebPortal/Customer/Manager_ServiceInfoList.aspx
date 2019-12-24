<%@ Page Language="C#" AutoEventWireup="true" Inherits="Customer_Manager_ServiceInfoList" Codebehind="Manager_ServiceInfoList.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>问题服务管理中心</title>
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
         
           window.location.href("Manager_AuditingServiceInfo.aspx?action="+action+"&AuditingId="+encodeURIComponent(str)) ;
    
         
    
        }
     
    }
    
    </script>
</head>
<body>
    <form id="form2" runat="server">
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
    <DIV  style="width: 955px">
        <table border="0" width="100%">
            <tr>
                <td style="width: 127px">
                </td>
                <td style="height: 21px" align="left">
                    &nbsp;&nbsp; 
                   
                    &nbsp; &nbsp;<input id="Button3" name="shenhe" onclick="document.location.href='ServiceInfo_Add.aspx'"
                        style="width: 81px" type="button" value="新添问题" />
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    <input id="Submit1" name="shenhe" onclick="javascript:if(!confirm('您确定要操作吗!你将受理这些案件'))return  false;shenheSubmit('Auditing')"
                        style="width: 81px" type="button" value="受理服务" />
                    &nbsp; &nbsp; &nbsp; &nbsp;
                    <input id="Button1" name="shenhe" onclick="javascript:if(!confirm('您确定要解决服务吗！'))return  false;shenheSubmit('Solve')"
                        style="width: 89px" type="button" value="解决服务" />
                    &nbsp;&nbsp;
                    <input id="Button2" name="shenhe" onclick="javascript:if(!confirm('您确定要让服务作废吗！'))return  false;shenheSubmit('Cancel')" style="width: 103px" type="button"
                        value="服务作废" />
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    <asp:Button ID="MyOrder" runat="server" Text="我的受理服务" OnClick="MyOrder_Click"  /></td>
            </tr>
        </table>
        <br />
  <table width="900" border="0">
    <tr>
     <td style="width: 205px; height: 34px;" align="right">
         发布日期</td>
     <td style="width: 129px; height: 34px;">
     从:
         <asp:TextBox ID="baginData" runat="server" Width="83px"></asp:TextBox>
          <img src="../images/calendar.gif" onclick="fPopUpCalendarDlg(baginData);return false;" /> </td>
      <td style="width: 138px; height: 34px;"> 
      至:
          <asp:TextBox ID="endData" runat="server" Width="92px"></asp:TextBox>
          <img src="../images/calendar.gif" onClick="fPopUpCalendarDlg(endData);return false;" />
      </td>
      <td style="width: 127px; height: 34px;">
          <asp:DropDownList ID="side" runat="server" Width="78px">
              <asp:ListItem Value="0">未受理 </asp:ListItem>
              <asp:ListItem Value="1">受理中</asp:ListItem>
              <asp:ListItem Value="2">已解决</asp:ListItem>
              <asp:ListItem Value="3">过期作废</asp:ListItem>
          </asp:DropDownList>
          &nbsp;&nbsp;&nbsp;
      </td>
      <td style="width: 228px; height: 34px;">
          <asp:Button ID="Select" runat="server"
              Text="查询" OnClick="Select_Click" />
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
    </tr>
  </table>
</DIV>
<table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px; height: 38px;">
    用户问题受理管理中心
</td>
</tr>
</table>
<table style="width:872px;" >
    <tr>
        <td align="center" style="width: 846px" >

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
            	<td> <a target="_blank" href="ServiceInfo_Detail.aspx?ServiceID=<%#Eval("ID")%>" ><%#Eval("ServiceTitle")%></a>
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

