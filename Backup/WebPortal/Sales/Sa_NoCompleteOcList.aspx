<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_NoCompleteOcList.aspx.cs" Inherits="WebPortal.Sales.Sa_NoCompleteOcList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <%--<link rel="stylesheet" href="/css/bootstrap.min.css"/>  --%>
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>

    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>

    <script type="text/javascript" >
        function PopMat() {
            var result = showModalDialog('../Base/ShowMatCode.aspx', 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no'); //打开模态子窗体,并获取返回值
            document.getElementById("txtMat").value = result.split("'")[0]; //返回值分别赋值给相关文本框
        }
        function PopPrd() {
            var result = showModalDialog('../Base/ShowProdType.aspx', 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no'); //打开模态子窗体,并获取返回值
            document.getElementById("txtProd").value = result.split("'")[0]; //返回值分别赋值给相关文本框
        }
        function PopSize() {
            var result = showModalDialog('../Base/ShowSizeCode.aspx', 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no'); //打开模态子窗体,并获取返回值
            document.getElementById("txtSize").value = result.split("'")[0]; //返回值分别赋值给相关文本框
        }
        function PopClr() {
            var result = showModalDialog('../Base/ShowClrCode.aspx', 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no'); //打开模态子窗体,并获取返回值
            document.getElementById("txtClr").value = result.split("'")[0]; //返回值分别赋值给相关文本框
        }
        function PopSeason() {
            var result = showModalDialog('../Base/ShowSeasonCode.aspx', 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no'); //打开模态子窗体,并获取返回值
            document.getElementById("txtSeason").value = result.split("'")[0]; //返回值分别赋值给相关文本框
        } 
    </script>


    <script language="JavaScript" type="text/javascript">
        var new_window;
        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }


        //以下導出到EXCEL，是不用安裝ActiveX控件的，也不用降低IE的安全設定

        function getXlsFromTbl(objWin, inTblId, inWindow,excelVer) {
            new_window = objWin;
            //判斷表中是否存在記錄
            var tableObj = document.getElementById("tableDetail");

            if (tableObj == null) {
                alert('記錄不存在,不能匯出!');
                return false;
            }
            try {
                var allStr = "";
                var curStr = "";
                //alert("getXlsFromTbl"); 
                if (inTblId != null && inTblId != "" && inTblId != "null") {
                    curStr = getTblData(inTblId, inWindow);
                }
                if (curStr != null) {
                    allStr += curStr;
                }
                else {
                    alert("你要导出的表不存在！");
                    return;
                }
                //                var fileName = getExcelFileName();
                //                var office_ver = readOfficeVersion(); //獲取Office版本號，根據不同版本號，得到Excel擴展名
                var file_ext = ".xls";
                if (excelVer == "2010") {
                    file_ext = ".xlsx";
                }
                var fileName = "OC資料未完成報表";

                fileName = fileName + file_ext;
                doFileExport(fileName, allStr);
            }
            catch (e) {
                alert("导出发生异常:" + e.name + "->" + e.description + "!");
            }
        }
        function getTblData(inTbl, inWindow) {
            var rows = 0;
            //alert("getTblData is " + inWindow); 
            var tblDocument = document;
            if (!!inWindow && inWindow != "") {
                if (!document.all(inWindow)) {
                    return null;
                }
                else {
                    tblDocument = eval(inWindow).document;
                }
            }
            var curTbl = tblDocument.getElementById("tableDetail");
            var outStr = "";
            outStr += "<table borderColor='black' border='1' >";
            //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");

            outStr += "<tbody>";
            if (curTbl != null) {
                for (var j = 0; j < curTbl.rows.length; j++) {
                    outStr += "<tr class='firstTR'>";
                    for (var i = 0; i < curTbl.rows[j].cells.length; i++) {

                        if (j!=0 && (i == 1 || i == 2 || i == 9 || i == 10 || i == 14 || i == 5 || i == 16))
                            outStr += "<td>" + "=\"" + curTbl.rows[j].cells[i].innerText + "\"" + "</td>";
                        else
                            outStr += "<td>" + curTbl.rows[j].cells[i].innerText + "</td>";

                    }
                    outStr += "</tr>";
                }
                outStr += "</tbody></table>";
            }
            else {
                outStr = null;
                alert(inTbl + "不存在!");
            }
            return outStr;
        }
        function getExcelFileName() {
            var d = new Date();
            var curYear = d.getYear();
            var curMonth = "" + (d.getMonth() + 1);
            var curDate = "" + d.getDate();
            var curHour = "" + d.getHours();
            var curMinute = "" + d.getMinutes();
            var curSecond = "" + d.getSeconds();
            if (curMonth.length == 1) {
                curMonth = "0" + curMonth;
            }
            if (curDate.length == 1) {
                curDate = "0" + curDate;
            }
            if (curHour.length == 1) {
                curHour = "0" + curHour;
            }
            if (curMinute.length == 1) {
                curMinute = "0" + curMinute;
            }
            if (curSecond.length == 1) {
                curSecond = "0" + curSecond;
            }
            var fileName = "leo_zhang" + "_" + curYear + curMonth + curDate + "_"
             + curHour + curMinute + curSecond + ".csv";
            //alert(fileName); 
            return fileName;
        }
        function doFileExport(inName, inStr) {
            var xlsWin = null;
            if (!!document.all("glbHideFrm")) {
                xlsWin = glbHideFrm;
            }
            else {
                //                var width = 6;
                //                var height = 4;
                //                var openPara = "left=" + (window.screen.width / 2 - width / 2)
                //                 + ",top=" + (window.screen.height / 2 - height / 2)
                //                 + ",scrollbars=no,width=" + width + ",height=" + height;
                //                xlsWin = window.open("", "_blank", openPara);

                xlsWin = new_window;
            }
            xlsWin.document.write(inStr);
            xlsWin.document.close();
            xlsWin.document.execCommand('Saveas', true, inName);
            xlsWin.close();
        }

    </script>


    <%--   <style type="text/css"> 
        .divShowQueryImg{ border:1px solid #000; height:80px;overflow:hidden;} 
        .divShowQueryImg img{max-width:60px;_width:expression(this.width > 300 ? "300px" : this.width);} 
        .tableDetails{table-layout: fixed;word-break: break-all; word-wrap: break-word;}
        .award-name1{height:20px;width:60px;-o-text-overflow:ellipsis;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;width:100%;overflow-x:hidden;overflow-y:hidden; }
        .overfllow1{width:120px;word-wrap:break-word;}
    </style> --%>

    


</head>
<body>


    <div id="container">

    <table class="table_SiteMapPath">
    <tr>
    <td>
    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
          </asp:SiteMapPath>
    </td>
    </tr>
    </table>

    <div id="content"> 
    <form id="form1" runat="server">


    <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
        </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>

    <div class="div_search_frame">
    <table width="1200px" border="2" cellspacing="1" cellpadding="2" align="left"  style="margin:0px;"> 
	<tr>
		<td style="width:10%">
        <asp:Button class="btn btn-success" id="btnFind" Text="查找" OnClick="btnFind_Click"  Width="90%" Height ="30px"  runat="server"/>
        </td>
        <td style="width:10%">
        <button class="btn btn-success" style="width:90%" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail','2003');">匯出到Excel(2003)</button> 
        </td>
        <td style="width:10%">
        <button class="btn btn-success" style="width:90%" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail','2010');">匯出到Excel(2010)</button> 
        </td>
        <td style="width:70%">已過期未完成制單，以貨是否已到包裝部為准：請輸入條件，按查找。
        </td>
                
  	</tr>

  	</table>
    </div>
    <div class="div_search_frame">
    <table style="table-layout:fixed;word-wrap:break-word;word-break:break-all;" border="2" width="1200px">
    <tr id="L1" style="height:20px">
    <td style="width:8%">
    開單日期
    </td>
    <td style="width:10%">
    <input size="12" type="text" id="crDateStart" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td style="width:5%">
    To
    </td>
    <td style="width:10%">
    <input size="12" type="text" id="crDateEnd" style="height:18px;width:120px" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td style="width:5%">
    開單人
    </td>
    <td style="width:8%">
    <asp:TextBox id="txtCrBy" Text="" Width ="120px" runat="server"/>
    </td>
    <td style="width:8%">
    客戶PO
    </td>
    <td style="width:8%">
    <asp:TextBox id="txtPoNo" Width ="120px" Text="" runat="server"/>
    </td>
    <td style="width:8%">
    客人產品編號
    </td>
    <td colspan="2" style="width:16%">
    <asp:TextBox id="txtCust_Goods" Width ="120px" Text="" runat="server"/>
    </td>
    </tr>

    <tr id="L2">
    <td>
    制單編號
    </td>
    <td>
    <asp:TextBox id="txtMo1" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    To
    </td>
    <td>
    <asp:TextBox id="txtMo2" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    客戶編號
    </td>
    <td>
    <asp:TextBox id="txtCust" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    洋行代號
    </td>
    <td>
    <asp:TextBox id="txtAgent1" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    客人產品顏色
    </td>
    <td colspan="2">
    <asp:TextBox id="txtCust_Color" Width ="120px" Text="" runat="server"/>
    </td>

   </tr>
   <tr id="L3">
   <td>
    訂單日期
    </td>
    <td>
    <input size="12" type="text" id="orderDateStart" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td>
    To
    </td>
    <td>
    <input size="12" type="text" id="orderDateEnd" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td>
    牌子編號
    </td>
    <td>
    <asp:TextBox id="txtBrand" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    OC編號
    </td>
    <td>
    <asp:TextBox id="txtOcNo" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    客人款號
    </td>
    <td colspan="2">
    <asp:TextBox id="txtCust_Style" Width ="120px" Text="" runat="server"/>
    </td>
    </tr>

    <tr  id="L4">
    <td>
    物料種類
    </td>
    <td>
    <asp:TextBox id="txtMat" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    <asp:Button ID="btnPopMat" runat="server" Text="..." Width="40px" OnClientClick="PopMat()" />
    </td>
    <td>
    產品類型
    </td>
    <td>
    <asp:TextBox id="txtProd" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    <asp:Button ID="btnPopPrd" runat="server" Text="..." Width="40px" OnClientClick="PopPrd()" />
    </td>
    <td>
    圖樣代號
    </td>
    <td>
    <asp:TextBox id="txtArt" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    尺寸代號
    </td>
    <td>
    <asp:TextBox id="txtSize" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    <asp:Button ID="btnPopSize" runat="server" Text="..." Width="40px" OnClientClick="PopSize()" />
    </td>
    
    </tr>

    <tr  id="L5">
    <td>
    組別
    </td>
    <td>
    <asp:DropDownList ID="dlMo_group" Width ="140px" runat="server" />
    </td>
    <td>
    季度
    </td>
    <td>
    <asp:TextBox id="txtSeason" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    <asp:Button ID="btnPopSeason" runat="server" Text="..." Width="40px" OnClientClick="PopSeason()" />
    </td>
    <td>
    <div class="checkbox">
		<label>
			<input runat="server" id="chkShowA_part" type="checkbox"/>只顯示A件
		</label>
	</div>
    </td>
    
    <td>
    顏色代號
    </td>
    <td>
    <asp:TextBox id="txtClr" Width ="120px" Text="" runat="server"/>
    </td>
    <td  colspan="3">
    <asp:Button ID="btnPopClr" runat="server" Text="..." Width="40px" OnClientClick="PopClr()" />
    </td>
    </tr>

    <tr id="L6">
    <td>
    是否顯示過期單
    </td>
    <td colspan="3" height="28px">
    <asp:DropDownList ID="dlShowPeriod" Width ="360px" runat="server" height="30px" >
        <asp:ListItem>顯示全部</asp:ListItem>
        <asp:ListItem>未完成制單(以貨未到包裝部為准)--過期</asp:ListItem>
        <asp:ListItem>未完成制單(以包裝部未出貨為准)--過期</asp:ListItem>
        <asp:ListItem>已過交貨日仍未到包裝</asp:ListItem>
        </asp:DropDownList>
    </td>
    <td>
    客人要求交貨期
    </td>
    <td>
    <input size="11" type="text" id="custReqDateStart" height="20px" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td>
    To
    </td>
    <td>
    <input size="11" type="text" id="custReqDateEnd" height="20px" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td>
    產品編號
    </td>
    <td  colspan="2">
    <asp:TextBox id="txtGoods_id" Width ="200px" height="18px" Text="" runat="server"/>
    </td>

    </tr>


    <tr id="L7">
    <td  colspan="11" height="32px">
    <asp:Label id="lblShowPeriodInfo" Text="" Font-Size="13px" ForeColor="Red" runat="server"/>
    </td>
    </tr>
    </table>
    </div>

    <table width="98%" border="0" cellpadding="0" cellspacing="2" align="center">
    <tr>
    <td>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="show_query_img">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
    </asp:UpdateProgress> 
    </td>
    </tr>
    </table>


    <div id="divDetail" class="div_table_scroll" runat="server">
        <%--<table class="tableDetails" id="tableDetail" width="98%" border="1" cellspacing="1" cellpadding="2" align="center" style="margin:0px;">--%>
      
        <table class="table-responsive table-hover" cellspacing="0" width="100%" id="tableDetail" align="center" border="1" cellpadding="2">
  			 <thead>
             <tr class="a1" style="color:#ffffff;font-size:12px;">
                <th width="30">制單編號</th>
                <th width="30">開單日期</th>
                <th width="30">訂單日期</th>
                <th width="40">產品編號</th>
                <th width="60">產品描述</th>
                <th width="30">未完成貨品</th>
                <th width="30">計劃生產數量(PCS)</th>
                <th width="30">訂單數量(PCS)</th>
                <th width="30">完成數量(PCS)</th>
                <th width="30">要求包裝部完成日期</th>
                <th width="30">實際完成日期</th>
                <th width="30">過期天數</th>
                <th width="30">負責部門</th>
                <th width="30">收貨部門</th>
                <th width="30">客人要求交貨期</th>
                <th width="30">計劃回港日期期</th>
                <th width="30">實際回港日期</th>
                <th width="30">實際回港數量(PCS)</th>
                <th width="30">生產備註</th>
                <th width="30">OC編號</th>
                <th width="30">產品編號A件</th>
                <th width="30">訂單數量</th>
                <th width="30">數量單位</th>
                <th width="30">單價</th>
                <th width="30">單價單位</th>
                <th width="30">貨幣代號</th>
                <th width="30">客戶編號</th>
                <th width="30">客戶描述</th>
                <th width="30">牌子編號</th>
                <th width="30">洋行代號</th>
                <th width="30">開單人</th>
                <th width="30">組別</th>
                <th width="30">顏色描述</th>
                <th width="40">顏色做法</th>
                <th width="30">客人產品編號</th>
                <th width="30">客人產品顏色</th>
                <th width="30">季度</th>
                <th width="30">客戶PO</th>
                <th width="30">客戶款號</th>
                <th width="30">補正單頁數</th>
             </tr> 
             </thead>
             <tbody>
            <asp:Repeater ID="OrderList" runat="server">
            <ItemTemplate>
                <tr>
                <td><div class="award-name"><%#Eval("mo_id")%></div></td>
            	<td><div class="award-name"><%#Eval("create_date")%></div></td>
            	<td><div class="award-name"><%#Eval("order_date")%></div></td>
                <td><div class="award-name"><%#Eval("goods_id")%></div></td>
            	<td><div class="overfllow"><%#Eval("goods_name")%></div></td>
                <td><div class="award-name"><%#Eval("wp_goods_id")%></div></td>
            	<td><div class="award-name"><%#Eval("prod_qty")%></div></td>
                <td><div class="award-name"><%#Eval("qty_pcs")%></div></td>
            	<td><div class="award-name"><%#Eval("c_qty_ok")%></div></td>
                <td><div class="award-name"><%#Eval("t_complete_date")%></div></td>
            	<td><div class="award-name"><%#Eval("f_complete_date")%></div></td>
                <td><div class="award-name"><%#Eval("period_day")%></div></td>
            	<td><div class="award-name"><%#Eval("wp_id")%></div></td>
                <td><div class="award-name"><%#Eval("next_wp_id")%></div></td>
            	<td><div class="award-name"><%#Eval("cs_req_date")%></div></td>
                <td><div class="award-name"><%#Eval("hk_req_date")%></div></td>
            	<td><div class="award-name"><%#Eval("act_to_hk_date")%></div></td>
                <td><div class="award-name"><%#Eval("act_to_hk_qty")%></div></td>
            	<td><div class="award-name"><%#Eval("production_remark")%></div></td>
                <td><div class="award-name"><%#Eval("id")%></div></td>
            	<td><div class="award-name"><%#Eval("goods_id_part")%></div></td>
                <td><div class="award-name"><%#Eval("order_qty")%></div></td>
            	<td><div class="award-name"><%#Eval("goods_unit")%></div></td>
                <td><div class="award-name"><%#Eval("unit_price")%></div></td>
            	<td><div class="award-name"><%#Eval("p_unit")%></div></td>
                <td><div class="award-name"><%#Eval("m_id")%></div></td>
            	<td><div class="award-name"><%#Eval("cust_code")%></div></td>
            	<td><div class="award-name"><%#Eval("cust_cname")%></div></td>
                <td><div class="award-name"><%#Eval("brand_id")%></div></td>
            	<td><div class="award-name"><%#Eval("agent")%></div></td>
                <td><div class="award-name"><%#Eval("create_by")%></div></td>
            	<td><div class="award-name"><%#Eval("mo_group")%></div></td>
                <td><div class="award-name"><%#Eval("color_name")%></div></td>
            	<td><div class="award-name"><%#Eval("do_color")%></div></td>
                <td><div class="award-name"><%#Eval("customer_goods")%></div></td>
            	<td><div class="award-name"><%#Eval("customer_color_id")%></div></td>
                <td><div class="award-name"><%#Eval("season")%></div></td>
            	<td><div class="award-name"><%#Eval("contract_id")%></div></td>
                <td><div class="award-name"><%#Eval("table_head")%></div></td>
            	<td><div class="award-name"><%#Eval("repair_mo_id")%></div></td>
                </tr>
            </ItemTemplate>
            </asp:Repeater>
            </tbody>
        </table>
    </div>





    <asp:Label id="lblShowTotalRec" Text="記錄數：" Width ="120px" Font-Size="16px" ForeColor="Blue" runat="server"/>


    </ContentTemplate>
        


    </asp:UpdatePanel> 


    </form>
    </div>
    </div>
</body>
</html>
