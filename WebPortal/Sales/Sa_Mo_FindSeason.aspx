<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Mo_FindSeason.aspx.cs" Inherits="WebPortal.Sales.Sa_Mo_FindSeason" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /> 
    <%--<script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>--%>
    <%--<link rel="stylesheet" href="../css/bootstrap.min.css"/>  --%>

   <%-- <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>--%>

    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
      
       <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
         <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
        <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
          <%--<script type="text/javascript" src="../js/Sales/Js_Oc_NoCompleteOc.js"></script>--%>
        <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>

    <script language="JavaScript" type="text/javascript">
    var new_window;
    function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }


        //以下導出導EXCEL，是不用安裝ActiveX控件的，也不用降低IE的安全設定

    function getXlsFromTbl(objWin, inTblId, inWindow, excel_ver) {
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
                //var office_ver = readOfficeVersion(); //獲取Office版本號，根據不同版本號，得到Excel擴展名
                var file_ext = ".xls";
                var fileName = "測試表";
                if (excel_ver == "2010")
                    file_ext = ".xlsx";
//                var fileName = "每日結存匯總表";

//                if (inTblId == "tableDetail") {
//                    fileName = "每日結存明細表";
//                }

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
            var curTbl = document.getElementById("tableDetail");
            var outStr = "";
            var temp_str = "";
            if (curTbl != null) {
                for (var j = 0; j < curTbl.rows.length; j++) {
                    //alert("j is " + j); 
                    for (var i = 0; i < curTbl.rows[j].cells.length; i++) {
                        //alert("i is " + i); 
                        if (i == 0 && rows > 0) {
                            outStr += " \t";
                            rows -= 1;
                        }
                        temp_str = curTbl.rows[j].cells[i].innerText;
                        outStr += temp_str + "\t";
                        
                    }
                    outStr += "\r\n";
                }
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


        function JsonToExcel() {

            var json = [];
            var j = {};
            j.season = $("#selSeason").textbox("getValue");
            j.mo_group = $("#selMo_group").textbox("getValue");
            j.dat1 = document.getElementById('dateStart').value;
            j.dat2 = document.getElementById('dateEnd').value;
            j.brand1 = $("#txtBrand1").textbox('getValue');
            j.brand2 = $("#txtBrand2").textbox('getValue');
            j.cust_goods = $("#txtCust_goods").textbox('getValue');
            json.push(j);
            var obja = JSON.stringify(json);


            $.ajax({
                url: "../ashx/Ax_Mo_FindSeason.ashx/GetItem?paraa=get_data",
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
                //alert(data);
                
                var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
                var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
                var l = $('<input type="hidden" id="txtName" name="txtName" />');
                var dataJson = JSON.parse(data);
                i.val(JSONToExcelConvertor("我的excel", dataJson));
                i.appendTo(f);
                l.val('S組測試表');
                l.appendTo(f);
                f.appendTo(document.body).submit();
                $(document.body).remove("form:last");


                //document.getElementById('btnFind').click();

                $("#divShowLoadMsg").html('');
            }
            function BefLoadFunction() {
                $("#divShowLoadMsg").html('加载中...');
            }
            function erryFunction() {
                alert("error");
            }



        }


        function JSONToExcelConvertor(fileName, jsonData) {
            ///<summary>json转excel下载</summary>
            ///<param name="fileName">文件名</param>
            ///<param name="jsonData">数据</param>        

            //json
            var arrData = typeof jsonData != 'object' ? JSON.parse(jsonData) : jsonData;

            // #region 拼接数据

            var excel = '<table>';

            //设置表头
            var row = "<tr>";


            //------------用JASON的標頭作為EXCEL的表頭----------------

            //for (var name in arrData[0]) {
            //    //每个单元格都可以指定样式. eg color:red   生成出来的就是 红色的字体了.
            //    row += "<td style='color:red;text-align:center;'>" + name + '</td>';
            //}
            //------------用JASON的標頭作為EXCEL的表頭----------------

            row += '<td>' + '季度' + '</td>';
            row += '<td>' + '客戶編號' + '</td>';
            row += '<td>' + '頁數' + '</td>';
            row += '<td>' + '尺寸' + '</td>';
            row += '<td>' + '型號' + '</td>';
            row += '<td>' + '顏色' + '</td>';
            row += '<td>' + '顏色做法' + '</td>';
            row += '<td>' + '數量(PCS)' + '</td>';
            row += '<td>' + '牌子編號' + '</td>';
            row += '<td>' + '客戶產品編號' + '</td>';

            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["season"] + '</td>';
                row += '<td>' + arrData[i]["it_customer"] + '</td>';
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["size_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["art"] + '</td>';
                row += '<td>' + arrData[i]["clr_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["do_color"] + '</td>';
                row += '<td>' + arrData[i]["qty_grs"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["customer_goods"] + '</td>';
                ////循環將JASON中的記錄傳入EXCEL
                //for (var index in arrData[i]) {

                //    var value = arrData[i][index] === "." ? "" : arrData[i][index];

                //    row += '<td style="text-align:center;">' + value + '</td>';//将值放入td
                //}
                ////循環將JASON中的記錄傳入EXCEL

                //将td 放入tr,将tr放入table
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion


        }



    </script>





    <style type="text/css"> 
        .divShowQueryImg{ border:1px solid #000; height:80px;overflow:hidden;} 
        .divShowQueryImg img{max-width:60px;_width:expression(this.width > 300 ? "300px" : this.width);} 
    </style> 
    <%--<style type="text/css"> 
        .divcss5{ border:1px solid #000; height:80px} 
        .divcss5 img{width:80px; height:60px} 
    </style> --%>


</head>
<body>
    <div id="container"> 

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


    <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>

        

    <div class="div_search_frame">
    <table border="0" width="800px">
    <tr>
		<td colspan="6"> 
            <%--<asp:Button class="btn btn-success" ID="Button1" runat="server" onclick="Btn_Query_Click" Text="查询" Width="120px" />--%>
            <%--<input type="button" class="btn btn-success" style="width:140px" value="匯出到Excel(2003)" onclick="javascript: getXlsFromTbl(window.open(), 'tableDetail', 'divDetail', '2003');">
            <input type="button" class="btn btn-success" style="width:140px" value="匯出到Excel(2010)" onclick="javascript: getXlsFromTbl(window.open(), 'tableDetail', 'divDetail', '2010');">--%>
            <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel()" style="width:80px;height:25px">匯出全部</a>
        </td>
        <td colspan="2">
            <div id="divShowLoadMsg" style="color:blue">

            </div>
        </td>
                
  	</tr>
	 		<tr>
				<td style="width:10%">  
				    季度:
                </td>
                <td style="width:15%">
                    <%--<asp:DropDownList ID="dlSeason" runat="server" Width="90%" />--%>
                    <select id="selSeason" name="selSeason" class="easyui-combobox" style="width:120px;height:22px" data-options="width:80, valueField: 'id', textField: 'id', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_season&parab=list'" />
                </td>
                <td style="width:5%">
                    組別
                </td>
                <td style="width:15%">
                    <%--<asp:DropDownList ID="dlMo_group" runat="server" Width="90%" />--%>
                    <select id="selMo_group" name="selMo_group" class="easyui-combobox" style="width:120px;height:22px" data-options="width:80, valueField: 'mo_group', textField: 'mo_group', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_mogroup&parab=list'" />
                </td>
                <td style="width:10%">
                    訂單日期
                </td>
                <td style="width:20%">
                    <input size="10" type="text" id="dateStart" style="height:18px;width:90%" runat="server" onchange="setValue(this,dateEnd)" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})"/>
                </td>
                <td style="width:5%">
	  				到
                </td>
                <td style="width:20%">
	  				<input size="10" type="text" id="dateEnd" style="height:18px;width:90%" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                </td>
            </tr>
            <tr>
                <td>
                    牌子編號
                </td>
                <td>
                    <input type="text" id="txtBrand1" class="easyui-textbox" style="height:20px;width:90%" onkeypress="setValue(this,txtBrand2)" runat="server"/>
                </td>
                <td>
	  				到
                </td>
                <td>
                    <input type="text" id="txtBrand2" class="easyui-textbox" style="height:20px;width:90%" runat="server"/>
                </td>
                <td colspan="5">
                    客戶產品編號:
                    <input type="text" id="txtCust_goods" class="easyui-textbox" style="height:20px;width:200px" runat="server"/>
                </td>

  			</tr>

    </table>
    </div>
        
        



        <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="divShowQueryImg" style=" color: Blue; background-color: #FAEBD7; border: 0px solid #FAEBD7;">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
        </asp:UpdateProgress> 


        <div id="divDetail" class="div_table_scroll" runat ="server">
        <table class="table-responsive table-hover" id="tableDetail" width="98%" border="1" cellspacing="1" cellpadding="2" align="center" style="margin:0px;"> 
        <thead>
  			 <tr class="a1" style="color:#ffffff;font-size:12px;">
   				        <th height="30">季度</th>
				        <th>客戶編號</th>
                        <th>頁數</th>
    			        <th>尺寸</th>
				        <th>型號</th>
				        <th>顏色</th>
                        <th>顏色做法</th>
				        <th>數量(GRS)</th>
                        <th>牌子編號</th>
  			 </tr>  
  			</thead>
  			<asp:Repeater ID="wpDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td><%#Eval("season")%></td>
      			    <td><%#Eval("it_customer")%></td>
                    <td><%#Eval("mo_id")%></td>
      			    <td><%#Eval("size_cdesc")%></td>
      			    <td><%#Eval("art")%></td>
      			    <td><%#Eval("clr_cdesc")%></td>
                    <td><%#Eval("do_color")%></td>
      			    <td><%#Eval("qty_grs")%></td>
                    <td><%#Eval("brand_id")%></td>
  			     </tr>
  			    </ItemTemplate>
  			</asp:Repeater>

            
  			 
		</table>
        </div>


        



        </ContentTemplate>
        </asp:UpdatePanel>
    </form>

    </div>
    </div>


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
            format: 'yyyy-mm-dd',
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
