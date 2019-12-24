<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Oc_ShowStatus.aspx.cs" Inherits="WebPortal.Sales.Sa_Oc_ShowStatus" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>頁數匯總</title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <%--<link rel="stylesheet" href="/css/bootstrap.min.css"/>--%>  
    <script src="../js/util.js" type="text/javascript"></script> 
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>

    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <%--<link href="../bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen"/>
    <script type="text/javascript" src="../bootstrap/js/jquery-1.8.3.min.js" charset="UTF-8"></script>--%>
    <%--<script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>可以不用--%>
    <%--<script type="text/javascript" src="../bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>--%>
    

    <script language="JavaScript" type="text/javascript">

    function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }


        //以下導出導EXCEL，是不用安裝ActiveX控件的，也不用降低IE的安全設定

        function getXlsFromTbl(inTblId, inWindow,excel_ver) {

            //判斷表中是否存在記錄
            var tableObj = document.getElementById(inTblId);

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

                var fileName = "頁數匯總";
                var fileExt = ".xls";
                if (excel_ver == "2010")
                { fileExt = ".xlsx"; }
//                if (office_ver == "office2007" || office_ver == "office2010")
//                    file_ext = ".xlsx";
//                var fileName = "每日結存匯總表";

//                if (inTblId == "tableDetail") {
//                    fileName = "每日結存明細表";
//                }
                fileName = fileName + fileExt;
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
            var curTbl = tblDocument.getElementById(inTbl);
            var outStr = "";
            var col_str = "";
            
            outStr = "";
            outStr += "<table borderColor='black' border='1' >";
            //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");

            outStr += "<tbody>";
            outStr += "<tr class='firstTR'>";
            outStr += "<td width=80px>" + "新增期" + "</td>";
            outStr += "<td>" + "組別" + "</td>";
            outStr += "<td>" + "未完成頁數" + "</td>";
            outStr += "<td>" + "計劃回港期" + "</td>";
            outStr += "<td>" + "客人落單期" + "</td>";
            outStr += "<td>" + "要求完成期" + "</td>";
            outStr += "<td>" + "牌子編號" + "</td>";
            outStr += "<td>" + "客戶編號" + "</td>";
            outStr += "<td>" + "開單人" + "</td>";
            outStr += "<td>" + "急/特急狀態" + "</td>";
            outStr += "<td>" + "有否採購" + "</td>";
            outStr += "<td>" + "備註" + "</td>";
            outStr += "<td>" + "當前部門" + "</td>";
            outStr += "<td>" + "經過部門" + "</td>";
            outStr += "<td>" + "配件編號" + "</td>";
            outStr += "<td>" + "主件" + "</td>";
            outStr += "<td>" + "物料編號" + "</td>";
            outStr += "<td>" + "物料描述" + "</td>";
            outStr += "<td>" + "下部門" + "</td>";
            outStr += "<td>" + "洋行代號" + "</td>";
            outStr += "<td>" + "訂單數量" + "</td>";
            outStr += "<td>" + "數量單位" + "</td>";
            outStr += "<td>" + "實際回港日期" + "</td>";
            outStr += "</tr>";
            for (var j = 1; j < curTbl.rows.length; j++) {
                outStr += "<tr class='firstTR'>";
                outStr += "<td>" + "=\"" + curTbl.rows[j].cells[0].innerText + "\"" + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[1].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[2].innerText + "</td>";
                outStr += "<td>" + "=\"" + curTbl.rows[j].cells[3].innerText + "\"" + "</td>";
                outStr += "<td>" + "=\"" + curTbl.rows[j].cells[4].innerText + "\"" + "</td>";
                outStr += "<td>" + "=\"" + curTbl.rows[j].cells[5].innerText + "\"" + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[6].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[7].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[9].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[10].innerText + "</td>";
                outStr += "<td>" + "" + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[11].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[14].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[15].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[12].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[13].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[17].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[18].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[16].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[23].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[24].innerText + "</td>";
                outStr += "<td>" + curTbl.rows[j].cells[25].innerText + "</td>";
                outStr += "<td>" + "=\"" + curTbl.rows[j].cells[26].innerText + "\"" + "</td>";
                outStr += "</tr>";
            }
            outStr += "</tbody></table>";







            return outStr;
        }
//        //生成文件名
//        function getExcelFileName() {
//            var d = new Date();
//            var curYear = d.getYear();
//            var curMonth = "" + (d.getMonth() + 1);
//            var curDate = "" + d.getDate();
//            var curHour = "" + d.getHours();
//            var curMinute = "" + d.getMinutes();
//            var curSecond = "" + d.getSeconds();
//            if (curMonth.length == 1) {
//                curMonth = "0" + curMonth;
//            }
//            if (curDate.length == 1) {
//                curDate = "0" + curDate;
//            }
//            if (curHour.length == 1) {
//                curHour = "0" + curHour;
//            }
//            if (curMinute.length == 1) {
//                curMinute = "0" + curMinute;
//            }
//            if (curSecond.length == 1) {
//                curSecond = "0" + curSecond;
//            }
//            var fileName = "leo_zhang" + "_" + curYear + curMonth + curDate + "_"
//             + curHour + curMinute + curSecond + ".csv";
//            //alert(fileName); 
//            return fileName;
//        }
        function doFileExport(inName, inStr) {
            var xlsWin = null;
            if (!!document.all("glbHideFrm")) {
                xlsWin = glbHideFrm;
            }
            else {
                var width = 6;
                var height = 4;
                var openPara = "left=" + (window.screen.width / 2 - width / 2)
                 + ",top=" + (window.screen.height / 2 - height / 2)
                 + ",scrollbars=no,width=" + width + ",height=" + height;
                xlsWin = window.open("", "_blank", openPara);
            }
            xlsWin.document.write(inStr);
            xlsWin.document.close();
            xlsWin.document.execCommand('Saveas', true, inName);
            xlsWin.close();
        }

    </script>

    <script type="text/javascript">
	function SetBatchPrint(){
        location='Sa_Mo_BatchPrint.aspx';
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
        <asp:UpdatePanel ID="UpdatePanel" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>
    <div style="width:98%">
    <table width="600px" border="1" cellspacing="1" cellpadding="2" align="left"  style="margin:0px;"> 
	 	<tr>
		<td style="width:160px"> 
    <asp:Button ID="Select" class="btn btn-success" Width="96%" runat="server"
              Text="查询" OnClick="Select_Click" />
        </td>
        <td style="width:160px">
            <input type="button" class="btn btn-success" style="width:96%" onclick="javascript:getXlsFromTbl('tableDetail','','2003');" value="匯出到EXCEL(2003)"/> 
        </td>
        <td style="width:160px">
            <input type="button" class="btn btn-success" style="width:96%" onclick="javascript:getXlsFromTbl('tableDetail','','2010');" value="匯出到EXCEL(2010)"/> 
        </td>
        

        <td style="width:160px">
        <asp:Button ID="setMoPrint" class="btn btn-success" Width="96%" runat="server"
              Text="設定制單編號" OnClick="setMoPrint_Click" />
        </td>

  		</tr>

  	</table>
    </div>


    <div class="div_search_frame">
    <table style="table-layout:fixed;word-wrap:break-word;word-break:break-all;" border="2" width="1200px">
    <thead>
    <tr style="height:18px">
    <td style="width:5%">範圍</td>
    <td style="width:10%">開單日期</td>
    <td style="width:8%">開單人</td>
    <td style="width:8%">制單編號</td>
    <td style="width:8%">組別</td>
    <td style="width:8%">牌子編號</td>
    <td style="width:12%">訂單日期</td>
    <td style="width:8%">客戶編號</td>
    <td style="width:8%">洋行代號</td>
    <td style="width:8%">完成狀態</td>
    <td style="width:17%">條件</td>
    </tr>
    
    </thead>
    <tbody>
    <tr>
    <td style="height:18px">From</td>
    <td>
         <input size="10" type="text" id="dateStart" style="height:18px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
     </td>
     <td>
          <asp:TextBox id="txtCrBy" Width="90%" Text="" runat="server"/>
     </td>
     <td>
          <asp:TextBox ID="txtMo1" Width="90%" onKeyUp="setValue(this,txtMo2)" runat="server"></asp:TextBox>
     </td>
     <td>
          <asp:DropDownList ID="dlMo_group" Width="90%"  runat="server" /></td>
    <td>
          <asp:TextBox ID="txtBrand1" Width="90%" onKeyUp="setValue(this,txtBrand2)" runat="server"></asp:TextBox></td>
    <td>
          <input size="12" type="text" id="orderDateStart" style="height:18px;width:90%" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
      </td>
      <td>
          <asp:TextBox ID="txtCust1" Width="90%" onKeyUp="setValue(this,txtCust2)" runat="server"></asp:TextBox></td>
    <td>
          <asp:TextBox ID="txtOwn1" Width="90%" runat="server"></asp:TextBox></td>
    <td>
          <asp:DropDownList ID="dlComplete" Width="90%" runat="server" /></td>
    <td>
      <div class="checkbox">
		<label>
			<input style="width:20px" runat="server" id="chkShowA_part" type="checkbox"/>只顯示面件
		</label>
	</div>
      </td>
    
    </tr>
    <tr style="height:18px">
    <td>To</td>
    <td>
         <input size="10" type="text" id="dateEnd" style="height:18px;width:90%" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
     </td>
     <td></td>
     <td>
          <asp:TextBox ID="txtMo2" Width="90%" runat="server"></asp:TextBox></td>
    <td></td>
    <td>
          <asp:TextBox ID="txtBrand2" Width="90%" runat="server"></asp:TextBox></td>
    <td>
          <input size="12" type="text" id="orderDateEnd" style="height:18px;width:90%" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
      </td>
    <td>
          <asp:TextBox ID="txtCust2" Width="90%" runat="server"></asp:TextBox></td>
    <td>
          <asp:TextBox ID="txtOwn2" Width="90%" runat="server"></asp:TextBox></td>
    <td></td>
    <td>
    <div class="checkbox">
      <label>
			<input style="width:20px" runat="server" id="chkBatchMo" type="checkbox"/>只查找已設定的制單
		</label>
        </div>
      </td>
    </tr>
    </tbody>
    

    </table>
    </div>

    <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="show_query_img">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
    </asp:UpdateProgress> 


    

    <div class="div_table_scroll" runat="server">
        <table class="table-responsive table-hover" id="tableDetail" width="100%" border="1" cellspacing="1" cellpadding="2" align="center" style="margin:0px;"> 
  			 <thead>
             <tr class="a1" style="color:#ffffff;font-size:12px;">
   				        <th height="30">新增期</th>
				        <th>組別</th>
                        <th>制單編號</th>
    			        <th>計劃回港期</th>
				        <th>客人落單期</th>
				        <th>客人要求期</th>
				        <th>牌子編號</th>
				        <th>客戶編號</th>
                        <th>客戶描述</th>
                        <th>開單人</th>
                        <th>急單</th>
                        <th>備註</th>
                        <th>配件編號</th>
                        <th>主件</th>
                        <th>當前部門</th>
                        <th>經過部門</th>
                        <th>下部門</th>
                        <th>物料編號</th>
                        <th>物料描述</th>
                        <th>最後部門</th>
                        <th>最後發貨數</th>
                        <th>交配件部門</th>
                        <th>收到配件數</th>
                        <th>洋行代號</th>
                        <th>訂單數量</th>
                        <th>數量單位</th>
                        <th>實際回港日期</th>
  			 </tr>  
  			</thead>
            <tbody>
  			<asp:Repeater ID="rpOcDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td><%#Eval("create_date")%></td>
      			    <td><%#Eval("mo_group")%></td>
                    <td><%#Eval("mo_id")%></td>
      			    <td><%#Eval("hk_req_date")%></td>
      			    <td><%#Eval("order_date")%></td>
      			    <td><%#Eval("cs_req_date")%></td>
      			    <td><%#Eval("brand_id")%></td>
      			    <td><%#Eval("cust_code")%></td>
                    <td><%#Eval("cust_cname")%></td>
                    <td><%#Eval("create_by")%></td>
                    <td><%#Eval("remark")%></td>
                    <td><%#Eval("urgent")%></td>
                    <td><%#Eval("item_part")%></td>
                    <td><%#Eval("a_part")%></td>
                    <td><%#Eval("curr_dep")%></td>
                    <td><%#Eval("prd_dep")%></td>
                    <td><%#Eval("curr_next_dep")%></td>
                    <td><%#Eval("goods_id")%></td>
                    <td><%#Eval("goods_name")%></td>
                    <td><%#Eval("end_wp_id")%></td>
                    <td><%#Eval("end_ok_qty")%></td>
                    <td><%#Eval("period_wp_id")%></td>
                    <td><%#Eval("period_ok_qty")%></td>
                    <td><%#Eval("agent")%></td>
                    <td><%#Eval("order_qty")%></td>
                    <td><%#Eval("goods_unit")%></td>
                    <td><%#Eval("actual_bto_hk_date")%></td>
  			     </tr>
  			    </ItemTemplate>
  			</asp:Repeater>
            </tbody>
            
  			 
		</table>
        </div>


        

        </ContentTemplate>
        </asp:UpdatePanel>
        
    </form>

    </div><%--content --%>
    </div><%-- container --%>

    
   <%--<script type="text/javascript">
       $('.form_datetime').datetimepicker({
           //language:  'fr',
           weekStart: 1,
           todayBtn: 1,
           autoclose: 1,
           todayHighlight: 1,
           startView: 2,
           forceParse: 0,
           showMeridian: 1
       });
       $('.form_date').datetimepicker({
           language: 'zh-CN',
           format: 'yyyy/mm/dd',
           weekStart: 1,
           todayBtn: 1,
           autoclose: 1,
           todayHighlight: 1,
           startView: 2,
           minView: 2,
           forceParse: 0
       });
       $('.form_time').datetimepicker({
           language: 'zh-CN',
           weekStart: 1,
           todayBtn: 1,
           autoclose: 1,
           todayHighlight: 1,
           startView: 1,
           minView: 0,
           maxView: 1,
           forceParse: 0
       });

        
    </script>--%>


</body>
</html>
