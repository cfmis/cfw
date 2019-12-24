<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Order_Trace_New.aspx.cs" Inherits="WebPortal.Sales.Sa_Order_Trace_New" %>

<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>訂單生產跟蹤表</title>
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <%--<script src="../js/util.js" type="text/javascript"></script> --%>
    <script src="../js/jquery.min.js" type="text/javascript"></script> 
    <script src="../js/jquery-1.11.0-beta1.js" type="text/javascript"></script> 
    <script src="../js/json2.js" type="text/javascript"></script>
    
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>

    <script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>

    <%--<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>--%>
   	

    
    
   	


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

                alert("&#35831;&#36873;&#25321;要操作的&#36873;&#39033;");
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
//            var rows = document.getElementById("tableExcel").rows.length; //&#33719;得行&#25968;(包括thead)
//            var colums = document.getElementById("tableExcel").rows[0].cells.length; //&#33719;得列&#25968;
//            if (rows > 1) {//
//                for (var i = 1; i < rows; i++) { //每行 &#20174;第二行&#24320;始因&#20026;第一行是表格的&#26631;&#39064;
//                    var OrderObj1 = new Object(OrderObj); //&#36825;里一定要new新的&#23545;象，要不然保存的都是一&#26679;的&#25968;据；都是最后一行的&#25968;据
//                    OrderObj1.id = document.getElementById("tableExcel").rows[i].cells[1].innerText;
//                    OrderObj1.mo_id = document.getElementById("tableExcel").rows[i].cells[8].innerText;

//                    a.data.push(OrderObj1); //向JSON&#25968;&#32452;添加JSON&#23545;象的方法；很&#20851;&#38190;
//                }

//                ///格式化&#25968;据
//                var obj = JSON.stringify(a); //&#36825;一行很&#20851;&#38190;
//            }





            var tb = document.getElementById('tableExcel');
            rows = tb.rows;
            if (rows.length > 0) {
//            var selectinput=tb.getElementsByTagName("select");//選擇表格中所有select的對象
                
            var select_flag = false;
                var json = [];
                for (var i = 0; i < rows.length; i++) {
                    var cells = rows[i].cells;
                    //這個是循環取表格中所有select的值
//                    var rowIndex = i-1;
//                    var text1 = selectinput[rowIndex].options[selectinput[rowIndex].selectedIndex].text;
//                    var value1 = selectinput[rowIndex].options[selectinput[rowIndex].selectedIndex].value;
                    if (cells[0].childNodes[0].checked) {
                        select_flag = true;
                        var j = {};
                        var cb;
                        j.id = cells[5].innerText;
                        j.order_date = cells[1].innerText;
                        j.mo_id = cells[8].innerText;
                        cb = cells[11].childNodes[0];
                        j.prd_status = cb.options[cb.selectedIndex].value; //生產狀態
                        cb = cells[12].childNodes[0];
                        j.ret_hk_status = cb.options[cb.selectedIndex].value; //大貨回港情況
                        cb = cells[14].childNodes[0];
                        j.sample_hk_status = cb.options[cb.selectedIndex].value; //大貨辦情況
                        cb = cells[15].childNodes[0];
                        j.chk_color_status = cb.options[cb.selectedIndex].value; //大貨批色情況
                        j.chk_color_date = cells[16].childNodes[0].value;
                        j.job_no = cells[17].childNodes[0].value;
                        j.test_status = cells[18].childNodes[0].value;
                        j.inv_no = cells[19].childNodes[0].value;
                        j.inv_date = cells[20].childNodes[0].value;
                        j.shipment = cells[21].childNodes[0].value;
                        j.awb_no = cells[22].childNodes[0].value;
                        j.sent_date = cells[23].childNodes[0].value;
                        j.remark = cells[24].childNodes[0].value;
                        cb = cells[25].childNodes[0];
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






//            异步提交&#25968;据

            $.ajax({
                url: "../ashx/Sa_Order_Trace.ashx",
                type: "post",
                data: { 'param': obja }, //&#21442;&#25968;
                datatype: "json",
                beforeSend: BefLoadFunction, //加&#36733;&#25191;行方法
                error: erryFunction, //&#38169;&#35823;&#25191;行方法
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
                $("#ddd").html('加&#36733;中...');
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
                    alert("你要&#23548;出的表不存在！");
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
                alert("&#23548;出&#21457;生异常:" + e.name + "->" + e.description + "!");
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
            //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>&#33829;&#38144;&#25253;表</th></tr>");

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
                        if (j > 0 && (i == 11 || i == 12 || i == 14 || i == 15 || i == 25)) {
                            var cb = cells[i].childNodes[0];
                            val = cb.options[cb.selectedIndex].text;
                        }
                        else
                            val = curTbl.rows[j].cells[i].innerText;
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
        function showChkValue() {
            var tb = document.getElementById('tableExcel');
            var rows = tb.rows;
            if (rows.length > 0) {
                for (var i = 0; i < rows.length; i++) {
                    var cells = rows[i].cells;
                    var mo = cells[8].innerText;

                    var val = cells[0].childNodes[0].checked;

                    var val1 = cells[0].childNodes[0].value;

                }
            }
            else {
                alert("沒有記錄!");
                return;
            }
        }
    </script>

    <script type="text/javascript">
        function selectAll() {
            var tb = document.getElementById('tableExcel');
            var rows = tb.rows;
            if (rows.length > 0) {
                for (var i = 0; i < rows.length; i++) {
                    var cells = rows[i].cells;

                    if (document.getElementById('chkSelectAll').checked) {
                        var aa = cells[0].innerHTML;//.innerText;
                        cells[0].childNodes[0].checked = true;
//                        cells[1].innerText = i;
//                        aa = cells[1].innerText;
                    }
                    else
                        cells[0].childNodes[0].checked = false;
                }
            }
            else {
                alert("沒有記錄!");
                return;
            }





//            var checkboxes = document.getElementsByName('selOrder');
//            $("#select_all").click(function () {
//                for (var i = 0; i < checkboxes.length; i++) {
//                    var checkbox = checkboxes[i];
//                    if (!$(this).get(0).checked) {
//                        checkbox.checked = false;
//                    } else {
//                        checkbox.checked = true;
//                    }
//                }
//            });




        }
    </script>
    


    <script type="text/javascript">
        $(function () {
            //            $("#btnShowVal").click(function () {
            //                //获取选中的数据组
            //                var array = $("table input[type=checkbox]:checked").map(function () {
            //                    return { "cell2": $.trim($(this).closest("tr").find("td:eq(2)").text()), "cell4": $.trim($(this).closest("tr").find("td:eq(4)").text()) };
            //                }).get();

            //                $.each(array, function (i, d) {
            //                    alert(d.cell2 + "|" + d.cell4);
            //                })
            //            })

            var inputs = document.getElementsByName('colJob_no');
            $("#btnShowVal").click(function () {
                for (var i = 0; i < inputs.length; i++) {
                    var inputt = inputs[i];
                    var aa = inputt.value;
                    //                    if (!$(this).get(0).checked) {
                    //                        checkbox.checked = false;
                    //                    } else {
                    //                        checkbox.checked = true;
                    //                    }
                }
            });

            var checkboxes = document.getElementsByName('selOrder');
            $("#select_all").click(function () {
                for (var i = 0; i < checkboxes.length; i++) {
                    var checkbox = checkboxes[i];
                    if (!$(this).get(0).checked) {
                        checkbox.checked = false;
                    } else {
                        checkbox.checked = true;
                    }
                }
            });


        })
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

                //                document.getElementById('divSearch').style.display = 'none'; //&#38544;藏





                document.getElementById('btnShowDivSeach').value = "顯示條件>>"
            }
            else {
                o_lay.style.display = "block";
                h_lay = o_lay.offsetHeight;
                h_cont = h_w - h_lay - h_lay;
                
//                o.style.height = o.offsetHeight - ui.offsetHeight;
//                document.getElementById('divSearch').style.display = 'block'; //&#26174;示  
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
            alert("网&#39029;可&#35265;&#21306;域高：" + document.body.offsetHeight);
            alert("网&#39029;可&#35265;&#21306;域高：" + document.body.clientHeight);
            alert("网&#39029;正文全文高：" + document.body.offsetHeight);
            alert("网&#39029;被卷去的高：" + document.body.scrollTop);
            alert(" 屏幕可用工作&#21306;高度：" + window.screen.availHeight);
            alert("cont:" + document.getElementById("container").offsetHeight);
            alert("divLayer2:" + document.getElementById("divLayer2").offsetHeight);
            alert("divDetail:" + document.getElementById("divDetail").offsetHeight);
        }
    </script>
    <script type="text/javascript">
        function initDivHeight() {
//        window.onload=function(){
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
//            s += " 网&#39029;可&#35265;&#21306;域&#23485;：" + document.body.clientWidth;
//            s += " 网&#39029;可&#35265;&#21306;域高：" + document.body.clientHeight;
//            s += " 网&#39029;可&#35265;&#21306;域&#23485;：" + document.body.offsetWidth + " (包括&#36793;&#32447;和&#28378;&#21160;&#26465;的&#23485;)";
//            s += " 网&#39029;可&#35265;&#21306;域高：" + document.body.offsetHeight + " (包括&#36793;&#32447;的&#23485;)";
//            s += " 网&#39029;正文全文&#23485;：" + document.body.scrollWidth;
//            s += " 网&#39029;正文全文高：" + document.body.scrollHeight;
//            s += " 网&#39029;被卷去的高(ff)：" + document.body.scrollTop;
//            s += " 网&#39029;被卷去的高(ie)：" + document.documentElement.scrollTop;
//            s += " 网&#39029;被卷去的左：" + document.body.scrollLeft;
//            s += " 网&#39029;正文部分上：" + window.screenTop;
//            s += " 网&#39029;正文部分左：" + window.screenLeft;
//            s += " 屏幕分辨率的高：" + window.screen.height;
//            s += " 屏幕分辨率的&#23485;：" + window.screen.width;
//            s += " 屏幕可用工作&#21306;高度：" + window.screen.availHeight;
//            s += " 屏幕可用工作&#21306;&#23485;度：" + window.screen.availWidth;
//            s += " 你的屏幕&#35774;置是 " + window.screen.colorDepth + " 位彩色";
//            s += " 你的屏幕&#35774;置 " + window.screen.deviceXDPI + " 像素/英寸";
//            alert (s); 

        }
    </script>


    <script type="text/javascript">

        function fixgrid() {

            $('.flexme2').flexigrid();
            ///$('.flexme2').flexigrid({height:'auto',striped:false});
        }


        </script>


        <script type="text/javascript">  

        $(document).ready(function(){  
			addItems(); 
		});


//动态绑定下拉框项  
       function addItems() {  
           $.ajax({  
               url: "../ashx/Base_Select.ashx/GetItem",    //后台webservice里的方法名称  
               type: "post",  
               dataType: "json",  
               contentType: "application/json",  
               traditional: true,  
                success: function (data) {  
                    for (var i in data) {  
                        var jsonObj =data[i];  
                        var optionstring = "";  
                        for (var j = 0; j < jsonObj.length; j++) {  
                            optionstring += "<option value=\"" + jsonObj[j].flag_id + "\" >" + jsonObj[j].flag_desc + "</option>";  
                        }  
                        $("#dpdField1").html("<option value='请选择'>请选择...</option> "+optionstring);  
                    }  
                },  
                error: function (msg) {  
                    alert("出错了！");  
                }  
            });            
        };  
         
    </script>   




    <style type="text/css">
    #addMian_b {width:980px;height:450px;background:#000;-moz-opacity:0.2; filter:alpha(opacity=25);margin:-30px 10 0 10px; position:absolute;}
#addMian_t { z-index:20;border:1px solid #a4d5e3;width:960px;height:450px;background:#FFF;margin:-15px 0 0 5px; position:absolute;}
body {
	margin-left: 10px;
	margin-top: 0px;
}
    
    </style>



</head>
<body>
    <%--<div id="container">  --%>


    <table class="table_SiteMapPath">
    <tr>
    <td>
    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
          </asp:SiteMapPath>
    </td>
    </tr>
    </table>

    <%--<div id="content"> --%>
    
    
    <form id="form1" runat="server">
    

    <div align="center" >
    <%--<asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
        </asp:ScriptManager>
    
        <asp:UpdatePanel ID="UpdatePanel" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>--%>
    
    <select id="dpdField1"></select>
                        
                        

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
        
        <input type="button" class="btn btn-success" style="width:96%" value="取消追蹤表" id="Submit1" onclick="javascript:if(!confirm('您确定要操作&#21527;'))return  false;shenheSubmit('shenhe')" />
        <input type="button" class="btn btn-success" style="width:96%;" value="設定值" name="select_all" id="Button2" />
        <input type="button" class="btn btn-success" style="width:96%;" value="顯示值" id="btnShowVal" />
        
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
        <input type="checkbox" id="select_all" value='全選' />
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


    <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="show_query_img">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
    </asp:UpdateProgress> --%>
<br />

<div style="width:100%;">
  <table id="tableExcel"  class="flexme2">
	<thead>
    		<tr>
   				        <th width="40">選擇</th>
				        <th width="60">訂單日期</th>
                        <th width="40">客戶編號</th>
                        <th width="80">客戶描述</th>
                        <th width="40">客戶PO</th>
                        <th width="40">OC編號</th>
                        <th width="40">客戶產品編號</th>
                        <th width="40">客戶顏色編號</th>
                        <th width="60">制單編號</th>
                        <th width="40">PI貨期</th>
                        <th width="40">客人要求日期</th>
                        <th width="40">生產情況</th>
                        <th width="40">大貨回港情況</th>
                        <th width="40">大貨回港日期</th>
                        <th width="40">大貨辦情況</th>
                        <th width="40">大貨批色情況</th>
                        <th width="40">批復日期</th>
                        <th width="60">Job No.</th>
                        <th width="40">測試情況</th>
                        <th width="40">測試發票編號</th>
                        <th width="40">測試發票日期</th>
                        <th width="40">ShipMent</th>
                        <th width="40">AWB No.</th>
                        <th width="40">出貨日期</th>
                        <th width="80">備註</th>
                        <th width="40">制單狀態</th>
                        <th width="40">測試狀況</th>
  			 </tr>  
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>

            	<td><input type="checkbox" name="selOrder" value="<%#Eval("id")%>" /></td>
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
                        <option value="<%#Eval("prd_status")%>"><%#Eval("prd_status_desc")%>
                        </option><option value="01">未完成</option>
                        <option value="02">已完成</option>
                        <option value="03">強制完成</option>
                        <option value="04">已取消</option>
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
                        </select>
                    </td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("chk_color_status")%>"><%#Eval("chk_color_status_desc")%>
                        </option><option value="1">待批</option>
                        <option value="2">已批</option>
                        </select>
                    </td>
                    <td><input type="text" name="colChk_color_date" style="width:80%" value="<%#Eval("chk_color_date")%>"/></td>
                    <td><input type="text" name="colJob_no" style="width:80%" value="<%#Eval("job_no")%>"/></td>
                    <td><input type="text" name="colTest_status" style="width:80%" value="<%#Eval("test_status")%>"/></td>
                    <td><input type="text" name="colInv_no" style="width:80%" value="<%#Eval("inv_no")%>"/></td>
                    <td><input type="text" name="colInv_no" style="width:80%" value="<%#Eval("inv_date")%>"/></td>
                    <td><input type="text" name="colShipment" style="width:80%" value="<%#Eval("shipment")%>"/></td>
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
    		</tr>
        
        </ItemTemplate>
        </asp:Repeater>
      
    		
    </tbody>
</table>
</div>

           <div class="pageLink" id="pageLink">

            </div>
        

        <script type="text/javascript">



            $('.flexme2').flexigrid();
            ///$('.flexme2').flexigrid({height:'auto',striped:false});


</script>

        <%--</ContentTemplate>
        </asp:UpdatePanel>--%>



         </div>
        
    </form>




    <%--</div>--%><%--content --%>
    <%--</div>--%><%-- container --%>



   
</body>
</html>
