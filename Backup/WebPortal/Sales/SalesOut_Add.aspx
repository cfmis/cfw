<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_SalesOut_Add" Codebehind="SalesOut_Add.aspx.cs" %>

<%@ Register Assembly="Components" Namespace="Leyp.Components.Controls" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title> 销售开单</title>
    <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../js/skin/qq/ymPrompt.css" /> 
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
    <script type="text/javascript" src="../js/ymPrompt.js"></script> 
   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/jquery.blockUI.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
   
    <style type="text/css">
   body {
	margin-left: 10px;
	margin-top: 10px;
}
    
    </style>
    

    <script type="text/javascript">
    
 //明细表单提交

function  ajaxSubmit() {
    
            var  NID = document.getElementById("SalesOutID");
            var  NProductsID = document.getElementById("ProductsID");
            var  NProductsNum = document.getElementById("Quantity");
            var  NPrice = document.getElementById("Price");
            var  NDiscountRate = document.getElementById("DiscountRate");
           
            var  NDetailID = document.getElementById("DetailIDvalue").value;
            var NewOrEdits=document.getElementById("NewOrEdit").value;
           
           var  NStoreHouseID = document.getElementById("StoreHouseID");
            var  NHouseDetailID = document.getElementById("HouseDetailID");
            

            if(NStoreHouseID.value=="")
            {
               
			    alert('请选择库区');
			    
		         return false;
            }
 
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
                       
                      
                       loadDetail();
                       ajaxSubmited();
                       $.unblockUI();//
                       
                    }
                }
                xmlHttp.open("POST", "AjaxSalesOutDetail_load_Add_Edit_Del.aspx", true);
                xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                xmlHttp.send("action=editDetail&DetailID="+NDetailID+"&SalesOutID="+NID.value+"&ProductsID="+NProductsID.value+"&Price="+NPrice.value+"&Quantity="+NProductsNum.value+"&DiscountRate="+NDiscountRate.value+"&Descriptions=无&StoreHouseID="+NStoreHouseID.value+"&HouseDetailID="+NHouseDetailID.value+"");//  

             
             
           
   }
 
         
     ///明细表单提交后，清空输入框中的值
 function  ajaxSubmited()
 {
     document.getElementById("ProductsID").value="";
     document.getElementById("Quantity").value="0";
     document.getElementById("Price").value="0.00";
     document.getElementById("DiscountRate").value="0";
    // document.getElementById("Descriptions").value="";
     document.getElementById("ProductsName").value="";
      document.getElementById("StoreHouseID").value="";
      document.getElementById("HouseDetailID").value="";
            

   this.document.getElementById("NewOrEdit").value="new";//标志明细单是编辑采购单
     
 }
         
         





function gysSelect()
{
  
  var Pid=document.getElementById("ProductsID").value;
  if(Pid=="")
  {
   alert("请先选择商品！");
   return false;
  }
    var Url="../Stock/Detop_CommonWindow1.aspx?ProductsID="+Pid+"";
    var result=window.showModalDialog(Url,'','dialogWidth:500px;status:no;dialogheight:500px');   
    if(result!=null)
    { 
       var val=result.split('$$$');
       document.getElementById("StoreHouseID").value=val[0]; 
       document.getElementById("HouseDetailID").value=val[1]; 
        checkProductsNum();
     
    }else
    {
     
    }

}

//检查该库区商品数量是否符合开单
function checkProductsNum()
{
  var houseID= document.getElementById("HouseDetailID").value;
  var SPID=document.getElementById("ProductsID").value;
  if(houseID=="")
  {
   return false;
  }
  if(houseID=="0")
  {
   return false;
  }
  if(SPID=="")
  {
   return false;
  }
  if(SPID=="0")
  {
   return false;
  }
  
               var xmlHttp=this.createXmlHttp();                       
                xmlHttp.onreadystatechange = function() {
                    if (xmlHttp.readyState == 4) {
                       checkProductsNumReslut(xmlHttp.responseText);
                    }
                }
                xmlHttp.open("POST", "AjaxSalesOutDetail_load_Add_Edit_Del.aspx", true);
                xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                xmlHttp.send("action=checkProductsNum&ProductsID="+SPID+"&HouseDetailID="+houseID+"");//  

  
}

//检查结果
function checkProductsNumReslut(text)
{  
   var ProductsNum=parseInt(text);
   var thisQuantity=parseInt(document.getElementById("Quantity").value);
   if(thisQuantity > ProductsNum)
   {
     alert("当前库存不足，只有数量"+ProductsNum);
     document.getElementById("StoreHouseID").value="";
     document.getElementById("HouseDetailID").value="";
     
   }
   
}

function checkTaxRate(node)
{
       if( !/^(-|\+)?\d+(\.\d+)?$/.test(node.value))
        {
	       node.value="0.00";
        }
}


///选择销售订单
function selectSalesOrderID()
{
   var Url="NQ_SalesOrder_CommonWindows.aspx";
    var result=window.showModalDialog(Url,'','dialogWidth:1000px;status:no;dialogheight:600px');   
    if(result!=null)
    { 
       var val=result.split('$$$');
      document.getElementById("SalesOrderID").value=val[0];  
      document.getElementById("DeliveryType").value=val[1]; 
     
    }else
    {
     // ymPrompt.alert({message:'引用失败',title:'错误提示',handler:null});
    }


}


///保存表头只是生成相关的明细
function SaveHeadOrder()
{
            var  NSalesOutID= document.getElementById("SalesOutID");
            var  NSalesOrderID= document.getElementById("SalesOrderID");
           
            if(NSalesOrderID.value=="")
            {
               
			    alert('请选择销售订单');
			    
		         return false;
            }

            $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
             var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   
                     showresult(xmlHttp.responseText);
                     
                      $.unblockUI();// 
                     
                }
            }
            xmlHttp.open("POST", "AjaxSalesOutLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=testAdd&SalesOutID="+NSalesOutID.value+"&SalesOrderID="+NSalesOrderID.value+"");//       
  

}
 ///提交结果
  function showresult(text) {
      
            this.document.getElementById("Detail").style.display='';
            this.document.getElementById("selSalesOrderID").style.display='none';
            this.document.getElementById("SaveHead").style.display='none';
            this.document.getElementById("SaveAll").style.display='';
            this.document.getElementById("finish").style.display='';
            
            //this.document.getElementById("yinyong").style.display='none';
            loadDetail();
            this.document.getElementById("NewOrEdit").value="new";//标志明细单是编辑采购单
              
            
       
       
    }
    
 function loadDetail()//装载由采购订单刚刚生成的入库单
 {
    var SalesOutID = "";
    SalesOutID=document.getElementById("SalesOutID").value;
     var xmlHttps=this.createXmlHttp();                       
            xmlHttps.onreadystatechange = function() {
                if (xmlHttps.readyState == 4) {
                   
                      document.getElementById("initSubmitInfo").innerHTML=xmlHttps.responseText;
                      $('.flexme2').flexigrid();
                     
                }
            }
            xmlHttps.open("POST", "AjaxSalesOutDetail_load_Add_Edit_Del.aspx", true);
            xmlHttps.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttps.send("action=LoadDetailEdit&SalesOutID="+SalesOutID);//  
 }
 
 ///点击编辑
function editDetail(DetailID)
{   
     $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
    var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                      editingSet(xmlHttp.responseText);
                       $.unblockUI();// 
                }
            }          
            xmlHttp.open("POST", "AjaxSalesOutDetail_load_Add_Edit_Del.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=getNode&DetailID="+DetailID);//   

}
///点击编辑后
function editingSet(str)
{
       var val=str.split('$');
       document.getElementById("DetailIDvalue").value=val[0]; 
       document.getElementById("ProductsID").value=val[1]; 
       document.getElementById("ProductsName").value=val[2]; 
       document.getElementById("Price").value=val[3];
       document.getElementById("Quantity").value=val[4];
       document.getElementById("DiscountRate").value=val[5];
       //document.getElementById("Description").value=val[6];
       document.getElementById("StoreHouseID").value=val[7];
       document.getElementById("HouseDetailID").value=val[8];
       this.document.getElementById("NewOrEdit").value="edit";//标志明细单是编辑采购单
       
         checkProductsNum();
       
 
}


//删除详细入库项
function deleteDetail(str)
{ 
  
     $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
    var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
               
                if (xmlHttp.readyState == 4) {
                     loadDetail();
                      $.unblockUI();// 
                }
            }
            xmlHttp.open("POST", "AjaxSalesOutDetail_load_Add_Edit_Del.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=delDetail&DetailID="+str);//   

}
    //删除单   
function deleteOrder()
  {
   alert("成功删除");
  document.location.href="SalesOut_Add.aspx" ;                  
 
  }   



function initLoad()
{
  this.document.getElementById("Detail").style.display='none';
  this.document.getElementById("SaveAll").style.display='none';
  this.document.getElementById("finish").style.display='none';
  this.document.getElementById("finshInfo").style.display='none';
  
  
  
}

function finishAll()
{

            var  NSalesOutID= document.getElementById("SalesOutID");
            var  NSalesOrderID= document.getElementById("SalesOrderID");
            var  NCreateDate= document.getElementById("CreateDate");
            var  NConsignee = "没有填写";
           // var  NTradePlace = document.getElementById("TradePlace");
            var  NTradeDate = "未知";
            var NDeliveryID=document.getElementById("DeliveryID");
            //var  NAccountsID =document.getElementById("AccountsID");
            var  NDescription = document.getElementById("Description");
            var sDeposits="0";
            // var str;
           
            if(NSalesOrderID.value=="")
            {
               
			    alert('请选择销售订单');
			    
		         return false;
            }
            
            
            
           
            if(NDeliveryID.value=="")
            {
               alert('请选择配送方式！');
			    
		         return false;
            }
            
           
            
            
               
            var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                  
                   document.getElementById("mainInfo").style.display='none';
                   document.getElementById("finshInfo").style.display='';
  
                   
                     
                }
            }
            xmlHttp.open("POST", "AjaxSalesOutLoad.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=add&SalesOutID="+NSalesOutID.value+"&SalesOrderID="+NSalesOrderID.value+"&CreateDate="+NCreateDate.value+"&Consignee="+NConsignee+"&TradeDate="+NTradeDate+"&Deposits="+sDeposits+"&Description="+NDescription.value+"&DeliveryID="+NDeliveryID.value+"&AccountsID=123456");//       
  
}


function  checkAndFinsh()
{   var reslut="aa";
    var SalesOutID = "";
    SalesOutID=document.getElementById("SalesOutID").value;
       var xmlHttps=this.createXmlHttp();                       
            xmlHttps.onreadystatechange = function() {
                if (xmlHttps.readyState == 4) {
                
                    finshOrder(xmlHttps.responseText);       
                }
            }
            xmlHttps.open("POST", "AjaxSalesOutDetail_load_Add_Edit_Del.aspx", true);
            xmlHttps.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttps.send("action=checkEdit&SalesOutID="+SalesOutID);//  
   
}



function finshOrder(text)
{ 
  if(text=="0")
  {
    finishAll();
  }
  else
  {
   alert('还没有编辑完商品定位的库区');
   return false;
  
  }
}
//function getVlaue()
//{  checkDetailEidt();
//   return this.checkReturnValue;
//}


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
<body onload="initLoad();loadDetail()">
    <form id="form1" runat="server">
    <br /><asp:SiteMapPath ID="SiteMapPath1" runat="server">
          </asp:SiteMapPath>
        <br />
      <p></p>
      
      <div id="mainInfo">

        <div id="addMian_t" style="left: 0px; top: 10px; height: 248px">
      <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 100%! important; BORDER-BOTTOM: #a4d5e3 1px solid; height: 171px;">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">&nbsp;
      
      &nbsp;
      
      </H2>
     
      <DIV style="MARGIN: 5px">
   
 
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 style="height: 202px" >
  <TBODY>
  <TR>
    <TD class=title align=middle height=50>
        销 售 开 单</TD></TR>
  <TR>
    <TD bgColor=#ffffff style="height: 118px" valign="top">
      <TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD bgColor=#ffffff style="width: 219px; height: 9px;">订单编号：<asp:TextBox ID="SalesOutID" runat="server" Width="150px" CssClass="txt_left" ReadOnly="True"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="width: 354px; height: 9px;">制单日期：
              <asp:TextBox ID="CreateDate" runat="server" Width="99px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              </TD>
          <TD bgColor=#ffffff style="height: 9px; width: 418px;">
              销售订单 ：
              <input id="SalesOrderID" readonly="readonly" type="text" value="" style="width: 149px" class="txt_left" />
              <input id="selSalesOrderID" type="button" onclick="selectSalesOrderID()" value="选择" />
              </TD>
          <TD bgColor=#ffffff style="height: 9px"></TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=3 >
              &nbsp;配送方式：&nbsp;
              <cc1:deliverydropdownlist id="DeliveryID" Width="80" runat="server"></cc1:deliverydropdownlist>
                   <span style="height: 13px; color: #ff0033;">原要求配送方式：</span> <asp:TextBox ID="DeliveryType" runat="server" CssClass="txt_left" ReadOnly="True"
                        Width="231px"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 13px"> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=3 style="height: 34px">备&nbsp;&nbsp;&nbsp;&nbsp;注：
              <asp:TextBox ID="Description" runat="server" Width="484px" CssClass="txt_left"></asp:TextBox>
              <input id="SaveHead" style="width: 121px" onclick="javascript:if(!confirm('您确定要生成吗'))return  false;SaveHeadOrder()" type="button" value="生成销售出库单" />
              <input id="SaveAll" type="button"  onclick="javascript:if(!confirm('您确定要删除吗'))return  false;deleteOrder();" value="删除该单" />
              
              <input id="finish" type="button" onclick="javascript:if(!confirm('您确定要完成吗！确认后不能修改'))return  false;checkAndFinsh()" value="完成所有" />
              </TD>
          <TD bgColor=#ffffff style="height: 34px"> </TD></TR></TBODY></TABLE></TD></TR>
  </TBODY></TABLE>
    
      </DIV></DIV>
      
   </div>
        <br />
        <br />
        <DIV  id="Detail"
style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(../images/content_bg1.gif) repeat-x 50% bottom; FLOAT: left; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 919px; BORDER-BOTTOM: #a4d5e3 1px solid; HEIGHT: 122px"><DIV style="MARGIN: 5px">
<table border="0" style="width: 908px; height: 77px">
  <tr>
    <td height="24" style="width: 50px">商品：</td>
    <td style="width: 212px">&nbsp;<input id="ProductsName" style="width: 71px" type="text" class="txt_left" readonly="readOnly" />
        <input id="ProductsID" style="width: 17px" type="hidden" />
        </td>
    <td width="55">价钱</td>
    <td style="width: 172px">&nbsp;<input id="Price"  onblur="checkPrice(this)" style="width: 99px" type="text" class="txt_left" value="0" readonly="readOnly" />RMB</td>
    <td style="width: 79px"><p >数量</p></td>
    <td style="width: 204px">&nbsp;<input id="Quantity"  onblur="checkQuantity(this)" style="width: 83px" type="text" class="txt_left" value="0" readonly="readOnly" /></td>
  </tr>
  <tr>
    <td style="width: 50px; height: 39px;">折扣率</td>
    <td style="height: 39px; width: 212px;">&nbsp;<input id="DiscountRate" onblur="checkTaxRate(this)" style="width: 99px" type="text" class="txt_left" value="0" readonly="readOnly" /></td>
      <td colspan="4" style="height: 39px">
          &nbsp;&nbsp;库房：<asp:TextBox ID="StoreHouseID" runat="server" Width="69px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              库区：<asp:TextBox ID="HouseDetailID" runat="server" Width="55px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              <INPUT class="input" onclick="gysSelect()" type=button value=引用 name="yyBtn0" id="gyshButtun">
              </td>
  </tr>
  <tr>
    <td height="22" style="width: 50px"></td>
    <td colspan="5">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <img src="../images/Save.gif" id="IMG1" onclick="return ajaxSubmit()" />&nbsp;
        <input id="NewOrEdit" style="width: 51px"  value="new" type="hidden" />
        <input id="DetailIDvalue" style="width: 51px"  value="0" type="hidden" /></td>
  </tr>
</table>
    &nbsp;</DIV></DIV>
        <br />
          <br />
      
           
        <DIV id="initSubmitInfo" style="width:100%">
        
        
</DIV>

        <br />
        <br />
        <br />
        <br />
 </div>
 
 <div id="finshInfo">
 
     <table style="width: 881px">
         <tr>
             <td style="height: 9px;" align="right" colspan="3">
                 <input id="Button2" onclick="javascript:document.location.href='Manager_SalesOutOrder.aspx' ;" type="button" value="返回列表" />&nbsp;
                 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; 
                 <input id="Button1" onclick="javascript:document.location.href='SalesOut_Add.aspx' ;" type="button" value="继续开单" />
                 </td>
         </tr>
         <tr>
             <td align="right" style="width: 20px; height: 9px">
             </td>
             <td style="width: 64px; height: 9px">
             </td>
             <td style="width: 3px; height: 9px">
             </td>
         </tr>
     </table>
 
 </div>
 
  
    </form>
</body>
</html>


