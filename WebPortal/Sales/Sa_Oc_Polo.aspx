<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Oc_Polo.aspx.cs" Inherits="WebPortal.Sales.Sa_Oc_Polo" %>

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
        var editIndex = undefined;
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


            var editIndex = undefined;
            $(function () {
                //bindData();
                //bindAddButton();
                //bindDelButton();
                bindSaveButton();
                bindRejectButton();
            });

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

                url: "../ashx/Ax_Oc_Polo.ashx?paraa=get_oc&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                //{ field: '选择', checkbox: 'false', width: 30 },
                { field: 'order_date', title: 'Order Date', width: 100 },
                { field: 'mo_id', title: 'Mo', width: 100 },
                { field: 'pono', title: 'PO Number', width: 120 },
                { field: 'cust_cname', title: 'Company Name', width: 160 },
                { field: 'cust_code', title: 'Company Code', width: 80 },
                { field: 'brand_id', title: 'Brand Code', width: 80 },
                { field: 'styles', title: 'Garment Style No.', width: 120 },
                { field: 'brand_id', title: 'Mens/Womens/Childrens', width: 120 },
                { field: 'regions', title: 'Regions', width: 60, editor: { type: 'validatebox', options: {} } },
                { field: 'id', title: 'PI Number', width: 100 },
                { field: 'req_mock_up', title: 'Request Mock Up', width: 120, editor: { type: 'validatebox', options: {} } },
                { field: 'rec_mock_up', title: 'Received Mock Up', width: 120, editor: { type: 'validatebox', options: {} } },
                { field: 'data_sheet_pre', title: 'Data Sheet Prepare', width: 120, editor: { type: 'validatebox', options: {} } },
                { field: 'data_sheet_sent', title: 'Data Sheet Sent', width: 120, editor: { type: 'validatebox', options: {} } },
                {
                    field: 'oprate', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="opera" onclick="deleteRecord(' + index + ')" class="easyui-linkbutton" >刪除</a>';
                        ////value = '<a href="#" name="opera" onclick="showDetails1(' + index + ')" class="easyui-linkbutton" ></a>';
                        ////str="showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id='+row.dep_id+'&dep_cdesc='+row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no')";
                        return str;
                        //return '<a href="#" onclick="showDetails1(' + index + ')">修改</a>';
                    }
                }
                ]],
                loadFilter: pagerFilter,
                //singleSelect: true,
                onClickRow: onClickRow,
                toolbar: '#tb',



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
                brand_from: $("#txtBrandId_from").val(),
                brand_to: $("#txtBrandId_to").val(),
                order_date_from: $('#txtDate_from').datebox('getValue'),
                order_date_to: $('#txtDate_to').datebox('getValue'),
                mo_from: $("#txtMo_from").val(),
                mo_to: $("#txtMo_to").val(),
                ocno_from: $("#txtOcNo_from").val(),
                ocno_to: $("#txtOcNo_to").val(),
                set_flag: $("#selSet_flag").textbox('getValue'),
            };
            //将值传递给initTable
            initList(queryData);
            return false;
        }

        //编辑状态
        function endEditing() {
            if (editIndex == undefined) { return true }
            if ($('#tbInvList').datagrid('validateRow', editIndex)) {
                var ed = $('#tbInvList').datagrid('getEditor', { index: editIndex, field: 'mo_id' });
                $('#tbInvList').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }

        //单击某行进行编辑
        function onClickRow(index) {
            if (editIndex != index) {
                if (endEditing()) {
                    $('#tbInvList').datagrid('selectRow', index)
                            .datagrid('beginEdit', index);
                    editIndex = index;
                } else {
                    $('#tbInvList').datagrid('selectRow', editIndex);
                }
            }
        }

        //撤销编辑
        function reject() {
            $('#tbInvList').datagrid('rejectChanges');
            editIndex = undefined;
        }

        //获得编辑后的数据,并提交到后台
        function saveChanges() {
            if (endEditing()) {
                var $dg = $('#tbInvList');
                var rows = $dg.datagrid('getChanges');
                if (rows.length) {
                    var inserted = $dg.datagrid('getChanges', "inserted");
                    var deleted = $dg.datagrid('getChanges', "deleted");
                    var updated = $dg.datagrid('getChanges', "updated");
                    var effectRow = new Object();
                    if (inserted.length) {
                        effectRow["inserted"] = JSON.stringify(inserted);
                    }
                    if (deleted.length) {
                        effectRow["deleted"] = JSON.stringify(deleted);
                    }
                    if (updated.length) {
                        effectRow["updated"] = JSON.stringify(updated);
                    }
                }
            }
            
            $.post("../ashx/Ax_Oc_Polo.ashx?paraa=updateOc", effectRow, function (rsp) {
                debugger;
                if (rsp.status) {
                    $('#tbInvList').datagrid('acceptChanges');
                    bindData();
                }
            }, "JSON").error(function (rsp) {
                if (rsp.status == 200) {
                    $.messager.alert("系統提示", "儲存記錄成功！");
                    $('#tbInvList').datagrid('acceptChanges');
                    SearchData();
                } else
                    $.messager.alert("系統提示", "儲存記錄失敗！");
            });

        }

        //撤销编辑
        function reject() {
            $('#tbInvList').datagrid('rejectChanges');
            editIndex = undefined;
            $("#tbInvList").datagrid('reload') //重新刷新整个页面
        }

        function bindSaveButton() {
            $("#saveButton").click(function () {
                saveChanges();
            });
        }

        function bindRejectButton() {
            $("#rejectButton").click(function () {
                reject();
            });
        }

        function deleteRecord(index) {
            $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
            var row = $('#tbInvList').datagrid('getSelected');
            if (row) {
                $.messager.confirm("删除信息", "您确认删除该条記錄吗？", function (deleteClient) {
                    if (deleteClient) {
                        $.ajax({
                            url: "../ashx/Ax_Oc_Polo.ashx?paraa=delete&mo_id=" + row.mo_id,///GetPrdItem
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
            var json = [];
            var j = {};
            j.brand_from = $("#txtBrandId_from").val();
            j.brand_to = $("#txtBrandId_to").val();
            j.order_date_from = $('#txtDate_from').datebox('getValue'),
            j.order_date_to = $('#txtDate_to').datebox('getValue'),
            j.mo_from = $("#txtMo_from").val();
            j.mo_to = $("#txtMo_to").val();
            j.ocno_from = $("#txOcNo_from").val();
            j.ocno_to = $("#txtOcNo_to").val();
            j.set_flag = $("#selSet_flag").textbox('getValue');
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_Oc_Polo.ashx?paraa=get_oc&parab=table";
            
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
            l.val('POLO訂單記錄表');
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
            row += '<td>' + 'Order Date' + '</td>';
            row += '<td>' + 'PO Number' + '</td>';
            row += '<td>' + 'Company Name' + '</td>';
            row += '<td>' + 'Company Code' + '</td>';
            row += '<td>' + 'Brand Code' + '</td>';
            row += '<td>' + 'Garment Style No.' + '</td>';
            row += '<td>' + 'Mens/Womens/Childrens' + '</td>';
            row += '<td>' + 'Regions' + '</td>';
            row += '<td>' + 'PI Number' + '</td>';
            row += '<td>' + 'Request Mock Up' + '</td>';
            row += '<td>' + 'Received Mock Up' + '</td>';
            row += '<td>' + 'Data Sheet Prepare' + '</td>';
            row += '<td>' + 'Data Sheet Sent' + '</td>';

            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + "=\"" + arrData[i]["order_date"] + "\"" + '</td>';
                row += '<td>' + arrData[i]["pono"] + '</td>';
                row += '<td>' + arrData[i]["cust_cname"] + '</td>';
                row += '<td>' + arrData[i]["cust_code"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["styles"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["regions"] + '</td>';
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["req_mock_up"] + '</td>';
                row += '<td>' + arrData[i]["rec_mock_up"] + '</td>';
                row += '<td>' + arrData[i]["data_sheet_pre"] + '</td>';
                row += '<td>' + arrData[i]["data_sheet_sent"] + '</td>';
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
                    </div>

                
                <%--</form>--%>
            </fieldset>
            <table>
                <tr>
                    <td style="text-align:right"><label for="lblLoc_no">牌子編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtBrandId_from" name="txtBrandId_from" style="width:120px" onchange="setValue(this,txtBrandId_to)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtBrandId_to" name="txtBrandId_to" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblDate">訂單日期</label></td>
                    <%--<td><input size="10" type="text" id="txtDate_from" style="height:18px;width:120px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})""/></td>--%>
                    <%--<td><input size="10" type="text" id="txtDate_to" style="height:18px;width:120px" readonly="readonly" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/></td>--%>
                    <td><input id="txtDate_from" style="width:120px" class="easyui-datebox-expand"/></td>
                    <td><input id="txtDate_to" style="width:120px" class="easyui-datebox-expand"/></td>
                </tr>
                <tr>
                    <td style="text-align:right"><label for="lblMo">制單編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMo_from" name="txtMo_from" style="width:120px" onchange="setValue(this,txtMo_to)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMo_to" name="txtMo_to" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblPrd_item">OC編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txOcNo_from" name="txOcNo_from" style="width:120px" onchange="setValue(this,txtOcNo_to)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtOcNo_to" name="txtOcNo_to" style="width:120px" /></td>
                </tr>
                <tr>
                    <td style="text-align:right"><label for="lblSet_flag">設定標識</label></td>
                    <td><input id="selSet_flag" name="selSet_flag" style="float:none" class="easyui-combobox" data-options="width:120, valueField: 'flag_id', textField: 'flag_desc', url: '../ashx/Base_Select.ashx/GetItem?paraa=set_polo_order_trace&parab=list'" /></td>
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

            <div id="tb">
        <%--<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" id="addButton">新增</a>
        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" id="delButton">删除</a>--%>
        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-save'" id="saveButton"> 儲存 </a>
        <a href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-undo'" id="rejectButton"> 撤銷 </a>
    </div>

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
