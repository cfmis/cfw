<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="St_Jx_Store_Summary.aspx.cs" Inherits="WebPortal.Stock.St_Jx_Store_Summary" %>

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
    <style> 
        .box1 {width:400px; float:left; display:inline;} 
        .box2 {width:200px; float:left; display:inline;} 
    </style>
    <script type="text/javascript">

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }
        function txtNowDate_from_click(a) {
            var val = a.cal.getNewDateStr();
            var old_date = (parseInt(val.substring(0, 4)) - 1).toString() + val.substring(4, 10);//上期日期
            $('#txtNowDate_to').val(val);//$('#txtNowDate_from').val();
            $('#txtOldDate_from').val(old_date);
            $('#txtOldDate_to').val(old_date);
        }
        function txtNowDate_to_click(a) {
            var val = a.cal.getNewDateStr();//document.getElementById('txtNowDate_from').value;
            $('#txtOldDate_to').val((parseInt(val.substring(0, 4))-1).toString() + val.substring(4, 10));
        }
        $(function () {
            $("#chkNoZero").prop("checked", "checked");
            var Transfer_flag = getUrlParam("Transfer_flag");
            var Loc_no = getUrlParam("Loc_no");
            var Def_height = 200;
            if (Loc_no != "" && Loc_no!=null) {
                $("#selLoc_no").textbox('setValue', Loc_no); 
                $("#btnExpAll").hide();
                $("#btnTransfer").hide();
                $("#divMo").hide();
                Def_height = 150;
                //SearchData();
            }
            //else
            //{
            //    initList();
            //}
            initList();
            //SearchData();

            $('#tbInvList').datagrid({               //根据自身情况更改
                width: $(window).width() - 40,    //根据自身情况更改
                height: $(window).height() - Def_height,  //根据自身情况更改

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


            function initList(queryData) {
                $('#tbInvList').datagrid({

                    url: "../ashx/Ax_St_Jx_Store_Summary.ashx/GetItem?paraa=get_matdata&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                    idField: 'prd_item',//主键值
                    rownumbers: true,//显示行号
                    multiSort: true,//启用排序 sortable: true //启用排序列
                    //toolbar: '#tbInvList',
                    pagination: true,
                    pageSize: 100,
                    pageList: [100, 200, 300, 400, 500],
                    queryParams: queryData, //搜索条件查询
                    //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                    columns: [[
                    {
                        field: 'oprate_conf', title: '操作', align: 'center', width: 60,
                        formatter: function (value, row, index) {
                            var str = '<a href="#" name="opera_edit" onclick="getPrd_item(' + index + ')" class="easyui-linkbutton" >確定</a>';
                            return str;
                        }
                    },
                    { field: 'prd_item', title: '物料編號', width: 180 },
                    { field: 'prd_item_cdesc', title: '物料描述', width: 220 },
                    { field: 'loc_no', title: '倉庫編號', width: 80 },
                    { field: 'wh_or_weg', title: '庫存重量', width: 100 },
                    { field: 'wh_or_qty', title: '庫存數量', width: 100 },
                    { field: 'prd_mo', title: '制單編號', width: 80 },
                    { field: 'lot_no', title: '批號', width: 80 },
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
                if (Transfer_flag != "2") {
                    $('#tbInvList').datagrid('hideColumn', 'oprate_conf');
                }
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
                var Zero_flag = "";
                if ($("#chkNoZero").prop("checked"))
                    Zero_flag = "0";
                //得到用户输入的参数
                var queryData = {
                    rpt_type: 0,
                    Loc_no: $("#selLoc_no").textbox('getValue'),
                    Prd_mo_from: $("#txtMo_from").val(),
                    Prd_mo_to: $("#txtMo_to").val(),
                    Prd_item_from: $("#txtPrd_item_from").val(),
                    Prd_cdesc: $("#txtPrd_cdesc").val(),
                    Zero_flag:Zero_flag
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            }

        });

        
        

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
            var Zero_flag = "";
            if ($("#chkNoZero").prop("checked"))
                Zero_flag = "0";
            var json = [];
            var j = {};

            j.Loc_no = $("#selLoc_no").textbox('getValue');
            j.Prd_mo_from = $("#txtMo_from").val();
            j.Prd_mo_to = $("#txtMo_to").val();
            j.Prd_item_from = $("#txtPrd_item_from").val();
            j.Prd_cdesc = $("#txtPrd_cdesc").val();
            j.Zero_flag = Zero_flag;
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_St_Jx_Store_Summary.ashx/GetItem?paraa=get_matdata"
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
        }

        function LoadFunctionDetails(data) {
            //alert(data);

            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            i.val(JSONToExcelConvertorDetails("我的excel", dataJson));
            i.appendTo(f);
            l.val('庫存明細表');
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

            var excel = '<table>';

            //设置表头
            var row = "<tr>";


            //------------用JASON的標頭作為EXCEL的表頭----------------

            //for (var name in arrData[0]) {
            //    //每个单元格都可以指定样式. eg color:red   生成出来的就是 红色的字体了.
            //    row += "<td style='color:red;text-align:center;'>" + name + '</td>';
            //}
            //------------用JASON的標頭作為EXCEL的表頭----------------

            
            row += '<td>' + '物料編號' + '</td>';
            row += '<td>' + '物料描述' + '</td>';
            row += '<td>' + '庫存重量' + '</td>';
            row += '<td>' + '庫存數量' + '</td>';
            row += '<td>' + '倉庫編號' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '批號' + '</td>';

            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["prd_item"] + '</td>';
                row += '<td>' + arrData[i]["prd_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["wh_or_weg"] + '</td>';
                row += '<td>' + arrData[i]["wh_or_qty"] + '</td>';
                row += '<td>' + arrData[i]["loc_no"] + '</td>';
                row += '<td>' + arrData[i]["prd_mo"] + '</td>';
                row += '<td>' + arrData[i]["lot_no"] + '</td>';

                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion



        }

        

    </script>
    <script type="text/javascript">
 
        function showMessageDialog(url, title, width, height, shadow) {

            var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
            var boarddiv = '<div id="msgwindow" title="' + title + '"></div>'//style="overflow:hidden;"可以去掉滚动条  
            $(document.body).append(boarddiv);
            var win = $('#msgwindow').dialog({
                content: content,
                width: width,
                height: height,
                modal: shadow,
                title: title,
                onClose: function () {
                    //$(this).dialog('destroy');//后面可以关闭后的事件  
                    document.getElementById('btnSerach').click();
                }
            });
            win.dialog('open');
        }
        //傳送物料編號到新增頁
        function getPrd_item(index) {
            if (index >= 0) {
                $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
                var row = $('#tbInvList').datagrid('getSelected');
                if (row) {
                    Prd_item = row.prd_item;
                    //window.parent.document.getElementById('txtPrd_item').value = Prd_item;
                    //var obj = window.parent.document.getElementById('txtPrd_item');
                    ////obj.value("setValue", Prd_item);
                    //obj.textbox('setValue', Prd_item);
                    window.parent.setPrd_item_value(row.prd_item, row.prd_item_cdesc,row.prd_mo,row.lot_no);
                }
            }
            window.parent.closeWindow();
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
                <div style="margin-bottom: 5px">
                    <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:120px;height:25px">查詢</a>
                    <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel()" style="width:120px;height:25px">Excel</a>
                    <a href="#" id="btnTransfer" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="showMessageDialog('../Stock/St_Jx_Store_Transfer_Add.aspx','新增',800,500,true)" style="width:120px;height:25px">原料記帳</a>
                </div>
                <div style="margin-bottom: 5px">
                貨倉編號:
                <input id="selLoc_no" name="selPrd_dep" style="float:none" class="easyui-combobox" data-options="width:160, valueField: 'id', textField: 'name', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_jx_dep&parab=list'" />
                <label><input type="checkbox" id="chkBatchMo"/><span>只查找已設定的制單</span></label>
                </div>
                <div id="divMo" style="margin-bottom: 5px">
                制單編號:
                <input type="text" class="easyui-validatebox" id="txtMo_from" name="txtMo_from" style="width:160px" onchange="setValue(this,txtMo_to)" />
                <input type="text" class="easyui-validatebox" id="txtMo_to" name="txtMo_to" style="width:160px" />
                </div>
                <div style="margin-bottom: 5px">
                產品編號:
                <input type="text" class="easyui-validatebox" id="txtPrd_item_from" name="txtPrd_item_from" style="width:160px" />
                產品描述:
                <input type="text" class="easyui-validatebox" id="txtPrd_cdesc" name="txtPrd_item_to" style="width:160px" />
                </div>
                    
            </fieldset>
        
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
