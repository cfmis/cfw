<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_SalesOrder_Add" Codebehind="SalesOrder_Add.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>添 加 销 售 订 单</title>
    <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../js/skin/qq/ymPrompt.css" /> 
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
    <script type="text/javascript" src="../js/ymPrompt.js"></script> 
   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/jquery.blockUI.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
   
    <style type="text/css">
    #addMian_b {width:940px;height:320px;background:#000;-moz-opacity:0.2; filter:alpha(opacity=25);margin:-30px 10 0 10px; position:absolute;}
#addMian_t { z-index:20;border:1px solid #a4d5e3;width:920px;height:320px;background:#FFF;margin:-15px 0 0 5px; position:absolute;}
body {
	margin-left: 10px;
	margin-top: 10px;
}
    </style>
     <script type="text/javascript">
    
    
function  ajaxSubmit() {
    
            var  NID = document.getElementById("SalesOrderID");
            var  NProductsID = document.getElementById("ProductsID");
            var  NProductsNum = document.getElementById("Quantity");
            var  NPrice = document.getElementById("Price");
            var  NDiscountRate = document.getElementById("DiscountRate");
            var  NDescriptions ="无";
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
            if(NDiscountRate.value < 0)
            {  
               alert('折扣率输入不应小于0');
              
			   return false; 
            }
            
            $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
            
            var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   loadpage();
                   ajaxSubmited();
                   $.unblockUI();// 
                }
            }
            xmlHttp.open("POST", "AjaxSalesOrderLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=addDetail&SalesOrderID="+NID.value+"&ProductsID="+NProductsID.value+"&Price="+NPrice.value+"&Quantity="+NProductsNum.value+"&DiscountRate="+NDiscountRate.value+"&Descriptions="+NDescriptions.value+"");//   
            
         }
 
   
 
          
     ///明细表单提交后，清空输入框中的值
 function  ajaxSubmited()
 {
     document.getElementById("ProductsID").value="";
     document.getElementById("Quantity").value="0";
     document.getElementById("Price").value="0";
     document.getElementById("DiscountRate").value="0";
     document.getElementById("ProductsName").value="";
     
     var inum= document.getElementById("checkRecode").value;
     inum=inum+1;
     
     document.getElementById("checkRecode").value=inum;
     updateAttachPay();
     
   
     
 }
      
 
 function loadpage()
 {
          var  sSalesOrderID=document.getElementById("SalesOrderID").value;
           var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   
                    //alert( xmlHttp.responseText);
                   document.getElementById("initSubmitInfo").innerHTML=xmlHttp.responseText;
                    $('.flexme2').flexigrid();
                   
                   
                }
            }
            xmlHttp.open("POST", "AjaxSalesOrderLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=LoadDetail&SalesOrderID="+sSalesOrderID);//   
     
 
 }     
         
//删除详细入库项
function deleteDetail(str)
{ 
  
    
    var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
               
                if (xmlHttp.readyState == 4) {
                     deleted();
                     loadpage();
                     
                }
            }
            xmlHttp.open("POST", "AjaxSalesOrderLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=delDetail&DetailID="+str);//   

}   
 
 ///删除详细后
function deleted()
{
  var inum= document.getElementById("checkRecode").value;
     inum=inum-1;
     
     document.getElementById("checkRecode").value=inum;
     updateAttachPay();
}


//选择商品。
function yinyong_onclick() {

    var Url="../Products/NQ_Products_CommonWindow.aspx";
    var result=window.showModalDialog(Url,'','dialogWidth:590px;status:no;dialogheight:500px');   
    if(result!=null)
    { 
       var val=result.split('$$$');
       document.getElementById("ProductsID").value=val[0]; 
       document.getElementById("ProductsName").value=val[1]; 
      
        setProductsPrice();
    }else
    {
      
    }
   


}
//根据用户类型得到商品的价格
function setProductsPrice()
{
           var  sProductsID=document.getElementById("ProductsID").value;
           var xmlHttp=this.createXmlHttp();  
           $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影                     
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {   
                   document.getElementById("Price").value=xmlHttp.responseText;
                   $.unblockUI();//
                   
                }
            }
            xmlHttp.open("POST", "AjaxSalesOrderLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=getProductsPrice&ProductsID="+sProductsID);//   
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
        }else
        {
          node.value=parseFloat(node.value);
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
        }else
        {
        node.value=parseFloat(node.value);
        }
        
  }

//提交所有
function checkheadTable()
{
  var node= document.getElementById("checkRecode");
  var node0=document.getElementById("CreateDate");
  var node1=document.getElementById("DeliveryType");
  
  var node2=document.getElementById("SalesOrderID");
  var node3=document.getElementById("CreateDate");
  var node4=document.getElementById("DeliveryPlace");
  var node5=document.getElementById("ClosingType");
  var node6=document.getElementById("ShopID");
  var node7=document.getElementById("AttachPay");
  var node8=document.getElementById("Description");
  var node9=document.getElementById("Discount");
  
  var node10=document.getElementById("CustomerID");
  var node101=document.getElementById("CustomerIDType").value;
  var node11=document.getElementById("CustomerName");
  var node12=document.getElementById("CustomerTel");
  var node13=document.getElementById("CustomerPost");
  var node14=document.getElementById("CustomerArea");
  var node15=document.getElementById("Platform");
  
  
   var node16=document.getElementById("PayInfo");
   var strs=node8.value;
   
   var customerIDstr=node101+node10.value;//区分聊号 QQ/旺旺...
   if(node16.value!="")
   {
     strs=strs+" ------>>>> 付款说明："+node16.value+" ";
  }
 
  if(node1.value =="")
  {
   alert("请选择交货方式");
   return false;
  }
  
  
  if(node4.value =="")
  {
   alert("请填写交货地址");
   return false;
  }
  
  
  if(node.value < 1)
  {
   alert("该订单还没有添加订购的商品");
   return false;
  }
  if(!customer_onclick())
  {
     return false;
  }
  
  
     var xmlHttp=this.createXmlHttp();  
     $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影                     
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {  
                   $.unblockUI();//
                   
                 
                  
                   
                }
            }
            xmlHttp.open("POST", "AjaxSalesOrderLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=addHeadTable&SalesOrderID="+node2.value+"&ClosingDate="+node0.value+"&DeliveryType="+node1.value+"&CreateDate="+node3.value+"&DeliveryPlace="+node4.value+"&ClosingType="+node5.value+"&ShopID="+node6.value+"&AttachPay="+node7.value+"&Description="+strs+"&Discount="+node9.value+"&CustomerID="+customerIDstr+"&CustomerName="+node11.value+"&CustomerTel="+node12.value+"&CustomerPost="+node13.value+"&CustomerArea="+node14.value+"&PlatformID="+node15.value+"");//   
    return true;
  
}



   
 //选择交货方式 
function setDeliveryTypeData(node)
{
       var va=node.value.split('$$$');
       document.getElementById("DeliveryType").value=va[0]; 
       document.getElementById("price1").value=va[1]; 
	   document.getElementById("price2").value=va[2]; 
	   updateAttachPay();
}

///更新运费总额0
function updateAttachPay()
{
         var  sSalesOrderID=document.getElementById("SalesOrderID").value;
           var xmlHttp=this.createXmlHttp();  
          
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {  
                   setAttachPay(xmlHttp.responseText);
                   
                   
                }
            }
            xmlHttp.open("POST", "AjaxSalesOrderLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=getQuantity&SalesOrderID="+sSalesOrderID);//   
}

//更新运费总额1
function setAttachPay(text)
{
  var totalPrice=0;
  var p1=document.getElementById("price1").value;
  var p2=document.getElementById("price2").value;
  var pr0=0;
  var pr1=0;
  if(parseInt(text)!=0)
  {  
     pr0=p1;
     pr1=(text-1)*p2;
     totalPrice=parseInt(pr0)+parseInt(pr1);
  }
  document.getElementById("AttachPay").value=totalPrice;
  orderTotalPrice();
}

//显示订单的合计金额
function orderTotalPrice()
{
         var  sSID=document.getElementById("SalesOrderID").value;
           var xmlHttp=this.createXmlHttp();  
          
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {  
                   setOrderTotalPrice(xmlHttp.responseText);
                   
                   
                }
            }
            xmlHttp.open("POST", "AjaxSalesOrderLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=getTotalPrice&SalesOrderID="+sSID);//   
}
function setOrderTotalPrice(text)
{    var texts0=document.getElementById("AttachPay").value;
     var texts1=document.getElementById("Discount").value;
     var totals=parseFloat(text)+parseFloat(texts0);
     document.getElementById("TotalPrice").value=totals-parseFloat(texts1);
}




//隐藏DeliveryTypeMenu
//检查填写顾客信息。
function customer_onclick() {
    var str0=document.getElementById("CustomerName").value;
     var str1=document.getElementById("CustomerID").value;
      var str2=document.getElementById("CustomerTel").value;
       var str3=document.getElementById("CustomerPost").value;
        var str4=document.getElementById("DeliveryPlace").value;
        var str5=document.getElementById("CustomerArea").value;
   if(str0=="")
   {
    alert("请填写顾客姓名");
    return false;
   }
   if(str1=="")
   {
    alert("请填写顾客聊号");
    return false;
   }
   
   if(str4=="")
   {
    alert("请填写顾客送货地址");
    return false;
   }
   
   if(str5=="")
   {
    alert("请填写顾客所在的地区");
    
    return false;
   }
   return true;
   
    
}

///完成顾客信息下一步操作  1
function checknext1()
{
  if(customer_onclick())
  {
    this.document.getElementById("nextInfo1").style.display='none';
    this.document.getElementById("nextInfo2").style.display='';
     return true;
  }
  else
  {
  return false;
  }
  
}
//完成添加商品检测下一步操作 2
function checknext2()
{ var node= document.getElementById("checkRecode");
  if(node.value < 1)
  {
   alert("该订单还没有添加订购的商品");
   return false;
  }else
  {
    this.document.getElementById("nextInfo2").style.display='none';
    this.document.getElementById("nextInfo3").style.display='';
  }
  return true;
}

///完成配送方式 下一步操作 3
function checknext3()
{
  var node= document.getElementById("DeliveryType");
  if(node.value == "")
  {
   alert("请选择配送方式");
   return false;
  }else
  {
    this.document.getElementById("nextInfo3").style.display='none';
    this.document.getElementById("nextInfo4").style.display='';
  }

}
//完成结算方式 下一步操作 4
function checknext4()
{
    this.document.getElementById("nextInfo1").style.display='';
    this.document.getElementById("nextInfo2").style.display='';
    this.document.getElementById("nextInfo3").style.display='';
    this.document.getElementById("nextInfo4").style.display='';
    this.document.getElementById("nextInfo5").style.display='';
    
    this.document.getElementById("next1").style.display='none';
    this.document.getElementById("next2").style.display='none';
    this.document.getElementById("next3").style.display='none';
    this.document.getElementById("next4").style.display='none';
}
//完成结算方式  去付款
function checknext4a()
{
  this.document.getElementById("nextInfo4").style.display='none';
  this.document.getElementById("nextInfo5").style.display='';
}

//第五步
function checknext5()
{    
     if( checkheadTable())
     {
     this.document.getElementById("nextInfo6").style.display='';
    this.document.getElementById("nextInfo0").style.display='none';
    this.document.getElementById("nextInfo1").style.display='none';
    this.document.getElementById("nextInfo2").style.display='none';
    this.document.getElementById("nextInfo3").style.display='none';
    this.document.getElementById("nextInfo4").style.display='none';
    this.document.getElementById("nextInfo5").style.display='none';
      }

}
//第六步1
function checknext6()
{
    this.document.getElementById("nextInfo6").style.display='none';
    this.document.getElementById("nextInfo7").style.display='';
  
}

//第六步2
function checknext6a()
{
 if(checkheadTable())
 {
 document.location.href="SalesOrder_Add.aspx";
 }else
 {
  return false;
 }
  
}




//第七步2
function checknext7()
{

  var PayInfo=document.getElementById("PayInfo").value;
  var SoID=document.getElementById("SalesOrderID").value;
  if(PayInfo=="")
  {
     document.location.href="SalesOrder_Add.aspx";
  }else
  {
     var xmlHttp=this.createXmlHttp();  
     $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影                     
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {  
                   $.unblockUI();//
                   
                 document.location.href="SalesOrder_Add.aspx";
                  
                   
                }
            }
            xmlHttp.open("POST", "AjaxSalesOrderLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=updatePayInfo&SalesOrderID="+SoID+"&PayInfo="+PayInfo);//   
  
  }

  
}


//第七步2
function checknext7a()
{

  var PayInfo=document.getElementById("PayInfo").value;
  var SoID=document.getElementById("SalesOrderID").value;
  if(PayInfo=="")
  {
     document.location.href="MySalesOrder.aspx";
  }else
  {
     var xmlHttp=this.createXmlHttp();  
     $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影                     
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {  
                   $.unblockUI();//
                   
                 document.location.href="MySalesOrder.aspx";
                  
                   
                }
            }
            xmlHttp.open("POST", "AjaxSalesOrderLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=updatePayInfo&SalesOrderID="+SoID+"&PayInfo="+PayInfo);//   
  
  }

  
}




//检查是不是内部用户
function initCheckUserType()
{
   var str=document.getElementById("CheckUserType").value;
   if(str=="1")
   {
     this.document.getElementById("DiscountRate").readOnly=true;
    this.document.getElementById("initUserUsed1").style.display='none';//折让金额、店铺不可见

    //this.document.getElementById("finish").style.display='';
    
   }
//   this.document.getElementById("nextInfo2").style.display='none';
//   this.document.getElementById("nextInfo3").style.display='none';
//   this.document.getElementById("nextInfo4").style.display='none';
//   this.document.getElementById("nextInfo5").style.display='none';
   this.document.getElementById("nextInfo6").style.display='none';
   this.document.getElementById("nextInfo7").style.display='none';


}

    </script>
</head>
<body onload="loadpage();initCheckUserType()">
    <form id="form1" runat="server">
        <br />
     <DIV  id="nextInfo0"
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 953px; BORDER-BOTTOM: #a4d5e3 1px solid; ">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">&nbsp;
      
 
      
      &nbsp;
      
 
      
      </H2>
     
      <DIV style="MARGIN: 5px">
   
 
<TABLE cellSpacing=0 cellPadding=0 align=center border=0 style="height: 133px; width: 100%;" >
  <TBODY>
  <TR>
    <TD class=title align=middle height=50 style="width: 910px">
        销 售 订 单&nbsp;</TD></TR>
  <TR>
    <TD bgColor=#ffffff style="height: 118px; width: 910px;" valign="top">
      <TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD bgColor=#ffffff style="height: 1px; width: 396px;" colspan="2">
              订单编号:<asp:TextBox ID="SalesOrderID" runat="server" Width="174px" CssClass="txt_left" ReadOnly="True"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 1px; width: 378px;" colspan="2">
              &nbsp;制单日期：<asp:TextBox ID="CreateDate" runat="server" Width="99px" CssClass="txt_left" ReadOnly="True"></asp:TextBox></TD>
          </TR>
        <TR>
            <td bgcolor="#ffffff" colspan="4" style="height: 6px">
                <div id="initUserUsed1">
  <table width="820"  border="0">
    <tr>
      <td style="width: 369px;">折让金额：<input id="Discount" onblur="checkPrice(this);updateAttachPay()" style="width: 99px" type="text" class="txt_left" value="0"  /></td>
      <td style=" width: 450px;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          &nbsp;&nbsp; 选择店铺: &nbsp; &nbsp;<cc1:ShopDropDownList ID="ShopID" runat="server" Visible="true">
                </cc1:ShopDropDownList></td>
    </tr>
  </table>
</div>
              
              </td>
        </tr>
        </TBODY></TABLE></TD></TR>
  </TBODY></TABLE>
    
      </DIV></DIV>
        <br />
        <DIV  id="nextInfo1"
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 948px; BORDER-BOTTOM: #a4d5e3 1px solid; ">
            <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid"><img id="Img3"  src="../images/collapse_arrow.png" />顾 客 信 息
                &nbsp;</h2>
            <DIV style="MARGIN: 5px">
                <TABLE cellSpacing=0 cellPadding=0 align=center border=0 style="height: 133px; width: 100%; background-color: #ffffff;" >
                    <TBODY>
                        <TR style="font-size: 12px; color: #000000">
                            <TD bgColor=#ffffff style="height: 118px; width: 910px;" valign="top" align="center">
                                <TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
                                    <TBODY>
                                        <TR>
                                            <TD bgColor=#ffffff style="height: 1px; width: 396px;" colspan="2" align="left">
                                                顾客姓名：:<asp:TextBox ID="CustomerName" runat="server" CssClass="txt_left" 
                                                    Width="174px"></asp:TextBox></td>
                                            <TD bgColor=#ffffff style="height: 1px; width: 378px;" colspan="2" align="left">
                                                &nbsp;顾客聊号：<select id="CustomerIDType" style="width: 54px">
                                                    <option selected="selected" value="QQ">QQ</option>
                                                    <option value="WW">旺旺</option>
                                                    <option value="QT">其它</option>
                                                </select>&nbsp;
                                                <asp:TextBox ID="CustomerID" runat="server" CssClass="txt_left" 
                                                    Width="99px"></asp:TextBox></td>
                                        </tr>
                                        <TR>
                                            <TD bgColor=#ffffff colSpan=2 style="height: 6px; width: 396px;" align="left">
                                                顾客电话：&nbsp; :<input id="CustomerTel"  style="width: 99px" type="text" class="txt_left"  /></td>
                                            <TD bgColor=#ffffff style="height: 6px; width: 378px;" colspan="2" align="left">
                                                &nbsp;顾客邮编：<asp:TextBox ID="CustomerPost" runat="server" CssClass="txt_left" 
                                                    Width="99px"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td align="left" bgcolor="#ffffff" colspan="2" style="width: 396px; height: 26px">
                                                消费平台：<asp:DropDownList ID="Platform" runat="server" DataSourceID="ObjectDataSource1"
                                                    DataTextField="PlatformName" DataValueField="PlatformID">
                                                </asp:DropDownList></td>
                                            <td align="left" bgcolor="#ffffff" colspan="2" style="width: 378px; height: 26px">
                                                顾客所在地区： <select name="select" id="CustomerArea" runat="server">
        <option value="">请选择</option>
        <option value="安徽">安徽</option>
        <option value="北京">北京</option>
        <option value="福建">福建</option>
        <option value="甘肃">甘肃</option>
        <option value="广东">广东</option>
        <option value="广西">广西</option>
        <option value="贵州">贵州</option>
        <option value="海南">海南</option>
        <option value="河北">河北</option>
        <option value="河南">河南</option>
        <option value="黑龙江">黑龙江</option>
        <option value="湖北">湖北</option>
        <option value="湖南">湖南</option>
        <option value="吉林">吉林</option>
        <option value="江苏">江苏</option>
        <option value="江西">江西</option>
        <option value="辽宁">辽宁</option>
        <option value="内蒙">内蒙</option>
        <option value="宁夏">宁夏</option>
        <option value="青海">青海</option>
        <option value="山东">山东</option>
        <option value="山西">山西</option>
        <option value="陕西">陕西</option>
        <option value="上海">上海</option>
        <option value="四川">四川</option>
        <option value="天津">天津</option>
        <option value="西藏">西藏</option>
        <option value="新疆">新疆</option>
        <option value="云南">云南</option>
        <option value="浙江">浙江</option>
                                                    <option value="重庆">重庆</option>
      </select></td>
                                        </tr>
                                        <TR>
                                            <TD bgColor=#ffffff colSpan=4 style="height: 34px" align="left">
                                                送货地址：
                                                <asp:TextBox ID="DeliveryPlace" runat="server" CssClass="txt_left" Width="649px"></asp:TextBox>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                &nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="getList" TypeName="Leyp.SQLServerDAL.Sales.SalesPlatformDAL"></asp:ObjectDataSource>
        <br />
        <DIV  id="nextInfo2"
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) #ffffff repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 952px; BORDER-BOTTOM: #a4d5e3 1px solid;  font-size: 12px; color: #000000;">
            <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid"><img id="Img2"  src="../images/collapse_arrow.png" />
                                &nbsp;商 品 信 息</h2>
            <DIV style="MARGIN: 5px">
                <TABLE cellSpacing=0 cellPadding=0 align=center border=0 style="height: 133px; width: 99%;" >
                    <TBODY>
                        <TR>
                            <TD bgColor=#ffffff style="height: 118px; width: 910px;" valign="top" align="center">
                                        <table border="0" style="width: 794px; height: 77px">
                                            <tr>
                                                <td height="24" style="width: 50px" align="left">
                                                    商品：</td>
                                                <td style="width: 212px" align="left">
                                                    &nbsp;<input id="ProductsName" class="txt_left" style="width: 71px" type="text" />
                                                    <input id="ProductsID" style="width: 17px" type="hidden" />
                                                    <input id="yinyong" onclick="return yinyong_onclick()" type="button" value="引用" /></td>
                                                <td width="55" align="left">
                                                    价钱</td>
                                                <td style="width: 172px" align="left">
                                                    &nbsp;<input id="Price" class="txt_left" onblur="checkPrice(this)" readonly="readonly"
                                                        style="width: 99px" type="text" value="0.00" />RMB</td>
                                                <td style="width: 79px" align="left">
                                                    <p>
                                                        数量</p>
                                                </td>
                                                <td style="width: 204px" align="left">
                                                    &nbsp;<input id="Quantity" class="txt_left" onblur="checkQuantity(this)" style="width: 83px"
                                                        type="text" value="0" /></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 50px; height: 33px" align="left">
                                                    折扣率</td>
                                                <td style="width: 212px; height: 33px" align="left">
                                                    &nbsp;
                                                    <input id="DiscountRate" class="txt_left" onblur="checkTaxRate(this)" style="width: 99px"
                                                        type="text" value="0" /></td>
                                                <td colspan="4" style="height: 33px" align="left">
                                                    <img id="IMG1" onclick="return ajaxSubmit()" src="../images/Save.gif" />
                                                    <input id="checkRecode" style="width: 40px" type="hidden" value="0" />
                                                    <input id="CheckUserType" runat="server" style="width: 13px" type="hidden" value="0" /></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 50px; height: 27px;" align="left">
                                                </td>
                                                <td colspan="5" style="height: 27px" align="left">
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                <div id="initSubmitInfo" style="width: 95%">
                                </div>
                                <br />
                                </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <br />
        <DIV  id="nextInfo3"
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) #ffffff repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 951px; BORDER-BOTTOM: #a4d5e3 1px solid; ">
            <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid"><img id="Img4"  src="../images/collapse_arrow.png" />
                                &nbsp;配 送 方 式</h2>
            <DIV style="MARGIN: 5px">
                <TABLE cellSpacing=0 cellPadding=0 align=center border=0 style="height: 133px; width: 99%;" >
                    <TBODY>
                        <TR>
                            <TD bgColor=#ffffff style="height: 118px; width: 810px;" valign="top" align="center">
                                <table border="1" height="326" style="width: 817px">
                                    <tr>
                                        <td width="149" align="left">
                                            1.物流快递</td>
                                        <td width="784" align="left">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td align="left">
                                                        <input id="rblSelectArea_0" name="rblSelectArea" onclick="setDeliveryTypeData(this)"
                                                            type="radio" value="物流快递$$$6$$$2" />
                                                        <label for="rblSelectArea_0">
                                                            （6元+2元/每个）广东省内</label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <input id="rblSelectArea_1" name="rblSelectArea" onclick="setDeliveryTypeData(this)"
                                                            type="radio" value="物流快递$$$8$$$2" />
                                                        <label for="rblSelectArea_1">
                                                            （8元+2元/每个）上海、江苏、浙江</label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <input id="rblSelectArea_2" name="rblSelectArea" onclick="setDeliveryTypeData(this)"
                                                            type="radio" value="物流快递$$$10$$$2" />
                                                        <label for="rblSelectArea_2">
                                                            （10元+2元/每个）安徽、福建、四川、北京、湖南、湖北、江西、广西、海南</label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <input id="rblSelectArea_3" name="rblSelectArea" onclick="setDeliveryTypeData(this)"
                                                            type="radio" value="物流快递$$$12$$$3" />
                                                        <label for="rblSelectArea_3">
                                                            （12元+3元/每个）天津、重庆、陕西、山西、山东、辽宁、黑龙江、河南、河北、云南、贵州</label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <input id="rblSelectArea_4" name="rblSelectArea" onclick="setDeliveryTypeData(this)"
                                                            type="radio" value="物流快递$$$15$$$4" />
                                                        <label for="rblSelectArea_4">
                                                            （15元+4元/每个）内蒙古、吉林、甘肃、青海、宁夏</label></td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <input id="rblSelectArea_5" name="rblSelectArea" onclick="setDeliveryTypeData(this)"
                                                            type="radio" value="物流快递$$$18$$$5" />
                                                        <label for="rblSelectArea_5">
                                                            （18元+5元/每个）其它地区</label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="65" align="left">
                                            2.
                                            <input id="rblWayOfShipping_1" name="rblSelectArea" onclick="setDeliveryTypeData(this)"
                                                type="radio" value="平邮$$$6$$$2" />
                                            平邮</td>
                                        <td align="left" valign="bottom">
                                            <label for="rblWayOfShipping_1">
                                                <br />
                                            </label>
                                            <table border="1" cellpadding="0" cellspacing="0" height="47" width="278">
                                                <tr>
                                                    <td align="center" bgcolor="#ffffff" width="74">
                                                        <strong>运送到</strong></td>
                                                    <td align="center" bgcolor="#ffffff" width="88">
                                                        <strong>第1个包</strong></td>
                                                    <td align="center" bgcolor="#ffffff" width="108">
                                                        <strong>每多1个包</strong></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#ffffff">
                                                        全国</td>
                                                    <td align="right" bgcolor="#ffffff">
                                                        6.00 元</td>
                                                    <td align="right" bgcolor="#ffffff">
                                                        2.00 元</td>
                                                </tr>
                                            </table>
                                            <label for="rblWayOfShipping_1">
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="59" align="left">
                                            3.
                                            <input id="rblWayOfShipping_2" name="rblSelectArea" onclick="setDeliveryTypeData(this)"
                                                type="radio" value="EMS$$$20$$$6" />
                                            EMS</td>
                                        <td align="left" valign="bottom">
                                            <table border="1" cellpadding="0" cellspacing="0" height="47" width="278">
                                                <tr>
                                                    <td align="center" bgcolor="#ffffff" width="71">
                                                        <strong>运送到</strong></td>
                                                    <td align="center" bgcolor="#ffffff" width="93">
                                                        <strong>第1个包</strong></td>
                                                    <td align="center" bgcolor="#ffffff" width="106">
                                                        <strong>每多1个包</strong></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#ffffff">
                                                        全国</td>
                                                    <td align="right" bgcolor="#ffffff">
                                                        20.00 元</td>
                                                    <td align="right" bgcolor="#ffffff">
                                                        6.00 元</td>
                                                </tr>
                                            </table>
                                            <label for="rblWayOfShipping_2">
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td height="68" align="left">
                                            4.
                                            <label for="rblWayOfShipping_3">
                                                <input id="rblWayOfShipping_3" name="rblSelectArea" onclick="setDeliveryTypeData(this)"
                                                    type="radio" value="邮政包裹快递$$$14$$$4" />
                                                邮政包裹快递</label></td>
                                        <td align="left" valign="bottom">
                                            <table border="1" cellpadding="0" cellspacing="0" height="56" width="279">
                                                <tr>
                                                    <td align="center" bgcolor="#ffffff" width="72">
                                                        <strong>运送到</strong></td>
                                                    <td align="center" bgcolor="#ffffff" width="91">
                                                        <strong>第1个包</strong></td>
                                                    <td align="center" bgcolor="#ffffff" width="108">
                                                        <strong>每多1个包</strong></td>
                                                </tr>
                                                <tr>
                                                    <td bgcolor="#ffffff">
                                                        全国</td>
                                                    <td align="right" bgcolor="#ffffff">
                                                        14.00 元</td>
                                                    <td align="right" bgcolor="#ffffff">
                                                        4.00 元</td>
                                                </tr>
                                            </table>
                                            <label for="rblWayOfShipping_3">
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            <strong> 您选择的配送方式是：</strong><asp:TextBox ID="DeliveryType" runat="server" CssClass="txt_left" ReadOnly="True"
                                    Width="170px"></asp:TextBox>&nbsp;
                                <input id="price1" style="width: 6px" type="hidden" value="0" />
                                &nbsp;&nbsp;
                                <input id="price2" style="width: 10px" type="hidden" value="0" />
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<strong>运费合计：</strong>
                                &nbsp;
                                <asp:TextBox ID="AttachPay" runat="server" CssClass="txt_left" ReadOnly="True" Width="80px">0</asp:TextBox><br />
                                <br />
                                </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <br />
        <DIV  id="nextInfo4"
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 949px; BORDER-BOTTOM: #a4d5e3 1px solid; ">
            <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid"><img id="Img5"  src="../images/collapse_arrow.png" />
                                &nbsp;结 算 方 式</h2>
            <DIV style="MARGIN: 5px">
                <TABLE cellSpacing=0 cellPadding=0 align=center border=0 style="height: 67px; width: 98%;" >
                    <TBODY>
                        <TR>
                            <TD bgColor=#ffffff style="height: 118px; width: 910px;" valign="top" align="center">
                                <TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
                                    <TBODY>
                                        <TR>
                                            <TD bgColor=#ffffff style="width: 264px; height: 50px" align="left" >
                                                订单总价：<input id="TotalPrice" class="txt_left" onblur="checkPrice(this)" readonly="readonly"
                                                        style="width: 99px; height: 17px;" type="text" value="0.00" />人民币</td>
                                            <TD bgColor=#ffffff style="height: 50px; width: 378px;" align="left" >
                                                &nbsp;结算方式： &nbsp;
                                                <asp:DropDownList ID="ClosingType" runat="server">
                                                    <asp:ListItem Value="银行汇款">银行汇款</asp:ListItem>
                                                    <asp:ListItem Value="淘宝支付宝">淘宝支付宝</asp:ListItem>
                                                    <asp:ListItem Value="拍拍财付通">拍拍财付通</asp:ListItem>
                                                    <asp:ListItem Value="百度百付宝">百度百付宝</asp:ListItem>
                                                    <asp:ListItem Value="易趣安付通">易趣安付通</asp:ListItem>
                                                </asp:DropDownList></td>
                                        </tr>
                                    </tbody>
                                </table>
                                &nbsp; &nbsp;
                                &nbsp; &nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <br />
        <br />
        <div id="nextInfo5" style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid;
            background: url(images/content_bg1.gif) repeat-x 50% bottom; margin-bottom: 8px;
            border-left: #a4d5e3 1px solid; width: 946px; border-bottom: #a4d5e3 1px solid;
            height: 46px">
            <div style="margin: 5px">
                <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 98%;
                    height: 75px">
                    <tbody>
                        <tr>
                            <td align="center" bgcolor="#ffffff" style="width: 910px; height: 74px" valign="top">
                                备 &nbsp; &nbsp;注：<asp:TextBox ID="Description" runat="server" Width="716px" CssClass="txt_left"></asp:TextBox><br />
              &nbsp;( 请勿填如“请找个质量好点的”“今天一定要发货”这类的常规性的要求)<br />
                                <input id="next5" onclick="javascript:if(!confirm('您确定要完成订单吗'))return  false;checknext5()"
                                    style="width: 113px" type="button" value="保 存 订 单" /><br />
                                &nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="nextInfo6" style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid;
            background: url(images/content_bg1.gif) repeat-x 50% bottom; margin-bottom: 8px;
            border-left: #a4d5e3 1px solid; width: 942px; border-bottom: #a4d5e3 1px solid;
            height: 46px">
            <div style="margin: 5px">
                <table align="center" border="0" cellpadding="0" cellspacing="0" style="width: 98%;
                    height: 75px">
                    <tbody>
                        <tr>
                            <td align="center" bgcolor="#ffffff" style="width: 910px; height: 74px" valign="top">
                                &nbsp;<input id="next6" onclick="checknext6()" style="width: 113px" type="button"
                                    value="提交付款信息" />
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input id="next6a" onclick="document.location.href='SalesOrder_Add.aspx';"
                                    style="width: 113px" type="button" value="继续下单" />&nbsp;&nbsp; &nbsp;&nbsp;
                                &nbsp;<input id="Button1" onclick="document.location.href='MySalesOrder.aspx';"
                                    style="width: 113px" type="button" value="返回列表" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <br />
        <DIV  id="nextInfo7"
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 942px; BORDER-BOTTOM: #a4d5e3 1px solid; ">
            <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid"><img id="Img6"  src="../images/collapse_arrow.png" />
                &nbsp;付 款 说 明</h2>
            <DIV style="MARGIN: 5px">
                <TABLE cellSpacing=0 cellPadding=0 align=center border=0 style="height: 75px; width: 98%;" >
                    <TBODY>
                        <TR>
                            <TD bgColor=#ffffff style="height: 74px; width: 910px;" valign="top" align="center"><input id="PayInfo" class="txt_left" 
                                                        style="width: 477px; height: 15px;" type="text" />
                                &nbsp;&nbsp; &nbsp;请填写您为本单据所付款情况<br />
                                <br />
                                <input id="next7" onclick="checknext7()" style="width: 106px" type="button" value="保存且继续下单" />
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<input id="next7a" onclick="checknext7a()" style="width: 100px" type="button" value="保存且返回列表" /> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                &nbsp;&nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <br />
    </form>
</body>
</html>
