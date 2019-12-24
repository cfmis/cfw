<%@ Page Language="C#" AutoEventWireup="true" Inherits="Stock_Inventory_Add" Codebehind="Inventory_Add.aspx.cs" %>

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
                document.getElementById("StoreHouseID").value=val[0]; 
                document.getElementById("HouseDetailID").value=val[1]; 
                setBillNum();

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
                 setBillNum();

                }else
                {

                }
            
            }
  
  //根据库区 和 商品得到数量        
function setBillNum()
{
   var NUM="0";
   var  NHouseDetailID = document.getElementById("HouseDetailID");
   var  NProductsID = document.getElementById("ProductsID");
   if(NHouseDetailID.value=="")
   {
     return;
   }
   if(NProductsID.value=="")
   {
     return;
   }
   $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
              var xmlHttp=this.createXmlHttp();                       
            xmlHttp.onreadystatechange = function() {
                if (xmlHttp.readyState == 4) {
                   
                     showresult(xmlHttp.responseText);
                      $.unblockUI();// 
                     
                }
            }
    xmlHttp.open("GET", "ajaxResp.aspx?action=loadProductsStock&ProductsID="+NProductsID.value+"&HouseDetailID="+NHouseDetailID.value, true);
    xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    xmlHttp.send(null);//      

}

function showresult(str)
{
 document.getElementById("BillNum").value=str;
}
            
 function submitAdd()
        {
           
            var  NInventoryID = document.getElementById("InventoryID");
            var  NCreateDate = document.getElementById("CreateDate");
            var  NStoreHouseID = document.getElementById("StoreHouseID");
            var  NHouseDetailID = document.getElementById("HouseDetailID");
            var  NProductsID = document.getElementById("ProductsID");
            var  NRealityNum = document.getElementById("RealityNum");
            var  NBillNum = document.getElementById("BillNum");
            var  NAdjustNum = document.getElementById("AdjustNum");
            var  NOperator = document.getElementById("Operator");
            var  NTradeDate = document.getElementById("TradeDate");
            var  NDescription = document.getElementById("Description");
           
            if(NStoreHouseID.value=="")
            {
                alert("请选择库区");
               
			    return false;
            }
             if(NProductsID.value=="")
            {
                alert("请选择商品");
               
			    return false;
            }
            
             if(NRealityNum.value=="")
            {
                alert("实际数量不能为空");
               
			    return false;
            }
            if(!/^\d+$/.test(NRealityNum.value))
            {
                alert("实际数量应该是整数");
			   return false;
            }
            if(NRealityNum.value < 0)
            {
                alert("实际数量应该不小于0");
			   return false;
            } 
                    
                   if(NAdjustNum.value=="")
                    {
                        alert("调整数量不能为空");
                       
			            return false;
                    }
                    if(!/^\d+$/.test(NAdjustNum.value))
                    {
                        alert("调整数量应该是整数");
			           return false;
                    }
                    if(NAdjustNum.value < 0)
                    {
                        alert("调整数量应该不小于0");
			           return false;
                    }
            
            if(NTradeDate.value=="")
            {
              
               alert('盘点日期不能为空');
			   return false;
            }
           
            $.blockUI({message:"<img src=\"../images/load.gif\" />"});//阴影
                  var xmlHttp=this.createXmlHttp();
               xmlHttp.onreadystatechange = function() {
                    if (xmlHttp.readyState == 4) {
                       
                       ajaxSubmited();
                       alert("添加成功");
                       $.unblockUI();//
                       
                    }
                }
                xmlHttp.open("POST", "Inventory_Add.aspx", true);
                xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
                 xmlHttp.send("action=add&InventoryID="+NInventoryID.value+"&CreateDate="+NCreateDate.value+"&StoreHouseID="+NStoreHouseID.value+"&HouseDetailID="+NHouseDetailID.value+"&ProductsID="+NProductsID.value+"&RealityNum="+NRealityNum.value+"&BillNum="+NBillNum.value+"&AdjustNum="+NAdjustNum.value+"&Operator="+NOperator.value+"&TradeDate="+NTradeDate.value+"&Description="+NDescription.value+"");//   
        
            
        }
        
        function ajaxSubmited()
        {
                var i=1;
                i=this.document.getElementById("InventoryID").value;
                this.document.getElementById("InventoryID").value=i+1;
                this.document.getElementById("StoreHouseID").value="";
                this.document.getElementById("HouseDetailID").value="";
                this.document.getElementById("ProductsID").value="";
                this.document.getElementById("RealityNum").value="";
                this.document.getElementById("BillNum").value="";
                this.document.getElementById("AdjustNum").value="";
                this.document.getElementById("Operator").value="";
                this.document.getElementById("TradeDate").value="";
                this.document.getElementById("Description").value="";
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
    <TD class=title align=middle style="height: 39px"> 库 存 盘 点</TD></TR>
  <TR>
    <TD bgColor=#ffffff style="height: 118px" valign="top">
      <TABLE cellSpacing=1 cellPadding=1 width="100%" align=center border=0>
        <TBODY>
        <TR>
          <TD bgColor=#ffffff style="width: 462px; height: 9px;">
              单号：<asp:TextBox ID="InventoryID" runat="server" Width="150px" CssClass="txt_left" ReadOnly="True"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="width: 752px; height: 9px;">制单日期：
              <asp:TextBox ID="CreateDate" runat="server" Width="99px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              </TD>
          <TD bgColor=#ffffff style="height: 9px; width: 418px;">
              经办人： &nbsp;&nbsp;
              <asp:TextBox ID="Operator" runat="server" CssClass="txt_left"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 9px"></TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 12px">
              盘点库区 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 库房&nbsp; &nbsp;<asp:TextBox ID="StoreHouseID"  runat="server" Width="43px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
              &nbsp; &nbsp;&nbsp; 库区 &nbsp;
              <asp:TextBox ID="HouseDetailID" runat="server" CssClass="txt_left" Width="39px"></asp:TextBox>&nbsp;
              <INPUT class="input" onclick="gysSelect()" type=button value=引用 name="yyBtn0" id="gyshButtun">
              </TD>
          <TD bgColor=#ffffff style="height: 12px; width: 418px;">
              执行日期：<asp:TextBox ID="TradeDate" runat="server" Width="90px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>&nbsp;
              <IMG 
            style="CURSOR: hand" 
            onclick="fPopUpCalendarDlg(TradeDate);return false;" height=16 
            alt=弹出日历下拉菜单 src="../images/calendar.gif" width=16></TD>
          <TD bgColor=#ffffff style="height: 12px"> </TD></TR>
        <TR>
          <TD bgColor=#ffffff colSpan=2 style="height: 30px">
              盘点 商品 &nbsp; &nbsp; &nbsp; &nbsp; 
                    <asp:TextBox ID="ProductsID" runat="server" Width="54px" CssClass="txt_left" ReadOnly="True"></asp:TextBox>
                    <INPUT class="input" onclick="productsSelect()" type=button value=引用 name="yyBtn0" id="Button2">
          </TD>
          <TD bgColor=#ffffff style="height: 30px; width: 418px;"></TD>
          <TD bgColor=#ffffff style="height: 30px"> </TD></TR>
            <tr>
                <td bgcolor="#ffffff" colspan="2" style="height: 26px">
                    账面数量
                    <asp:TextBox ID="BillNum" runat="server" Width="37px" CssClass="txt_left" ReadOnly="True">0</asp:TextBox>
                    &nbsp; &nbsp; &nbsp; 实际数量： &nbsp; &nbsp; &nbsp; 
                    <asp:TextBox ID="RealityNum" runat="server" Width="65px" CssClass="txt_left"></asp:TextBox>
                    &nbsp; &nbsp; 调整数量：<asp:TextBox ID="AdjustNum" runat="server" CssClass="txt_left" Width="116px"></asp:TextBox></td>
                <td bgcolor="#ffffff" style="width: 418px; height: 26px">
                    &nbsp;</td>
                <td bgcolor="#ffffff" style="height: 26px">
                </td>
            </tr>
        <TR>
          <TD bgColor=#ffffff colSpan=3 style="height: 28px">备&nbsp;&nbsp;&nbsp;&nbsp;注： &nbsp;&nbsp;&nbsp;
              <asp:TextBox ID="Description" runat="server" Width="609px" CssClass="txt_left"></asp:TextBox></TD>
          <TD bgColor=#ffffff style="height: 28px"> </TD></TR>
            <tr>
                <td align="center" bgcolor="#ffffff" colspan="3" style="height: 28px">
                    <input id="Button1" onclick="javascript:if(!confirm('您确定要提交吗'))return  false;submitAdd()" type="button" value="提  交" /></td>
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

