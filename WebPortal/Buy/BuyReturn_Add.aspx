<%@ Page Language="C#" AutoEventWireup="true" Inherits="Buy_BuyReturn_Add" Codebehind="BuyReturn_Add.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"/ >
 
<head id="Head1" runat="server">
  <meta   http-equiv="Expires"   content="0" />     
  <meta   http-equiv="Cache-Control"   content="no-cache" />     
  <meta   http-equiv="Pragma"    content="no-cache" />  
    <title> 采 购 退 货</title>
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
    
 //明细表单提交
function  ajaxSubmit() {
    
            var NBuyReturnID =document.getElementById("BuyReturnID");
            var  NProductsID = document.getElementById("ProductsID");
            var  NProductsNum = document.getElementById("Quantity");
            var  NPrice = document.getElementById("Price");
            
            var  NDescriptions = document.getElementById("Descriptions");
            var  NSupplier=document.getElementById("SupplierID");
            var  NDetailID=document.getElementById("DetailIDvalue");
            var sideSubmit=document.getElementById("NewOrEdit").value;//提交标志
            var xmlHttp=this.createXmlHttp();
            
         if(NProductsID.value=="")
            {
               
			    alert('请选择商品；如果是按采购入库单填写请选择要编辑的项');
		         return false;
            }
            if(NProductsNum.value=="")
            {
                // alert("请输入商品数量");
                alert('请输入商品数量');
			    return false;
            }
            if(!/^\d+$/.test(NProductsNum.value))
            {
                alert("商品数量应该是整数");
               
              
			   return false;
            }
            
             if(NProductsNum.value < 1)
            {
               alert("商品数量不应该小于1");
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
           
            
            
            $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
                  var xmlHttp=this.createXmlHttp();
          if(sideSubmit=="edit")
            {
               xmlHttp.onreadystatechange = function() {
                    if (xmlHttp.readyState == 4) {
                       
                       loadBuyReturnOrderDetail();
                       ajaxSubmited();
                       $.unblockUI();//
                       
                    }
                }
                xmlHttp.open("POST", "AjaxBuyReturnDetail_load_Add_Edit_Del.aspx", true);
                xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                xmlHttp.send("action=edit&DetailID="+NDetailID.value+"&BuyReturnID="+NBuyReturnID.value+"&ProductsID="+NProductsID.value+"&SupplierID="+NSupplier.value+"&Price="+NPrice.value+"&Quantity="+NProductsNum.value+"&Descriptions="+NDescriptions.value+"");//   
          }
          else 
          {
             xmlHttp.onreadystatechange = function() {
                    if (xmlHttp.readyState == 4) {
                       
                       loadBuyReturnOrderDetail();
                       ajaxSubmited();
                       $.unblockUI();//
                       
                    }
                }
                xmlHttp.open("POST", "AjaxBuyReturnDetail_load_Add_Edit_Del.aspx", true);
                xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                xmlHttp.send("action=add&DetailID="+NDetailID.value+"&BuyReturnID="+NBuyReturnID.value+"&ProductsID="+NProductsID.value+"&SupplierID="+NSupplier.value+"&Price="+NPrice.value+"&Quantity="+NProductsNum.value+"&Descriptions="+NDescriptions.value+"");//   
   
          
          }
   
         }
         
     ///明细表单提交后，清空输入框中的值
 function  ajaxSubmited()
 {
     document.getElementById("ProductsID").value="";
     document.getElementById("ProductsName").value="";
     document.getElementById("Quantity").value="0";
     document.getElementById("Price").value="0";
     document.getElementById("Descriptions").value="";
     document.getElementById("SupplierID").value="";
     document.getElementById("SupplierName").value="";
   this.document.getElementById("NewOrEdit").value="new";//标志明细单是编辑采购单
     
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
       if( !/^(-|\+)?\d+(\.\d+)?$/.test(node.value))
        {
	       node.value="0.00";
        }
}


///选择采购订单
function selectReceiptOrderID()
{
   var Url="NQ_BuyReceipt_CommonWindows.aspx";
    var result=window.showModalDialog(Url,'','dialogWidth:1000px;status:no;dialogheight:600px');   
    if(result!=null)
    { 
       var val=result.split('$$$');
       document.getElementById("Identitys").value=val[0]; 
       document.getElementById("StoreHouseID").value=val[1]; 
       document.getElementById("HouseDetailID").value=val[2]; 
       document.getElementById("IdentitysH").value="0"; 
      
     
    }else
    {
     // ymPrompt.alert({message:'引用失败',title:'错误提示',handler:null});
    }


}


///保存表头
function SaveHeadOrder()
{

  
            var  NBuyReturnID= document.getElementById("BuyReturnID");
            var  NBuyReturnDate = document.getElementById("BuyReturnDate");
            var  NStoreHouseID = document.getElementById("StoreHouseID");
            
            var  NHouseDetailID = document.getElementById("HouseDetailID");
            var  NReceiptOrderID = document.getElementById("Identitys");
            var  NIdentitys = document.getElementById("IdentitysH");
            var  NTradeDate = document.getElementById("TradeDate");
            var  NDescription = document.getElementById("Description");
            var  sReceiptOrderID=NReceiptOrderID.value;

            if(NStoreHouseID.value=="")
            {
               
			   alert('请选择库区');
			    
		         return false;
            }
            if(NReceiptOrderID.value=="直接出库")
            {
              sReceiptOrderID="RB00000000000000000";
            }
          
           $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影  
            var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   
                     showresult(xmlHttp.responseText);
                      $.unblockUI();//
                     
                }
            }
            xmlHttp.open("GET", "AjaxBuyReturn_Add.aspx?BuyReturnID="+NBuyReturnID.value+"&BuyReturnDate="+NBuyReturnDate.value+"&StoreHouseID="+NStoreHouseID.value+"&HouseDetailID="+NHouseDetailID.value+"&ReceiptOrderID="+sReceiptOrderID+"&Identitys="+NIdentitys.value+"&TradeDate="+NTradeDate.value+"&Description="+NDescription.value+"", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send(null);//         
  

}
 ///提交结果
  function showresult(text) {
        var status = text.substr(0,1);
        var str0="";
        if (status == "0") {
            this.document.getElementById("BuyReturnDetail").style.display='';
            this.document.getElementById("selBuyOrderID").style.display='none';
            this.document.getElementById("gyshButtun").style.display='none';
            this.document.getElementById("SaveHead").style.display='none';
            this.document.getElementById("SaveAll").style.display='';
            this.document.getElementById("finish").style.display='';
            str0=this.document.getElementById("IdentitysH").value;
             if(str0=="0")//调用采购入库单提交
             {
                this.document.getElementById("yinyong").style.display='none';
                this.document.getElementById("gyingsh").style.display='none';
                loadBuyReturnOrderDetail();
                this.document.getElementById("NewOrEdit").value="edit";//标志明细单是编辑采购单
                alert('请编辑退货数量 ');
             }
            
        } else {
           
        }
       
    }
    
 function loadBuyReturnOrderDetail()//装载由采购订单刚刚生成的入库单
 {
    var BuyReturnID = "";
    BuyReturnID=document.getElementById("BuyReturnID").value;
     var xmlHttps=this.createXmlHttp();                       
            xmlHttps.onreadystatechange = function() {
                if (xmlHttps.readyState == 4) {
                   
                      document.getElementById("initSubmitInfo").innerHTML=xmlHttps.responseText;
                      $('.flexme2').flexigrid();
                     
                }
            }
            xmlHttps.open("POST", "AjaxBuyReturnDetail_load_Add_Edit_Del.aspx", true);
            xmlHttps.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttps.send("action=load&BuyReturnID="+BuyReturnID);//  
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
            xmlHttp.open("POST", "AjaxBuyReturnDetail_load_Add_Edit_Del.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=getNode&DetailID="+DetailID);//   

}
///点击编辑后
function editingSet(str)
{
       var val=str.split('$');
       document.getElementById("ProductsName").value=val[0]; 
       document.getElementById("ProductsID").value=val[1]; 
       document.getElementById("Price").value=val[2]; 
       document.getElementById("Quantity").value=val[3];
       document.getElementById("Quantitys").value=val[3];
       document.getElementById("SupplierName").value=val[4];
       document.getElementById("SupplierID").value=val[5];
       document.getElementById("Description").value=val[6];
       document.getElementById("DetailIDvalue").value=val[7];
       this.document.getElementById("NewOrEdit").value="edit";//标志明细单是编辑采购单
       
 
}


//删除详细入库项
function deleteDetail(str)
{ 
  
     $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
    var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
               
                if (xmlHttp.readyState == 4) {
                     loadBuyReturnOrderDetail();
                      $.unblockUI();// 
                }
            }
            xmlHttp.open("POST", "AjaxBuyReturnDetail_load_Add_Edit_Del.aspx", true);
            xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
            xmlHttp.send("action=del&DetailID="+str);//   

}
    //删除采购入库单   
  function deleteOrder()
  {
     var NReceiptOrderID =document.getElementById("BuyReturnID").value;
     window.location.href("AjaxBuyReturn_Del.aspx?BuyReturnID="+encodeURIComponent(NReceiptOrderID)) ;
 
  }   



function initLoad()
{
  this.document.getElementById("BuyReturnDetail").style.display='none';
  this.document.getElementById("SaveAll").style.display='none';
   this.document.getElementById("finish").style.display='none';
  
  
}

function finishAll()
{
  var rtid=document.getElementById("BuyReturnID").value;
  window.location.href("BuyReturn_Detail.aspx?BuyReturnID="+encodeURIComponent(rtid)) ;
  
}

//检查输入的数量是否 小于 入库单明细的数量
function ckeckProductsNum()
{
 var num=this.document.getElementById("Quantity").value;
 var realnum=this.document.getElementById("Quantitys").value;
 var sige=this.document.getElementById("IdentitysH").value;
 if(sige=="1")
 {
  
 }
 else
 {
    if(realnum < num)
     {
      alert("该项退货单据数量不超过"+realnum);
      this.document.getElementById("Quantity").value="0";
       return ;
     }
 
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
<body onload="initLoad();loadBuyReturnOrderDetail()">
    <form id="form1" runat="server">
    <br />


        <div id="addMian_t" style="left: 0px; top: 10px; height: 248px">
      <DIV 
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 100%! important; BORDER-BOTTOM: #a4d5e3 1px solid; height: 171px;">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">&nbsp;
      
      &nbsp;<asp:SiteMapPath ID="SiteMapPath1" runat="server">
          </asp:SiteMapPath>
      
      </H2>
     
      <DIV style="MARGIN: 5px">
   
 
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0 style="height: 202px" >
  <TBODY>
  <TR>
    <TD class=title align=middle height=50>采 购 退 货</TD></TR>
  <TR>
    <TD bgColor=#ffffff style="height: 118px" valign="top">
      <TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD bgColor=#ffffff style="width: 219px; height: 9px;">订单编号：<asp:TextBox ID="BuyReturnID" runat="server" Width="150px" CssClass="txt_left" ReadOnly="True"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="width: 270px; height: 9px;">制单日期：
              <asp:TextBox ID="BuyReturnDate" runat="server" Width="111px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              </TD>
          <TD bgColor=#ffffff style="height: 9px; width: 418px;">
              调用入库单 ：
              <input id="Identitys" readonly="readonly" type="text" value="直接出库" style="width: 97px" />
              <input id="selBuyOrderID" type="button" onclick="selectReceiptOrderID()" value="选择" />
              <input id="IdentitysH" style="width: 14px" type="hidden" value="1" /></TD>
          <TD bgColor=#ffffff style="height: 9px"></TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 13px">
              &nbsp;库房：<asp:TextBox ID="StoreHouseID" runat="server" Width="69px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              库区：<asp:TextBox ID="HouseDetailID" runat="server" Width="55px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              <INPUT class="input" onclick="gysSelect()" type=button value=引用 name="yyBtn0" id="gyshButtun">
              </TD>
          <TD bgColor=#ffffff style="height: 13px; width: 418px;">
              出库日期：<asp:TextBox ID="TradeDate" runat="server" Width="90px" CssClass="txt_left"></asp:TextBox>&nbsp;
              <IMG 
            style="CURSOR: hand" 
            onclick="fPopUpCalendarDlg(TradeDate);return false;" height=16 
            alt=弹出日历下拉菜单 src="../images/calendar.gif" width=16></TD>
          <TD bgColor=#ffffff style="height: 13px"> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 30px">合计金额：<asp:TextBox ID="TotalPrice" runat="server" CssClass="txt_left" ReadOnly="True">0.00</asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 30px; width: 418px;"></TD>
          <TD bgColor=#ffffff style="height: 30px"> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=3 style="height: 34px">备&nbsp;&nbsp;&nbsp;&nbsp;注：
              <asp:TextBox ID="Description" runat="server" Width="484px" CssClass="txt_left"></asp:TextBox>
              <input id="SaveHead" style="width: 121px" onclick="SaveHeadOrder()" type="button" value="生成采购退货单" />
              <input id="SaveAll" type="button"  onclick="javascript:if(!confirm('您确定要删除吗'))return  false;deleteOrder();" value="删除该单" />
              <input id="finish" type="button" onclick="javascript:if(!confirm('您确定要完成吗！确认后不能修改'))return  false;finishAll()" value="完成所有" /></TD>
          <TD bgColor=#ffffff style="height: 34px"> </TD></TR></TBODY></TABLE></TD></TR>
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
        <DIV  id="BuyReturnDetail"
style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(../images/content_bg1.gif) repeat-x 50% bottom; FLOAT: left; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 919px; BORDER-BOTTOM: #a4d5e3 1px solid; HEIGHT: 122px"><DIV style="MARGIN: 5px">
<table border="0" style="width: 908px; height: 77px">
  <tr>
    <td height="24" style="width: 50px">商品：</td>
    <td style="width: 212px">&nbsp;<input id="ProductsName" style="width: 71px" type="text" class="txt_left" />
        <input id="ProductsID" style="width: 17px" type="hidden" />
        <input id="yinyong" type="button" value="引用" onclick="return yinyong_onclick()" /></td>
    <td width="55">价钱</td>
    <td style="width: 172px">&nbsp;<input id="Price" onblur="checkPrice(this)" style="width: 99px" type="text" class="txt_left" value="0" />RMB</td>
    <td style="width: 79px"><p >数量</p></td>
    <td style="width: 204px">&nbsp;<input id="Quantity"   onblur="checkQuantity(this)" style="width: 83px" type="text" class="txt_left" value="0" />
        <input id="Quantitys" style="width: 32px" type="hidden" value="0" /></td>
  </tr>
  <tr>
    <td style="height: 39px; width: 79px;">&nbsp;供 应 商：</td>
    <td style="width: 204px; height: 39px;">&nbsp;
    
   
    <input id="SupplierName" style="width: 71px" type="text" class="txt_left" />
        <input id="SupplierID" style="width: 17px" type="hidden" />
    
              <INPUT class="input"  onclick="selectSupplier()"; type="button" value="引用"  id="gyingsh"></td>
  </tr>
  <tr>
    <td height="22" style="width: 50px">描述：</td>
    <td colspan="5">&nbsp;<input id="Descriptions" type="text" style="width: 458px" class="txt_left" />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        <img src="../images/Save.gif" id="IMG1" onclick="return ajaxSubmit()" />&nbsp;
        <input id="NewOrEdit" style="width: 51px"  value="new" type="hidden" />
        <input id="DetailIDvalue" style="width: 51px"  value="0" type="hidden" /></td>
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


