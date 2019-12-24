<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Sample_Trace_View.aspx.cs" Inherits="WebPortal.Sales.Sa_Sample_Trace_View" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
      
       <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
         <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>

    <%--<link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />--%>
    <script src="../js/util.js" type="text/javascript"></script> 
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <%--<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>--%>

    <script language="JavaScript" type="text/javascript">
        var new_window;
        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }

        //以下導出導EXCEL，是不用安裝ActiveX控件的，也不用降低IE的安全設定

        function getXlsFromTbl(objWin, inTblId, inWindow,rpt_type) {
            new_window = objWin;
            //判斷表中是否存在記錄
            //            var tableObj = document.getElementById(inTblId);
            var tableObj = document.getElementById("tableDetail");
            //            var tableObj = document.getElementsByTagName("tableDetail");

            //            var nn = tableObj.innerHTML;
            if (tableObj == null) {
                alert('記錄不存在,不能匯出!');
                return false;
            }
            try {
                var allStr = "";
                var curStr = "";
                //alert("getXlsFromTbl"); 
                if (inTblId != null && inTblId != "" && inTblId != "null") {
                    curStr = getTblData(inTblId, inWindow,rpt_type);
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
                var fileName = "辨卡追蹤記錄表";
                if (rpt_type == 2)
                    fileName = "樣辨登記表";
                //                if (office_ver == "office2007" || office_ver == "office2010")
                //                    file_ext = ".xlsx";
                //                var fileName = "每日結存匯總表";

                //                if (inTblId == "tableDetail") {
                //                    fileName = "每日結存明細表";
                //                }
                fileName = fileName + file_ext;
                doFileExport(fileName, allStr, rpt_type);
                //                preview(allStr);
            }
            catch (e) {
                alert("导出发生异常:" + e.name + "->" + e.description + "!");
            }
        }
        function getTblData(inTbl, inWindow,rpt_type) {
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
            var curTbl = document.getElementById("tableDetail"); // tblDocument.getElementById(inTbl);

            var outStr = "";
            var temp_str = "";
            if (rpt_type == 1) {
                outStr += "<table borderColor='black' border='1' >";
                //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");

                outStr += "<tbody>";

                if (curTbl != null) {

                    for (var j = 0; j < curTbl.rows.length; j++) {
                        outStr += "<tr class='firstTR'>";
                        for (var i = 0; i < curTbl.rows[j].cells.length; i++) {

                            if (i == 1 && j!=0)
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
            }
            else {
                var str1 = "";
                outStr += "<table borderColor='black' border='0' width='900px' align='center' >";
                outStr += "<tbody>";
                outStr += "<tr>";
                outStr += "<td colspan='2' align='center' style='width:15%;font-size:20px'>" + "東莞潤豐金屬制品厂" + "</td>";
                outStr += "</tr>";
                outStr += "<tr>";
                outStr += "<td colspan='2' align='center' style='width:15%;font-size:large'>" + "外發加工樣(色)辨領用登記表" + "</td>";
                outStr += "</tr>";
                outStr += "<tr>";

                var DropDownList1_Value = "";
                var DropDownList1_Text = "";
                var DropDownList1 = document.getElementById("dlOwnType");
                if (DropDownList1 != null) {
                    var DropDownList1_Index = DropDownList1.selectedIndex;                 //获取选择项的索引

                    if (DropDownList1_Index >= 0) {
                        DropDownList1_Value = DropDownList1.options[DropDownList1_Index].value;   //获取选择项的值
                        DropDownList1_Text = DropDownList1.options[DropDownList1_Index].text;     //获取选择项的文本
                    }
                    else
                        DropDownList1_Text = "";
                }

                outStr += "<td style='width:15%;font-size:16px'>" + "供應商：" + DropDownList1_Text + "</td>";
                str1 = document.getElementById("<%=dateStart.ClientID %>").value;

                outStr += "<td align='right' style='width:15%;font-size:16px'>" + "日期：" + str1.substr(0, 4) + " 年 " + str1.substr(5, 2) + " 月 " + str1.substr(8, 2) + " 日" + "</td>";
                outStr += "</tr>";
                outStr += "</tbody></table>";
                outStr += "<table borderColor='black' border='1' width='900px' align='center' >";
                //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");

                outStr += "<tbody>";
                
                if (curTbl != null) {
                    outStr += "<td style='width:5%'>" + "技術文件編號" + "</td>";
                    outStr += "<td style='width:8%'>" + "訂單編號" + "</td>";
                    outStr += "<td style='width:23%'>" + "樣品名稱" + "</td>";
                    outStr += "<td style='width:21%'>" + "顏色" + "</td>";
                    outStr += "<td style='width:5%'>" + "是否客辨" + "</td>";
                    outStr += "<td style='width:8%'>" + "備註" + "</td>";
                    outStr += "<td style='width:10%'>" + "回辨確認" + "</td>";
                    outStr += "<td style='width:10%'>" + "Qc簽名" + "</td>";
                    outStr += "<td style='width:10%'>" + "簽辦日期" + "</td>";
                    for (var j = 1; j < curTbl.rows.length; j++) {
                        outStr += "<tr style='height:60px' class='firstTR'>";
                        str1 = curTbl.rows[j].cells[0].innerText;
                        if (str1 == "" || str1.substr(0,1)>"9")
                            str1 = "&nbsp;&nbsp";
                        outStr += "<td>" + str1 + "</td>";
                        str1 = curTbl.rows[j].cells[2].innerText;
                        if (str1 == "")
                            str1 = "&nbsp;&nbsp";
                        outStr += "<td>" + str1 + "</td>";
                        str1 = curTbl.rows[j].cells[12].innerText;
                        if (str1 == "")
                            str1 = "&nbsp;&nbsp";
                        outStr += "<td>" + str1 + "</td>";
                        str1 = curTbl.rows[j].cells[3].innerText;
                        if (str1 == "")
                            str1 = "&nbsp;&nbsp";
                        outStr += "<td>" + str1 + "</td>";
                        outStr += "<td>" + "&nbsp;&nbsp" + "</td>";
                        outStr += "<td>" + "&nbsp;&nbsp" + "</td>";
                        outStr += "<td>" + "&nbsp;&nbsp" + "</td>";
                        outStr += "<td>" + "&nbsp;&nbsp" + "</td>";
                        outStr += "<td>" + "&nbsp;&nbsp" + "</td>";
                        outStr += "</tr>";
                    }
                    outStr += "</tbody></table>";

                }
                else {
                    outStr = null;
                    alert(inTbl + "不存在!");
                }
                outStr += "<table borderColor='black' border='0' width='900px' align='center' >";
                outStr += "<tbody>";
                outStr += "<tr>";
                outStr += "<td style='width:70%;font-size:16px'>" + "備註：(一)請跟足來辨顏色電鍍，并在交貨時連色辦交回，以便對色。" + "</td>";
                outStr += "<td align='right' style='width:30%;font-size:16px'>" + "P10-F-020A" + "</td>";
                outStr += "</tr>";
                outStr += "<tr>";
                outStr += "<td colspan='2' style='font-size:16px'>" + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp" + "(二)遺失原辨按公司規定扣款。" + "</td>";
                outStr += "</tr>";
                outStr += "<tr>";
                outStr += "<td colspan='2' style='font-size:16px'>" + "&nbsp;&nbsp" + "</td>";
                outStr += "</tr>";
                outStr += "<tr>";
                outStr += "<td style='width:50%;font-size:16px'>" + "發辦人：______________________" + "</td>";
                outStr += "<td align='right' style='width:50%;font-size:16px'>" + "供應商簽收:______________________" + "</td>";
                outStr += "</tr>";
                outStr += "</tbody></table>";
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
        function doFileExport(inName, inStr,rpt_type) {
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

                //                xlsWin = window.open("", "_blank", openPara);
                xlsWin = new_window;


            }

            xlsWin.document.write(inStr);

            xlsWin.document.close();

            if (rpt_type == 1) {
                xlsWin.document.execCommand('Saveas', true, inName); //匯出到Excel
            }
            else {
                xlsWin.document.execCommand("print"); //打印
            }
            xlsWin.close();
        }

        //加一个确认,可以在这个方法里面执行很多适用于自己的判断...
        function sure_open() {
            if (confirm('确定要打开php爱好者吗？'))
                open_window(url);
            else
                new_window.close(); //关闭窗口
        }

        function open_window(url) {
            new_window.location.href = "TestExpToExcel.aspx"; // url;
        }


    </script>



</head>
<body>
    <div id="container">
        <%--顯示的導航條--%>
    <%--<table class="table_SiteMapPath">
    <tr>
    <td>
    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
          </asp:SiteMapPath>
    </td>
    </tr>
    </table>--%>

    <div id="content"> 

    <form id="form1" runat="server">

    <table style="table-layout:fixed;word-wrap:break-word;word-break:break-all;" border="0" width="580px">
    <tr>
    <td> 
    <asp:Button class="easyui-linkbutton" id="btnFind" Text="查找" OnClick="btnFind_Click" Width="120px" Height="28px"  runat="server"/>
    </td>
    <td>
    <button class="easyui-linkbutton" style="width:120px" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail',1);">Excel Export</button>
    </td>
    <td>
    <asp:Button class="easyui-linkbutton" id="btnFindSample" Text="查找樣辨登記表" Width="120px" Height="28px" OnClick="btnFindSample_Click"  runat="server"/>
    </td>
    <td>
    <button class="easyui-linkbutton" style="width:120px" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail',2);">樣辨登記表</button> 
    </td>
    </tr>
    </table>
    <div id="Div1" class="div_search_frame" runat="server">
    <table style="table-layout:fixed;word-wrap:break-word;word-break:break-all;" border="1" width="900px">
    <tr>
    <td style="width:10%">
    <asp:Label id="lblCard_id" Text="ID卡號" Width="90%" Height ="20px"  runat="server"/>
    </td>
    <td style="width:15%">
    <asp:Textbox id="txtCard_id" Text="" Width="90%" Height ="20px"  runat="server"/>
    </td>
    <td style="width:10%">
    <asp:Label ID="lblMo" runat="server" Text="制單編號" Width ="90%" />
    </td>
    <td style="width:15%">
    <asp:TextBox ID="txtMo" runat="server" Text="" Height ="20px" Width="90%" AutoPostBack="false" />
    </td>
    <td style="width:10%">
    <asp:Label ID="lblCard_id_org" runat="server" Text="原辦編號" Width ="90%" />
    </td>
    <td style="width:40%">
    <asp:TextBox ID="txtCard_id_org" runat="server" Text="" Height ="20px" Width="90%" AutoPostBack="false" />
    </td>

    </tr>
    <tr>
    <td>
    <asp:Label ID="lblWaitSample" runat="server" Text="批色結果" Width ="90%" />
    </td>
    <td>
    <asp:DropDownList ID="dlWaitSample" runat="server" Height ="25px" Width="90%" AutoPostBack ="false" />
    </td>
    <td>
    <asp:Label ID="lblOwnType" runat="server" Text="所屬部門" Width ="90%" />
    </td>
    <td>
    <asp:DropDownList ID="dlOwnType" runat="server" Height ="25px" Width="90%" AutoPostBack ="false" />
    </td>
    <td>
    <asp:Label id="lblDate1" Text="建立日期" Width ="80px" runat="server"/>
    </td>
    <td>
    <input size="10" type="text" id="dateStart" style="height:18px;width:130px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd HH:mm',readOnly:true})"/>

    <asp:Label id="lblTo1" Text="To" Width ="60px" runat="server"/>

    <input size="10" type="text" id="dateEnd" style="height:18px;width:130px" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd HH:mm'})"/>
    </td>
    </tr>
    </table>

    </div>

    <div id="divDetail" class="div_table_scroll" runat="server">
        <table class="table-responsive table-hover" id="tableDetail" width="98%" border="1" cellspacing="1" cellpadding="2" align="center" style="margin:0px;"> 
        <thead>
  			 <tr class="a1" style="color:#ffffff;font-size:12px;">
   				        <th height="30">ID編號</th>
				        <th>日期</th>
                        <th>制單編號</th>
                        <th>顏色</th>
                        <th>詳細說明</th>
                        <th>交辦流程</th>
    			        <th>批色狀況</th>
				        <th>所屬部門</th>
				        <th>原辦編號</th>
                        <th>單據編號</th>
                        <th>主卡ID</th>
                        <th>物料編號</th>
                        <th>物料描述</th>
                        
  			 </tr>  
  		</thead>
  			<asp:Repeater ID="trDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td><%#Eval("card_id")%></td>
      			    <td><%#Eval("doc_date")%></td>
                    <td><%#Eval("corr_mo")%></td>
                    <td><%#Eval("color_desc")%></td>
                    <td><%#Eval("remark_head")%></td>
      			    <td><%#Eval("route_dep")%></td>
      			    <td><%#Eval("wait_sample_desc")%></td>
                    <td><%#Eval("own_type_desc")%></td>
                    <td><%#Eval("card_id_org")%></td>
                    <td><%#Eval("doc_id")%></td>
                    <td><%#Eval("card_id_m")%></td>
                    <td><%#Eval("prd_item")%></td>
                    <td><%#Eval("item_cdesc")%></td>
  			     </tr>
  			    </ItemTemplate>
  			</asp:Repeater>

            
  			 
		</table>
        </div>


    </form>

    </div>
    </div>


</body>
</html>
