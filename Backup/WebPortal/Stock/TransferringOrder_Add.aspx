<%@ Page Language="C#" AutoEventWireup="true" Inherits="Stock_TransferringOrder_Add" Codebehind="TransferringOrder_Add.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
        <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../js/skin/qq/ymPrompt.css" /> 
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
    <script type="text/javascript" src="../js/ymPrompt.js"></script> 
   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/jquery.blockUI.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
   
    <style type="text/css">
    #addMian_b {width:940px;height:275px;background:#000;-moz-opacity:0.2; filter:alpha(opacity=25);margin:-30px 10 0 10px; position:absolute;}
#addMian_t { z-index:20;border:1px solid #a4d5e3;width:920px;height:275px;background:#FFF;margin:-15px 0 10 5px; position:absolute;}
body {
	margin-left: 10px;
	margin-top: 10px;
}
    
    </style>
    
            <script type="text/javascript">
              
              //选择出库
            function gysSelect()
            {
                var Url="../Stock/Detop_CommonWindow.aspx";
                var result=window.showModalDialog(Url,'','dialogWidth:400px;status:no;dialogheight:500px');   
                if(result!=null)
                { 
                var val=result.split('$$$');
                //document.getElementById("StoreHouseID").value=val[0]; 
                document.getElementById("OutHouseID").value=val[1]; 


                }else
                {

                }

            }
            //选择入库区
            function gysSelectIn()
            {
               var Url="../Stock/Detop_CommonWindow.aspx";
                var result=window.showModalDialog(Url,'','dialogWidth:400px;status:no;dialogheight:500px');   
                if(result!=null)
                { 
                var val=result.split('$$$');
                //document.getElementById("StoreHouseID").value=val[0]; 
                document.getElementById("InHouseID").value=val[1]; 


                }else
                {

                }

            
            }
            
            ///选择商品
            function productsSelect()
            {
            
                var Url="../Products/NQ_Products_CommonWindow.aspx";
                var result=window.showModalDialog(Url,'','dialogWidth:590px;status:no;dialogheight:500px');   
                if(result!=null)
                { 
                var val=result.split('$$$');
                document.getElementById("ProductsID").value=val[0]; 
                //document.getElementById("ProductsName").value=val[1]; 


                }else
                {

                }
            
            }
            
        function check()
        {
           
            var  NQuantity = document.getElementById("Quantity");
            var  NPrice = document.getElementById("Price");
           
            if(NQuantity.value=="")
            {
                alert("请输入商品数量");
               
			    return false;
            }
            if(!/^\d+$/.test(NQuantity.value))
            {
                alert("数量应该是整数");
			   return false;
            }
            if(!/^(-|\+)?\d+(\.\d+)?$/.test(NPrice.value))
            {
              
               alert('商品价格输入有误');
			   return false;
            }
            if(NPrice.value < 0)
            {  
               alert('商品价格不能是负的');
              
			   return false;
            }
            return true;
            
        }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
        
    <div>
    <asp:Panel ID="Panel1" runat="server">
    <div id="addMian_t" style="left: 0px; top: 10px; height: 248px">
      <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 100%! important; BORDER-BOTTOM: #a4d5e3 1px solid; height: 171px;">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">&nbsp;
      
          <asp:SiteMapPath ID="SiteMapPath1" runat="server">
          </asp:SiteMapPath>
      
      </H2>
     
      <DIV style="MARGIN: 5px">
   
 
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 style="height: 202px" >
  <TBODY>
  <TR>
    <TD class=title align=middle style="height: 39px"> 库 存 调 拨</TD></TR>
  <TR>
    <TD bgColor=#ffffff style="height: 118px" valign="top">
      <TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD bgColor=#ffffff style="width: 297px; height: 9px;">
              单号：<asp:TextBox ID="TransferringOrderID" runat="server" Width="150px" CssClass="txt_left" ReadOnly="True"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="width: 270px; height: 9px;">制单日期：
              <asp:TextBox ID="Date" runat="server" Width="99px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              </TD>
          <TD bgColor=#ffffff style="height: 9px; width: 418px;">
              经办人： &nbsp;&nbsp;
              <asp:TextBox ID="Operator" runat="server" CssClass="txt_left"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 9px"></TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 12px">
             调出仓库分区 &nbsp; &nbsp; &nbsp; &nbsp;<asp:TextBox ID="OutHouseID"  runat="server" Width="76px" CssClass="txt_left"></asp:TextBox>
              &nbsp; &nbsp;&nbsp; &nbsp;
              <INPUT class="input" onclick="gysSelect()" type=button value=引用 name="yyBtn0" id="gyshButtun">
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="OutHouseID"
                  ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></TD>
          <TD bgColor=#ffffff style="height: 12px; width: 418px;">
              执行日期：<asp:TextBox ID="TradeDate" runat="server" Width="90px" CssClass="txt_left"></asp:TextBox>&nbsp;
              <IMG 
            style="CURSOR: hand" 
            onclick="fPopUpCalendarDlg(TradeDate);return false;" height=16 
            alt=弹出日历下拉菜单 src="../images/calendar.gif" width=16></TD>
          <TD bgColor=#ffffff style="height: 12px"> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 30px">调入仓库分区 &nbsp; &nbsp; &nbsp; &nbsp;<asp:TextBox ID="InHouseID" runat="server" Width="76px" CssClass="txt_left"></asp:TextBox>&nbsp;&nbsp;&nbsp;
              <INPUT class="input" onclick="gysSelectIn()" type=button value=引用 name="yyBtn0" id="Button1">
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="InHouseID"
                  ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator></TD>
          <TD bgColor=#ffffff style="height: 30px; width: 418px;">票号 &nbsp;
              <asp:TextBox ID="Ticket" runat="server" CssClass="txt_left"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 30px"> </TD></TR>
            <tr>
                <td bgcolor="#ffffff" colspan="2" style="height: 26px">
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;商品： &nbsp; &nbsp; &nbsp; 
                    <asp:TextBox ID="ProductsID" runat="server" Width="54px" CssClass="txt_left"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;<INPUT class="input" onclick="productsSelect()" type=button value=引用 name="yyBtn0" id="Button2">&nbsp; 
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ProductsID"
                        ErrorMessage="<img src=../images/false.gif  />不能为空"></asp:RequiredFieldValidator>&nbsp; &nbsp;&nbsp; 数量： &nbsp; &nbsp; &nbsp; 
                    <asp:TextBox ID="Quantity" runat="server" Width="65px" CssClass="txt_left"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Quantity"
                        ErrorMessage="<img src=../images/false.gif  />"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="Quantity"
                        ErrorMessage="输入有误" MaximumValue="10000" MinimumValue="0" Type="Integer"></asp:RangeValidator> </td>
                <td bgcolor="#ffffff" style="width: 418px; height: 26px">
                    单价：<asp:TextBox ID="Price" runat="server" Width="126px" CssClass="txt_left">0.00</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="Price"
                        ErrorMessage="<img src=../images/false.gif  />"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationExpression="^[0-9]*\.?[0-9]{0,2}$" runat="server" ErrorMessage="输入有误" ControlToValidate="Price"></asp:RegularExpressionValidator></td>
                <td bgcolor="#ffffff" style="height: 26px">
                </td>
            </tr>
        <TR>
          <TD bgColor=#ffffff colSpan=3 style="height: 28px">备&nbsp;&nbsp;&nbsp;&nbsp;注： &nbsp;&nbsp;&nbsp;
              <asp:TextBox ID="Description" runat="server" Width="609px" CssClass="txt_left"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 28px"> </TD></TR>
            <tr>
                <td align="center" bgcolor="#ffffff" colspan="3" style="height: 28px">
                    <asp:Button ID="AddSubmit" runat="server" Text="提 交" Width="122px"  OnClick="AddSubmit_Click" /></td>
                <td align="center" bgcolor="#ffffff" style="height: 28px">
                </td>
            </tr>
        </TBODY></TABLE></TD></TR>
  </TBODY></TABLE>
    
      </DIV></DIV>
      
   </div>
   
    <div id="addMian_b"   >
  </div>
  
  </asp:Panel>
  
  <asp:Panel ID="Panel2" Visible="false" runat="server" Height="50px" Width="125px">
  
            
      <asp:HyperLink ID="HyperLink1"  NavigateUrl="~/Stock/Manager_TransferringOrder.aspx" runat="server">操作成功 返回列表</asp:HyperLink></asp:Panel>
    </div>
    </form>
</body>
</html>
