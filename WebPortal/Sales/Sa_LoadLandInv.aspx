<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_LoadLandInv.aspx.cs" Inherits="WebPortal.Sales.Sa_LoadLandInv" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/demo/demo.css"/>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>
    <%--<script type="text/javascript" src="../js/download.js"></script>--%>
    <style> 
        .box1 {width:400px; float:left; display:inline;} 
        .box2 {width:200px; float:left; display:inline;} 
    </style>
    <script type="text/javascript">

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }
        $(function () {
            initList();
            $('#dg').datagrid({               //根据自身情况更改
                width: $(window).width() - 40,    //根据自身情况更改
                height: $(window).height() - 200,  //根据自身情况更改

            });

            //$("#dg").datagrid({
            //    //双击事件
            //    onDblClickRow: function (index, row) {
            //        var obj = window.parent.document.getElementById("txtMat");
            //        obj.value = row.id;
            //        window.parent.closeWindow();
            //    }
            //});

            $(window).resize(function () {
                $('#dg').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 40,    //根据自身情况更改
                    height: $(window).height() - 200  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 40,      //根据自身情况更改
                    height: $(window).height() - 200   //根据自身情况更改
                });
            });
            InitSearch();//查询

        });

        
        function initList(queryData) {
            $('#dg').datagrid({

                url: "../ashx/Ax_Sa_LoadLandInv.ashx/GetItem",   //指向后台的Action来获取当前用户的信息的Json格式的数据
                iconCls: 'icon-view',//图标
                //height: 500,
                //fit: true,//自动适屏功能，表格會自動適應屏幕，就算設置了高度也無效的
                //width: function () { return document.body.clientWidth * 0.9 },//自动宽度
                nowrap: true,
                autoRowHeight: false,//自动行高
                striped: true,
                collapsible: true,
                singleSelect: true,
                //sortName: 'Id',//排序列名为ID
                sortOrder: 'asc',//排序为将序
                remoteSort: false,
                idField: 'ID',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#dg',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'goods_id', title: '編號', width: 100 },
                { field: 'it_customer', title: '客戶編號', width: 80 },
                { field: 'cust_ename', title: '客戶描述', width: 80 },
                { field: 'goods_ename', title: '貨品名稱', width: 200 },
                { field: 'customer_goods', title: '客戶產品編號', width: 100 },
                { field: 'u_invoice_qty', title: '發票數量', width: 100 },
                { field: 'goods_unit', title: '單位', width: 80 },
                { field: 'mo_id', title: '頁數', width: 100 },
                { field: 'customer_color_id', title: '客戶顏色編號', width: 100 },
                { field: 'brand_id', title: '牌子編號', width: 80 },
                { field: 'season', title: '季度', width: 80 },
                { field: 'amt_hkd', title: '金額HKD', width: 100 },
                { field: 'amt_usd', title: '金額USD', width: 100 },
                { field: 'inv_dat', title: '發票日期', width: 100 },
                { field: 'id', title: '發票編號', width: 100 },
                { field: 'order_date', title: '訂單日期', width: 100 },
                { field: 'goods_cname', title: '物料中文描述', width: 100 }
                ]],
                loadFilter: pagerFilter,
                //toolbar: [{
                //    id: 'btnreload',
                //    text: '刷新',
                //    iconCls: 'icon-reload',
                //    handler: function () {
                //        $("#btnSerach").datagrid("reload");
                //    }
                //}]



            });
        }

        //初始化搜索框
        function InitSearch() {
            //按照条件进行查询，首先我们得到数据
            $("#btnSerach").click(function () {
                if (!chkDataValid()) {
                    return;
                }
                //得到用户输入的参数
                var queryData = {
                    rpt_type: 0,
                    Date_from: $("#txtDate_from").val(),
                    Date_to: $("#txtDate_to").val()
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            });
        }

        function chkDataValid()
        {
            //if ($("#txtLoc_no").val() == "")
            //{
            //    alert("部門不能為空!");
            //    return false;
            //}
            return true;
        }


        function JsonToExcel() {
            if (!chkDataValid())
                return;
            var json = [];
            var j = {};
            j.Date_from = $("#txtDate_from").val(),
            j.Date_to = $("#txtDate_to").val(),
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_Sa_LoadLandInv.ashx/GetItem"

            $.ajax({
                url: url,
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                async: true,    //默認异步，要改為同步：true
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: LoadFunctionDetails

            });
        }

        function LoadFunctionDetails(data) {
            //alert(data);
            $('#txt').val(data);
            return;
            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            var xls = JSONToExcelConvertorDetails("我的excel", dataJson);
            i.val(xls);
            i.appendTo(f);
            l.val('LAND牌子發票記錄');
            l.appendTo(f);
            f.appendTo(document.body).submit();
            $(document.body).remove("form:last");

            //var dataJson = JSON.parse(data);
            //var xls = JSONToExcelConvertorDetails("我的excel", dataJson);
            //var IEwindow = window.open();
            //IEwindow.document.write('sep=,\r\n' +xls);
            //IEwindow.document.close();
            //IEwindow.document.execCommand('SaveAs', true, '11' + ".csv");
            //IEwindow.close();


            //var dataJson = JSON.parse(data);
            //var xls = JSONToExcelConvertorDetails("我的excel", dataJson);
            //var uri = 'data:text/csv;charset=utf-8,\uFEFF' + encodeURI(xls);
            //var link = document.createElement("a");
            //link.href = uri;
            //link.style = "visibility:hidden";
            //link.download = '11' + ".csv";
            //document.body.appendChild(link);
            //link.click();
            //document.body.removeChild(link);
 

            $("#divShowLoadMsg").html('');
        }
        function BefLoadFunction() {
            $("#divShowLoadMsg").html('加载中...');
        }
        function erryFunction(data) {
            alert(data);
        }

        function JSONToExcelConvertorDetails(fileName, jsonData) {
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
            
            row += '<td>' + '編號' + '</td>';
            row += '<td>' + '客戶編號' + '</td>';
            row += '<td>' + '客戶描述' + '</td>';
            row += '<td>' + '貨品名稱' + '</td>';
            row += '<td>' + '客戶產品編號' + '</td>';
            row += '<td>' + '發票數量' + '</td>';
            row += '<td>' + '單位' + '</td>';
            row += '<td>' + '頁數' + '</td>';
            row += '<td>' + '客戶顏色編號' + '</td>';
            row += '<td>' + '牌子編號' + '</td>';
            row += '<td>' + '季度' + '</td>';
            row += '<td>' + '金額HKD' + '</td>';
            row += '<td>' + '金額USD' + '</td>';
            row += '<td>' + '發票日期' + '</td>';
            row += '<td>' + '發票編號' + '</td>'; 
            row += '<td>' + '訂單日期' + '</td>';
            row += '<td>' + '物料中文描述' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                
                row += '<td>' + arrData[i]["goods_id"] + '</td>';
                row += '<td>' + arrData[i]["it_customer"] + '</td>';
                row += '<td>' + arrData[i]["cust_ename"] + '</td>';
                row += '<td>' + arrData[i]["goods_ename"] + '</td>';
                row += '<td>' + arrData[i]["customer_goods"] + '</td>';
                row += '<td>' + arrData[i]["u_invoice_qty"] + '</td>';
                row += '<td>' + arrData[i]["goods_unit"] + '</td>';
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["customer_color_id"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["season"] + '</td>';
                row += '<td>' + arrData[i]["amt_hkd"] + '</td>';
                row += '<td>' + arrData[i]["amt_usd"] + '</td>';
                row += '<td>' + arrData[i]["inv_dat"] + '</td>';
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["order_date"] + '</td>';
                row += '<td>' + arrData[i]["goods_cname"] + '</td>';
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion

        }


        function loadJsonData(objWin,inTblId, inWindow) {
             if (!chkDataValid())
                return;
            var json = [];
            var j = {};
            j.Date_from = $("#txtDate_from").val(),
            j.Date_to = $("#txtDate_to").val(),
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_Sa_LoadLandInv.ashx/GetItem"

            $.ajax({
                url: url,
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                async: true,    //默認异步，要改為同步：true
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: function(data) {toExcel(objWin,data) }//LoadFunctionDetails

            });
        }

        function toExcel(objWin,data)
        {
            var dataJson = JSON.parse(data);
            var xlsStr = JSONToExcelConvertorDetails("我的excel", dataJson);
            doFileExport(objWin,'Land.xls', xlsStr);
        }

        function doFileExport(objWin,inName, inStr) {
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
                xlsWin = objWin//new_window;
                //var IEwindow = window.open();

            }

            xlsWin.document.write(inStr);

            xlsWin.document.close();


            xlsWin.document.execCommand('Saveas', true, inName);//匯出到Excel

            //xlsWin.document.execCommand("print");//打印
            xlsWin.close();


            ////其它瀏覽器的儲存方法
            //var uri = 'data:text/xls;charset=big5,\uFEFF' + encodeURI(inStr);
            //var link = document.createElement("a");
            //link.href = uri;
            //link.style = "visibility:hidden";
            //link.download = 'land' + ".xls";
            //document.body.appendChild(link);
            //link.click();
            //document.body.removeChild(link);


        }

    </script>


    <script type="text/javascript">

        function cellStyler(value, row, index) {  
                if ($.trim(value) == '已拒绝') {  
                        return 'color:#ff0000';  
                    }  
            }               
        
        //分页功能      
        function pagerFilter(data) {  
                if (typeof data.length == 'number' && typeof data.splice == 'function') {  
                        data = {  
                                total: data.length,  
                                rows: data  
                       }  
               }  
           var dg = $(this);  
           var opts = dg.datagrid('options');  
           var pager = dg.datagrid('getPager');  
           pager.pagination({  
                   onSelectPage: function (pageNum, pageSize) {  
                           opts.pageNumber = pageNum;  
                           opts.pageSize = pageSize;  
                           pager.pagination('refresh', {  
                                   pageNumber: pageNum,  
                                   pageSize: pageSize  
                           });  
                   dg.datagrid('loadData', data);  
               }  
           });  
           if (!data.originalRows) {  
                   if(data.rows)  
                           data.originalRows = (data.rows);  
                   else if(data.data && data.data.rows)  
                           data.originalRows = (data.data.rows);  
                   else  
                       data.originalRows = [];  
               }  
           var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);  
           var end = start + parseInt(opts.pageSize);  
           data.rows = (data.originalRows.slice(start, end));  
           return data;  
       }  


    </script>



</head>
<body>
    <div id="container">  

    <div id="content"> 
    <!--存放内容的主区域-->
   <%-- <div data-options="region:'north'" title="請輸入查詢內容" style="height: 60px;">
        <div class="easyui-layout" id="tb" style="padding: 0px; height: auto">--%>
            <!-------------------------------搜索框----------------------------------->
            <fieldset>
                <legend>查詢條件</legend>
                <%--<form id="ffSearch" method="post">--%>
                    <div style="margin-bottom: 5px">
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:120px;height:25px">查詢</a>
                        <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="javascript:loadJsonData(window.open(),'tableDetail','divDetail');" style="width:120px;height:25px">Excel</a>
<%--                        <button class="btn btn-success" onclick ="javascript:loadJsonData(window.open(),'tableDetail','divDetail');">Excel Export</button> 
                        <button class="download">下载CSV</button>
                        <textarea id="txt" class='txtarea' rows="15" cols="100">
                        </textarea>--%>
                    </div>

                
                <%--</form>--%>
            </fieldset>
            <table>
                <tr>
                    <td style="text-align:right"><label for="lblDate">日期</label></td>
                    <td><input size="10" type="text" id="txtDate_from" style="height:18px;width:120px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})""/></td>
                    <td><input size="10" type="text" id="txtDate_to" style="height:18px;width:120px" readonly="readonly" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/></td>
                </tr>
            </table>
  <%--      </div>
    </div>--%>
    <!-------------------------------详细信息展示表格----------------------------------->
    <%--<div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true" style="background: #ccc;">--%>
            <table id="dg" padding-left: 0px;></table>
        <%--</div>
    </div>--%>
    <%--<div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true" style="background: #ccc;">
            <table id="dg" class="easyui-datagrid" title="銷售統計表" style="width:700px;height:250px"
                   data-options="singleSelect:true,collapsible:true,url:'datagrid_data1.json',method:'get'"></table>
        </div>
    </div>--%>
    </div>
    </div>
</body>
</html>
