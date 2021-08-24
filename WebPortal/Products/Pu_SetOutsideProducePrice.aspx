<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pu_SetOutsideProducePrice.aspx.cs" Inherits="WebPortal.Products.Pu_SetOutsideProducePrice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>設置外發加工單價</title>
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
            
            ////设置时间  
            //var curr_time = new Date();

            //添加以下兩行賦值代碼後，會導致JQUERY載入實效，導致不能查詢數據的
            //$("#txtDate_from").val(myformatter(curr_time));
            //$('#selPrd_dep').textbox('setValue', 'J03');

            initList();
            //SearchData();
            
            //$('#tbDetails').datagrid({               //根据自身情况更改
            //    width: $(window).width() - 40,    //根据自身情况更改
            //    height: $(window).height() - 200,  //根据自身情况更改

            //});

            //$("#tbDetails").datagrid({
            //    //双击事件
            //    onDblClickRow: function (index, row) {
            //        var obj = window.parent.document.getElementById("txtMat");
            //        obj.value = row.id;
            //        window.parent.closeWindow();
            //    }
            //});

            //$(window).resize(function () {
            //    $('#tbDetails').datagrid('resize', {               //根据自身情况更改
            //        width: $(window).width() - 40,    //根据自身情况更改
            //        height: $(window).height() - 200  //根据自身情况更改
            //    }).datagrid('resize', {
            //        width: $(window).width() - 40,      //根据自身情况更改
            //        height: $(window).height() - 200   //根据自身情况更改
            //    });
            //});
            InitSearch();//查询
            Save();
            
            $("input", $("#txtDate_from").next("span")).blur(function () {
                $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));
            });
            $("input", $("#txtMoFrom").next("span")).blur(function () {
                $("#txtMoTo").textbox('setValue', $("#txtMoFrom").textbox('getValue'));
            });
            $("input", $("#txtIdFrom").next("span")).blur(function () {
                $("#txtIdTo").textbox('setValue', $("#txtIdFrom").textbox('getValue'));
            });
        });

        var editIndex = undefined;
        function initList(queryData) {

            var json = [];
            var j = {};
            //debugger;
            //$("#YWaitDialog").show();
            //$("#divMsg").html('Hello');
            //return;
            //j.rpt_type = "123";//rpt_type;
            //j.date_from = $('#txtDate_from').datebox('getValue'),
            //j.date_to = $('#txtDate_to').datebox('getValue'),
            //j.mo_from = $("#txtMoFrom").val();
            //j.mo_to = $("#txtMoTo").val();
            //j.vend_id = $("#selVend").textbox('getValue');
            //j.id_from = $("#txtIdFrom").val();
            //j.id_to = $("#txtIdTo").val();
            //json.push(j);
            //var obja = JSON.stringify(json);


            $('#tbDetails').datagrid({

                url: "../ashx/Ax_SetOutsideProducePrice.ashx?paraa=select",   //指向后台的Action来获取当前用户的信息的Json格式的数据?paraa=select
                iconCls: 'icon-view',//图标
                //height: 500,
                //fit: true,//自动适屏功能，表格會自動適應屏幕，就算設置了高度也無效的
                //width: function () { return document.body.clientWidth * 0.9 },//自动宽度
                nowrap: true,
                autoRowHeight: false,//自动行高
                striped: true,
                collapsible: true,
                singleSelect: false,
                fit:true,
                onClickRow: onClickRow,
                //onAfterEdit:onAfterEdit,
                //onClickCell: onClickCell,
                //onAfterEdit: onAfterEdit,
                //sortName: 'Id',//排序列名为ID
                sortOrder: 'asc',//排序为将序
                remoteSort: false,
                idField: 'id,sequence_id',//主键值，要注意這個，如果重複的，則Checkbox多選擇時，id重複的只會獲取到一筆記錄
                loadMsg: '正在加载中，请稍等... ',
                emptyMsg: '<span>无记录</span>',
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#tbDetails',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询obja,//
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'chkSelect', checkbox: 'true', width: 30 },
                { field: 'mo_id', title: '制單編號', width: 80 },
                { field: 'price', editor: { type: 'numberbox', options: { precision: 3 } }, title: '價格', width: 60 },
                { field: 'p_unit', editor: { type: 'combobox', options: { valueField: 'id', textField: 'id', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_base_unit&parab=list&parac=05' } }, title: '單價單位', width: 60 },
                { field: 'prod_qty', title: '數量', width: 60 },
                { field: 'order_qty_pcs', title: '訂單數量(PCS)', width: 80 },
                { field: 'sec_price', editor: { type: 'numberbox', options: { precision: 3 } }, title: '重量價格', width: 80 },
                { field: 'sec_p_unit', editor: { type: 'combobox', options: { valueField: 'id', textField: 'id', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_base_unit&parab=list&parac=03' } }, title: '單價單位', width: 60 },
                { field: 'remark', editor: 'text', title: '備註', width: 80 },
                { field: 'process_request', editor: 'text', title: '價格備註', width: 80 },
                { field: 'mould_fee', editor: { type: 'numberbox', options: { precision: 3 } }, title: '最低消費金額', width: 80 },
                { field: 'former_free', editor: { type: 'numberbox', options: { precision: 3 } }, title: '版費', width: 60 },
                { field: 'do_color', title: '顏色做法', width: 120 },
                { field: 'goods_name', title: '物料描述', width: 280 },
                { field: 'plate_remark', title: '電鍍/噴油備註', width: 220 },
                {
                    field: 'setRec', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="operaReq" onclick="showWindow(' + index + ')" class="easyui-linkbutton" >歷史單價</a>';
                        return str;
                    }
                },
                { field: 'goods_id', title: '物料編號', width: 160 },
                { field: 'id', title: '加工單號', width: 120 },
                { field: 'sequence_id', title: '序號', width: 60 },
                
                { field: 'sec_qty', title: '重量', width: 60 },
                { field: 'issue_date', title: '加工單日期', width: 80 },
                { field: 'vendor_id', title: '供應商', width: 80 },
                { field: 'order_date', title: '訂單日期', width: 80 },
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
        function Save() {
            $("#btnSave").click(function () {
                //$('#tbDetails').datagrid('endEdit', editRow)
                saveChanges();
            });
        }
        
        //function endEditing() {//该方法用于关闭上一个焦点的editing状态
        //    if (editIndex == undefined) {
        //        return true
        //    }
        //    if ($('#tbDetails').datagrid('validateRow', editIndex)) {
        //        $('#tbDetails').datagrid('endEdit', editIndex);
        //        editIndex = undefined;
        //        return true;
        //    } else {
        //        return false;
        //    }
        //}
        //点击单元格事件：
        function onClickCell(index, field, value) {
            if (endEditing()) {
                if (field == "finalResult") {
                    $(this).datagrid('beginEdit', index);
                    var ed = $(this).datagrid('getEditor', { index: index, field: field });
                    $(ed.target).focus();
                }
                editIndex = index;
            }
            $('#tbDetails').datagrid('onClickRow');
        }
        //function onClickRow(rowIndex, rowData) {
        //    $('#tbDetails').datagrid('beginEdit', rowIndex);
        //    editRow = rowIndex;
        //}


        //编辑状态
        function endEditing() {
            if (editIndex == undefined) { return true }
            if ($('#tbDetails').datagrid('validateRow', editIndex)) {
                var ed = $('#tbDetails').datagrid('getEditor', { index: editIndex, field: 'id' });
                $('#tbDetails').datagrid('endEdit', editIndex);
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
                    $('#tbDetails').datagrid('selectRow', index)
                            .datagrid('beginEdit', index);
                    editIndex = index;
                } else {
                    $('#tbDetails').datagrid('selectRow', editIndex);
                }
            }
        }

        ////儲存一：只能手動在表格中修改的，就可以用這種形式獲取有改動的行
        ////若是以賦值的形式修改的，以下方法是感應不到有修改的，需用儲存二的方法
        //获得编辑后的数据,并提交到后台
        function saveChanges1() {
            if (endEditing()) {
                var $dg = $('#tbDetails');
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
                     $.post("../ashx/Ax_SetOutsideProducePrice.ashx?paraa=update", effectRow, function (rsp) {

                        if (rsp) {
                            //$dg.datagrid('acceptChanges');
                            //SearchData();
                            //$('#tbDetails').datagrid('loaded');
                            //$('#tbDetails').datagrid('load');
                            //$('#tbDetails').datagrid('unselectAll');
                            editIndex = undefined;
                            $('#tbDetails').datagrid('unselectAll');//這個要用，不然儲存後刷新時，會仍有幾行選中的
                            $("#tbDetails").datagrid('reload');

                        }
                    }, "JSON").error(function () {
                        $.messager.alert("提示", "提交错误了！");
                    });
                }
            }
            


            //$.ajax({
            //    type: 'POST',
            //    url: "../ashx/Ax_SetOutsideProcessPrice.ashx?paraa=update",
            //    data: effectRow,
            //    beforeSend: function () {
            //        //console.log(rowData);
            //        //$('#tbDetails').datagrid('loading');
            //    },
            //    success: function (data) {
            //        if (data) {
            //            //$('#tbDetails').datagrid('loaded');
            //            //$('#tbDetails').datagrid('load');
            //            //$('#tbDetails').datagrid('unselectAll');
            //            $.messager.show({
            //                title: '提示',
            //                msg: data,
            //            });
            //            editIndex = undefined;
            //        }
            //    }
            //});

        }
        ////儲存二：這個當是賦值的形式(手工修改也可以)，提取Checkbox選中的行來獲取修改的值
        //获得编辑后的数据,并提交到后台
        function saveChanges() {

            var $dg = $('#tbDetails');
            //一定要用這行來結束，不然手動修改直接點擊儲存時，是獲取不到新值的(要隨意點擊一行以讓該行的值修改)
            //用了這行後就不用了，修改完可直接點擊儲存，就會獲取到新的值
            $('#tbDetails').datagrid('endEdit', editIndex);
            //獲取表格中被選中的所有行
            //獲取記錄時要注意idField: 'id,sequence_id',//主键值，如果重複的，則Checkbox或多選擇時，id重複的只會獲取到一筆記錄
            //var rows = $("#tbDetails").datagrid('getRows');//獲取所有行的記錄
            //var selectItems = $('#tbDetails').datagrid('getSelections');//獲取被選擇行的記錄
            //var row = $('#tbDetails').datagrid('getSelected');//獲取第一行選擇的記錄
            var checkedItems = $('#tbDetails').datagrid('getChecked');//獲取Checkbox的記錄
            var json = [];
            //遍歷行
            $.each(checkedItems, function (index, item) {
                var j = {
                    id: item.id,
                    sequence_id: item.sequence_id,
                    price: item.price,
                    sec_price: item.sec_price,
                    mould_fee: item.mould_fee,
                    former_free: item.former_free,
                    prod_qty: item.prod_qty,
                    sec_qty: item.sec_qty,
                    p_unit: item.p_unit,
                    sec_p_unit: item.sec_p_unit,
                    process_request: item.process_request,
                    remark:item.remark,
                };
                json.push(j);
                
            });
            var effectRow = new Object();
            effectRow["updated"] = JSON.stringify(json);
                    $.post("../ashx/Ax_SetOutsideProducePrice.ashx?paraa=update", effectRow, function (rsp) {

                        if (rsp) {
                            editIndex = undefined;
                            //$dg.datagrid('acceptChanges');
                            //SearchData();
                            //$('#tbDetails').datagrid('loaded');
                            //$('#tbDetails').datagrid('load');
                            $('#tbDetails').datagrid('unselectAll');//這個要用，不然儲存後刷新時，會仍有幾行選中的
                            $("#tbDetails").datagrid('reload');

                        }
                    }, "JSON").error(function () {
                        $.messager.alert("提示", "提交错误了！");
                    });
        }
        function onAfterEdit(rowIndex, rowData, changes) {
            // console.log(rowData);
            debugger;
            var $dg = $('#tbDetails');
            var inserted = $dg.datagrid('getChanges', 'inserted');
            var updated = $dg.datagrid('getChanges', 'updated');
            var effectRow = new Object();
            effectRow["updated"] = JSON.stringify(updated);
            return
            //$('#save,#redo').hide();
            var rows = $("#tbDetails").datagrid("getRows");
            for (var i = 0; i < rows.length; i++) {
                var inserted = $('#tbDetails').datagrid('getChanges', 'inserted');
                var updated = $('#tbDetails').datagrid('getChanges', 'updated');
                if (updated.length > 0)
                    alert(rows[i].id);
                //if (inserted.length > 0) {//添加
            }
            //    uri = 'add.ashx';
            //}
            //if (updated.length > 0) {//修改
            //    uri = 'update.ashx?id=' + rowData.id + '';
            //}
            $.ajax({
                type: 'POST',
                url: uri,
                data: {
                    code: rowData.code,
                    name: rowData.name,
                    sex: rowData.sex,
                    age: rowData.age,
                    tel: rowData.tel,
                },
                beforeSend: function () {
                    console.log(rowData);
                    $('#tbDetails').datagrid('loading');
                },
                success: function (data) {
                    if (data) {
                        $('#tbDetails').datagrid('loaded');
                        $('#tbDetails').datagrid('load');
                        $('#tbDetails').datagrid('unselectAll');
                        $.messager.show({
                            title: '提示',
                            msg: data,
                        });
                        obj.editRow = undefined;
                    }
                }
            });
            //console.log(inserted);
            //console.log(updated);
        }
        function SearchData() {
            if (!chkDataValid()) {
                return;
            }
            //得到用户输入的参数
            var queryData = getParas();
            //将值传递给initTable
            initList(queryData);
            $('#tbDetails').datagrid('unselectAll');//這個要用，不然儲存後刷新時，會仍有幾行選中的
            return false;
        }

        function chkDataValid()
        {
            //if ($('#txtDate_from').datebox('getValue') == "" && $('#txtOrderDateFrom').datebox('getValue') == "")
            //{
            //    alert("單據日期不能為空!");
            //    return false;
            //}
            return true;
        }



        function JsonToExcel(rpt_type) {
            if (!chkDataValid())
                return;
            var json = [];
            //debugger;
            //$("#YWaitDialog").show();
            //$("#divMsg").html('Hello');
            //return;
            var queryData = getParas();
            json.push(queryData);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_SetOutsideProducePrice.ashx?paraa=";
            if (rpt_type == 2)
                url += "amount";
            else
                url += "select";
            $.ajax({
                url: url,
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                async: true,    //默認异步，要改為同步：true
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: function (data) { LoadFunctionDetails(rpt_type,data); }

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
        function getParas() {
            var objChk = document.getElementsByName('chkShowSum');
            var queryData = {
                rpt_type: objChk[0].checked,
                date_from: $('#txtDate_from').datebox('getValue'),//$("#txtDate_from").val(),
                date_to: $('#txtDate_to').datebox('getValue'),
                dep: $("#txtDep").val(),
                vend_id: $("#selVend").textbox('getValue'),
                mo_from: $("#txtMoFrom").val(),
                mo_to: $("#txtMoTo").val(),
                id_from: $("#txtIdFrom").val(),
                id_to: $("#txtIdTo").val(),
                price_status: $("#selPriceStatus").textbox('getValue'),
                prd_item: $("#txtPrdItem").val(),
                order_date_from: $('#txtOrderDateFrom').datebox('getValue'),//$("#txtDate_from").val(),
                order_date_to: $('#txtOrderDateTo').datebox('getValue'),
                color_id: "",
            };
            return queryData;
        }
        function LoadFunctionDetails(rpt_type,data) {
            //$('#YWaitDialog').dialog('close');
            //closeWindow();
            closeLoadingWindow();
            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            var fileName = '';
            if (rpt_type == 2)//金額表
            {
                fileName = '外發加工金額明細表';
                i.val(JSONToExcelConvertorDetailsAmount(dataJson));
            }
            else//明細表
            {
                fileName = '外發加工單價明細表';
                i.val(JSONToExcelConvertorDetails("我的excel", dataJson));
            }
            i.appendTo(f);
            l.val(fileName);
            l.appendTo(f);
            f.appendTo(document.body).submit();
            $(document.body).remove("form:last");


            //document.getElementById('btnFind').click();

            $("#divShowLoadMsg").html('');
        }
        function BefLoadFunction() {
            //$("#divShowLoadMsg").html('加载中...');
            //$("#YWaitDialog").show();
            //$('#YWaitDialog').dialog('open').dialog('setTitle', '正在加載，請稍候。。。');
            //showMessageDialog();
            showLoadingDialog();
        }
        function erryFunction(data) {
            closeLoadingWindow();
            if (data.status == 500)
                alert("提取數據失敗!");
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
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '數量單價' + '</td>';
            row += '<td>' + '單價單位' + '</td>';
            row += '<td>' + '重量單價' + '</td>';
            row += '<td>' + '單價單位' + '</td>';
            row += '<td>' + '價格備註' + '</td>';
            row += '<td>' + '最低消費金額' + '</td>';
            row += '<td>' + '版費' + '</td>';
            row += '<td>' + '顏色做法' + '</td>';
            row += '<td>' + '電鍍/噴油備註' + '</td>';
            row += '<td>' + '物料編號' + '</td>';
            row += '<td>' + '物料描述' + '</td>';
            row += '<td>' + '加工單號' + '</td>';
            row += '<td>' + '序號' + '</td>';
            row += '<td>' + '數量' + '</td>';
            row += '<td>' + '重量' + '</td>';
            row += '<td>' + '加工單日期' + '</td>';
            row += '<td>' + '供應商' + '</td>';
            row += '<td>' + '訂單日期' + '</td>';
            row += '<td>' + '訂單數量' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["price"] + '</td>';
                row += '<td>' + arrData[i]["p_unit"] + '</td>';
                row += '<td>' + arrData[i]["sec_price"] + '</td>';
                row += '<td>' + arrData[i]["sec_p_unit"] + '</td>';
                row += '<td>' + arrData[i]["process_request"] + '</td>';
                row += '<td>' + arrData[i]["mould_fee"] + '</td>';
                row += '<td>' + arrData[i]["former_free"] + '</td>';
                row += '<td>' + arrData[i]["do_color"] + '</td>';
                row += '<td>' + arrData[i]["plate_remark"] + '</td>';
                row += '<td>' + arrData[i]["goods_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_name"] + '</td>';
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["sequence_id"] + '</td>';
                row += '<td>' + arrData[i]["prod_qty"] + '</td>';
                row += '<td>' + arrData[i]["sec_qty"] + '</td>';
                row += '<td>' + arrData[i]["issue_date"] + '</td>';
                row += '<td>' + arrData[i]["vendor_id"] + '</td>';
                row += '<td>' + arrData[i]["order_date"] + '</td>';
                row += '<td>' + arrData[i]["order_qty"] + '</td>';
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion



        }

        function JSONToExcelConvertorDetailsAmount(jsonData) {
            ///<summary>json转excel下载</summary>
            ///<param name="fileName">文件名</param>
            ///<param name="jsonData">数据</param>        

            //json
            var arrData = typeof jsonData != 'object' ? JSON.parse(jsonData) : jsonData;
            // #region 拼接数据

            var excel = '<table>';

            //设置表头
            var row = "";

            row += "<tr>";
            row += "<td colspan='6' align='center'>" + $("#txtDate_from").textbox('getValue')+"日" + "</td>";
            row += "</tr>";

            row += "<tr>";


            //------------用JASON的標頭作為EXCEL的表頭----------------

            //for (var name in arrData[0]) {
            //    //每个单元格都可以指定样式. eg color:red   生成出来的就是 红色的字体了.
            //    row += "<td style='color:red;text-align:center;'>" + name + '</td>';
            //}
            //------------用JASON的標頭作為EXCEL的表頭----------------
            row += '<td>' + '頁數' + '</td>';
            row += '<td>' + '備註' + '</td>';
            row += '<td>' + '數量' + '</td>';
            row += '<td>' + '單價' + '</td>';
            row += '<td>' + '金額' + '</td>';
            row += '<td>' + '追貨人' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["remark"] + '</td>';
                row += '<td>' + arrData[i]["prod_qty"] + '</td>';
                row += '<td>' + arrData[i]["price"] + '</td>';
                row += '<td>' + arrData[i]["amt_rmb"] + '</td>';
                row += '<td>' + '' + '</td>';
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion



        }

        //這個在子窗口中調用，并給表格賦值，并關閉子窗口
        function closeWindow() {
            ////從子窗口中給表格賦值:
            ////1--選擇原來所點擊的行
            ////2--刷新行，不然賦的值是看不到的
            ////3--重新選擇行，另Checkbox是選中狀態，以便在儲存時可專門提取Checkbox=true的記錄
            var index = editIndex;
            ////1--用這種形式選擇原來所點擊的行
            var rows = $('#tbDetails').datagrid('getRows')[index];
            rows.price = $("#txtGetPrice").val();
            rows.sec_price = $("#txtGetPrice1").val();
            rows.p_unit = $("#txtGetUnit").val();
            rows.sec_p_unit = $("#txtGetUnit1").val();
            ////2--刷新行，不然賦的值是不變的
            $('#tbDetails').datagrid('refreshRow', index);
            ////3--重新選擇行，另Checkbox是選中狀態，以便在儲存時可專門提取Checkbox=true的記錄
            $('#tbDetails').datagrid('selectRow', index);
            //$('#tbDetails').datagrid({ checkOnSelect: $(this).is(':checked') })
            
            ////用以下這個選擇行也行，但同一行每次只能點擊一次，再點擊時會出錯，而且點擊該行後再點擊第二行，值是不會跟著改變的
            //var RowFindByID = $('#tbDetails').datagrid('getSelections');
            //RowFindByID[0].price = $("#txtGetPrice").val();
            //RowFindByID[0].sec_price = $("#txtGetPrice1").val();
            //$('#tbDetails').datagrid('refreshRow', index);
            //$('#tbDetails').datagrid('selectRow', index);

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

        //調用子窗口，用來獲取選中行的，并給表格賦值(closeWindow)
        function showWindow(index) {
            editIndex = index;
            ////1--要用這個語句才可以選中不同行的值的
            var rows = $('#tbDetails').datagrid('getRows')[index];
            ////2--以下3行也是選擇行，但則只能獲取第一次選中行的值，就算點擊了其它行，值都是第一次的行的
            ////$('#tbDetails').datagrid('getSelected');
            ////$('#tbDetails').datagrid('selectRow', index);// 关键在这里  
            ////var row = $('#tbDetails').datagrid('getSelected');
            var title = '查找';
            if (rows) {
                url = "../Products/Pu_SetOutsideProducePriceFind.aspx?goods_id=" + rows.goods_id
                    + "&color_id=" + rows.color + "&vend_id=" + rows.vendor_id;
                var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
                //content += '<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="javascript:$(' + '\'#msgwindow\'' + ').dialog(' + '\'close\'' + ')">' + '关闭' + '</a>';
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
                    <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(0)" style="width:120px;height:25px">Excel</a>
                    <a href="#" id="btnExcel" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(2)" style="width:120px;height:25px">金額明細表</a>
                    <a href="#" class="easyui-linkbutton" iconcls="icon-save" id="btnSave" style="width:120px;height:25px">儲存</a>
                </div>
                <table>
                <tr>
                    <td>
                        <label for="lblDate">發貨日期</label>
                        <input id="txtDate_from" style="width:160px" class="easyui-datebox-expand"/>
                        <input id="txtDate_to" style="width:160px" class="easyui-datebox-expand"/>
                        
                    </td>
                    <td>
                        <label for="lblMo">&nbsp&nbsp 加工單號</label>
                        <input type="text" class="easyui-textbox" id="txtIdFrom" style="width:160px" onchange="setValue(this,txtCustTo)" />
                        <input type="text" class="easyui-textbox" id="txtIdTo" style="width:160px" />
                    </td>
                </tr>
                <tr>
                <td>
                    <label for="lblMo">制單編號</label>
                    <input type="text" class="easyui-textbox" id="txtMoFrom" style="width:160px" onchange="setValue(this,txtMoTo)" />
                    <input type="text" class="easyui-textbox" id="txtMoTo" style="width:160px" />
                </td>
                <td>
                    <label for="lblVend">供應商編號</label>
                    <select id="selVend" name="selVend" class="easyui-combobox" data-options="width:160, valueField: 'vend_id', textField: 'vend_cdesc', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_vend&parab=list'" />
                    <label>
			            <input runat="server" id="chkShowSum" type="checkbox"/>顯示匯總表
		            </label>
                </td>
                </tr>
                    <tr>
                        <td>
                            <label for="lblPriceStatus">單價狀態</label>
                            <select id="selPriceStatus" name="selVend" class="easyui-combobox" data-options="width:160">
                                <option value ="0" selected ="selected">全部</option>
                                <option value ="1">已設定單價</option>
                                <option value ="2">未設定單價</option>
                            </select>

                        </td>
                        <td>
                            <label for="lblDep">&nbsp&nbsp 部門編號</label>
                            <input type="text" class="easyui-textbox" id="txtDep" value="501" style="width:160px" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <label for="lblDate">訂單日期</label>
                        <input id="txtOrderDateFrom" style="width:160px" class="easyui-datebox-expand"/>
                        <input id="txtOrderDateTo" style="width:160px" class="easyui-datebox-expand"/>
                        
                        </td>
                        <td>
                            <label for="lblPrdItem">&nbsp&nbsp 物料編號</label>
                            <input type="text" class="easyui-textbox" id="txtPrdItem" style="width:160px" />
                        </td>
                    </tr>
                    
                </table>
                <%--</form>--%>
            </fieldset>
        <div style="display:none">
            <input type="text" id="txtGetPrice" style="width:160px" />
            <input type="text" id="txtGetPrice1" style="width:160px" />
            <input type="text" id="txtGetUnit" style="width:160px" />
            <input type="text" id="txtGetUnit1" style="width:160px" />
        </div>
        <%--<div id="YWaitDialog" 
	style="background-color: #e0e0e0; 
	position: absolute; 
	margin: auto; 
	top: 150px; 
	left: 300px; 
	display:normal;
	height: 60px; 
	width: 300px;">
    <p style="text-align: center; vertical-align: central;">
        请等待，正在查询数据  <img src="~/images/splash.gif" />
    </p>
</div>--%>
        <%--<div id="YWaitDialog" style="display:none;">--%>
    <%--<div id="YWaitDialog" class="easyui-dialog" style="width: 600px; height:500px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">--%>
<%--    <div id="YWaitDialog" class="easyui-dialog" style="width: 200px; height:130px; padding: 0px 0px;" closed="true" closable="false" resizable="false" modal="true"">
    <p style="text-align: center; vertical-align: central;">
        <img src="../images/splash.gif" />
    </p>--%>
</div>

  <%--      </div>
    </div>--%>
    <!-------------------------------详细信息展示表格----------------------------------->
    <div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true" style="background: #ccc;">
            <table id="tbDetails" class="easyui-datagrid" style="width:100%;height:350px"></table>
        </div>
    </div>

    <%--<table id="tbDetails" padding-left: 0px;></table>--%>
    <%--<div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true" style="background: #ccc;">
            <table id="dg" class="easyui-datagrid" title="銷售統計表" style="width:700px;height:250px"
                   data-options="singleSelect:true,collapsible:true,url:'datagrid_data1.json',method:'get'"></table>
        </div>
    </div>--%>
 <%--   </div>
    </div>--%>
    </div>
</body>
</html>
