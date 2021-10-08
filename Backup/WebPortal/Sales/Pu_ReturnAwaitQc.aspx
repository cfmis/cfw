<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pu_ReturnAwaitQc.aspx.cs" Inherits="WebPortal.Sales.Pu_ReturnAwaitQc" %>

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

    function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }



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
                var fileName = "外發收貨待檢驗記錄";

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

                        if (i == 0 || i == 3)
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

        <table width="98%" border="2" cellspacing="1" cellpadding="2" align="center"  style="margin:0px;"> 
	 		<tr>
            
            <td>
                <asp:Button class="btn btn-success" ID="Btn_Query" runat="server" onclick="Btn_Query_Click" Text="查询" Width="120px" />
                <button class="btn btn-success" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail');">匯出到Excel</button> 
            </td>
            </tr>
            <tr>
				<td colspan="9">  
                    收貨日期:
                    <input size="12" type="text" id="DateStart" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                    &nbsp;
                    <input size="12" type="text" id="DateEnd" style="height:18px;width:120px" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                    部門:
				    <asp:TextBox id="txtDep" Width ="80px" Text="" runat="server"/>
	  				
                </td>
                
  			</tr>
            <tr>
           
            <td colspan="9">

                制單編號:
	  				<asp:TextBox ID="txtFindMo1" runat="server" Width="120px" onKeyUp="setValue(this,txtFindMo2)"></asp:TextBox>&nbsp;
	  				到&nbsp;<asp:TextBox ID="txtFindMo2" Width="120px" runat="server" />
                檢驗類型:
                <asp:DropDownList ID="ddlCheckState" Width ="100px" runat="server" >
                    <asp:ListItem>待檢驗</asp:ListItem>
                    <asp:ListItem>已檢驗</asp:ListItem>
                </asp:DropDownList>
                記錄數:
                <asp:TextBox ID="txtShowRec" Width="120px" runat="server" />
            </td>
            </tr>
  		</table>

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
        <table id="tableDetail" width="100%" border="1" cellspacing="1" cellpadding="2" align="center" style="margin:0px;">
        <thead>
  			 <tr class="a1" style="color:#ffffff;font-size:12px;">
   				        <th height="30">收貨日期</th>
				        <th>制單編號</th>
                        <th>物料描述</th>
                        <th>欠色瓣</th>
                        <th>生產備註</th>
    			        <th>供應商</th>
				        <th>收貨單號</th>
				        <th>序號</th>
				        <th>物料編號</th>
				        <th>收貨數量</th>
                        <th>檢驗狀態</th>
                        <th>檢驗結果</th>
                        <th>單據狀態</th>
                        <th>QC單號</th>
                        <th>檢驗日期</th>
                        <th>抽檢數量</th>
                        <th>檢驗人</th>
                        <th>AC</th>
                        <th>RE</th>
                        <th>QC備註</th>
                        <th>建立人</th>
                        <th>部門</th>
                        <th>供應商描述</th>
  			 </tr>  
  			</thead>
            <tbody>
  			<asp:Repeater ID="wpDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td id='dat_<%#Eval("mo_no") %>'><%#Eval("dat")%></td>
      			    <td id='mo_no_<%#Eval("mo_no") %>'><%#Eval("mo_no")%></td>
                    <td id='goods_name1_<%#Eval("mo_no") %>'><%#Eval("goods_name")%></td>
                    <td id='no_sample_<%#Eval("mo_no") %>'><%#Eval("dat")%></td>
                    <td id='production_remark_<%#Eval("mo_no") %>'><%#Eval("production_remark")%></td>
      			    <td id='vendor_id_<%#Eval("mo_no") %>'><%#Eval("vendor_id")%></td>
      			    <td id='doc_id_<%#Eval("mo_no") %>'><%#Eval("doc_id")%></td>
      			    <td id='doc_seq_<%#Eval("mo_no") %>'><%#Eval("doc_seq")%></td>
      			    <td id='mat_item_<%#Eval("mo_no") %>'><%#Eval("mat_item")%></td>
                    <td id='lot_qty_<%#Eval("mo_no") %>'><%#Eval("lot_qty")%></td>
                    <td id='iqc_state_desc_<%#Eval("mo_no") %>'><%#Eval("iqc_state_desc")%></td>
                    <td id='iqc_result_desc_<%#Eval("mo_no") %>'><%#Eval("iqc_result_desc")%></td>
                    <td id='qc_doc_state_<%#Eval("mo_no") %>'><%#Eval("qc_doc_state")%></td>
                    <td id='qc_doc_id_<%#Eval("mo_no") %>'><%#Eval("qc_doc_id")%></td>
                    <td id='qc_date_<%#Eval("mo_no") %>'><%#Eval("qc_date")%></td>
                    <td id='check_qty_<%#Eval("mo_no") %>'><%#Eval("check_qty")%></td>
                    <td id='qc_by_<%#Eval("mo_no") %>'><%#Eval("create_by")%></td>
                    <td id='ac_<%#Eval("mo_no") %>'><%#Eval("ac")%></td>
                    <td id='re_<%#Eval("mo_no") %>'><%#Eval("re")%></td>
                    <td id='qc_remark_<%#Eval("mo_no") %>'><%#Eval("qc_remark")%></td>
                    <td id='create_by_<%#Eval("mo_no") %>'><%#Eval("create_by")%></td>
                    <td id='dep_no_<%#Eval("mo_no") %>'><%#Eval("dep_no")%></td>
                    <td id='vendor_<%#Eval("mo_no") %>'><%#Eval("vendor")%></td>
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
