<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_SalesOut_Edit" Codebehind="SalesOut_Edit.aspx.cs" %>

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
// 1.判断select选项中 是否存在Value="paraValue"的Item        
function jsSelectIsExitItem(objSelect, objItemValue) {        
    var isExit = false;        
    for (var i = 0; i < objSelect.options.length; i++) {        
        if (objSelect.options[i].value == objItemValue) {        
            isExit = true;        
            break;        
        }        
    }        
    return isExit;        
} 
// 4.让select选中和给定值一样的项    
function jsSelect() {  
   
    var str0= document.getElementById("DeliveryIDh").value;
     var str1= document.getElementById("AccountsIDh").value;
     var str2= document.getElementById("Platformh").value;
     var str3= document.getElementById("CustomerIDTypeh").value; 
    
    document.all.DeliveryID.value = str0;
    document.all.AccountsID.value = str1;
    document.all.Platform.value = str2;
    document.all.CustomerIDType.value = str3;
} 

//提交检验
function submit()
{
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
}
  
  
    </script>

</head>
<body  onload="loadDetail();jsSelect();">
    <form id="form1" runat="server">
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <table style="width: 941px">
            <tr>
                <td style="width: 411px">
                </td>
                <td class=title>
                    销售开单修改</td>
                <td>
                </td>
            </tr>
        </table>
        <br />
     <DIV  id="nextInfo0"
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 953px; BORDER-BOTTOM: #a4d5e3 1px solid; height: 155px;">
      <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid">&nbsp;<img id="Img4"  src="../images/collapse_arrow.png" />基本信息</H2>
     
      <DIV style="MARGIN: 5px">
          <table align="center" border="0" cellpadding="1" cellspacing="1" width="100%">
              <tbody>
                  <tr>
                      <td bgcolor="#ffffff" style="width: 219px; height: 9px">
                          订单编号：<asp:TextBox ID="SalesOutID" runat="server" CssClass="txt_left" ReadOnly="True"
                              Width="150px"></asp:TextBox></td>
                      <td bgcolor="#ffffff" style="width: 270px; height: 9px">
                          制单日期：
                          <asp:TextBox ID="CreateDate" runat="server" CssClass="txt_left" ReadOnly="True" Width="99px"></asp:TextBox>
                      </td>
                      <td bgcolor="#ffffff" style="width: 418px; height: 9px">
                          销售订单 ：
                          &nbsp;&nbsp;<asp:TextBox ID="SalesOrderID" runat="server" CssClass="txt_left"
                              ReadOnly="True" Width="150px"></asp:TextBox></td>
                      <td bgcolor="#ffffff" style="height: 9px">
                      </td>
                  </tr>
                  <tr>
                      <td bgcolor="#ffffff" colspan="2" style="height: 13px">
                          &nbsp;配送方式：&nbsp;
                      
                          <asp:DropDownList ID="DeliveryID" runat="server" DataTextField="DeliveryName" DataValueField="DeliveryID" >
                          </asp:DropDownList>
                          <input id="DeliveryIDh" style="width: 46px" type="hidden" runat="server" /></td>
                      <td bgcolor="#ffffff" style="width: 418px; height: 13px">
                          出库日期：<asp:TextBox ID="TradeDate" runat="server" 
                              Width="111px"></asp:TextBox>&nbsp;
                          <img alt="弹出日历下拉菜单" height="16" onclick="fPopUpCalendarDlg(TradeDate);return false;"
                              src="../images/calendar.gif" style="cursor: hand" width="16" />
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="不能为空" ControlToValidate="TradeDate"></asp:RequiredFieldValidator></td>
                      <td bgcolor="#ffffff" style="height: 13px">
                      </td>
                  </tr>
                  <tr>
                      <td bgcolor="#ffffff" colspan="2" style="height: 32px">
                          收款帐号：&nbsp;
                          <asp:DropDownList ID="AccountsID" runat="server" DataTextField="AccountsName" DataValueField="AccountsID" >
                          </asp:DropDownList>
                          <input id="AccountsIDh" style="width: 51px" type="hidden" runat="server" /></td>
                      <td bgcolor="#ffffff" style="width: 418px; height: 32px">
                          <span style="font-size: 10pt; font-family: 宋体">领货人<asp:TextBox ID="Consignee" runat="server" Width="90px"></asp:TextBox></span></td>
                      <td bgcolor="#ffffff" style="height: 32px">
                      </td>
                  </tr>
                  <tr>
                      <td bgcolor="#ffffff" colspan="2" style="height: 30px">
                          折扣金额：<asp:TextBox ID="Discount"  runat="server" Width="90px"></asp:TextBox>(原)<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Discount"
                        ErrorMessage="信息输入有误" ValidationExpression="^[0-9]*\.?[0-9]{0,2}$"></asp:RegularExpressionValidator></td>
                      <td bgcolor="#ffffff" style="width: 418px; height: 30px">
                          运费：<asp:TextBox ID="AttachPay" runat="server" Width="90px"></asp:TextBox>(原)
                          
                          
                          <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="AttachPay"
                        ErrorMessage="信息输入有误" ValidationExpression="^[0-9]*\.?[0-9]{0,2}$"></asp:RegularExpressionValidator></td>
                      <td bgcolor="#ffffff" style="height: 30px">
                      </td>
                  </tr>
                  <tr>
                      <td bgcolor="#ffffff" colspan="3" style="height: 34px">
                          备 &nbsp; &nbsp;注：
                          <asp:TextBox ID="Description" runat="server" Width="484px"></asp:TextBox>
                          &nbsp;&nbsp;
                      </td>
                      <td bgcolor="#ffffff" style="height: 34px">
                      </td>
                  </tr>
              </tbody>
          </table>
      </DIV></DIV>
        <br />
        <DIV  id="nextInfo1"
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 948px; BORDER-BOTTOM: #a4d5e3 1px solid; height: 155px;">
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
                                                顾客姓名：:<asp:TextBox ID="CustomerName" runat="server" 
                                                    Width="131px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CustomerName"
                                                    ErrorMessage="不能为空"></asp:RequiredFieldValidator></td>
                                            <TD bgColor=#ffffff style="height: 1px; width: 378px;" colspan="2" align="left">
                                                &nbsp;顾客聊号：<select id="CustomerIDType" style="width: 54px" runat="server">
                                                    <option value="QQ">QQ</option>
                                                    <option value="WW">旺旺</option>
                                                    <option value="QT">其它</option>
                                                </select>&nbsp;
                                                <asp:TextBox ID="CustomerID" runat="server" 
                                                    Width="99px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="CustomerID"
                                                    ErrorMessage="不能为空"></asp:RequiredFieldValidator>
                                                <input id="CustomerIDTypeh" style="width: 31px" type="hidden" runat="server" /></td>
                                        </tr>
                                        <TR>
                                            <TD bgColor=#ffffff colSpan=2 style="height: 6px; width: 396px;" align="left">
                                                顾客电话：&nbsp; :
                                                <asp:TextBox ID="CustomerTel" runat="server" Width="130px"></asp:TextBox></td>
                                            <TD bgColor=#ffffff style="height: 6px; width: 378px;" colspan="2" align="left">
                                                &nbsp;顾客邮编：<asp:TextBox ID="CustomerPost" runat="server" 
                                                    Width="99px"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="CustomerPost"
                                                    ErrorMessage="不能为空"></asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td align="left" bgcolor="#ffffff" colspan="2" style="width: 396px; height: 26px">
                                                消费平台：<asp:DropDownList ID="Platform" runat="server"
                                                    DataTextField="PlatformName" DataValueField="PlatformID">
                                                </asp:DropDownList>
                                                <input id="Platformh" style="width: 51px" type="hidden" runat="server" />
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="Platform"
                                                    ErrorMessage="不能为空"></asp:RequiredFieldValidator></td>
                                            <td align="left" bgcolor="#ffffff" colspan="2" style="width: 378px; height: 26px">
                                                顾客所在地区： <select name="select" id="CustomerArea" runat="server">
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
      </select>&nbsp;</td>
                                        </tr>
                                        <TR>
                                            <TD bgColor=#ffffff colSpan=4 style="height: 34px" align="left">
                                                顾客地址：
                                                <asp:TextBox ID="DeliveryPlace" runat="server" Width="649px"></asp:TextBox>
                                                &nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                                    ControlToValidate="CustomerArea" ErrorMessage="不能为空"></asp:RequiredFieldValidator>
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
        <br />
        <DIV  id="nextInfo2"
      style="BORDER-RIGHT: #a4d5e3 1px solid; BORDER-TOP: #a4d5e3 1px solid; BACKGROUND: url(images/content_bg1.gif) #ffffff repeat-x 50% bottom; MARGIN-BOTTOM: 8px; BORDER-LEFT: #a4d5e3 1px solid; WIDTH: 952px; BORDER-BOTTOM: #a4d5e3 1px solid; height: 155px; font-size: 12px; color: #000000;">
            <H2 
      style="PADDING-RIGHT: 0px; PADDING-LEFT: 8px; FONT-SIZE: 14px; BACKGROUND: #e2f3fa; PADDING-BOTTOM: 0px; MARGIN: 0px; COLOR: #0066a9; LINE-HEIGHT: 24px; PADDING-TOP: 0px; BORDER-BOTTOM: #a4d5e3 1px solid"><img id="Img2"  src="../images/collapse_arrow.png" />
                                &nbsp;商 品 信 息</h2>
            <DIV style="MARGIN: 5px">
                <TABLE cellSpacing=0 cellPadding=0 align=center border=0 style="height: 133px; width: 99%;" >
                    <TBODY>
                        <TR>
                            <TD bgColor=#ffffff style="height: 118px; width: 910px;" valign="top" align="center">
                                <div id="Detail" style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid;
                                    background: url(../images/content_bg1.gif) repeat-x 50% bottom; float: left;
                                    margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 928px; border-bottom: #a4d5e3 1px solid;
                                    height: 122px">
                                    <div style="margin: 5px">
                                        <table border="0" style="width: 908px; height: 77px">
                                            <tr>
                                                <td height="24" style="width: 50px">
                                                    商品：</td>
                                                <td style="width: 212px">
                                                    &nbsp;<input id="ProductsName" class="txt_left" readonly="readonly" style="width: 71px"
                                                        type="text" />
                                                    <input id="ProductsID" style="width: 17px" type="hidden" />
                                                </td>
                                                <td width="55">
                                                    价钱</td>
                                                <td style="width: 172px">
                                                    &nbsp;<input id="Price" class="txt_left" onblur="checkPrice(this)" readonly="readonly"
                                                        style="width: 99px" type="text" value="0" />RMB</td>
                                                <td style="width: 79px">
                                                    <p>
                                                        数量</p>
                                                </td>
                                                <td style="width: 204px">
                                                    &nbsp;<input id="Quantity" class="txt_left" onblur="checkQuantity(this)" readonly="readonly"
                                                        style="width: 83px" type="text" value="0" /></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 50px; height: 32px">
                                                    折扣率</td>
                                                <td style="width: 212px; height: 32px">
                                                    &nbsp;<input id="DiscountRate" class="txt_left" onblur="checkTaxRate(this)" readonly="readonly"
                                                        style="width: 99px" type="text" value="0" /></td>
                                                <td colspan="4" style="height: 32px">
                                                    &nbsp; 库房：<asp:TextBox ID="StoreHouseID" runat="server" CssClass="txt_left" ReadOnly="True"
                                                        Width="69px"></asp:TextBox>
                                                    库区：<asp:TextBox ID="HouseDetailID" runat="server" CssClass="txt_left" ReadOnly="True"
                                                        Width="55px"></asp:TextBox>
                                                    <input id="gyshButtun" class="input" name="yyBtn0" onclick="gysSelect()" type="button"
                                                        value="引用" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="22" style="width: 50px">
                                                </td>
                                                <td colspan="5">
                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                    &nbsp;&nbsp;
                                                    <img id="IMG1" onclick="return ajaxSubmit()" src="../images/Save.gif" />&nbsp;
                                                    <input id="NewOrEdit" style="width: 51px" type="hidden" value="new" />
                                                    <input id="DetailIDvalue" style="width: 51px" type="hidden" value="0" /></td>
                                            </tr>
                                        </table>
                                        &nbsp;</div>
                                </div>
                                <div id="initSubmitInfo" style="width: 800px">
                                </div>
                                <br />
                                </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <br /><table style="width: 941px">
            <tr>
                <td style="width: 411px">
                </td>
                <td >
                    <asp:Button ID="Button1" runat="server" Text="提交修改" Width="108px" OnClick="Button1_Click" />&nbsp;
                    <asp:Button ID="Button2" runat="server" Text="放弃修改" OnClientClick="javascript:window.close()" /></td>
                <td>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>