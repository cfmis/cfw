<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Order_Trace.aspx.cs" Inherits="WebPortal.Sales.Sa_Order_Trace" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>訂單生產跟蹤表</title>
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <script src="../js/jquery.min.js" type="text/javascript"></script> 
    <script src="../js/json2.js" type="text/javascript"></script>
    
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>

    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
   	


    <script language="JavaScript" type="text/javascript">

    function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }
    </script>


    <script type="text/javascript">

        function shenheSubmit(action) {
            var str = "";
            var j = 0;
            var obj = document.getElementsByName("selOrder");
            var k = obj.length;
            if (k == 1) {

                if (obj[0].checked == true)
                    str = obj[0].value;
            } else {
                for (i = 0; i < document.all.selOrder.length; i++) {
                    if (document.all.selOrder[i].checked) {
                        if (0 == j) {
                            str = document.all.selOrder[i].value
                        } else {
                            str = str + "#" + document.all.selOrder[i].value;
                        }
                        j++;
                    }
                    document.all.selOrder[i].checked = false;
                }
            }
            if (str == "") {

                alert("请选择要操作的选项");
                return false;
            }
            else {
                // window.location.replace("Manager_AuditingBuyOrder.aspx?AuditingId="+encodeURIComponent(str)) ;
                //window.location.href("Manager_AuditingAppendStockOrder.aspx?action=" + action + "&AuditingId=" + encodeURIComponent(str));
                alert(encodeURIComponent(str));
            }

        }

        function newAdd() {
            window.location.href("AppendStock_Add.aspx");
        }
    </script>

    <script type="text/javascript">
        function SaveData() {


//            //這個是另一種轉換成Json的方法，但在C#中暫未有解決轉換成字符的方法
//            var OrderObj =
//            {
//            id: "",
//            mo_id: ""
//            }

//            var a = JSON.parse("{\"title\":\"\",\"data\":[]}");
//            var rows = document.getElementById("tableExcel").rows.length; //获得行数(包括thead)
//            var colums = document.getElementById("tableExcel").rows[0].cells.length; //获得列数
//            if (rows > 1) {//
//                for (var i = 1; i < rows; i++) { //每行 从第二行开始因为第一行是表格的标题
//                    var OrderObj1 = new Object(OrderObj); //这里一定要new新的对象，要不然保存的都是一样的数据；都是最后一行的数据
//                    OrderObj1.id = document.getElementById("tableExcel").rows[i].cells[1].innerText;
//                    OrderObj1.mo_id = document.getElementById("tableExcel").rows[i].cells[8].innerText;

//                    a.data.push(OrderObj1); //向JSON数组添加JSON对象的方法；很关键
//                }

//                ///格式化数据
//                var obj = JSON.stringify(a); //这一行很关键
//            }





            var tb = document.getElementById('tableExcel');
            rows = tb.rows;
            if (rows.length > 0) {
//            var selectinput=tb.getElementsByTagName("select");//選擇表格中所有select的對象

            var select_flag = false;
                var json = [];
                for (var i = 1; i < rows.length; i++) {
                    var cells = rows[i].cells;
                    //這個是循環取表格中所有select的值
//                    var rowIndex = i-1;
//                    var text1 = selectinput[rowIndex].options[selectinput[rowIndex].selectedIndex].text;
//                    var value1 = selectinput[rowIndex].options[selectinput[rowIndex].selectedIndex].value;
                    if (cells[0].childNodes[0].checked) {
                        select_flag = true;
                        var j = {};
                        var cb;
                        j.id = cells[5].innerText;//OC編號
                        j.order_date = cells[1].innerText;//訂單日期
                        j.mo_id = cells[8].innerText;//制單編號
                        cb = cells[11].childNodes[0];
                        j.prd_status = cb.options[cb.selectedIndex].value; //生產情況
                        cb = cells[12].childNodes[0];
                        j.ret_hk_status = cb.options[cb.selectedIndex].value; //大貨回港情況
                        cb = cells[14].childNodes[0];
                        j.sample_hk_status = cb.options[cb.selectedIndex].value; //大貨辦情況
                        cb = cells[15].childNodes[0];
                        j.chk_color_status = cb.options[cb.selectedIndex].value; //大貨批色情況
                        j.chk_color_oth = cells[16].childNodes[0].value; //大貨批色說明
                        j.chk_color_date = cells[17].childNodes[0].value; //批復日期
                        j.job_no = cells[18].childNodes[0].value; //Job No.
                        cb = cells[19].childNodes[0];
                        j.test_result = cb.options[cb.selectedIndex].value; //測試結果
                        j.test_status = cells[20].childNodes[0].value; //測試情況其它
                        j.test_inv_no = cells[21].childNodes[0].value; //試發票編號
                        j.test_inv_date = cells[22].childNodes[0].value; //測試發票日期
                        cb = cells[23].childNodes[0];
                        j.shipment = cb.options[cb.selectedIndex].value; //ShipMent
                        j.shipment_oth = cells[24].childNodes[0].value; //ShipMent其它
                        j.awb_no = cells[25].childNodes[0].value; //AWB No.
                        j.sent_date = cells[26].childNodes[0].value; //出貨日期
                        j.remark = cells[27].childNodes[0].value; //備註
                        cb = cells[28].childNodes[0];
                        j.mo_status = cb.options[cb.selectedIndex].value;//制單完成情況
                        j.obj = i;
                        json.push(j);

//                        //測試下拉框取值
//                        var cb = cells[11].childNodes[0];
//                        var selectvalue = cb.options[cb.selectedIndex].value;
//                        var selecttext = cb.options[cb.selectedIndex].text;
//                        alert('row: '+i+' value: '+selectvalue+' text:' +selecttext);
//                        cb.options[cb.selectedIndex].value = "2";

                    }



                }
                if (select_flag == true) {
                    var obja = JSON.stringify(json);
                } else {
                    alert("沒有選擇更新的記錄!");
                    return;
                }

                
            }
            else {
                alert("沒有查詢的選擇記錄!");
                return;
            }



//            $.post("Sa_Order_Trace_Excel.aspx=" + new Date().getTime(), { JsonStr: obja });
            //                        $.post("../sales/Sa_Order_Trace_Excel.aspx", { name: "John", time: "2pm" });
//            $.post("../sales/Sa_Order_Trace_Excel.aspx/SayHello");






//            异步提交数据

            $.ajax({
                url: "../ashx/Sa_Order_Trace.ashx",
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: LoadFunction

            });
            function succFunction(data) {
                var obj = eval("(" + data + ")");
                if (obj.success) {
                    mini.unmask();
                    alert(obj.message);

                    location.reload();
                }
                else {
                    mini.unmask();
                    alert(obj.message);
                }
            }
            function LoadFunction(data) {
                alert(data);
                if (document.getElementById('chkSelectExistRec').checked) {
                    document.getElementById('btnFindHasTrace').click();
                }
                else {
                    document.getElementById('btnFindNoTrace').click();
                }
            }
            function BefLoadFunction() {
                $("#ddd").html('加载中...');
            }
            function erryFunction() {
                alert("error");
            }


        }
    </script>
    
    <script type="text/javascript">

        //以下導出到EXCEL，是不用安裝ActiveX控件的，也不用降低IE的安全設定

        function getXlsFromTbl(objWin, inTblId, inWindow,excelVer) {
            new_window = objWin;
            //判斷表中是否存在記錄
            var tableObj = document.getElementById("tableExcel");

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
                if (excelVer == '2010') {
                    file_ext = ".xlsx";
                }
                var fileName = "制單追蹤表";

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
            var curTbl = tblDocument.getElementById("tableExcel");
            var outStr = "";
            outStr += "<table borderColor='black' border='1' >";
            //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");

            outStr += "<tbody>";
            if (curTbl != null) {
//                for (var j = 0; j < curTbl.rows.length; j++) {
//                    outStr += "<tr class='firstTR'>";

//                    for (var i = 0; i < curTbl.rows[j].cells.length; i++) {

//                        if (i == 1)
//                            outStr += "<td>" + "=\"" + curTbl.rows[j].cells[i].innerText + "\"" + "</td>";
//                        else
//                            outStr += "<td>" + curTbl.rows[j].cells[i].innerText + "</td>";

//                    }
//                    outStr += "</tr>";
//                }



                var rows = curTbl.rows;
                for (var j = 0; j < curTbl.rows.length; j++) {
                    var cells = rows[j].cells;
                    outStr += "<tr class='firstTR'>";

                    for (var i = 0; i < curTbl.rows[j].cells.length; i++) {
                        var val;
                        if (j > 0 && (i == 11 || i == 12 || i == 14 || i == 15 || i == 19 || i == 23 || i == 28)) {
                            var cb = cells[i].childNodes[0];
                            val = cb.options[cb.selectedIndex].text;
                        }
                        else {
                            if (j > 0 && (i==13 || i == 16 || i == 17 || i == 18 || i == 20 || i == 21 || i == 22 || i == 24 || i == 25 || i == 26 || i == 27))
                            {
                                val = curTbl.rows[j].cells[i].childNodes[0].value;
//                                j.chk_color_oth = cells[16].childNodes[0].value; //大貨批色說明
                            }
                            else
                                val = curTbl.rows[j].cells[i].innerText;
                        }
                        if (i == 1 || i==9 || i==10)
                            outStr += "<td>" + "=\"" + val + "\"" + "</td>";
                        else
                            outStr += "<td>" + val + "</td>";

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
    

    <script type="text/javascript">
        function selectAll() {
            var tb = document.getElementById('tableExcel');
            var rows = tb.rows;
            if (rows.length > 1) {
                for (var i = 1; i < rows.length; i++) {
                    var cells = rows[i].cells;

                    if (document.getElementById('chkSelectAll').checked) {
                        cells[0].childNodes[0].checked = true;
                    }
                    else
                        cells[0].childNodes[0].checked = false;
                }
            }
            else {
                alert("沒有記錄!");
                return;
            }
        }
    </script>
    
    <script type="text/javascript">        
        function showDivDetailsHeight() {
            var h_w = window.screen.availHeight; // document.body.clientHeight; // document.body.clientHeight;
            var o_cont = document.getElementById("container");
            var o_tb = document.getElementById("divDetail");
            var o_lay = document.getElementById("divLayer2");

            var h_cont;
            var h_lay;
            var h_tb;
            var h_1 = 100;

            

            if (document.getElementById('btnShowDivSeach').value == "隱藏條件<<") {

                //                o.style.height = o.offsetHeight + ui.offsetHeight;

                h_lay = o_lay.offsetHeight;
                o_lay.style.display = "none";
                
                h_cont = h_w - h_lay;

                //                document.getElementById('divSearch').style.display = 'none'; //隐藏





                document.getElementById('btnShowDivSeach').value = "顯示條件>>"
            }
            else {
                o_lay.style.display = "block";
                h_lay = o_lay.offsetHeight;
                h_cont = h_w - h_lay - h_lay;
                
//                o.style.height = o.offsetHeight - ui.offsetHeight;
//                document.getElementById('divSearch').style.display = 'block'; //显示  
                document.getElementById('btnShowDivSeach').value = "隱藏條件<<"
            }
            o_cont.style.height = h_cont;
            o_tb.style.height = h_cont - h_1;

            
            
            
        }
    </script>
    <script type="text/javascript">
        function showHeight() {
            var o = document.getElementById("divDetail");
//            alert(o.offsetHeight);
            var h1 = window.screen.availHeight; // document.body.clientHeight; // document.body.clientHeight;
//            alert(h1);
            alert("网页可见区域高：" + document.body.offsetHeight);
            alert("网页可见区域高：" + document.body.clientHeight);
            alert("网页正文全文高：" + document.body.offsetHeight);
            alert("网页被卷去的高：" + document.body.scrollTop);
            alert(" 屏幕可用工作区高度：" + window.screen.availHeight);
            alert("cont:" + document.getElementById("container").offsetHeight);
            alert("divLayer2:" + document.getElementById("divLayer2").offsetHeight);
            alert("divDetail:" + document.getElementById("divDetail").offsetHeight);
        }
    </script>
    <script type="text/javascript">
//        function initDivHeight() {
        window.onload=function(){
            var h1 = window.screen.availHeight;// document.body.clientHeight; // document.body.clientHeight;
            var o_tb = document.getElementById("divDetail");
            var o_lay = document.getElementById("divLayer2");
            var o_cont = document.getElementById("container");
//            h1 = di.offsetHeight;
//            alert(di.offsetHeight);
//            alert(o.offsetHeight);
//            alert(ui.offsetHeight);

            
            o_cont.style.height = h1 - o_lay.offsetHeight;

//            alert(di.offsetHeight);
//            alert(o.offsetHeight);
            //            alert(ui.offsetHeight);

            o_tb.style.height = o_cont.offsetHeight - o_lay.offsetHeight-100;


//            var s = "";
//            s += " 网页可见区域宽：" + document.body.clientWidth;
//            s += " 网页可见区域高：" + document.body.clientHeight;
//            s += " 网页可见区域宽：" + document.body.offsetWidth + " (包括边线和滚动条的宽)";
//            s += " 网页可见区域高：" + document.body.offsetHeight + " (包括边线的宽)";
//            s += " 网页正文全文宽：" + document.body.scrollWidth;
//            s += " 网页正文全文高：" + document.body.scrollHeight;
//            s += " 网页被卷去的高(ff)：" + document.body.scrollTop;
//            s += " 网页被卷去的高(ie)：" + document.documentElement.scrollTop;
//            s += " 网页被卷去的左：" + document.body.scrollLeft;
//            s += " 网页正文部分上：" + window.screenTop;
//            s += " 网页正文部分左：" + window.screenLeft;
//            s += " 屏幕分辨率的高：" + window.screen.height;
//            s += " 屏幕分辨率的宽：" + window.screen.width;
//            s += " 屏幕可用工作区高度：" + window.screen.availHeight;
//            s += " 屏幕可用工作区宽度：" + window.screen.availWidth;
//            s += " 你的屏幕设置是 " + window.screen.colorDepth + " 位彩色";
//            s += " 你的屏幕设置 " + window.screen.deviceXDPI + " 像素/英寸";
//            alert (s); 

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
    
    <div class="div_search_frame" id="divSearch">
    <table id="tbLayer1">

    <tr>
    <td>

    <table width="1200px" border="1" cellspacing="1" cellpadding="2" align="left"  style="margin:0px;"> 
    
	 	<tr>
		<td style="width:10%"> 
    <asp:Button ID="btnFindNoTrace" class="btn btn-success" Width="96%" runat="server"
              Text="未加入追蹤表" OnClick="btnFindNoTrace_Click" />
        </td>
        
        <td style="width:10%"> 
    <asp:Button ID="btnFindHasTrace" class="btn btn-success" Width="96%" runat="server"
              Text="已加入追蹤表" OnClick="btnFindHasTrace_Click" />
        </td>

        <td style="width:3%">
        </td>
        


        <td style="width:10%">
        <input type="button" class="btn btn-success" style="width:96%;" value="更新追蹤表" id="btnSaveData" onclick="SaveData()" />
        </td>
        <td style="width:10%">
        <input type="button" class="btn btn-success" style="width:96%" value="取消追蹤表" id="Submit1" onclick="javascript:if(!confirm('您确定要操作吗'))return  false;shenheSubmit('shenhe')" />

        </td>

        <td style="width:3%">
        </td>
        <td style="width:10%">
            <button type="button" class="btn btn-success" style="width:96%" onclick="javascript:getXlsFromTbl(window.open(),'tableExcel','divDetail','2003');">Excel(2003)</button>
        </td>
        <td style="width:10%">
            <button type="button" class="btn btn-success" style="width:96%" onclick="javascript:getXlsFromTbl(window.open(),'tableExcel','divDetail','2010');">Excel(2010)</button>
        </td>
        <td style="width:10%">
        <input type="button" class="btn btn-success" style="width:96%;color: #006633;background-color: #FFCCFF" onclick="showDivDetailsHeight()" id="btnShowDivSeach" value="隱藏條件<<" />
        
        </td>
        
        <%--<td style="width:10%">
        <input type="button" class="btn btn-success" style="width:96%;color: #006633;background-color: #FFCCFF" onclick="showHeight()" id="Button1" value="顯示高度" />
        </td>--%>
        <td style="width:24%">
        <div class="checkbox">
      <label>
			<input style="width:20px;visibility:hidden" runat="server" id="chkSelectExistRec" type="checkbox"/>
		</label>
        <asp:Label id="lblShowInfo" Text="查詢：未加入追蹤表的記錄" ForeColor="Red" Font-Size="14px" runat="server"/>
        </div>

        </td>
  		</tr>

  	</table>

    </td>
    </tr>

    <tr>
    <td>

    <div id="divLayer2">

    <table id="tbLayer2">
    <tr>
    <td>
    <table style="table-layout:fixed;word-wrap:break-word;word-break:break-all;" border="2" width="1200px">
    <thead>
    <tr style="height:28px">
    <th style="width:5%">範圍</th>
    <th style="width:15%">開單日期</th>
    <th style="width:15%">制單編號</th>
    <th style="width:15%">客戶編號</th>
    <th style="width:20%">OC編號</th>
    <th style="width:8%">組別</th>
    <th style="width:22%"></th>
    </tr>
    
    </thead>
    <tbody>
    <tr style="height:28px">
    <td>From</td>
    <td>
         <input type="text" id="dateStart" style="height:18px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
     </td>

     <td>
          <asp:TextBox ID="txtMo1" Width="90%" onKeyUp="setValue(this,txtMo2)" runat="server"></asp:TextBox>
     </td>
     

    <td>
          <asp:TextBox ID="txtCust1" Width="90%" onKeyUp="setValue(this,txtCust2)" runat="server"></asp:TextBox>
    </td>
    <td>
          <asp:TextBox ID="txtOc1" Width="90%" onKeyUp="setValue(this,txtOc2)" runat="server"></asp:TextBox>
    </td>
    <td>
          <asp:DropDownList ID="dlMo_group" Width="90%"  runat="server" /></td>

    
    </tr>


    <tr style="height:28px">
    <td>To</td>
    <td>
         <input type="text" id="dateEnd" style="height:18px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
     </td>
     <td>
          <asp:TextBox ID="txtMo2" Width="90%" runat="server"></asp:TextBox></td>
    

    <td>
          <asp:TextBox ID="txtCust2" Width="90%" runat="server"></asp:TextBox></td>
    <td>
          <asp:TextBox ID="txtOc2" Width="90%" runat="server"></asp:TextBox>
    </td>
    <td></td>
    </tr>
    </tbody>
    </table>

    </td>
    </tr>

    <tr>
    <td>
    <table border="2" width="1200px">
    <tbody>
    <tr style="height:28px">
    <td colspan="3">
    <div class="checkbox">
      <label>
			<input style="width:20px" runat="server" id="chkSelectAll" onclick="javascript:selectAll()" type="checkbox" />選擇所有記錄
            </label>
        </div>
    </td>
    <td colspan="8">
    <label style="color:Red">注：以下查詢條件只對已加入追蹤表的記錄生效:</label>
    </td>
    </tr>

    <tr style="height:28px">
    <td style="width:6%">
    制單狀態
    </td>
    <td style="width:8%">
          <asp:DropDownList ID="dlMo_status" Width="90%" runat="server" />
    </td>
    <td style="width:6%">
    生產情況
    </td>
    <td style="width:8%">
          <asp:DropDownList ID="dlPrd_state" Width="90%" runat="server" />
    </td>
    <td style="width:10%">
    大貨回港情況
    </td>
    <td style="width:8%">
          <asp:DropDownList ID="dlRet_hk_status" Width="90%" runat="server" />
    </td>
    <td style="width:8%">
    大貨辦情況
    </td>
    <td style="width:8%">
          <asp:DropDownList ID="dlSample_hk_status" Width="90%" runat="server" />
    </td>
    <td style="width:10%">
    大貨批色情況
    </td>
    <td style="width:8%">
          <asp:DropDownList ID="dlChk_color_status" Width="90%" runat="server" />
    </td>
    <td style="width:20%">
    <div class="checkbox">
      <label>
			<input style="width:20px" runat="server" id="chkShowNoJobNo" type="checkbox"/>只顯示沒有JobNo的記錄
		</label>
        </div>
    </td>
    </tr>
    
    
    </tbody>
    </table>

    </td>
    </tr>
    



    </table>
    </div>




    </td>
    </tr>
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


        <div id="divDetail" class="div_table_scroll" runat="server">
        <table id="tableExcel" style="table-layout:fixed;word-wrap:break-word;word-break:break-all;" border="2" width="3470px">
  			 <thead>
             <tr class="a1" style="color:#ffffff;height:30px">
   				        <th style="width:30px">選擇</th>
				        <th style="width:80px">訂單日期</th>
                        <th style="width:80px">客戶編號</th>
                        <th style="width:140px">客戶描述</th>
                        <th style="width:80px">客戶PO</th>
                        <th style="width:80px">OC編號</th>
                        <th style="width:80px">客戶產品編號</th>
                        <th style="width:80px">客戶顏色編號</th>
                        <th style="width:100px">制單編號</th>
                        <th style="width:80px">PI貨期</th>
                        <th style="width:80px">客人要求日期</th>
                        <th style="width:80px">生產情況</th>
                        <th style="width:80px">大貨回港情況</th>
                        <th style="width:80px">大貨回港日期</th>
                        <th style="width:80px">大貨辦情況</th>
                        <th style="width:80px">大貨批色情況</th>
                        <th style="width:80px">大貨批色說明</th>
                        <th style="width:80px">批復日期</th>
                        <th style="width:160px">Job No.</th>
                        <th style="width:80px">測試情況</th>
                        <th style="width:80px">測試情況其它</th>
                        <th style="width:80px">測試發票編號</th>
                        <th style="width:80px">測試發票日期</th>
                        <th style="width:80px">ShipMent</th>
                        <th style="width:80px">ShipMent其它</th>
                        <th style="width:100px">AWB No.</th>
                        <th style="width:80px">出貨日期</th>
                        <th style="width:160px">備註</th>
                        <th style="width:80px">制單狀態</th>
                        <th style="width:80px">測試狀況</th>

                        <th style="width:80px">發票編號</th>
                        <th style="width:80px">發票日期</th>
                        <th style="width:60px">發票數量(PCS)</th>
                        <th style="width:60px">訂單數量(PCS)</th>
                        <th style="width:80px">發貨狀態</th>
                        <th style="width:80px">發貨日期</th>
                        <th style="width:80px">運輸途徑</th>
                        <th style="width:80px">客人簽收人</th>
                        <th style="width:80px">客人簽收日期</th>
                        <th style="width:80px">回單狀態</th>
                        <th style="width:80px">发票狀態</th>
                        <th style="width:80px">確認人</th>
  			 </tr>  
  			</thead>
            <tbody>
  			<asp:Repeater ID="rpOcDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td><input type="checkbox" style="width:20px" name="selOrder" value="<%#Eval("id")%>" /></td>
      			    <td><%#Eval("order_date")%></td>
                    <td><%#Eval("it_customer")%></td>
      			    <td><%#Eval("cust_cname")%></td>
                    <td><%#Eval("contract_id")%></td>
                    <td><%#Eval("id")%></td>
                    <td><%#Eval("customer_goods")%></td>
                    <td><%#Eval("customer_color_id")%></td>
                    <td><a target="_blank" href="Sa_Mo_ShowStatus.aspx?to_mo_id=<%#Eval("mo_id")%>"><%#Eval("mo_id")%></a></td>
                    <td><%#Eval("hk_req_date")%></td>
                    <td><%#Eval("cs_req_date")%></td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("prd_status")%>"><%#Eval("prd_status_desc")%></option>
                        <option value="01">未完成</option>
                        <option value="02">已完成</option>
                        <option value="03">強制完成</option>
                        <option value="04">已取消</option>
                        <option value="05">生產中</option>
                        </select>
                    </td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("ret_hk_status")%>"><%#Eval("ret_hk_status_desc")%>
                        </option><option value="01">未回港</option>
                        <option value="02">已回港</option>
                        </select>
                    </td>
                    <td><input type="text" name="colAct_hk_date" style="width:80%" value="<%#Eval("act_hk_date")%>"/></td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("sample_hk_status")%>"><%#Eval("sample_hk_status_desc")%>
                        </option><option value="01">未回港</option>
                        <option value="02">已回港</option>
                        <option value="03">未完成</option>
                        <option value="04">已完成</option>
                        </select>
                    </td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("chk_color_status")%>"><%#Eval("chk_color_status_desc")%></option>
                        <option value="1">待批</option>
                        <option value="2">已批</option>
                        <option value="4">已回</option>
                        <option value="5">不用批色</option>
                        </select>
                    </td>
                    <td><input type="text" name="colChk_color_oth" style="width:80%" value="<%#Eval("chk_color_oth")%>"/></td>
                    <td><input type="text" name="colChk_color_date" style="width:80%" value="<%#Eval("chk_color_date")%>"/></td>
                    <td><input type="text" name="colJob_no" style="width:80%" value="<%#Eval("job_no")%>"/></td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("test_result")%>"><%#Eval("test_result_desc")%>
                        </option><option value="01">不合格</option>
                        <option value="02">合格</option>
                        </select>
                    </td>
                    <td><input type="text" name="colTest_status" style="width:80%" value="<%#Eval("test_status")%>"/></td>
                    <td><input type="text" name="colTestInv_no" style="width:80%" value="<%#Eval("test_inv_no")%>"/></td>
                    <td><input type="text" name="colTestInv_date" style="width:80%" value="<%#Eval("test_inv_date")%>"/></td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("shipment")%>"><%#Eval("shipment_desc")%></option>
                        <option value="01">DHL</option>
                        <option value="02">HS</option>
                        <option value="03">HT</option>
                        <option value="04">司機送貨</option>
                        </select>
                    </td>
                    <td><input type="text" name="colShipment" style="width:80%" value="<%#Eval("shipment_oth")%>"/></td>
                    
                    <td><input type="text" name="colAwb_no" style="width:80%" value="<%#Eval("awb_no")%>"/></td>
                    <td><input type="text" name="colSent_date" style="width:80%" value="<%#Eval("sent_date")%>"/></td>
                    <td><input type="text" name="colRemark" style="width:80%" value="<%#Eval("remark")%>"/></td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("mo_status")%>"><%#Eval("mo_status_desc")%>
                        </option><option value="01">未完成</option>
                        <option value="02">已完成</option>
                        </select>
                    </td>
                    <td><a target="_blank" href="Sa_Mo_View_Test.aspx?to_mo_id=<%#Eval("mo_id")%>"><%#Eval("customer_test_id")%></a></td>
                    <td><%#Eval("inv_id")%></td>
                    <td><%#Eval("inv_date")%></td>
                    <td><%#Eval("inv_qty_pcs")%></td>
                    <td><%#Eval("order_qty_pcs")%></td>
                    <td><%#Eval("issues_state")%></td>
                    <td><%#Eval("consignment_date")%></td>
                    <td><%#Eval("transport_style")%></td>
                    <td><%#Eval("receipt_person")%></td>
                    <td><%#Eval("receipted_date")%></td>
                    <td><%#Eval("return_state")%></td>
                    <td><%#Eval("inv_state")%></td>
                    <td><%#Eval("check_by")%></td>
                    
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



   
</body>
</html>
