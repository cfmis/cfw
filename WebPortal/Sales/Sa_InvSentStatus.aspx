<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_InvSentStatus.aspx.cs" Inherits="WebPortal.Sales.Sa_InvSentStatus" EnableEventValidation = "false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
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
                var fileName = "發票送貨狀態";

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

                        if (j!=0 && (i == 1 || i == 2))
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
    <asp:SiteMapPath ID="SiteMapPath2" runat="server">
          </asp:SiteMapPath>
    </td>
    </tr>
    </table>

    <div id="content">
    <form id="form1" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>
    <table width="98%" border="2" cellspacing="1" cellpadding="2" align="center"  style="margin:0px;"> 
	<tr>
    <asp:Button class="btn btn-success" id="btnFind" Text="查找" OnClick="btnFind_Click" Width="160px" Height ="30px"  runat="server"/>
    <button class="btn btn-success" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail');" style="width:160px">Excel Export</button> 
    </tr>

    <tr>
    <td style="width:5%">
    <asp:Label id="lblDate1" Text="發票日期" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td style="width:10%">
    <input size="12" type="text" id="dateStart" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td style="width:2%">
    <asp:Label id="lblTo2" Text="To" Width ="20px" Font-Size="13px" runat="server"/>
    </td>
    <td style="width:10%">
    <input size="12" type="text" id="dateEnd" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td style="width:5%">
    <asp:Label id="lblMo" Text="制單編號" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td style="width:10%">
    <asp:TextBox id="txtMo1" Width ="120px" Text="" AutoPostBack="true" runat="server"/>
    </td>
    <td style="width:2%">
    <asp:Label id="lblTo1" Text="To" Width ="20px" Font-Size="13px" runat="server"/>
    </td>
    <td style="width:10%">
    <asp:TextBox id="txtMo2" Width ="120px" Text="" runat="server"/>
    </td>
    <td style="width:5%">
    <asp:Label id="lblCust" Text="客戶編號" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td style="width:41%">
    <asp:TextBox id="txtCust" Width ="120px" Text="" runat="server"/>
    </td>
    </tr>

    <tr>
    <td>
    <asp:Label id="lblInv1" Text="發票編號" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td>
    <asp:TextBox id="txtInv1" Width ="120px" Text="" AutoPostBack="true" runat="server"/>
    </td>
    <td>
    <asp:Label id="lblTo3" Text="To" Width ="20px" Font-Size="13px" runat="server"/>
    </td>
    <td>
    <asp:TextBox id="txtInv2" Width ="120px" Text="" runat="server"/>
    </td>
    <td>
    <asp:Label id="lblShowDeliv" Text="送貨狀態" Width ="60px" Font-Size="13px" runat="server"/>
    </td>
    <td colspan="5">
    <asp:DropDownList ID="dlShowDeliv" Width ="200px" runat="server" >
        <asp:ListItem>顯示全部</asp:ListItem>
        <asp:ListItem>已開發票已送貨</asp:ListItem>
        <asp:ListItem>已開發票未送貨</asp:ListItem>
        </asp:DropDownList>
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
        <table  class="table-responsive table-hover" id="tableDetail" width="100%" border="1" cellspacing="1" cellpadding="2" align="center" style="margin:0px;">
  			 <thead class="fixedThead">
             <tr class="a1" style="color:#ffffff;font-size:12px;">
   				        <th height="30">發票編號</th>
				        <th>發票日期</th>
                        <th>發貨日期(DGD)</th>
    			        <th>序號</th>
                        <th>單據類型</th>
    			        <th>制單編號</th>
                        <th>物料編號</th>
    			        <th>物料描述</th>
                        <th>數量</th>
    			        <th>數量單位</th>
                        <th>重量</th>
    			        <th>发票狀態</th>
                        <th>發貨狀態</th>
    			        <th>發貨日期</th>
                        <th>運輸途徑</th>
    			        <th>客人簽收人</th>
                        <th>客人簽收日期</th>
    			        <th>回單狀態</th>
                        <th>確認人</th>
    			        <th>客戶編號</th>
                        <th>客戶描述</th>

  			 </tr>  
  			</thead>

            <tbody>
  			<asp:Repeater ID="wpDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td><%#Eval("id")%></td>
      			    <td><%#Eval("inv_dat")%></td>
                    <td><%#Eval("ship_date")%></td>
      			    <td><%#Eval("seq")%></td>
      			    <td><%#Eval("doc_type_desc")%></td>
      			    <td><%#Eval("mo_id")%></td>
      			    <td><%#Eval("goods_id")%></td>
      			    <td><%#Eval("goods_name")%></td>
                    <td><%#Eval("inv_qty")%></td>
                    <td><%#Eval("goods_unit")%></td>
                    <td><%#Eval("inv_weg")%></td>
                    <td><%#Eval("inv_state")%></td>
                    <td><%#Eval("issues_state_desc")%></td>
                    <td><%#Eval("consignment_date")%></td>
                    <td><%#Eval("transport_style")%></td>
                    <td><%#Eval("receipt_person")%></td>
                    <td><%#Eval("receipted_date")%></td>
                    <td><%#Eval("return_state")%></td>
                    <td><%#Eval("check_by")%></td>
                    <td><%#Eval("it_customer")%></td>
                    <td><%#Eval("cust_cname")%></td>
  			     </tr>
  			    </ItemTemplate>
  			</asp:Repeater>
            </tbody>

		</table>
        </div>




    <asp:Label id="lblShowInfo" Text="已開發票，未送貨記錄。" Width ="628px" ForeColor="Blue" Font-Size="13px" runat="server"/>

    </ContentTemplate>

    </asp:UpdatePanel>


    </form>
    </div>
    </div>

</body>
</html>
