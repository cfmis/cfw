<%@ Page Language="C#" AutoEventWireup="true" Inherits="Notice_NoticeList" Codebehind="NoticeList.aspx.cs" %>
<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>信息列表</title>
               <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div  align="center"><table style="width:97%;" >
        <tr>
            <td align="left" style="width: 810px; height: 20px;">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>
        <br />
        <table border="0" width="100%">
            <tr>
                <td align="right" style="width: 266px">
                    信息类型：</td>
                <td align="left" style="height: 21px">
                    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
                    <asp:DropDownList ID="NewType" runat="server" Width="72px">
                        <asp:ListItem Value="a">请选择</asp:ListItem>
                        <asp:ListItem Value="0">系统通知</asp:ListItem>
                        <asp:ListItem Value="1">热销</asp:ListItem>
                        <asp:ListItem Value="2">内部公告</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查询" />
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
            </tr>
        </table>
        <br />
     <table border="0"  width="100%">
     <tr>
     
     <td ></td>
     <td width="750px"> 
     
     
      <table width="800"   class="flexme2">
	<thead>
    		<tr >
            	<th width="150" >
                    时间</th>
            	<th width="450">
                    标题</th>
   
                <th width="100">
                    发布人</th>
                <th width="50">
                  </th>
               
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	
            	<td><%#Eval("CreateDate")%> </td>
            	<td><a target="_blank" href="Notice_Detail.aspx?NoticeID=<%#Eval("NoticeID")%>"><%#Eval("Title")%> </a></td>
            	<td><%#Eval("UserName")%></td>
            	
    		     <td></td>
    		  
    		</tr>
        
        </ItemTemplate>
        </asp:Repeater>
      
    		
    </tbody>
</table>

     
     </td>
     <td width="10%"></td>
     
     </tr>
   
     </table>
 <script type="text/javascript">



			$('.flexme2').flexigrid();
			///$('.flexme2').flexigrid({height:'auto',striped:false});


</script>
<cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
            backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
            pagesize="10" showfirstlast="true" showpagenumbers="true"></cc1:collectionpager>

        </div>
        <br />
        
    </form>
</body>
</html>
