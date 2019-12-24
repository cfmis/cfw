<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="St_GoodsTransferJxDetails.aspx.cs" Inherits="WebPortal.Stock.St_GoodsTransferJxDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/demo/demo.css"/>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <%--<script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>--%>
    <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>
    <script type="text/javascript" src="../js/easyuiDatePicker.js"></script>

    <style> 
        .box1 {width:400px; float:left; display:inline;} 
        .box2 {width:200px; float:left; display:inline;} 
    </style>
    <script type="text/javascript">

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }

        $(function () {

            //添加以下兩行賦值代碼後，會導致JQUERY載入實效，導致不能查詢數據的
            ////设置时间  
            //var curr_time = new Date();
            //$("#txtDate_from").val(myformatter(curr_time));
            //$("#txtDate_to").val(myformatter(curr_time));
            //$('#selLoc_no').textbox('setValue', 'J03');

            //initList();

            SearchData();
            $('#tbInvList').datagrid({               //根据自身情况更改
                width: $(window).width() - 40,    //根据自身情况更改
                height: $(window).height() - 200,  //根据自身情况更改

            });

            //$("#tbInvList").datagrid({
            //    //双击事件
            //    onDblClickRow: function (index, row) {
            //        var obj = window.parent.document.getElementById("txtMat");
            //        obj.value = row.id;
            //        window.parent.closeWindow();
            //    }
            //});

            $(window).resize(function () {
                $('#tbInvList').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 40,    //根据自身情况更改
                    height: $(window).height() - 200  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 40,      //根据自身情况更改
                    height: $(window).height() - 200   //根据自身情况更改
                });
            });
            InitSearch();//查询

            $('#txtDate_from').datebox({
                onSelect: function (value) {
                    $('#txtDate_to').datebox('setValue', $('#txtDate_from').datebox('getValue'));//, changeDateToChar(value)

                }
            });

        });

        
        function initList(queryData) {
            $('#tbInvList').datagrid({

                url: "../ashx/Ax_GoodsTransferJx.ashx?paraa=get_transfer_details&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                //toolbar: '#tbInvList',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                    { field: 'transfer_date', title: '日期', width: 120 },
                    { field: 'prd_mo', title: '制單編號', width: 120 },
                    { field: 'prd_item', title: '物料編號', width: 200 },
                    { field: 'prd_item_cdesc', title: '物料描述', width: 200 },
                    { field: 'transfer_qty', title: '數量', width: 80 },
                    { field: 'transfer_weg', title: '重量', width: 80 },
                    { field: 'flag_desc', title: '標識', width: 80 },
                    { field: 'prd_dep', title: '發貨部門', width: 80 },
                    { field: 'wip_id', title: '負責部門', width: 80 },
                    { field: 'prd_dep_cdesc', title: '負責部門', width: 80 },
                    { field: 'to_dep', title: '收貨部門', width: 80 },
                    { field: 'to_dep_cdesc', title: '收貨部門', width: 80 }
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
                SearchData();
            });
        }
        function SearchData() {
            if (!chkDataValid()) {
                return;
            }
            //得到用户输入的参数
            var queryData = {
                rpt_type: 0,
                Prd_dep: $("#selPrd_dep").textbox('getValue'),
                Mo_group: $("#txtMo_group").val(),
                Prd_mo_from: $("#txtMo_from").val(),
                Prd_mo_to: $("#txtMo_to").val(),
                Prd_item_from: $("#txtPrd_item_from").val(),
                Date_from: $("#txtDate_from").textbox("getValue"),
                Date_to: $("#txtDate_to").textbox("getValue"),
                Transfer_flag: $("#selTransfer_flag").textbox('getValue'),
            };
            //将值传递给initTable
            initList(queryData);
            return false;
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


        function JsonToExcel(rpt_type) {
            if (!chkDataValid())
                return;
            var xlsWin = null;
            if (rpt_type == 1)
            {
                xlsWin = window.open();
            }
            var json = [];
            var j = {};
            j.Prd_dep = $("#selPrd_dep").textbox('getValue');
            j.Mo_group = $("#txtMo_group").val();
            j.Prd_mo_from = $("#txtMo_from").val();
            j.Prd_mo_to = $("#txtMo_to").val();
            j.Prd_item_from = $("#txtPrd_item_from").val();
            j.Date_from = $("#txtDate_from").textbox("getValue"),
            j.Date_to = $("#txtDate_to").textbox("getValue"),
            j.Transfer_flag = $("#selTransfer_flag").textbox('getValue'),
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_GoodsTransferJx.ashx?paraa=get_transfer_details"

            $.ajax({
                url: url,
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                async: true,    //默認异步，要改為同步：true
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: function (data) {
                    LoadFunctionDetails(rpt_type,xlsWin, data);
                }

            });
        }

        function LoadFunctionDetails(rpt_type,xlsWin,data) {
            //alert(data);
            var dataJson = JSON.parse(data);
            var allStr = JSONToExcelConvertorDetails("我的excel", dataJson);
            if (rpt_type == 1)
            {
                printData(xlsWin, allStr);
                //doPrint();
                return;
            }
            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            
            i.val(allStr);
            i.appendTo(f);
            l.val('收發記錄表');
            l.appendTo(f);
            f.appendTo(document.body).submit();
            $(document.body).remove("form:last");


            //document.getElementById('btnFind').click();

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

            var excel = '<table style="border-collapse:collapse;width:98%" border="1">';

            //设置表头
            var row = "<tr>";


            //------------用JASON的標頭作為EXCEL的表頭----------------

            //for (var name in arrData[0]) {
            //    //每个单元格都可以指定样式. eg color:red   生成出来的就是 红色的字体了.
            //    row += "<td style='color:red;text-align:center;'>" + name + '</td>';
            //}
            //------------用JASON的標頭作為EXCEL的表頭----------------
            row += '<td>' + '日期' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '物料編號' + '</td>';
            row += '<td>' + '物料描述' + '</td>';
            row += '<td>' + '數量' + '</td>';
            row += '<td>' + '重量' + '</td>';
            row += '<td>' + '標識' + '</td>';
            row += '<td>' + '發貨部門' + '</td>';
            row += '<td>' + '負責部門' + '</td>';
            row += '<td>' + '負責部門' + '</td>';
            row += '<td>' + '下部門' + '</td>';
            row += '<td>' + '下部門' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["transfer_date"] + '</td>';
                row += '<td>' + arrData[i]["prd_mo"] + '</td>';
                row += '<td>' + arrData[i]["prd_item"] + '</td>';
                row += '<td>' + arrData[i]["prd_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["transfer_qty"] + '</td>';
                row += '<td>' + arrData[i]["transfer_weg"] + '</td>';
                row += '<td>' + arrData[i]["flag_desc"] + '</td>';
                row += '<td>' + arrData[i]["prd_dep"] + '</td>';
                row += '<td>' + arrData[i]["wip_id"] + '</td>';
                row += '<td>' + arrData[i]["prd_dep_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["to_dep"] + '</td>';
                row += '<td>' + arrData[i]["to_dep_cdesc"] + '</td>';
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion



        }

        function printData(xlsWin,inStr) {
            //var xlsWin = null;
            //if (!!document.all("glbHideFrm")) {
            //    xlsWin = glbHideFrm;

            //}
            //else {
            //    var width = 6;
            //    var height = 4;
            //    var openPara = "left=" + (window.screen.width / 2 - width / 2)
            //     + ",top=" + (window.screen.height / 2 - height / 2)
            //     + ",scrollbars=no,width=" + width + ",height=" + height;

            //    //xlsWin = window.open("../ExportToExcel.aspx", "_blank", openPara);
            //    window.open("../ExportToExcel.aspx");//new_window;


            //}

            xlsWin.document.write(inStr);

            xlsWin.document.close();
            xlsWin.document.execCommand("print"); //打印
            xlsWin.close();
        }

        function doPrint() {
            //var win = window.open() //写成一行
            //var win1;
            //window.print();
            //window.location.href("../Stock/St_GoodsTransferPrint.aspx?dateFrom=" + dateFrom + "&dateTo=" + dateTo);
            var url = "../Stock/St_GoodsTransferJxPrint.aspx?prdDep=" + $("#selPrd_dep").textbox('getValue')
                + "&dateFrom=" + $("#txtDate_from").textbox("getValue") + "&dateTo=" + $("#txtDate_to").textbox("getValue")
                + "&prdItem=" + $("#txtPrd_item_from").val() + "&prdMoFrom=" + $("#txtMo_from").val() + "&prdMoTo=" + $("#txtMo_to").val()
                + "&transferFlag=" + $("#selTransfer_flag").textbox('getValue')
                + "&moGroup=" + $("#txtMo_group").val();
            //window.open("../Stock/St_GoodsTransferPrint.aspx?dateFrom=" + dateFrom + "&dateTo=" + dateTo);

            //window.open(url, 'newwindow', 'height=600, width=800, top=60, left=60, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no')
            window.open(url, 'newwindow')


            return;

            var head = "<html><head><title></title></head><body><OBJECT classid='CLSID:8856F961-340A-11D0-A96B-00C04FD705A2' height='0' id='WebBrowser3' width='0' VIEWASTEXT></OBJECT><div align='center'><table width=250px align='center'>";//先生成头部
            var foot = "</table></div></body></html>";//生成尾部
            var newstr = "";
            newstr += '<tr><td colspan="4" style="font-size:10px;line-height:20px">单据编号：' + "abc" + '</td></tr>';

            var oldstr = document.body.innerHTML;//获取原本网页页面代码
            document.body.innerHTML = head + newstr + foot;//拼接打印页面
            if (getExplorer() == "IE") {//判断是否IE浏览器，是，调用去除页眉页脚的方法，否，直接输出即可
                pagesetup_null();
            }
            window.print();
            document.body.innerHTML = oldstr;//还原网页；  
            return false;

        }


        function pagesetup_null() {
            var hkey_root, hkey_path, hkey_key;
            hkey_root = "HKEY_CURRENT_USER";
            hkey_path = "\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
            try {
                var RegWsh = new ActiveXObject("WScript.Shell");
                hkey_key = "header";
                RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "");
                hkey_key = "footer";
                RegWsh.RegWrite(hkey_root + hkey_path + hkey_key, "");
            } catch (e) { }
        }

        function getExplorer() {
            var explorer = window.navigator.userAgent;
            //ie 
            if (explorer.indexOf("MSIE") >= 0) {
                return "IE";
            }
                //firefox 
            else if (explorer.indexOf("Firefox") >= 0) {
                return "Firefox";
            }
                //Chrome
            else if (explorer.indexOf("Chrome") >= 0) {
                return "Chrome";
            }
                //Opera
            else if (explorer.indexOf("Opera") >= 0) {
                return "Opera";
            }
                //Safari
            else if (explorer.indexOf("Safari") >= 0) {
                return "Safari";
            }
            
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
                        <a href="#" id="btnExpAll" class="easyui-linkbutton" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(0)" style="width:120px;height:25px">Excel</a>
                        <a href="#" id="btnPrint" class="easyui-linkbutton" iconCls="icon-print"  plain="false" onclick="doPrint()" style="width:120px;height:25px">Print</a>
                        <%--<a href="#" onclick="doPrint()">打开窗口</a>--%>
                    </div>

                
                <%--</form>--%>
            </fieldset>
            <table>
                <tr>
                    <td style="text-align:right"><label for="lblDep">部門編號</label></td>
                    <%--<td><input type="text" class="easyui-validatebox" id="txtDep" name="txtDep" style="width:120px" /></td>--%>
                    <td><input id="selPrd_dep" name="txtLoc_no" class="easyui-combobox" data-options="width:120, valueField: 'dep_id', textField: 'dep_cdesc', url: '../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=list'" /></td>
                    <td style="text-align:right"><label for="lblPrd_item">物料編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtPrd_item_from" name="txtPrd_item_from" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblMo_group">組別</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMo_group" name="txtMo_group" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblTransfer_flag">標識</label></td>
                    <td><input id="selTransfer_flag" name="selTransfer_flag" style="float:none" class="easyui-combobox" data-options="width:120, valueField: 'flag_id', textField: 'flag_desc', url: '../ashx/Base_Select.ashx/GetItem?paraa=goods_transfer_jx&parab=list'" /></td>
                </tr>
                <tr>
                    <td style="text-align:right"><label for="lblMo">制單編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMo_from" name="txtMo_from" style="width:120px" onchange="setValue(this,txtMo_to)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMo_to" name="txtMo_to" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblDate">日期</label></td>
                    <%--<td><input size="10" type="text" id="txtDate_from" style="height:18px;width:120px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})""/></td>--%>
                    <%--<td><input size="10" type="text" id="txtDate_to" style="height:18px;width:120px" readonly="readonly" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/></td>--%>
                    <td><input id="txtDate_from" style="width:120px" class="easyui-datebox-expand"/></td>
                    <td><input id="txtDate_to" style="width:120px" class="easyui-datebox-expand"/></td>
                </tr>
            </table>

  <%--      </div>
    </div>--%>
    <!-------------------------------详细信息展示表格----------------------------------->
    <%--<div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true" style="background: #ccc;">--%>
            <table id="tbInvList" padding-left: 0px;></table>
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
