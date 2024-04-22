<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Mo_NotComplete.aspx.cs" Inherits="WebPortal.Sales.Sa_Mo_NotComplete" %>

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
    <%--<script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>--%>
    <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>
    <script type="text/javascript" src="../js/easyuiDatePicker.js"></script>
    <style> 
        .box1 {width:400px; float:left; display:inline;} 
        .box2 {width:200px; float:left; display:inline;} 
    </style>
    <script type="text/javascript">
        var query_url = '';
        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }
        
        $(function () {
            
            SearchData();
            $('#tbInvList').datagrid({               //根据自身情况更改
                width: $(window).width() - 40,    //根据自身情况更改
                height: $(window).height() - 260,  //根据自身情况更改

            });

            $(window).resize(function () {
                $('#tbInvList').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 40,    //根据自身情况更改
                    height: $(window).height() - 260  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 40,      //根据自身情况更改
                    height: $(window).height() - 260   //根据自身情况更改
                });
            });
            

            //InitSearch();//查询

            $("#btnSerach").click(function () {
                query_url = "../ashx/Ax_Mo_NotComplete.ashx?paraa=table";
                SearchData();

            });

            //$("input", $("#txtDate_from").next("span")).blur(function () {
            //    $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));
            //});

            $("input", $("#txtMo_from").next("span")).blur(function () {
                $("#txtMo_to").textbox('setValue', $("#txtMo_from").textbox('getValue'));
            });

            //var date = new Date();
            //var newDate = date.addDays(7); //加7天
            //var newMonth = date.addMonths(1); //加1个月
            //var newYear = date.addYears(1); //加1年
            //var subtractDate = date.subtractDays(7); //减7天
            //var subtractMonth = date.subtractMonths(1); //减1个月
            //var subtractYear = date.subtractYears(1); //减1年
            var now_date = new Date();
            var from_date = new Date();
            from_date.setDate(now_date.getDate() - 90);
            $("#txtDate_from").datebox("setValue", changeDateToChar(from_date));
            $("#txtDate_to").datebox("setValue", changeDateToChar(now_date));
            //$("#selCmpState").datebox("setValue", 0);
            $('#selCmpState').combobox('select', 0);

        });

        function SearchData() {
             var queryData = GetQueryData(1);
            //将值传递给initTable
            initList(queryData);
            return false;
        }

        function GetQueryData(rpt_type) {
            var queryData = {
                rpt_type: rpt_type,
                complete_state: $("#selCmpState").textbox('getValue'),
                date_from: $("#txtDate_from").datebox("getValue"),
                date_to: $("#txtDate_to").datebox("getValue"),
                mo_from: $("#txtMo_from").val(),
                mo_to: $("#txtMo_to").val(),
            };
            return queryData;
        }
        
        function initList(queryData) {
             $('#tbInvList').datagrid({

                url: query_url,//"../ashx/Ax_Mo_NotComplete.ashx?paraa=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'mo_group',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#tbInvList',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'mo_group', title: '組別', width: 60 },
                { field: 'mo_type', title: '制單類型', width: 80 },
                { field: 'qty_pcs', title: '訂單數量(PCS)', width: 180 },
                { field: 'amt_hkd', title: '訂單金額(HKD)', width: 180 },
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

    <script type="text/javascript">
        function DownloadExcel(rpt_type) {
            var url = "../ashx/Ax_Mo_NotComplete.ashx?paraa=xls";
            var url_dst = "../file/";
            var queryData = GetQueryData(rpt_type);
            //debugger;
            $.ajax({
                url: url,
                type: 'post',
                data: queryData, //参数
                //xhrFields: { responseType: 'blob' },
                datatype: "json",
                beforeSend: BefLoadFunction, //加载执行方法
                success: function (data) {
                    //var directory = $(response).find('a').attr('href');

                    //// 在这里可以进行进一步的操作，比如显示目录地址、跳转到目录地址等
                    //console.log('Directory: ' + directory);
                    closeLoadingWindow();
                    var fileName = url_dst + data;
                    //alert(fileName);
                    window.location.href = fileName;

                    //$.get(url, function (data) { window.location.href = data; });
                },
                error: function () {
                    // 上传失败后的处理
                    closeLoadingWindow();
                    alert(data);
                }
            });
        }

        function BefLoadFunction() {
            showLoadingDialog();
        }

    </script>

    <script type="text/javascript">
        

        
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
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:80px;height:25px">查詢</a>
                        <a href="#" id="btnExcelSum" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="DownloadExcel(0)" style="width:120px;height:25px">Excel明細表</a>
                        <a href="#" id="A1" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="DownloadExcel(1)" style="width:120px;height:25px">Excel匯總表</a>
                    </div>

                <div style="margin-bottom: 5px">
                        <label id="lblDate">開單日期</label>
                        <input id="txtDate_from" style="width:160px" class="easyui-datebox-expand"/>
                        <input id="txtDate_to" style="width:160px" class="easyui-datebox-expand"/>
                        <label for="lblMo">制單編號</label>
                        <input type="text" class="easyui-textbox" id="txtMo_from" name="txtMo_from" style="width:160px" />
                        <input type="text" class="easyui-textbox" id="txtMo_to" name="txtMo_to" style="width:160px" />
                    </div>
                <div>
                    <label id="lblCmpState">完成狀態</label>
                    <input id="selCmpState" name="selCmpState" class="easyui-combobox" data-options="width:160, valueField: 'flag_id', textField: 'flag_desc', url: '../ashx/Base_Select.ashx/GetItem?paraa=CP_STATE&parab=list'" />
                </div>

            </fieldset>

            <table id="tbInvList" padding-left: 0px;></table>


    </div>
    </div>
</body>
</html>