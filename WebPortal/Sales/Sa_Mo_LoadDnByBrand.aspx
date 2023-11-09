<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Mo_LoadDnByBrand.aspx.cs" Inherits="WebPortal.Sales.Sa_Mo_LoadDnByBrand" %>

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

            $("input", $("#txtDate_from").next("span")).blur(function () {
                $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));
            })

            $("input", $("#txtMo_from").next("span")).blur(function () {
                $("#txtMo_to").textbox('setValue', $("#txtMo_from").textbox('getValue'));
            })

        });

        function SearchData() {
            var queryData = GetQueryData();
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
        function GetQueryData() {
            var queryData = {
                date_from: $("#txtDate_from").datebox("getValue"),
                date_to: $("#txtDate_to").datebox("getValue"),
                mo_from: $("#txtMo_from").val(),
                mo_to: $("#txtMo_to").val(),
            };
            return queryData;
        }
        
        function initList(queryData) {
            $('#tbInvList').datagrid({

                url: "../ashx/Ax_Mo_LoadDnByBrand.ashx?paraa=get_plan&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                { field: 'id', title: '單據編號', width: 60 },
                { field: 'transfer_date', title: '回港日期', width: 80 },
                { field: 'bill_type_no', title: '單據類型', width: 80 },
                { field: 'sequence_id', title: '序號', width: 60 },
                { field: 'mo_id', title: '制單編號', width: 100 },
                { field: 'goods_id', title: '物料編號', width: 160 },
                { field: 'goods_cname', title: '物料描述', width: 200 },
                { field: 'transfer_amount', title: '數量', width: 80 },
                { field: 'sec_qty', title: '凈重', width: 80 },
                { field: 'gross_wt', title: '毛重', width: 80 },
                { field: 'package_num', title: '包數', width: 80 },
                { field: 'position_first', title: '包數單位', width: 80 },
                { field: 'brand_id', title: '牌子編號', width: 80 },
                { field: 'brand_name', title: '牌子描述', width: 80 },
                { field: 'apr_brand_id', title: '授權狀態', width: 80 }
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






        function JsonToExcel() {
            var url = "../ashx/Ax_Mo_LoadDnByBrand.ashx?paraa=123";
            var queryData = GetQueryData();
            $.ajax({
                url: url,
                type: "post",
                //data: { 'param': obja }, //参数
                data: queryData, //参数
                datatype: "json",
                async: true,    //默認异步，要改為同步：true
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: function (data) {
                    LoadFunctionDetails( data);
                }

            });
        }

        function LoadFunctionDetails(data) {
            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);

            i.val(JSONToExcelArrange("我的excel", dataJson));
            i.appendTo(f);
            l.val('回港明細表');
            l.appendTo(f);
            f.appendTo(document.body).submit();
            $(document.body).remove("form:last");
            $("#divShowLoadMsg").html('');
        }
        function BefLoadFunction() {
            $("#divShowLoadMsg").html('加载中...');
        }
        function erryFunction(data) {
            alert(data);
        }

        function JSONToExcelArrange(fileName, jsonData) {
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
            row += '<td>' + '單據編號' + '</td>';
            row += '<td>' + '回港日期' + '</td>';
            row += '<td>' + '單據類型' + '</td>';
            row += '<td>' + '序號' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '物料編號' + '</td>';
            row += '<td>' + '物料描述' + '</td>';
            row += '<td>' + '數量' + '</td>';
            row += '<td>' + '凈重' + '</td>';
            row += '<td>' + '毛重' + '</td>';
            row += '<td>' + '包數' + '</td>';
            row += '<td>' + '包數單位' + '</td>';
            row += '<td>' + '牌子編號' + '</td>';
            row += '<td>' + '牌子描述' + '</td>';
            row += '<td>' + '授權狀態' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["transfer_date"] + '</td>';
                row += '<td>' + arrData[i]["bill_type_no"] + '</td>';
                row += '<td>' + arrData[i]["sequence_id"] + '</td>';
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_cname"] + '</td>';
                row += '<td>' + arrData[i]["transfer_amount"] + '</td>';
                row += '<td>' + arrData[i]["sec_qty"] + '</td>';
                row += '<td>' + arrData[i]["gross_wt"] + '</td>';
                row += '<td>' + arrData[i]["package_num"] + '</td>';
                row += '<td>' + arrData[i]["position_first"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["brand_name"] + '</td>';
                row += '<td>' + arrData[i]["apr_brand_id"] + '</td>';
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";
            return excel;
            // #endregion
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
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:80px;height:25px">查詢</a>
                        <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(1)" style="width:80px;height:25px">Excel</a>
                    </div>
                    <div style="margin-bottom: 5px">
                        <label id="lblDate">回港日期</label>
                        <input id="txtDate_from" style="width:160px" class="easyui-datebox-expand"/>
                        <input id="txtDate_to" style="width:160px" class="easyui-datebox-expand"/>
                    </div>
                    <div style="margin-bottom: 5px">
                        <%--<div class="box1">--%>
                        <label for="lblMo">制單編號</label>
                        <input type="text" class="easyui-textbox" id="txtMo_from" name="txtMo_from" style="width:160px" />
                        <input type="text" class="easyui-textbox" id="txtMo_to" name="txtMo_to" style="width:160px" />

                    </div>

                <%--</form>--%>
            </fieldset>

            <table id="tbInvList" padding-left: 0px;></table>


    </div>
    </div>
</body>
</html>
