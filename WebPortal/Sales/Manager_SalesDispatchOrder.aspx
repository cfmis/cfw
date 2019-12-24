<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_Manager_SalesDispatchOrder" Codebehind="Manager_SalesDispatchOrder.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc2" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>发货管理</title>
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
 window.open("MySalesDispatchEditSent.aspx?DispatchID="+text+"&fromUrl="+url,null,"height=300,width=700,status=no,toolbar=no,menubar=no,location=no,resizable=no,scroll=no");     
    
    }
 
   //选择捡货图示打印
function openSelectImgWin()
{
  var selData=document.getElementById("selectImgData").value;
  
  window.open("SelectProductsByImg.aspx?Data="+selData,"捡货图示打印",null,'location=no,height=100%,width=100%');
}
    
    </script>
</head>
<body>
    <form id="form2" runat="server">
    <div align="center" >
        <table style="width: 97%">
            <tr>
                <td align="left" style="width: 810px; height: 20px">
                    &nbsp;<asp:SiteMapPath ID="SiteMapPath1" runat="server">
                    </asp:SiteMapPath>
                </td>
                <td align="left" style="width: 810px; height: 20px">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                </td>
            </tr>
        </table>
        <table style="width: 97%">
            <tr>
                <td align="right" style="width: 799px; height: 18px">
                    &nbsp; &nbsp; &nbsp; &nbsp;<input id="Button2" onclick="document.location.href='PrintOrderInfo.aspx'" type="button"
                        value="发货单打印" /></td>
                <td align="left" style="width: 810px; height: 18px">
                    &nbsp;按时间
                    <asp:TextBox id="selectImgData" runat="server" Width="83px" ReadOnly="True"></asp:TextBox>
                    <img src="../images/calendar.gif" onclick="fPopUpCalendarDlg(selectImgData);return false;" />&nbsp;
                    <input id="Button3" type="button" onclick="openSelectImgWin()" value="捡货图示打印" /></td>
            </tr>
        </table>
        <br />
    <DIV class=bar>
  <table border="0" style="width: 960px; height: 19px">
    <tr>
     <td style="width: 118px; height: 5px;" align="right">
         &nbsp; &nbsp; &nbsp; &nbsp; 应发日期 &nbsp; &nbsp; &nbsp;&nbsp;
     </td>
     <td style="width: 149px; height: 5px;">
     从:
         <asp:TextBox ID="baginData" runat="server" Width="83px"></asp:TextBox><img src="../images/calendar.gif" onclick="fPopUpCalendarDlg(baginData);return false;" /> </td>
      <td style="width: 140px; height: 5px;"> 
      至:
          <asp:TextBox ID="endData" runat="server" Width="92px"></asp:TextBox>
          <img src="../images/calendar.gif" onClick="fPopUpCalendarDlg(endData);return false;" />
      </td>
      <td style="width: 135px; height: 5px;">
          <asp:DropDownList ID="side" runat="server" Width="112px">
              <asp:ListItem Value="0">未发货</asp:ListItem>
                 
              <asp:ListItem Value="1">已发货未付款</asp:ListItem>
               <asp:ListItem Value="2">发货完成付款</asp:ListItem>
              <asp:ListItem Value="3">问题件</asp:ListItem>
          </asp:DropDownList>
          &nbsp;&nbsp;&nbsp;&nbsp;
      </td>
      <td style="width: 228px; height: 5px;">
          <asp:Button ID="Select" runat="server"
              Text="查询" OnClick="Select_Click" Width="49px" />
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</td>
    </tr>
  </table>
</DIV>
<table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px; height: 38px;">
    管理发货单
</td>
</tr>
</table>
<table style="width:900px;" >
    <tr>
        <td align="center"  >

    <table width="830"  class="flexme2">
	<thead>
    		<tr>
            	<th width="40"  >发货</th>
              <th width="60"  >修改</th>
            	<th width="140"  >
                    销售出库单</th>
            	<th width="100">
                    应发日期</th>


            	<th width="100"  >配送方式</th>
            	<th width="100"  >已经打单</th>
            	<th width="100" >状态</th>
                <th width="150"  >备注描述</th>
    		    <th width="30"  ></th>
    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	<td><img src="../images/tbtn_calendar.gif" alt="编辑发货" onclick="openwinEdit('<%#Eval("DispatchID")%>')" /></td>
            	<td> <a  href="SalesDispatch_Edit.aspx?DispatchID=<%#Eval("DispatchID")%>"> <img src="../images/Edit.gif" border="0" alt="编辑"   /> </a>
            	    </td>
            	<td> <a target="_blank" href="SalesOut_Detail.aspx?SalesOutID=<%#Eval("SalesOutID")%>"><%#Eval("SalesOutID")%></a>
            	</td>
            	<td><%#Eval("DeliveryDate")%> </td>
            	
            	<td><%#Eval("DeliveryName")%></td>
            	<td><%# checkPrint(Eval("PrintFlag").ToString())%></td>
            	<td><%# changString(Eval("State").ToString())%></td>
            	<td><%#Eval("Description")%></td>
            

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

