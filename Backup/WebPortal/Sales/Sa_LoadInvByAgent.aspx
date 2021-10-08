<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_LoadInvByAgent.aspx.cs" Inherits="WebPortal.Sales.Sa_LoadInvByAgent" %>

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
        // EnableEventValidation="false" 設置這個gridview才可以按行選擇
        //by ahuinan 2009-4-10 
        function clearNoNum(event, obj) {
            //响应鼠标事件，允许左右方向键移动 
            event = window.event || event;
            if (event.keyCode == 37 | event.keyCode == 39) {
                return;
            }
            //先把非数字的都替换掉，除了数字和. 
            obj.value = obj.value.replace(/[^\d.]/g, "");
            //必须保证第一个为数字而不是. 
            obj.value = obj.value.replace(/^\./g, "");
            //保证只有出现一个.而没有多个. 
            obj.value = obj.value.replace(/\.{2,}/g, ".");
            //保证.只出现一次，而不能出现两次以上 
            obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
        }
        function checkNum(obj) {
            //为了去除最后一个. 
            obj.value = obj.value.replace(/\.$/g, "");
        }
        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }
    </script> 

    <script language="JavaScript" type="text/javascript">
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
                var fileName = "按洋行代號查詢發貨";

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

//                        if (i == 0 || i == 8 || i == 10 || i == 17)
//                            outStr += "<td>" + "=\"" + curTbl.rows[j].cells[i].innerText + "\"" + "</td>";
//                        else
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

    <table>
    <tr>
    <td>
    <asp:Button class="btn btn-success" id="btnFind" Text="查找" OnClick="btnFind_Click" Width="160px" Height ="30px"  runat="server"/>
    </td>
    <td>
    <button class="btn btn-success" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail','2003');" style="width:160px">Excel(2003)</button> 
    </td>
    <td>
    <button class="btn btn-success" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail','2010');" style="width:160px">Excel(2010)</button> 
    </td>
    </tr>
    </table>

    <div class="div_search_frame">
    <table style="table-layout:fixed;word-wrap:break-word;word-break:break-all;" border="2" width="1200px"> 
	
    <tr>
    <td style="width:10%">
    
    </td>
    <td style="width:8%">
    <asp:Label id="lblDate1" Text="發票日期" Width ="90%" runat="server"/>
    </td>
    <td style="width:10%">
    <input type="text" id="dateStart" style="height:18px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td style="width:3%">
    <asp:Label id="lblTo1" Text="To" Width ="90%" runat="server"/>
    </td>
    <td style="width:10%">
    <input type="text" id="dateEnd" style="height:18px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>

    <td style="width:5%">
    <asp:Label id="lblAgent" Text="洋行編號" Width ="90%" runat="server"/>
    </td>
    <td style="width:10%">
    <asp:TextBox id="txtAgent1" Width ="90%" Text="" onKeyUp="setValue(this,txtAgent2)" runat="server"/>
    </td>
    <td style="width:2%">
    <asp:Label id="lblTo2" Text="To" Width ="90%" runat="server"/>
    </td>
    <td style="width:10%">
    <asp:TextBox id="txtAgent2" Width ="90%" Text="" runat="server"/>
    </td>

    
    <td style="width:12%">
    
    </td>
    </tr>

    <tr>
    
    <td>
    <div class="checkbox">
		<label>
			<input style="width:20px" runat="server" id="chkShowVat" type="checkbox"/>查詢VAT的記錄
		</label>
	</div>

    </td>
    <td>
    <asp:Label id="Label1" Text="送貨日期(VAT)" Width ="90%" runat="server"/>
    </td>
    <td>
    <input type="text" id="vatDateStart" style="height:18px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})"/>
    </td>
    <td>
    <asp:Label id="ltlbTo4" Text="To" Width ="90%" runat="server"/>
    </td>
    <td>
    <input type="text" id="vatDateEnd" style="height:18px;width:90%" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td style="width:5%">
    <asp:Label id="lblBrand" Text="牌子編號" Width ="90%" runat="server"/>
    </td>
    <td style="width:10%">
    <asp:TextBox id="txtBrand1" Width ="90%" Text="" onKeyUp="setValue(this,txtBrand2)" runat="server"/>
    </td>
    <td style="width:2%">
    <asp:Label id="lblTo3" Text="To" Width ="90%" runat="server"/>
    </td>
    <td style="width:10%">
    <asp:TextBox id="txtBrand2" Width ="90%" Text="" runat="server"/>
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
             <tr class="a1" style="color:#FFFFFF;font-size:12px;">
   				        <th height="30">Supplier Name</th>
				        <th>牌子Code</th>
                        <th>Product Category</th>
    			        <th>Month</th>
				        <th>Year</th>
				        <th>Country of Origin</th>
				        <th>Vendor Name</th>
				        <th>Destination Country</th>
                        <th>Total Sales(in USD)</th>
                        <th>Volume</th>
                        <th>UNIT</th>
                        <th>Supplier Article</th>
                        <th>GAP RD #</th>
                        <th>Trim Type</th>
                        <th>Size</th>
                        <th>Finsh(顏色)</th>
                        <th>發票編號</th>
                        <th>序號</th>
                        <th>制單編號</th>
                        <th>產品編號</th>
                        <th>產品類型代號</th>
                        <th>尺寸代號</th>
                        <th>數量</th>
                        <th>數量單位</th>
                        <th>單價</th>
                        <th>單價單位</th>
                        <th>貨幣代號</th>
                        <th>HKD轉換率</th>
                        
  			 </tr>  
  			</thead>

            <tbody>
  			<asp:Repeater ID="wpDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td><%#Eval("sp_name")%></td>
      			    <td><%#Eval("brand_id")%></td>
                    <td><%#Eval("prd_cate")%></td>
      			    <td><%#Eval("inv_month")%></td>
      			    <td><%#Eval("inv_year")%></td>
      			    <td><%#Eval("c_name")%></td>
      			    <td><%#Eval("cust_name")%></td>
      			    <td><%#Eval("vend_dest")%></td>
                    <td><%#Eval("amt_usd")%></td>
                    <td><%#Eval("qty_pcs")%></td>
                    <td><%#Eval("unit_pcs")%></td>
                    <td><%#Eval("blueprint_id")%></td>
                    <td><%#Eval("customer_goods")%></td>
                    <td><%#Eval("prd_type_name")%></td>
                    <td><%#Eval("size_name")%></td>
                    <td><%#Eval("color_name")%></td>
                    <td><%#Eval("id")%></td>
                    <td><%#Eval("sequence_id")%></td>
                    <td><%#Eval("mo_id")%></td>
                    <td><%#Eval("goods_id")%></td>
                    <td><%#Eval("prod_type")%></td>
                    <td><%#Eval("size_id")%></td>
                    <td><%#Eval("u_invoice_qty")%></td>
                    <td><%#Eval("goods_unit")%></td>
                    <td><%#Eval("invoice_price")%></td>
                    <td><%#Eval("p_unit")%></td>
                    <td><%#Eval("m_id")%></td>
                    <td><%#Eval("m_rate")%></td>
  			     </tr>
  			    </ItemTemplate>
  			</asp:Repeater>
            </tbody>
            
  			 
		</table>
        </div>
        </ContentTemplate>

    </asp:UpdatePanel>

    </form>
    </div>
    </div>

</body>
</html>
