<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pd_LoadProductionBonus.aspx.cs" Inherits="WebPortal.Products.Pd_LoadProductionBonus" %>

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
                SearchData();

            });

            var now_date = new Date();
            var from_date = new Date();
            from_date.setDate(now_date.getDate() - 60);
            $("#txtDate_from").datebox("setValue", changeDateToChar(from_date));
            $("#txtDate_to").datebox("setValue", changeDateToChar(now_date));

            $('#selWorkType').combobox({
                value: 'A02' // 设置默认值为 'Department 2'
            });

            //$('#selWorkType').combobox('select', 'A02');
            //$("#selWorkType").datebox("setValue", "A02");
            //$('#selWorkType').children[1].checked = true;
        });

        function SearchData() {
            var queryData = GetQueryData(1);
            //将值传递给initTable
            initList(queryData);
            return false;
        }

        //初始化搜索框
        function InitSearch() {
            //按照条件进行查询，首先我们得到数据
            $("#btnSerach").click(function () {
                SearchData();

            });
        }
        function GetQueryData(rpt_type) {
            var queryData = {
                rpt_type: rpt_type,
                dep: $("#selPrd_dep").textbox('getValue'),
                date_from: $("#txtDate_from").datebox("getValue"),
                date_to: $("#txtDate_to").datebox("getValue"),
                prd_worktype: $("#selWorkType").textbox('getValue'),
            };
            return queryData;
        }
        
        function initList(queryData) {
            $('#tbInvList').datagrid({

                url: "../ashx/Ax_LoadProductionBouns.ashx?paraa=get_plan&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'sequence_id',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#tbInvList',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'prd_dep', title: '部門', width: 60 },
                { field: 'dep_group', title: '車間', width: 80 },
                { field: 'dep_group_desc', title: '車間描述', width: 80 },
                { field: 'prd_worker', title: '工號', width: 200 },
                { field: 'hrm1name', title: '姓名', width: 100 },
                { field: 'hrm1job', title: '職位', width: 60 },
                { field: 'hrc5name', title: '職位描述', width: 80 },
                { field: 'prd_qty', title: '生產數量', width: 80 },
                { field: 'count_time', title: '生產時數', width: 80 },
                { field: 'prd_bonus', title: '應得獎金', width: 80 },
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
            var url = "../ashx/Ax_LoadProductionBouns.ashx?paraa=xls";
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
        
        function DetailsToExcel(rpt_type) {
            var url = "../ashx/Ax_LoadProductionBouns.ashx?paraa=list";
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
                success: LoadFunctionDetails,
                error: function () {
                    // 上传失败后的处理
                    closeLoadingWindow();
                    alert(data);
                }
            });
        }
        function LoadFunctionDetails(data) {
            //alert(data);
            closeLoadingWindow();
            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            i.val(JSONToExcelConvertorDetails("我的excel", dataJson));
            i.appendTo(f);
            l.val('部門生產數明細表');
            l.appendTo(f);
            f.appendTo(document.body).submit();
            $(document.body).remove("form:last");


            //document.getElementById('btnFind').click();

            $("#divShowLoadMsg").html('');
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
            row += '<td>' + '部門' + '</td>';
            row += '<td>' + '車間' + '</td>';
            row += '<td>' + '工號' + '</td>';
            row += '<td>' + '姓名' + '</td>';
            row += '<td>' + '生產日期' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '物料編號' + '</td>';
            row += '<td>' + '物料描述' + '</td>';
            row += '<td>' + '正常班時數' + '</td>';
            row += '<td>' + '加班時數' + '</td>';
            row += '<td>' + '合計生產時數' + '</td>';
            row += '<td>' + '每小時標準數量' + '</td>';
            row += '<td>' + '應生產數量' + '</td>';
            row += '<td>' + '實際生產數量' + '</td>';
            row += '<td>' + '難度' + '</td>';
            row += '<td>' + '倍數' + '</td>';
            row += '<td>' + '應計時數' + '</td>';
            row += '<td>' + '應得獎金' + '</td>';
            row += '<td>' + '開始時間' + '</td>';
            row += '<td>' + '結束時間' + '</td>';
            row += '<td>' + '生產重量' + '</td>';
            row += '<td>' + '工種類型' + '</td>';
            row += '<td>' + '生產機器' + '</td>';
            row += '<td>' + '職位' + '</td>';
            row += '<td>' + '職位描述' + '</td>';
            row += '<td>' + '員工所屬' + '</td>';
            row += '<td>' + '單據編號' + '</td>';
            row += '<td>' + '生產類型' + '</td>';
            row += '<td>' + '類型描述' + '</td>';
            row += '<td>' + '記錄人' + '</td>';
            row += '<td>' + '記錄時間' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["prd_dep"] + '</td>';
                row += '<td>' + arrData[i]["dep_group"] + '</td>';
                row += '<td>' + arrData[i]["prd_worker"] + '</td>';
                row += '<td>' + arrData[i]["hrm1name"] + '</td>';
                row += '<td>' + "=\"" + arrData[i]["prd_date"] + "\"" + '</td>';
                row += '<td>' + arrData[i]["prd_mo"] + '</td>';
                row += '<td>' + arrData[i]["prd_item"] + '</td>';
                row += '<td>' + arrData[i]["prd_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["prd_normal_time"] + '</td>';
                row += '<td>' + arrData[i]["prd_ot_time"] + '</td>';
                row += '<td>' + arrData[i]["prd_time"] + '</td>';
                row += '<td>' + arrData[i]["hour_std_qty"] + '</td>';
                row += '<td>' + arrData[i]["prd_req_qty"] + '</td>';
                row += '<td>' + arrData[i]["prd_qty"] + '</td>';
                row += '<td>' + arrData[i]["difficulty_level"] + '</td>';
                row += '<td>' + arrData[i]["time_rate"] + '</td>';
                row += '<td>' + arrData[i]["count_time"] + '</td>';
                row += '<td>' + arrData[i]["prd_bonus"] + '</td>';
                row += '<td>' + arrData[i]["prd_start_time"] + '</td>';
                row += '<td>' + arrData[i]["prd_end_time"] + '</td>';
                row += '<td>' + arrData[i]["prd_weg"] + '</td>';
                row += '<td>' + arrData[i]["job_type"] + '</td>';
                row += '<td>' + arrData[i]["prd_machine"] + '</td>';
                row += '<td>' + arrData[i]["hrm1job"] + '</td>';
                row += '<td>' + arrData[i]["hrc5name"] + '</td>';
                row += '<td>' + arrData[i]["hrm1corp"] + '</td>';
                row += '<td>' + arrData[i]["prd_id"] + '</td>';
                row += '<td>' + arrData[i]["prd_work_type"] + '</td>';
                row += '<td>' + arrData[i]["prd_work_type_desc"] + '</td>';
                row += '<td>' + arrData[i]["amusr"] + '</td>';
                row += '<td>' + "=\"" + arrData[i]["amtim"] + "\"" + '</td>';
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion



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
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:80px;height:25px">查詢</a>
                        <a href="#" id="btnExcelSum" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="DetailsToExcel(0)" style="width:120px;height:25px">生產數明細</a>
                        <a href="#" id="btExcelDetails" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="DownloadExcel(1)" style="width:120px;height:25px">生產數匯總</a>
                    </div>
                <div style="margin-bottom: 5px">
                    <label id="lblDep">部門編號</label>
                    <input id="selPrd_dep" name="selPrd_dep" class="easyui-combobox" data-options="width:160,value:'102', valueField: 'dep_id', textField: 'dep_cdesc', url: '../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=list'" />
                    <%--<label>報表類型</label>
                    <select id="selIsComplete" class="easyui-combobox" data-options="width:120, valueField: 'flag_id', textField: 'flag_desc', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_order_complete_flag&parab=list'" />--%>
                </div>
                <div style="margin-bottom: 5px">
                        <label id="lblDate">生產日期</label>
                        <input id="txtDate_from" style="width:160px" class="easyui-datebox-expand"/>
                        <input id="txtDate_to" style="width:160px" class="easyui-datebox-expand"/>
                    <label id="lblWorkType">生產類型</label>
                    <input id="selWorkType" name="selWorkType" class="easyui-combobox" data-options="width:160, valueField: 'work_type_id', textField: 'work_type_desc', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_work_type&parab=list'" />
                </div>

            </fieldset>

            <table id="tbInvList" padding-left: 0px;></table>


    </div>
    </div>
</body>
</html>