<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Oc_DelivStatus.aspx.cs" Inherits="WebPortal.Sales.Sa_Oc_DelivStatus" EnableEventValidation = "false" %>

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



    <script language="JavaScript" type="text/javascript">
        //以下導出到EXCEL，是不用安裝ActiveX控件的，也不用降低IE的安全設定

        function getXlsFromTbl(objWin, inTblId, inWindow) {
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
                var fileName = "OC發貨狀態記錄";

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

                        if (j!=0 && (i == 1 || i == 2 || i == 8 || i == 9 || i == 11 || i == 12))
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
    <table width="98%" border="2" cellspacing="1" cellpadding="2" align="center"  style="margin:0px;">
    <tr>
    <td colspan="2">
    <asp:Button class="btn btn-success" id="btnFind" Text="查找" OnClick="btnFind_Click" Width="160px" Height ="30px"  runat="server"/>
    </td>
    <td colspan="2">
    <button class="btn btn-success" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail');" style="width:160px">Excel Export</button> 
    </td>
    <td colspan="6">
    <asp:Label id="lblShowInfo" Text="訂單是否已發貨(已開發票或送貨單)：請輸入條件，查找。"  ForeColor="Blue" Font-Size="13px" runat="server"/>
    </td>
    </tr>
    <tr>
    <td style="width:5%">
    <asp:Label id="lblCrDate1" Text="開單日期" Width ="60px" Font-Size="13px" runat="server"/>
    
    </td>
    <td style="width:10%">
    <input size="12" type="text" id="createDateStart" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td style="width:2%">
    <asp:Label id="lblTo3" Text="To" Width ="20px" Font-Size="13px" runat="server"/>
    </td>
    <td style="width:10%">
    <input size="12" type="text" id="createDateEnd" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td style="width:5%">
    <asp:Label id="lblDate1" Text="訂單日期" Width ="60px" Font-Size="13px" runat="server"/>
    
    </td>
    <td style="width:5%">
    <input size="12" type="text" id="orderDateStart" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td style="width:2%">
    <asp:Label id="lblTo2" Text="To" Width ="20px" Font-Size="13px" runat="server"/>
    </td>
    <td style="width:10%">
    <input size="12" type="text" id="orderDateEnd" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td style="width:5%">
    <asp:Label id="lblCust" Text="客戶編號" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td style="width:46%">
    <asp:TextBox id="txtCust" Width ="120px" Text="" runat="server"/>
    </td>
    </tr>

    <tr>
    <td>
    <asp:Label id="lblMo" Text="制單編號" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td>
    <asp:TextBox id="txtMo1" Width ="120px" Text="" AutoPostBack="true" runat="server"/>
    </td>
    <td>
    <asp:Label id="lblTo1" Text="To" Width ="20px" Font-Size="13px" runat="server"/>
    </td>
    <td>
    <asp:TextBox id="txtMo2" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    <asp:Label id="lblBrand" Text="牌子編號" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td>
    <asp:TextBox id="txtBrand" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    <asp:Label id="lblPoNo" Text="客戶PO" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td colspan="3">
    <asp:TextBox id="txtPoNo" Width ="120px" Text="" runat="server"/>
    </td>
    </tr>
    <tr>
    <td>
    <asp:Label id="lblMo_group" Text="組別" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td>
    <asp:DropDownList ID="dlMo_group" Width ="140px" runat="server" />
    </td>
    <td>
    <asp:Label id="lblShowPeriod" Text="訂單狀態" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td colspan="7">
    <asp:DropDownList ID="dlShowPeriod" Width ="260px" runat="server">
        <asp:ListItem>顯示全部</asp:ListItem>
        <asp:ListItem>訂單已發貨</asp:ListItem>
        <asp:ListItem>訂單未發貨</asp:ListItem>
        <asp:ListItem>已開發票未送貨</asp:ListItem>
        <asp:ListItem>已送貨但送貨數与訂單數不相符</asp:ListItem>
        </asp:DropDownList>
    </td>
    </tr>
    </table>
    </div>
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

    <div id="divDetail" class="div_table_scroll" runat="server">
        <table  class="table-responsive table-hover" id="tableDetail" width="100%" border="1" cellspacing="1" cellpadding="2" align="center" style="margin:0px;">
  			 <thead class="fixedThead">
             <tr class="a1" style="color:#ffffff;font-size:12px;">
   				        <th>制單編號</th>
				        <th>開單日期</th>
                        <th>訂單日期</th>
                        <th>產品編號</th>
                        <th>產品描述</th>
                        <th>訂單數量(PCS)</th>
                        <th>完成數量(PCS)</th>
                        <th>發票數量(PCS)</th>
                        <th>計劃回港日期</th>
                        <th>完成(回港)日期</th>
                        <th>過期天數(按回港日期)</th>
                        <th>客人要求交貨期</th>
                        <th>發票(出貨)日期</th>
                        <th>過期天數(按客人要求日期)</th>
                        <th>發票(出貨)編號</th>
                        <th>開單狀態</th>
                        <th>送貨狀態</th>
                        <th>序號</th>
                        <th>營業員</th>
                        <th>客戶編號</th>
                        <th>客戶描述</th>
                        <th>客戶PO</th>
                        <th>客人產品編號</th>
                        <th>客人款號</th>
                        <th>牌子編號</th>
                        <th>OC編號</th>
                        <th>訂單數量</th>
                        <th>數量單位</th>
                        <th>單價</th>
                        <th>單價單位</th>
                        <th>訂單金額</th>
                        <th>貨幣代號</th>
                        <th>金額(HKD)</th>
                        <th>收費標識</th>
  			 </tr>  
  			</thead>

            <tbody class="M_scrollBar">
  			<asp:Repeater ID="wpDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td><a href="mo_ShowStatus.aspx?to_mo_id=<%# Eval("mo_id")%>" target="_blank"><%# Eval("mo_id")%></a></td>
                    <td><%#Eval("create_date")%></td>
                    <td><%#Eval("order_date")%></td>
                    <td><%#Eval("goods_id")%></td>
                    <td><%#Eval("goods_name")%></td>
                    <td><%#Eval("qty_pcs")%></td>
                    <td><%#Eval("return_qty")%></td>
                    <td><%#Eval("inv_qty_pcs")%></td>
                    <td><%#Eval("plan_complete")%></td>
                    <td><%#Eval("return_dat")%></td>
                    <td><%#Eval("out_date_hk")%></td>
                    <td><%#Eval("arrive_date")%></td>
                    <td><%#Eval("inv_dat")%></td>
                    <td><%#Eval("out_date_cs")%></td>
                    <td><%#Eval("inv_id")%></td>
                    <td><%#Eval("order_del_status")%></td>
                    <td><%#Eval("inv_state_desc")%></td>
                    <td><%#Eval("sequence_id")%></td>
                    <td><%#Eval("seller_id")%></td>
                    <td><%#Eval("it_customer")%></td>
                    <td><%#Eval("custname")%></td>
                    <td><%#Eval("contract_id")%></td>
                    <td><%#Eval("customer_goods")%></td>
                    <td><%#Eval("table_head")%></td>
                    <td><%#Eval("brand_id")%></td>
                    <td><%#Eval("id")%></td>
                    <td><%#Eval("order_qty")%></td>
                    <td><%#Eval("goods_unit")%></td>
                    <td><%#Eval("unit_price")%></td>
                    <td><%#Eval("p_unit")%></td>
                    <td><%#Eval("order_amt")%></td>
                    <td><%#Eval("m_id")%></td>
                    <td><%#Eval("amt_hkd")%></td>
                    <td><%#Eval("is_free")%></td>
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
