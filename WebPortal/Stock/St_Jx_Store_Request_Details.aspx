<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="St_Jx_Store_Request_Details.aspx.cs" Inherits="WebPortal.Stock.St_Jx_Store_Request_Details" %>

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

            //添加以下兩行賦值代碼後，會導致JQUERY載入實效，導致不能查詢數據的
            ////设置时间  
            //var curr_time = new Date();
            //$("#txtDate_from").val(myformatter(curr_time));
            //$("#txtDate_to").val(myformatter(curr_time));
            //$('#selLoc_no').textbox('setValue', 'J03');

            //initList();
            $("#chkNotComplete").prop("checked", "checked");
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
                onSelect: function(value){
                    $('#txtDate_to').datebox('setValue', $('#txtDate_from').datebox('getValue'));//, changeDateToChar(value)

                }
            });


        });

        
        function initList(queryData) {
            $('#tbInvList').datagrid({

                url: "../ashx/Ax_St_Jx_Store_Summary.ashx?paraa=get_store_request_details&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'id',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#tbInvList',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'id', title: '編號', width: 120 },
                { field: 'loc_no', title: '倉庫編號', width: 80 },
                { field: 'request_date', title: '申請日期', width: 80 },
                { field: 'prd_item', title: '物料編號', width: 200 },
                { field: 'prd_item_cdesc', title: '物料描述', width: 200 },
                { field: 'request_weg', title: '申請重量', width: 80 },
                { field: 'request_qty', title: '申請數量', width: 80 },
                { field: 'rec_weg', title: '已到重量', width: 80 },
                { field: 'rec_qty', title: '已到數量', width: 80 },
                { field: 'prd_mo', title: '制單編號', width: 100 },
                { field: 'lot_no', title: '批號', width: 80 },
                { field: 'cpl_flag', title: '完成狀態', width: 80 },
                {
                    field: 'oprate', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="opera" onclick="deleteRecord(' + index + ')" class="easyui-linkbutton" >刪除</a>';
                        ////value = '<a href="#" name="opera" onclick="showDetails1(' + index + ')" class="easyui-linkbutton" ></a>';
                        ////str="showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id='+row.dep_id+'&dep_cdesc='+row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no')";
                        return str;
                        //return '<a href="#" onclick="showDetails1(' + index + ')">修改</a>';
                    }
                },
                {
                    field: 'setRec', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="operaRec" onclick="recRecord(' + index + ')" class="easyui-linkbutton" >收貨</a>';
                        return str;
                    }
                },
                {
                    field: 'setflag', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="operaSet" onclick="updateRecord(' + index + ')" class="easyui-linkbutton" >強制完成</a>';
                        return str;
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
        function SearchData() {
            if (!chkDataValid()) {
                return;
            }
            var Cpl_flag = "";
            if ($("#chkNotComplete").prop("checked"))
                Cpl_flag = "0";
            //得到用户输入的参数
            var queryData = {
                rpt_type: 0,
                Loc_no: $("#selLoc_no").textbox('getValue'),
                Date_from: $('#txtDate_from').datebox('getValue'),
                Date_to: $('#txtDate_to').datebox('getValue'),
                Prd_mo_from: $("#txtMo_from").val(),
                Prd_mo_to: $("#txtMo_to").val(),
                Prd_item_from: $("#txtPrd_item_from").val(),
                Prd_item_to: $("#txtPrd_item_to").val(),
                Cpl_flag:Cpl_flag
            };
            //将值传递给initTable
            initList(queryData);
            return false;
        }
        function deleteRecord(index) {
            $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
            var row = $('#tbInvList').datagrid('getSelected');
            if (row) {
                $.messager.confirm("删除信息", "您确认删除该条記錄吗？", function (deleteClient) {
                    if (deleteClient) {
                        $.ajax({
                            url: "../ashx/Ax_St_Jx_Store_Summary.ashx?paraa=delete_store_request_details&ID=" + row.id,///GetPrdItem
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

        function recRecord(index) {
            $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
            var row = $('#tbInvList').datagrid('getSelected');
            var title = '新增';
            //showMessageDialog('../Stock/St_Jx_Store_Transfer_Add.aspx','新增',800,600,true
            if (row) {
                url = "../Stock/St_Jx_Store_Transfer_Add.aspx?request_no=" + row.id + "&request_qty=" + row.request_qty
                    + "&request_weg=" + row.request_weg + "&loc_no=" + row.loc_no + "&prd_item=" + row.prd_item;
                var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
                //content += '<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="javascript:$(' + '\'#msgwindow\'' + ').dialog(' + '\'close\'' + ')">' + '关闭' + '</a>';
                var boarddiv = '<div id="msgwindow" title="' + title + '"></div>'//style="overflow:hidden;"可以去掉滚动条  
                $(document.body).append(boarddiv);
                var win = $('#msgwindow').dialog({
                    content: content,
                    width: 800,
                    height: 600,
                    modal: true,
                    title: title,
                    onClose: function () {
                        //$(this).dialog('destroy');//后面可以关闭后的事件  
                        //document.getElementById('btnSerach').click();
                    }
                });
                win.dialog('open');
            }

        }

        function updateRecord(index) {
            $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
            var row = $('#tbInvList').datagrid('getSelected');
            if (row) {
                $.messager.confirm("系統信息", "确认该条記錄已收貨吗？", function (deleteClient) {
                    if (deleteClient) {
                        $.ajax({
                            url: "../ashx/Ax_St_Jx_Store_Summary.ashx?paraa=update_store_request_details&ID=" + row.id,///GetPrdItem
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
            var Cpl_flag = "";
            if ($("#chkNotComplete").prop("checked", "checked") == "true")
                Cpl_flag = "0";
            var json = [];
            var j = {};

            j.Loc_no = $("#selLoc_no").textbox('getValue');
            j.Date_from = $('#txtDate_from').datebox('getValue'),
            j.Date_to = $('#txtDate_to').datebox('getValue'),
            j.Prd_mo_from = $("#txtMo_from").val();
            j.Prd_mo_to = $("#txtMo_to").val();
            j.Prd_item_from = $("#txtPrd_item_from").val();
            j.Prd_item_to = $("#txtPrd_item_to").val();
            j.Cpl_flag = Cpl_flag;
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_St_Jx_Store_Summary.ashx?paraa=get_store_request_details"

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
            l.val('來料申請表');
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
            row += '<td>' + '部門編號' + '</td>';
            row += '<td>' + '編號' + '</td>';
            row += '<td>' + '申請日期' + '</td>';
            row += '<td>' + '物料編號' + '</td>';
            row += '<td>' + '物料描述' + '</td>';
            row += '<td>' + '申請重量' + '</td>';
            row += '<td>' + '申請數量' + '</td>';
            row += '<td>' + '已到重量' + '</td>';
            row += '<td>' + '已到數量' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '批號' + '</td>';
            row += '<td>' + '完成狀態' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["loc_no"] + '</td>';
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["request_date"] + '</td>';
                row += '<td>' + arrData[i]["prd_item"] + '</td>';
                row += '<td>' + arrData[i]["prd_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["request_weg"] + '</td>';
                row += '<td>' + arrData[i]["request_qty"] + '</td>';
                row += '<td>' + arrData[i]["rec_weg"] + '</td>';
                row += '<td>' + arrData[i]["rec_qty"] + '</td>';
                row += '<td>' + arrData[i]["prd_mo"] + '</td>';
                row += '<td>' + arrData[i]["lot_no"] + '</td>';
                row += '<td>' + arrData[i]["cpl_flag"] + '</td>';
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

        function closeWindow() {
            //window.opener = null;
            ////window.open(' ', '_self', ' ');
            //window.open('', '_self');
            //window.close();

            $('#msgwindow').dialog('close');
            //$('msgwindow').dialog('close');
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
                        <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel()" style="width:120px;height:25px">Excel</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="showMessageDialog('../Stock/St_Jx_Store_Request_Add.aspx','新增',800,500,true)" style="width:120px;height:25px">新增</a>
                    </div>

                
                <%--</form>--%>
            </fieldset>
            <table>
                <tr>
                    <td style="text-align:right"><label for="lblLoc_no">貨倉編號</label></td>
                    <td><select id="selLoc_no" name="selPrd_dep" class="easyui-combobox" data-options="width:120, valueField: 'id', textField: 'name', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_jx_dep&parab=list'" /></td>
                    <td><label><input type="checkbox" id="chkNotComplete"/><span>未完成收貨的記錄</span></label> </td>
                    <td style="text-align:right"><label for="lblDate">日期</label></td>
                    <%--<td><input size="10" type="text" id="txtDate_from" style="height:18px;width:120px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})""/></td>--%>
                    <%--<td><input size="10" type="text" id="txtDate_to" style="height:18px;width:120px" readonly="readonly" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/></td>--%>
                    <td><input id="txtDate_from" style="width:120px" class="easyui-datebox-expand"/></td>
                    <td><input id="txtDate_to" style="width:120px" class="easyui-datebox-expand"/></td>
                </tr>
                <tr>
                    <td style="text-align:right"><label for="lblMo">制單編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMo_from" name="txtMo_from" style="width:120px" onchange="setValue(this,txtMo_to)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMo_to" name="txtMo_to" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblPrd_item">產品編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtPrd_item_from" name="txtPrd_item_from" style="width:120px" onchange="setValue(this,txtPrd_item_to)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtPrd_item_to" name="txtPrd_item_to" style="width:120px" /></td>
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
