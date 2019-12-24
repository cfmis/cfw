<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pd_Mo_Arrange_New.aspx.cs" Inherits="WebPortal.Products.Pd_Mo_Arrange_New" %>

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

            
            var Prd_dep = getUrlParam("Prd_dep");
            var Arrange_date = getUrlParam("Arrange_date");
            var Mat_item = getUrlParam("Prd_item");

                //设置时间  
                var curr_time = new Date();
                //$("#txtArrangeDate_from").val(myformatter(curr_time));
                //$('#selPrd_dep').textbox('setValue', 'J03');
                //initList();
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
                if ($("#txtArrangeDate_from").datebox("getValue") == '') {
                    alert("日期不能為空!");
                    $('#txtArrangeDate_from').textbox('textbox').focus();
                    return false;
                }
                $.messager.confirm("系統信息", "警告！將會清空所有記錄，請確認是否繼續？", function (deleteClient) {
                    if (deleteClient) {
                        
                        var Prd_dep = $("#selPrd_dep").textbox('getValue');
                        var Arrange_date = $("#txtArrangeDate_from").datebox("getValue");
                        $.ajax({
                            url: "../ashx/Ax_Pd_Mo_Arrange.ashx?paraa=delete&Prd_dep=" + Prd_dep + "&Arrange_date=" + Arrange_date,///GetPrdItem
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
            })

            $("input", $("#txtMo_from").next("span")).blur(function () {
                $("#txtMo_to").textbox('setValue', $("#txtMo_from").textbox('getValue'));
            })

        });

        
        function initList(queryData) {
            $('#tbInvList').datagrid({

                url: "../ashx/Ax_Pd_Mo_Arrange.ashx?paraa=get_plan&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                {
                    field: 'oprate_arrange', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="opera_arrange" onclick="arrangeRecord(' + index + ')" class="easyui-linkbutton" >安排</a>';
                        return str;
                    }
                },
                { field: 'arrange_seq', title: '序號', width: 60 },
                { field: 'prd_mo', title: '制單編號', width: 80 },
                { field: 'arrange_date', title: '排期日期', width: 80 },
                { field: 'flag_cdesc', title: '狀態', width: 60 },
                { field: 'worker_gp', title: '安排人員', width: 100 },
                { field: 'prd_item', title: '產品編號', width: 160 },
                { field: 'prd_item_cdesc', title: '產品描述', width: 200 },
                { field: 'cust_o_date', title: '客落單日期', width: 80 },
                { field: 'req_f_date', title: '要求完成日期', width: 80 },
                { field: 'order_qty', title: '訂單數量', width: 80 },
                { field: 'req_qty', title: '要求數量', width: 80 },
                { field: 'cpl_qty', title: '完成數量', width: 80 },
                { field: 'arrange_qty', title: '待完成數量', width: 80 },
                { field: 'prd_cpl_qty', title: '生產數量', width: 80 },
                { field: 'dep_rep_date', title: '部門復期', width: 80 },
                { field: 'arrange_machine', title: '生產設備', width: 80 },
                { field: 'now_date', title: '建立日期', width: 80 },
                { field: 'dep_group', title: '組別', width: 100 },
                { field: 'pre_prd_dep_date', title: '上部門來貨日期', width: 100 },
                { field: 'pre_prd_dep_qty', title: '上部門來貨數量', width: 100 },
                { field: 'prd_dep', title: '部門編號', width: 80 },
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
            //if (!chkDataValid()) {
            //    return;
            //}
            //得到用户输入的参数
            var queryData = {
                rpt_type: 0,
                Prd_dep: $("#selPrd_dep").textbox('getValue'),
                Arrange_date: $("#txtArrangeDate_from").datebox("getValue"),
                Prd_mo_from: $("#txtMo_from").val(),
                Prd_mo_to: $("#txtMo_to").val(),
                Prd_item_from: $("#txtPrd_item_from").val(),
                Dep_group: $("#txtDep_group").val(),
            };
            //将值传递给initTable
            initList(queryData);
            return false;
        } 

        function showMessageDialog(url, title, width, height, shadow) {

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

        function updateMoStatus(url, title, width, height, shadow) {

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

        function deleteRecord(index) {
            $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
            var row = $('#tbInvList').datagrid('getSelected');
            if (row) {
                $.messager.confirm("删除信息", "您确认删除该条記錄吗？", function (deleteClient) {
                    if (deleteClient) {
                        $.ajax({
                            url: "../ashx/Ax_Pd_Mo_Arrange.ashx?paraa=delete&arrange_id=" + row.arrange_id,///GetPrdItem
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

        function arrangeRecord(index) {
            $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
            var row = $('#tbInvList').datagrid('getSelected');
            if (row) {
                $("#txtArrange_id").textbox('setValue', row.arrange_id);
                $("#txtPrd_mo").textbox('setValue', row.prd_mo);
                $("#txtWorker").textbox('setValue', "");
                loadArrangeWorker();
                $('#AddDialog').dialog('open').dialog('setTitle', '安排工作');
            }

        }

        function loadArrangeWorker()
        {
            //得到用户输入的参数
            var queryData = {
                rpt_type: 0,
                arrange_id: $("#txtArrange_id").val(),
            };
            //将值传递给initTable
            findArrangeWorker(queryData);
        }

        function findArrangeWorker(queryData) {
            $('#tbWorkerList').datagrid({

                url: "../ashx/Ax_Pd_Mo_Arrange.ashx?paraa=get_arrange_worker&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                pageSize: 10,
                pageList: [10, 20, 30, 40, 50],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'worker_id', title: '工號', width: 100 },
                { field: 'worker_name', title: '姓名', width: 120 },
                { field: 'work_type_id', title: '工作類型', width: 80 },
                { field: 'work_type_cdesc', title: '類型描述', width: 100 },
                {
                    field: 'oprate_delete', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="opera_delete" onclick="deleteArrangeWorker(' + index + ')" class="easyui-linkbutton" >刪除</a>';
                       return str;
                    }
                }
                ]],
                loadFilter: pagerFilter,
            });
        }

        function saveWorker()
        {
            if (!chkDataValid())
                return;
            var json = [];

            var j = {};
            j.Arrange_id = $("#txtArrange_id").val();
            j.Worker = $("#txtWorker").val(),
            j.Work_type = $("#selWork_type").textbox('getValue');
            json.push(j);
            var obja = JSON.stringify(json);
            //            异步提交数据

            $.ajax({
                url: "../ashx/Ax_Pd_Mo_Arrange.ashx/GetItem?paraa=updateWorker",
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
                $("#tbWorkerList").datagrid('reload') //重新刷新整个页面
                //$("#txtWeg").textbox('setValue', '');
                //$("#txtQty").textbox('setValue', '');
                //document.getElementById('btnFind').click();
            }
            function BefLoadFunction() {
                $("#ddd").html('加载中...');
            }
            function erryFunction() {
                alert("error");
            }


        }

        function deleteArrangeWorker(index) {
            $('#tbWorkerList').datagrid('selectRow', index);// 关键在这里  
            var row = $('#tbWorkerList').datagrid('getSelected');
            if (row) {
                $.messager.confirm("删除信息", "您确认删除该条記錄吗？", function (deleteClient) {
                    if (deleteClient) {
                        $.ajax({
                            url: "../ashx/Ax_Pd_Mo_Arrange.ashx?paraa=delete_arrange_worker&arrange_id=" + row.arrange_id+"&Worker="+row.worker_id+"&Work_type="+row.work_type_id,///GetPrdItem
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
                            $("#tbWorkerList").datagrid('reload') //重新刷新整个页面
                        }
                        function erryFunction(data) {
                            alert("error");
                        }
                    }
                });
            }
        }


        function chkDataValid()
        {
            if ($("#txtWorker").val() == "") {
                alert("工號不能為空!");
                return false;
            }
            if ($("#selWork_type").textbox('getValue') == "")
            {
                alert("工作類型不能為空!");
                return false;
            }
            return true;
        }


        function JsonToExcel(rpt_type) {
            //rpt_type=1 -- 安排的記錄；2--安排制單的生產記錄
            var url = "../ashx/Ax_Pd_Mo_Arrange.ashx?paraa=";
            var json = [];
            var j = {};
            if (rpt_type == 1)
                url += "get_plan";
            else
                url += "getArrangeMoWithPrd";
            j.Prd_dep = $("#selPrd_dep").textbox('getValue');
            j.Arrange_date = $("#txtArrangeDate_from").datebox("getValue"),
            j.Prd_mo_from = $("#txtMo_from").val();
            j.Prd_mo_to = $("#txtMo_to").val();
            j.Prd_item_from = $("#txtPrd_item_from").val();
            j.Dep_group = $("#txtDep_group").val();
            json.push(j);
            var obja = JSON.stringify(json);
            $.ajax({
                url: url,
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                async: true,    //默認异步，要改為同步：true
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: function (data) {
                    LoadFunctionDetails(rpt_type, data);
                }

            });
        }

        function LoadFunctionDetails(rpt_type, data) {
            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            if (rpt_type == 1) {
                i.val(JSONToExcelArrange("我的excel", dataJson));
                i.appendTo(f);
                l.val('計劃單排期表');
            }
            else
            {
                i.val(JSONToExcelArrangeWithPrd("我的excel", dataJson));
                i.appendTo(f);
                l.val('計劃單排期生產記錄表');
            }
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
            row += '<td>' + '序號' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '排期日期' + '</td>';
            row += '<td>' + '狀態' + '</td>';
            row += '<td>' + '產品編號' + '</td>';
            row += '<td>' + '產品描述' + '</td>';
            row += '<td>' + '客落單日期' + '</td>';
            row += '<td>' + '要求完成日期' + '</td>';
            row += '<td>' + '訂單數量' + '</td>';
            row += '<td>' + '要求數量' + '</td>';
            row += '<td>' + '完成數量' + '</td>';
            row += '<td>' + '待完成數量' + '</td>';
            row += '<td>' + '生產數量' + '</td>';
            row += '<td>' + '部門復期' + '</td>';
            row += '<td>' + '生產設備' + '</td>';
            row += '<td>' + '建立日期' + '</td>';
            row += '<td>' + '安排人員' + '</td>';
            row += '<td>' + '組別' + '</td>';
            row += '<td>' + '上部門來貨日期' + '</td>';
            row += '<td>' + '上部門來貨數量' + '</td>';
            row += '<td>' + '部門編號' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["arrange_seq"] + '</td>';
                row += '<td>' + arrData[i]["prd_mo"] + '</td>';
                row += '<td>' + arrData[i]["arrange_date"] + '</td>';
                row += '<td>' + arrData[i]["flag_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["prd_item"] + '</td>';
                row += '<td>' + arrData[i]["prd_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["cust_o_date"] + '</td>';
                row += '<td>' + arrData[i]["req_f_date"] + '</td>';
                row += '<td>' + arrData[i]["order_qty"] + '</td>';
                row += '<td>' + arrData[i]["req_qty"] + '</td>';
                row += '<td>' + arrData[i]["cpl_qty"] + '</td>';
                row += '<td>' + arrData[i]["arrange_qty"] + '</td>';
                row += '<td>' + arrData[i]["prd_cpl_qty"] + '</td>';
                row += '<td>' + arrData[i]["dep_rep_date"] + '</td>';
                row += '<td>' + arrData[i]["arrange_machine"] + '</td>';
                row += '<td>' + arrData[i]["now_date"] + '</td>';
                row += '<td>' + arrData[i]["worker_gp"] + '</td>';
                row += '<td>' + arrData[i]["dep_group"] + '</td>';
                row += '<td>' + arrData[i]["pre_prd_dep_date"] + '</td>';
                row += '<td>' + arrData[i]["pre_prd_dep_qty"] + '</td>';
                row += '<td>' + arrData[i]["prd_dep"] + '</td>';
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";
            return excel;
            // #endregion
        }


        function JSONToExcelArrangeWithPrd(fileName, jsonData) {
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
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '排期日期' + '</td>';
            row += '<td>' + '狀態' + '</td>';
            row += '<td>' + '產品編號' + '</td>';
            row += '<td>' + '產品描述' + '</td>';
            row += '<td>' + '客落單日期' + '</td>';
            row += '<td>' + '要求完成日期' + '</td>';
            row += '<td>' + '訂單數量' + '</td>';
            row += '<td>' + '要求數量' + '</td>';
            row += '<td>' + '完成數量' + '</td>';
            row += '<td>' + '待完成數量' + '</td>';
            row += '<td>' + '生產數量' + '</td>';
            row += '<td>' + '部門復期' + '</td>';
            row += '<td>' + '生產設備' + '</td>';
            row += '<td>' + '建立日期' + '</td>';
            row += '<td>' + '安排人員' + '</td>';
            row += '<td>' + '組別' + '</td>';
            row += '<td>' + '上部門來貨日期' + '</td>';
            row += '<td>' + '上部門來貨數量' + '</td>';
            row += '<td>' + '生產日期' + '</td>';
            row += '<td>' + '開始時間' + '</td>';
            row += '<td>' + '結束時間' + '</td>';
            row += '<td>' + '生產數量' + '</td>';
            row += '<td>' + '生產工號' + '</td>';
            row += '<td>' + '生產類型' + '</td>';
            row += '<td>' + '按排期生產' + '</td>';
            row += '<td>' + '部門編號' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["arrange_seq"] + '</td>';
                row += '<td>' + arrData[i]["prd_mo"] + '</td>';
                row += '<td>' + arrData[i]["arrange_date"] + '</td>';
                row += '<td>' + arrData[i]["flag_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["prd_item"] + '</td>';
                row += '<td>' + arrData[i]["prd_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["cust_o_date"] + '</td>';
                row += '<td>' + arrData[i]["req_f_date"] + '</td>';
                row += '<td>' + arrData[i]["order_qty"] + '</td>';
                row += '<td>' + arrData[i]["req_qty"] + '</td>';
                row += '<td>' + arrData[i]["cpl_qty"] + '</td>';
                row += '<td>' + arrData[i]["arrange_qty"] + '</td>';
                row += '<td>' + arrData[i]["prd_cpl_qty"] + '</td>';
                row += '<td>' + arrData[i]["dep_rep_date"] + '</td>';
                row += '<td>' + arrData[i]["arrange_machine"] + '</td>';
                row += '<td>' + arrData[i]["now_date"] + '</td>';
                row += '<td>' + arrData[i]["worker_gp"] + '</td>';
                row += '<td>' + arrData[i]["dep_group"] + '</td>';
                row += '<td>' + arrData[i]["pre_prd_dep_date"] + '</td>';
                row += '<td>' + arrData[i]["pre_prd_dep_qty"] + '</td>';
                row += '<td>' + arrData[i]["prd_date"] + '</td>';
                row += '<td>' + arrData[i]["prd_start_time"] + '</td>';
                row += '<td>' + arrData[i]["prd_end_time"] + '</td>';
                row += '<td>' + arrData[i]["prd_qty"] + '</td>';
                row += '<td>' + arrData[i]["prd_worker"] + '</td>';
                row += '<td>' + arrData[i]["work_type_desc"] + '</td>';
                if (arrData[i]["arrange_date"]!="" && arrData[i]["prd_date"]!="" && arrData[i]["arrange_date"] == arrData[i]["prd_date"])
                    row += '<td>' + "Y" + '</td>';
                else
                    row += '<td>' + "" + '</td>';
                row += '<td>' + arrData[i]["prd_dep"] + '</td>';
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


        function closeWindow() {
            $('#msgwindow').dialog('close');
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
                        <a href="#" id="btnExpArrangeWithPrd" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(2)" style="width:120px;height:25px">生產記錄</a>
                        <a href="#" class="easyui-linkbutton" iconcls="icon-save" id="btnShowDlg" onclick="showMessageDialog('../Products/Pd_Mo_Arrange_Imput.aspx','上傳計劃',600,350,true)" style="width:100px;height:25px">上傳計劃單</a>
                        <a href="#" class="easyui-linkbutton" iconcls="icon-cancel" id="btnClean" style="width:100px;height:25px">清空計劃單</a>
                        <a href="#" class="easyui-linkbutton" iconcls="icon-save" id="btnShowDlg" onclick="updateMoStatus('../Products/Pd_Mo_Update_Status.aspx','上傳計劃',600,300,true)" style="width:120px;height:25px">更新制單狀態</a>
                    </div>
                    <div style="margin-bottom: 5px">
                        <%--<div class="box1">--%>
                        <label for="lblLoc_no">部門編號</label>
                        <input id="selPrd_dep" name="selPrd_dep" class="easyui-combobox" data-options="width:160, valueField: 'dep_id', textField: 'dep_cdesc', url: '../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=list'" />
                        <label for="lblMo">組別</label>
                        <input type="text" class="easyui-textbox" id="txtDep_group" name="txtDep_group" style="width:120px"" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <label id="lblDate">日期</label>
                        <%--<input size="10" type="text" id="txtArrangeDate_from" style="height:18px;width:160px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})""/>--%>
                        <input id="txtArrangeDate_from" style="width:160px" class="easyui-datebox-expand"/>
                    </div>
                    <div style="margin-bottom: 5px">
                        <%--<div class="box1">--%>
                        <label for="lblMo">制單編號</label>
                        <input type="text" class="easyui-textbox" id="txtMo_from" name="txtMo_from" style="width:160px" />
                        <input type="text" class="easyui-textbox" id="txtMo_to" name="txtMo_to" style="width:160px" />
                        <%--</div>--%>
                        &nbsp; &nbsp; &nbsp; &nbsp;<label for="lblPrd_item">物料編號</label>
                        <input type="text" class="easyui-textbox" id="txtPrd_item_from" name="txtPrd_item_from" style="width:160px" />
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
            <div id="AddDialog" class="easyui-dialog" style="width: 600px; height:300px; padding: 10px 20px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
                <fieldset id="fdArrange">
            <legend><label style="color:blue">請輸入此制單安排生產的人員</label></legend>
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="javascript:$('#AddDialog').dialog('close')">关闭</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-save" style="width:80px" onclick="saveWorker()">儲存</a>
                
            <div>
            <label for="lblPrd_mo">制單編號</label>
            <input type="text" class="easyui-textbox" id="txtPrd_mo" name="txtPrd_mo" readonly="true" style="width:120px"" />
            <input type="text" class="easyui-textbox" id="txtArrange_id" name="txtArrange_id" readonly="true" style="width:160px"" />
            </div>
            <div>
            <label for="lblWorker">生產員工</label>
            <input type="text" class="easyui-textbox" id="txtWorker" name="txtWorker" style="width:120px"" />
            <label for="lblWork_type">工作類型</label>
            <input id="selWork_type" name="selWork_type" class="easyui-combobox" data-options="width:160, valueField: 'work_type_id', textField: 'work_type_desc', url: '../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_work_type&parab=list'" />
            </div>
        </fieldset>
        <table id="tbWorkerList" padding-left: 0px;></table>
            
        </div>


    </div>
    </div>
</body>
</html>
