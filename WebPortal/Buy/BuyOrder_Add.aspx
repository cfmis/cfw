<%@ Page Language="C#" AutoEventWireup="true" Inherits="Buy_BuyOrder_Add" Codebehind="BuyOrder_Add.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添 加 采 购 订 单</title>
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
#addMian_t { z-index:20;border:1px solid #a4d5e3;width:920px;height:275px;background:#FFF;margin:-15px 0 0 5px; position:absolute;}
body {
	margin-left: 10px;
	margin-top: 10px;
}
    
    </style>
    

    <script type="text/javascript">
    
    
function  ajaxSubmit() {
    
            var  NBuyOrderID = document.getElementById("BuyOrderID");
            var  NProductsID = document.getElementById("ProductsID");
            var  NProductsNum = document.getElementById("Quantity");
            var  NPrice = document.getElementById("Price");
            var  NTaxRate = document.getElementById("TaxRate");
            var  NDiscountRate = document.getElementById("DiscountRate");
            var  NDescriptions = document.getElementById("Descriptions");
            var  NSupplier=document.getElementById("SupplierID");
            var xmlHttp=this.createXmlHttp();
            
         if(NProductsID.value=="")
            {
               
			    alert('请选择商品');
		         return false;
            }
            if(NProductsNum.value=="")
            {
                alert("请输入商品数量");
             
			    return false;
            }
            if(!/^\d+$/.test(NProductsNum.value))
            {
               alert("商品数量应该是整数");
			   return false;
            }
            
            if(NProductsNum.value < 1)
            {
               alert("商品数量应该不小于 1");
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
            
             if(NSupplier.value =="")
            {  
             alert('请选择供应商！');
              
			   return false;
            }
            
            
            
            
            if( !/^(-|\+)?\d+(\.\d+)?$/.test(NTaxRate.value) )
            {  
               alert('税率输入有误');
              
			   return false;
            }
            
            if( NTaxRate.value > 50 )
            {  
              alert('税率输入过大');
              
			   return false;
            }
            
            if(!/^(-|\+)?\d+(\.\d+)?$/.test(NDiscountRate.value))
            {  
               alert('折扣率输入有误');
              
			   return false;
            }
             if(NDiscountRate.value > 99)
            {  
               alert('折扣率输入不应大于 100');
              
			   return false; 
            }
            
            
            $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
            
            var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   
                   //alert( xmlHttp.responseText);
                   document.getElementById("initSubmitInfo").innerHTML=xmlHttp.responseText;
                   $('.flexme2').flexigrid();
                   ajaxSubmited();
                   $.unblockUI();//
                   
                }
            }
            xmlHttp.open("POST", "AjaxBuyDetail_Add.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("Action=add&BuyOrderID="+NBuyOrderID.value+"&ProductsID="+NProductsID.value+"&SupplierID="+NSupplier.value+"&Price="+NPrice.value+"&Quantity="+NProductsNum.value+"&TaxRate="+NTaxRate.value+"&DiscountRate="+NDiscountRate.value+"&Descriptions="+NDescriptions.value+"");//   
            
         }
 
 //
 function deleteDetail(id)
 {
    var  NBuyOrderID = document.getElementById("BuyOrderID");
    
     $.blockUI({message:"<img src=\"../images/load.gif\" /> "});//阴影
    var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   
                    //alert( xmlHttp.responseText);
                   document.getElementById("initSubmitInfo").innerHTML=xmlHttp.responseText;
                    $('.flexme2').flexigrid();
                    $.unblockUI();//
                    ajaxSubmited();
                   
                }
            }
            xmlHttp.open("POST", "AjaxBuyDetail_Add.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("Action=del&BuyOrderID="+NBuyOrderID.value+"&DetailID="+id);//   
     
 
 }   
 
          
     ///明细表单提交后，清空输入框中的值
 function  ajaxSubmited()
 {
     document.getElementById("ProductsID").value="";
     document.getElementById("ProductsName").value="";
     document.getElementById("Quantity").value="";
     document.getElementById("Price").value="";
     document.getElementById("TaxRate").value="";
     document.getElementById("DiscountRate").value="";
     document.getElementById("Descriptions").value="";
     document.getElementById("SupplierID").value="";
     document.getElementById("SupplierName").value="";
   
     
 }
      
 
 function loadpage()
 {
          var  sBuyOrderID=document.getElementById("BuyOrderID").value;
           var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   
                    //alert( xmlHttp.responseText);
                   document.getElementById("initSubmitInfo").innerHTML=xmlHttp.responseText;
                    $('.flexme2').flexigrid();
                   
                   
                }
            }
            xmlHttp.open("POST", "AjaxBuyDetail_Add.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("Action=load&BuyOrderID="+sBuyOrderID);//   
     
 
 }     
         
         

function selectSupplier() {

var Url="../Supplier/NQ_Supplier_CommonWindow.aspx";
    var result=window.showModalDialog(Url,'','dialogWidth:590px;status:no;dialogheight:500px');   
    if(result!=null)
    { 
      var val=result.split('$$$');

      document.getElementById("SupplierID").value=val[0];
      document.getElementById("SupplierName").value=val[1]; 
 
     
    }else
    {
      
    }

}


function yinyong_onclick() {

    var Url="../Products/NQ_Products_CommonWindow.aspx";
    var result=window.showModalDialog(Url,'','dialogWidth:590px;status:no;dialogheight:500px');   
    if(result!=null)
    { 
       var val=result.split('$$$');
       document.getElementById("ProductsID").value=val[0]; 
       document.getElementById("ProductsName").value=val[1]; 
      
     
    }else
    {
      
    }


}

function gysSelect()
{
  var Url="../Stock/Detop_CommonWindow.aspx";
    var result=window.showModalDialog(Url,'','dialogWidth:400px;status:no;dialogheight:500px');   
    if(result!=null)
    { 
       var val=result.split('$$$');
       document.getElementById("StoreHouseID").value=val[0]; 
       document.getElementById("HouseDetailID").value=val[1]; 
      
     
    }else
    {
      
    }

}

function checkTaxRate(node)
{
       if(!/^(-|\+)?\d+(\.\d+)?$/.test(node.value))
        {
	       node.value="0.00";
        }
        if(node.value=="")
        { 
        node.value="0.00";
        }
        if(node.value >99)
        {
          node.value="0.00";
        }
        if(node.value < 0)
        {
          node.value="0.00";
        }
        
}

function checkQuantity(node)
{
     if(!/^\d+$/.test(node.value))
        {
	       node.value="0";
        }
        if(node.value=="")
        { 
        node.value="0";
        }
        if(node.value < 0)
        {
          node.value="0";
        }
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
<body onload="loadpage()">
    <form id="form1" runat="server">
    <br />


        <div id="addMian_t" style="left: 0px; top: 10px; height: 248px">
            <br />
            &nbsp; &nbsp;
            <asp:SiteMapPath ID="SiteMapPath1" runat="server">
            </asp:SiteMapPath>
            <br />
      <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 100%! important; BORDER-BOTTOM: #a4d5e3 1px solid; height: 171px;">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">&nbsp;
      
      </H2>
     
      <DIV style="MARGIN: 5px">
   
 
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 style="height: 202px" >
  <TBODY>
  <TR>
    <TD class=title align=middle height=50>添 加 采 购 订 单&nbsp;</TD></TR>
  <TR>
    <TD bgColor=#ffffff style="height: 118px" valign="top">
      <TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD bgColor=#ffffff style="width: 205px; height: 9px;">订单编号：<asp:TextBox ID="BuyOrderID" runat="server" Width="125px" CssClass="txt_left" ReadOnly="True"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="width: 270px; height: 9px;">制单日期：
              <asp:TextBox ID="BuyOrderDate" runat="server" Width="99px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              <asp:Label ID="side" runat="server" Text="new" Width="41px" Visible="False"></asp:Label></TD>
          <TD bgColor=#ffffff style="height: 9px; width: 197px;">
              业务代表<asp:TextBox ID="Delegate" runat="server" Width="78px" CssClass="txt_left"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 9px">
              <asp:Image ID="Image1" runat="server" ImageUrl="~/images/AlertIcon.gif" />
              <asp:Label ID="Label1" runat="server" Text="没有提交"></asp:Label></TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 13px">
              &nbsp;库房：<asp:TextBox ID="StoreHouseID" runat="server" Width="69px" CssClass="txt_left"></asp:TextBox>
              库区：<asp:TextBox ID="HouseDetailID" runat="server" Width="55px" CssClass="txt_left"></asp:TextBox>
              <INPUT class="input" onclick="gysSelect()" type=button value=引用 name="yyBtn0" id="Button3">
              <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="HouseDetailID"
                  ErrorMessage="<img src=../images/false.gif  />请选择"></asp:RequiredFieldValidator></TD>
          <TD bgColor=#ffffff style="height: 13px; width: 197px;">签订日期：<asp:TextBox ID="SignDate" runat="server" Width="90px" CssClass="txt_left"></asp:TextBox>&nbsp;
              <IMG 
            style="CURSOR: hand" 
            onclick="fPopUpCalendarDlg(SignDate);return false;" height=16 
            alt=弹出日历下拉菜单 src="../images/calendar.gif" width=16></TD>
          <TD bgColor=#ffffff style="height: 13px">交货日期：<asp:TextBox ID="TradeDate" runat="server" Width="79px" CssClass="txt_left"></asp:TextBox>
              <IMG 
            style="CURSOR: hand" 
            onclick="fPopUpCalendarDlg(TradeDate);return false;" height=16 
            alt=弹出日历下拉菜单 src="../images/calendar.gif" width=16> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 30px">交货地址：
              <asp:TextBox ID="TradeAddress" runat="server" Width="271px" CssClass="txt_left"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 30px; width: 197px;">合计金额：<asp:TextBox ID="TotalPrice" runat="server" CssClass="txt_left" ReadOnly="True">0.00</asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 30px"> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=3 style="height: 34px">备&nbsp;&nbsp;&nbsp;&nbsp;注：
              <asp:TextBox ID="Description" runat="server" Width="484px" CssClass="txt_left"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 34px"> 
              <asp:Button ID="AddButton" runat="server" Text="添 加" Width="84px" OnClick="AddButton_Click"/>
              <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="完成所有" Visible="False" /></TD></TR></TBODY></TABLE></TD></TR>
  </TBODY></TABLE>
    
      </DIV></DIV>
      
   </div>
   
    <div id="addMian_b" style="height: 226px"  >
  </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <DIV 
style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(../images/content_bg1.gif) repeat-x 50% bottom; FLOAT: left; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 925px; BORDER-BOTTOM: #a4d5e3 1px solid; HEIGHT: 122px"><DIV style="MARGIN: 5px">
<table border="0" style="width: 908px; height: 77px">
  <tr>
    <td height="24" style="width: 50px">商品：</td>
    <td style="width: 212px">&nbsp;<input id="ProductsName" style="width: 71px" type="text" class="txt_left" />
        <input id="ProductsID" style="width: 17px" type="hidden" />
        <input id="yinyong" type="button" value="引用" onclick="return yinyong_onclick()" /></td>
    <td width="55">价钱</td>
    <td style="width: 172px">&nbsp;<input id="Price" onblur="checkPrice(this)" style="width: 99px" type="text" class="txt_left" />RMB</td>
    <td style="width: 79px"><p >数量</p></td>
    <td style="width: 204px">&nbsp;<input id="Quantity" onblur="checkQuantity(this)" style="width: 83px" type="text" class="txt_left" value="0" /></td>
  </tr>
  <tr>
    <td style="width: 50px; height: 39px;"><p >税率&nbsp;%</p></td>
    <td style="height: 39px; width: 212px;">&nbsp;<input id="TaxRate" onblur="checkTaxRate(this)" style="width: 105px" type="text" class="txt_left" value="0.00" /></td>
    <td style="height: 39px"><p >
        折扣率%</p></td>
    <td style="height: 39px; width: 172px;">&nbsp;<input id="DiscountRate" onblur="checkTaxRate(this)" style="width: 99px" type="text" class="txt_left" value="0" /></td>
    <td style="height: 39px; width: 79px;">&nbsp;供 应 商：</td>
    <td style="width: 204px; height: 39px;">&nbsp;
    
   
    <input id="SupplierName" style="width: 71px" type="text" class="txt_left" />
        <input id="SupplierID" style="width: 17px" type="hidden" />
    
              <INPUT class=input  onclick="selectSupplier()"; type=button value=引用 name=yyBtn id="Button2"></td>
  </tr>
  <tr>
    <td height="22" style="width: 50px">描述：</td>
    <td colspan="5">&nbsp;<input id="Descriptions" type="text" style="width: 458px" class="txt_left" />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <img src="../images/Save.gif" id="IMG1" onclick="return ajaxSubmit()" /></td>
  </tr>
</table>
    &nbsp;</DIV></DIV>
        <br />
        <br />
          <br />
        <br />
          <br />
        <br />
          <br />
        <br />
          <br />
        <br />
          <br />
      
           
        <DIV id="initSubmitInfo" style="width:100%">
        
        
</DIV>
<script type="text/javascript" >
     
   </script>
        <br />
        <br />
        <br />
        <br />
    
 
  
    </form>
</body>
</html>
