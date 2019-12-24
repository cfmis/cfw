<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="St_Jx_Mo_Arrange.aspx.cs" Inherits="WebPortal.Stock.St_Jx_Mo_Arrange" %>

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

        //function myformatter(date) {
        //    var y = date.getFullYear();
        //    var m = date.getMonth() + 1;
        //    var d = date.getDate();
        //    return y + '/' + (m < 10 ? ('0' + m) : m) + '/' + (d < 10 ? ('0' + d) : d);

        //}
        //function myparser(s) {
        //    if (!s) return new Date();
        //    var ss = (s.split('/'));
        //    var y = parseInt(ss[0], 10);
        //    var m = parseInt(ss[1], 10);
        //    var d = parseInt(ss[2], 10);
        //    if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
        //        return new Date(y, m - 1, d);
        //    } else {
        //        return new Date();
        //    }
        //}

        $(function () {
         
            var Prd_dep = getUrlParam("Prd_dep");
            var Arrange_date = getUrlParam("Arrange_date");
            var Mat_item = getUrlParam("Prd_item");
            if (Mat_item != '' && Mat_item != null) {
                $("#selPrd_dep").textbox('setValue', Prd_dep);
                //$("#txtArrangeDate_from").val(Arrange_date);
                $('#txtArrangeDate_from').datebox('setValue',Arrange_date)
                $("#txtMat_item_from").textbox('setValue', Mat_item);
                $("#btnShowDlg").hide();
                $("#btnClean").hide();
                //SearchData();
            }
            else {
                //设置时间  
                var curr_time = new Date();
                //$("#txtArrangeDate_from").val(myformatter(curr_time));
                //$('#selPrd_dep').textbox('setValue', 'J03');
                //initList();
            }
            SearchData();
            $('#tbInvList').datagrid({               //根据自身情况更改
                width: $(window).width() - 40,    //根据自身情况更改
                height: $(window).height() - 260,  //根据自身情况更改

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
                    height: $(window).height() - 260  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 40,      //根据自身情况更改
                    height: $(window).height() - 260   //根据自身情况更改
                });
            });
            

            InitSearch();//查询

            $("#btnClean").click(function () {
                if ($("#selPrd_dep").textbox('getValue') == '') {
                    alert("部門不能為空!");
                    $('#selPrd_dep').textbox('textbox').focus();
                    return false;
                }
                if ($('#txtArrangeDate_from').datebox('getValue') == '') {
                    alert("日期不能為空!");
                    $('#txtArrangeDate_from').textbox('textbox').focus();
                    return false;
                }
                $.messager.confirm("系統信息", "警告！將會清空所有記錄，請確認是否繼續？", function (deleteClient) {
                    if (deleteClient) {

                        var Prd_dep = $("#selPrd_dep").textbox('getValue');
                        var Arrange_date = $('#txtArrangeDate_from').datebox('getValue');
                        $.ajax({
                            url: "../ashx/Ax_St_Jx_Mo_Arrange.ashx?paraa=delete&Prd_dep=" + Prd_dep + "&Arrange_date=" + Arrange_date,///GetPrdItem
                            type: "post",
                            dataType: "text",//json//這個要同context.Response.ContentType = "text/plain";對應的
                            //async: true,    //同步
                            //contentType: "application/json",//"application/json"
                            //traditional: true,
                            error: erryFunction, //错误执行方法
                            success: LoadFunction
                        });

                        function LoadFunction(data) {
                            $.messager.alert({ title: '系統信息', msg: data, icon: 'info' });
                            $("#tbInvList").datagrid('reload') //重新刷新整个页面
                        }
                        function erryFunction(data) {
                            alert("error");
                        }
                    }
                });
            });

            $('#btnShowDlg').click(function () {
                $('#AddDialog').dialog('open').dialog('setTitle', '上傳計劃單');
            });

            $("input", $("#txtMo_from").next("span")).blur(function () {
                $("#txtMo_to").textbox('setValue', $("#txtMo_from").textbox('getValue'));
            });


            ////插入拓展按钮
            //var buttons = $.extend([], $.fn.datebox.defaults.buttons);
            //buttons.splice(1, 0, {
            //    text: '清空',   //按钮名称
            //    handler: function (target) {
            //        //alert('确定');
            //        //$('#txtArrangeDate_from').datebox('setValue', "");
            //        //target.datebox('setValue', "");
            //        $(target).datebox('setValue', '').datebox('hidePanel');
            //    }
            //});

            //$('#txtArrangeDate_from').datebox({
            //    panelWidth: 147,
            //    panelHeight: 200,
            //    buttons: buttons   //自定义拓展按钮
            //});

            ////$('#txtArrangeDate_from').datebox({
            ////    onSelect: function(value){
            ////        $('#dd1').datebox('setValue', $('#txtArrangeDate_from').datebox('getValue'));//, changeDateToChar(value)

            ////    }
            ////});

            //$('.box').datebox({             //将两个输入框，执行日期输入框方法
            //    panelWidth: 147,
            //    panelHeight: 200,
            //    sharedCalendar: '#sc',        //将日历控件指向id为sc的元素
            //    formatter: changeDateFormatter,
            //    parser: changeDateParser,
            //    editable: false,
            //    buttons: buttons
            //});
            //$('#sc').calendar({             //将id为sc元素执行日历方法
            //    firstDay: 1
            //})


        });

        
        function initList(queryData) {
            $('#tbInvList').datagrid({

                url: "../ashx/Ax_St_Jx_Mo_Arrange.ashx?paraa=get_plan&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'arrange_id',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#tbInvList',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'prd_seq', title: '序號', width: 60 },
                { field: 'receive_date', title: 'JX接單日期', width: 80 },
                { field: 'prd_mo', title: '制單編號', width: 80 },
                { field: 'prd_item', title: '產品編號', width: 200 },
                { field: 'prd_item_cdesc', title: '產品描述', width: 200 },
                { field: 'wp_id', title: '生產車間', width: 80 },
                { field: 'arrange_machine', title: '機台編號', width: 100 },
                { field: 'prd_worker', title: '操作員', width: 80 },
                { field: 'delivery_date', title: '訂單交貨期', width: 80 },
                { field: 'arrange_qty', title: '訂單生產數量', width: 80 },
                { field: 'cpl_qty', title: '已生產數量', width: 80 },
                { field: 'not_cpl_qty', title: '未生產數量', width: 80 },
                { field: 'not_cpl_weg', title: '未生產重量', width: 80 },
                { field: 'mat_item1', title: '原料曲', width: 200 },
                { field: 'mat_item_cdesc', title: '原料描述', width: 200 },
                { field: 'kg_qty_rate', title: '每Kg數量(PCS)', width: 80 },
                { field: 'arrange_id', title: '編號', width: 100 },
                { field: 'prd_dep', title: '部門編號', width: 80 },
                { field: 'arrange_date', title: '排期日期', width: 80 },
                { field: 'now_date', title: '當前日期', width: 80 },
                { field: 'mat_item', title: '原料曲(From Xls)', width: 200 },
                {
                    field: 'oprate_edit', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="opera_edit" onclick="showMessageDialog(' + "'修改轉換率'" + ',' + index + ')" class="easyui-linkbutton" >修改轉換率</a>';
                        ////value = '<a href="#" name="opera" onclick="showDetails1(' + index + ')" class="easyui-linkbutton" ></a>';
                        ////str="showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id='+row.dep_id+'&dep_cdesc='+row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no')";
                        return str;
                        //return '<a href="#" onclick="showDetails1(' + index + ')">修改</a>';
                    }
                },
                {
                    field: 'oprate_delete', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="opera_delete" onclick="deleteRecord(' + index + ')" class="easyui-linkbutton" >刪除</a>';
                        ////value = '<a href="#" name="opera" onclick="showDetails1(' + index + ')" class="easyui-linkbutton" ></a>';
                        ////str="showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id='+row.dep_id+'&dep_cdesc='+row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no')";
                        return str;
                        //return '<a href="#" onclick="showDetails1(' + index + ')">修改</a>';
                    }
                }
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

        function SearchData(){
            if (!chkDataValid()) {
                return;
            }
            //得到用户输入的参数
            var queryData = {
                rpt_type: 0,
                Prd_dep: $("#selPrd_dep").textbox('getValue'),
                Now_date: $('#txtArrangeDate_from').datebox('getValue'),//$("#txtArrangeDate_from").val(),
                Prd_mo_from: $("#txtMo_from").val(),
                Prd_mo_to: $("#txtMo_to").val(),
                Prd_item_from: $("#txtPrd_item_from").val(),
                Mat_item_from: $("#txtMat_item_from").val(),
            };
            //将值传递给initTable
            initList(queryData);
            return false;
        }

        //新增、修改記錄轉換率
        function showMessageDialog(title, index) {

            //var index = -1;
            var Prd_item = "";
            var Mat_item = "";
            if (index >= 0) {
                $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
                var row = $('#tbInvList').datagrid('getSelected');
                if (row) {
                    Prd_item = row.prd_item;
                    Mat_item = row.mat_item1;
                }
            }

            var url = '../Bs/Bs_Mat_Rate_Add.aspx?Prd_item=' + Prd_item + '&Mat_item=' + Mat_item + '&Dep_id=' + row.wp_id;

            var content = '<iframe src="' + url + '" width="100%" height="50%" frameborder="0" scrolling="no"></iframe>';
            content +='<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="javascript:$('+'\'#msgwindow\''+').dialog('+'\'close\''+')">'+'关闭'+'</a>';
            var boarddiv = '<div id="msgwindow" title="' + title + '"></div>'//style="overflow:hidden;"可以去掉滚动条  
            $(document.body).append(boarddiv);
            var win = $('#msgwindow').dialog({
                content: content,
                width: 800,
                height: 500,
                modal: true,
                title: title,
                onClose: function () {
                    //$(this).dialog('destroy');//后面可以关闭后的事件  
                    //document.getElementById('btnSerach').click();
                }
            });
            win.dialog('open');
        }
        

        function deleteRecord(index) {
            $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
            var row = $('#tbInvList').datagrid('getSelected');
            if (row) {
                $.messager.confirm("删除信息", "您确认删除该条記錄吗？", function (deleteClient) {
                    if (deleteClient) {
                        $.ajax({
                            url: "../ashx/Ax_St_Jx_Mo_Arrange.ashx?paraa=delete&arrange_id=" + row.arrange_id,///GetPrdItem
                            type: "post",
                            dataType: "text",//json//這個要同context.Response.ContentType = "text/plain";對應的
                            //async: true,    //同步
                            //contentType: "application/json",//"application/json"
                            //traditional: true,
                            error: erryFunction, //错误执行方法
                            success: LoadFunction
                        });

                        function LoadFunction(data) {
                            $.messager.alert({ title: '系統信息', msg: data, icon: 'info' });
                            $("#tbInvList").datagrid('reload') //重新刷新整个页面
                        }
                        function erryFunction(data) {
                            alert("error");
                        }
                    }
                });
            }

        }

        function uploadPlan(url, title, width, height, shadow) {

            var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
            //content += '<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="javascript:$(' + '\'#msgwindow\'' + ').dialog(' + '\'close\'' + ')">' + '关闭' + '</a>';
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
                    //document.getElementById('btnSerach').click();
                }
            });
            win.dialog('open');
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

        function closeWindow() {
            $('#msgwindow').dialog('close');
        }

        function JsonToExcel() {
            if (!chkDataValid())
                return;
            var json = [];
            var j = {};

            j.Prd_dep = $("#selPrd_dep").textbox('getValue');
            j.Now_date = $('#txtArrangeDate_from').datebox('getValue'),
            j.Prd_mo_from = $("#txtMo_from").val();
            j.Prd_mo_to = $("#txtMo_to").val();
            j.Prd_item_from = $("#txtPrd_item_from").val();
            j.Mat_item_from = $("#txtMat_item_from").val();
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_St_Jx_Mo_Arrange.ashx?paraa=get_plan"

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

            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            i.val(JSONToExcelConvertorDetails("我的excel", dataJson));
            i.appendTo(f);
            l.val('JX生產計劃單');
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
            row += '<td>' + '序號' + '</td>';
            row += '<td>' + 'JX接單日期' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '產品編號' + '</td>';
            row += '<td>' + '產品描述' + '</td>';
            row += '<td>' + '機台編號' + '</td>';
            row += '<td>' + '操作員' + '</td>';
            row += '<td>' + '訂單交貨期' + '</td>';
            row += '<td>' + '訂單生產數量' + '</td>';
            row += '<td>' + '已生產數量' + '</td>';
            row += '<td>' + '未生產數量' + '</td>';
            row += '<td>' + '未生產重量' + '</td>';
            row += '<td>' + '原料曲(From Xls)' + '</td>';
            row += '<td>' + '原料曲' + '</td>';
            row += '<td>' + '原料描述' + '</td>';
            row += '<td>' + '每Kg數量(PCS)' + '</td>';
            row += '<td>' + '編號' + '</td>';
            row += '<td>' + '部門編號' + '</td>';
            row += '<td>' + '排期日期' + '</td>';
            row += '<td>' + '當前日期' + '</td>';
            row += '<td>' + '生產車間' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["prd_seq"] + '</td>';
                row += '<td>' + arrData[i]["receive_date"] + '</td>';
                row += '<td>' + arrData[i]["prd_mo"] + '</td>';
                row += '<td>' + arrData[i]["prd_item"] + '</td>';
                row += '<td>' + arrData[i]["prd_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["arrange_machine"] + '</td>';
                row += '<td>' + arrData[i]["prd_worker"] + '</td>';
                row += '<td>' + arrData[i]["delivery_date"] + '</td>';
                row += '<td>' + arrData[i]["prd_qty"] + '</td>';
                row += '<td>' + arrData[i]["cpl_qty"] + '</td>';
                row += '<td>' + arrData[i]["not_cpl_qty"] + '</td>';
                row += '<td>' + arrData[i]["not_cpl_weg"] + '</td>';
                row += '<td>' + arrData[i]["mat_item"] + '</td>';
                row += '<td>' + arrData[i]["mat_item1"] + '</td>';
                row += '<td>' + arrData[i]["mat_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["kg_qty_rate"] + '</td>';
                row += '<td>' + arrData[i]["arrange_id"] + '</td>';
                row += '<td>' + arrData[i]["prd_dep"] + '</td>';
                row += '<td>' + arrData[i]["arrange_date"] + '</td>';
                row += '<td>' + arrData[i]["now_date"] + '</td>';
                row += '<td>' + arrData[i]["wp_id"] + '</td>';
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
        <div id="AddDialog" class="easyui-dialog" style="width: 600px; height:300px; padding: 10px 20px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
        <fieldset id="fdUpload">
                <legend><label style="color:blue">將計劃單匯入系統，必須為正確格式的Excel文件</label></legend>
            
        <form runat="server">
            <div>
                <label for="lblDep">生產部門:</label>
                <asp:DropDownList ID="dlDep" Width="120px" Height="22px"  runat="server" />
            <label for="lblDate">日期:</label>
                    <input type="text" id="txtArrangeDate" name="txtArrangeDate" runat="server" style="height:20px;width:120px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
            </div>
            <div>
            <asp:FileUpload ID="fileId" runat="server" Width ="400px" Height ="25px" data-options="formatter:myformatter" />

        <asp:Button ID="btnUpload" runat="server" Text="上传" onclick="btnUpload_Click" Width ="80px" Height="25px" />
            
            </div>
            
        </form>
        </fieldset>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="javascript:$('#AddDialog').dialog('close')">关闭</a>
        </div>
    <!--存放内容的主区域-->
   <%-- <div data-options="region:'north'" title="請輸入查詢內容" style="height: 60px;">
        <div class="easyui-layout" id="tb" style="padding: 0px; height: auto">--%>
            <!-------------------------------搜索框----------------------------------->
            <fieldset>
                <legend>查詢條件</legend>
                <%--<form id="ffSearch" method="post">--%>
                    <div style="margin-bottom: 5px">
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:80px;height:25px">查詢</a>
                        <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel()" style="width:80px;height:25px">Excel</a>
                        <a href="#" class="easyui-linkbutton" iconcls="icon-save" id="btnUploadPlan" onclick="uploadPlan('../Products/Jx_Mo_Arrange_Upload.aspx','上傳計劃',600,300,true)" style="width:100px;height:25px">上傳計劃單</a>
                        <%--<a href="#" class="easyui-linkbutton" iconcls="icon-save" id="btnShowDlg" style="width:100px;height:25px">上傳計劃單</a>--%>
                        <a href="#" class="easyui-linkbutton" iconcls="icon-cancel" id="btnClean" style="width:100px;height:25px">清空計劃單</a>

                    </div>
                    <div style="margin-bottom: 5px">
                        <%--<div class="box1">--%>
                        <label for="lblLoc_no">部門編號</label>
                        <input id="selPrd_dep" name="selPrd_dep" class="easyui-combobox" data-options="width:160, valueField: 'id', textField: 'name', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_jx_dep&parab=list'" />
                        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;
                        <label id="lblDate">日期</label>
                        <%--<input size="10" type="text" id="txtArrangeDate_from" style="height:18px;width:160px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})""/>--%>
                        <%--<input id="txtArrangeDate_from" type="text" class="easyui-datebox" data-options="formatter:changeDateFormatter,parser:changeDateParser,editable:false"/>--%>
                        <%--<input id="dd1" type="text" class="easyui-datebox" data-options="formatter:changeDateFormatter,parser:changeDateParser,editable:true"/>--%>

                        <input id="txtArrangeDate_from" class="easyui-datebox-expand"/>
                        <!--一个div-->
                        <%--<div id="easyui-sc-expand"></div>--%>

                    </div>
                    <div style="margin-bottom: 5px">
                        <%--<div class="box1">--%>
                        <label for="lblMo">制單編號</label>
                        <input type="text" class="easyui-textbox" id="txtMo_from" name="txtMo_from" style="width:160px" data-options="validType:'length[1,9]'" />
                        <input type="text" class="easyui-textbox" id="txtMo_to" name="txtMo_to" style="width:160px" data-options="validType:'length[1,9]'" />
                        <%--</div>--%>
                        &nbsp; &nbsp; &nbsp; &nbsp;<label for="lblPrd_item">產品編號</label>
                        <input type="text" class="easyui-textbox" id="txtPrd_item_from" name="txtPrd_item_from" style="width:160px" />
                    </div>
                    <div style="margin-bottom: 5px">
                        <label id="lblMat_item">原料編號</label>
                        <input type="text" class="easyui-textbox" id="txtMat_item_from" name="txtMat_item_from" style="width:160px" />
                    </div>
                <%--</form>--%>
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
