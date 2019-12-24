<%@ Page Language="C#" AutoEventWireup="true" Inherits="Buy_BuyPay_Add" Codebehind="BuyPay_Add.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
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
#addMian_t { z-index:20;border:1px solid #a4d5e3;width:920px;height:275px;background:#FFF;margin:-15px 0 50 5px; position:absolute;}
body {
	margin-left: 10px;
	margin-top: 10px;
}
    
    </style>
    
            <script type="text/javascript">
                     
            
///选择订单
function OrderIDsel()
{
   var Url="NQ_BuyReceipt_CommonWindows.aspx";
    var result=window.showModalDialog(Url,'','dialogWidth:1000px;status:no;dialogheight:600px');   
    if(result!=null)
    { 
       var val=result.split('$$$');
       document.getElementById("BuyReceiptID").value=val[0]; 
       //document.getElementById("StoreHouseID").value=val[1]; 
       //document.getElementById("HouseDetailID").value=val[2]; 
      /// document.getElementById("IdentitysH").value="0"; 
      getCost();
     
    }else
    {
     
    }


}
  
  //根据库区 和 商品得到数量        
function getCost()
{
   var NUM="0";
   var  NBuyReceiptID = document.getElementById("BuyReceiptID");
   $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
              var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   
                     setCost(xmlHttp.responseText);
                      $.unblockUI();// 
                     
                }
            }
    xmlHttp.open("GET", "AjaxResp.aspx?action=BuyPayLoad&BuyReceiptID="+NBuyReceiptID.value, true);
    xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlHttp.send(null);//      

}

function setCost(str)
{
 var val=str.split('$$$');
 document.getElementById("TotalCost").value=val[0];
 document.getElementById("havePay").value=val[1];
 
}
            
 function submitAdd()
        {
           
            var  NBuyReceiptID = document.getElementById("BuyReceiptID");
            var  NTicket = document.getElementById("Ticket");
            var  NCreateDate = document.getElementById("CreateDate");
            var  NPayType = document.getElementById("PayType");
            var  NRealPay = document.getElementById("RealPay");
            var  NAttachPay = document.getElementById("AttachPay");
            var  NDescription = document.getElementById("Description");
           
            if(NBuyReceiptID.value=="")
            {
                alert("请选择采购入库单");
               
			    return false;
            }
             if(NRealPay.value=="")
            {
                alert("请填写本次支付金额");
               
			    return false;
            }
            
             if(NPayType.value=="")
            {
                alert("请填写支付类型");
               
			    return false;
            }
            
            if( !/^(-|\+)?\d+(\.\d+)?$/.test(NRealPay.value) )
            {  
              alert('金额输入有误');
              
			   return false;
            }
             if( !/^(-|\+)?\d+(\.\d+)?$/.test(NAttachPay.value) )
            {  
              alert('附加金额输入有误');
              
			   return false;
            }
            
            if(NRealPay.value < 0)
            {
                alert("金额应该不小于0");
			   return false;
            } 
              $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影       
            var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   
                      ajaxSubmited();
                      $.unblockUI();// 
                     
                }
            }
        xmlHttp.open("GET", "AjaxResp.aspx?action=BuyPayLoadAdd&BuyReceiptID="+NBuyReceiptID.value+"&Ticket="+NTicket.value+"&CreateDate="+NCreateDate.value+"&PayType="+NPayType.value+"&RealPay="+NRealPay.value+"&AttachPay="+NAttachPay.value+"&Description="+NDescription.value, true);
        xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        xmlHttp.send(null);//           
           
            
            
        }
        
function ajaxSubmited()
        {

                this.document.getElementById("BuyReceiptID").value="";
                this.document.getElementById("Ticket").value="";
                this.document.getElementById("PayType").value="";
                this.document.getElementById("RealPay").value="";
                this.document.getElementById("AttachPay").value="";
                
                this.document.getElementById("TotalCost").value="";
                this.document.getElementById("havePay").value="";

        }
        
        
function checkPrice(node)
        {
        if(!/^(-|\+)?\d+(\.\d+)?$/.test(node.value))
        {
           node.value="0.00";
        }
        if(node.value=="")
        { 
        node.value="0.00";
        }
       
        if(node.value < 0)
        {
          node.value="0.00";
        }

        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        
    <div>
    <br />
    <asp:Panel ID="Panel1" runat="server">
    <div id="addMian_t" style="left: 0px; top: 10px; height: 248px">
      <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 100%! important; BORDER-BOTTOM: #a4d5e3 1px solid; height: 171px;">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">&nbsp;
      
      &nbsp;&nbsp;<asp:SiteMapPath ID="SiteMapPath1" runat="server">
          </asp:SiteMapPath>
      </H2>
     
      <DIV style="MARGIN: 5px">
   
 
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 style="height: 202px" >
  <TBODY>
  <TR>
    <TD class=title align=middle style="height: 39px"> 采 购 付 款</TD></TR>
  <TR>
    <TD bgColor=#ffffff style="height: 118px" valign="top">
      <TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD bgColor=#ffffff style="width: 462px; height: 9px;">
              采购单号：<asp:TextBox ID="BuyReceiptID" runat="server" Width="150px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
                    <INPUT class="input" onclick="OrderIDsel()" type=button value=引用 name="yyBtn0" id="Button2"></TD>
          <TD bgColor=#ffffff style="width: 269px; height: 9px;">制单日期：
              <asp:TextBox ID="CreateDate" runat="server" Width="99px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              </TD>
          <TD bgColor=#ffffff style="height: 9px; width: 418px;">
              票    号： &nbsp;&nbsp;
              <asp:TextBox ID="Ticket" runat="server" CssClass="txt_left">无</asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 9px"></TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 12px">
              单据总额：<asp:TextBox ID="TotalCost" runat="server" CssClass="txt_left" ReadOnly="True"
                  Width="90px"></asp:TextBox>
              &nbsp; &nbsp; &nbsp;已付总额
              <asp:TextBox ID="havePay" runat="server" CssClass="txt_left" ReadOnly="True" Width="90px"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 12px; width: 418px;">
              支付类型 &nbsp;&nbsp;
              <asp:TextBox ID="PayType" runat="server" CssClass="txt_left" Width="136px">银行汇款</asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 12px"> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 30px">
              本次实付金额 &nbsp; &nbsp;&nbsp; 
              <input id="RealPay" onblur="checkPrice(this)" style="width: 92px" type="text" class="txt_left" value="0.00" />
                    &nbsp;
              附加金额
              <input id="AttachPay" onblur="checkPrice(this)" style="width: 92px" type="text" class="txt_left" value="0.00" />
             
              (由于各种因素所花的费用 不用于计算)</TD>
          <TD bgColor=#ffffff style="height: 30px; width: 418px;"></TD>
          <TD bgColor=#ffffff style="height: 30px"> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=3 style="height: 28px">备&nbsp;&nbsp;&nbsp;&nbsp;注： &nbsp;&nbsp;&nbsp;
              <asp:TextBox ID="Description" runat="server" Width="609px" CssClass="txt_left"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 28px"> </TD></TR>
            <tr>
                <td align="center" bgcolor="#ffffff" colspan="3" style="height: 28px">
                    <input id="Button1" onclick="javascript:if(!confirm('您确定要删除吗'))return  false;submitAdd()" type="button" value="提  交" /></td>
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

