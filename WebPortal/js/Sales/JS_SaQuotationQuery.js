$(function () {
    oobj = {
        editRow: undefined,
        search: function () {
            $('#dg').datagrid('load', {
                //date_to: $("#txtDate_to").textbox("getValue"),//.val(),
                prd_item: $("#txtPrd_item").val(),
                size: $("#txtSize").val(),
                clr: $("#txtClr").val(),
            });
        },
        add: function () {
            $('#save,#redo').show();
            if (this.editRow == undefined) {
                $('#dg').datagrid('insertRow', {
                    index: 0,
                    row: {

                    },
                });
                $('#dg').datagrid('beginEdit', 0);
                this.editRow = 0;
            }
        },
        save: function () {
            $('#dg').datagrid('endEdit', this.editRow);


        },

        selectRow: function () {
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                alert('Dept ID:' + row.dep_id + "Cdesc:" + row.dep_cdesc);
            }

        },
        selectAllRow: function () {
            var ids = [];
            var rows = $('#dg').datagrid('getSelections');
            for (var i = 0; i < rows.length; i++) {
                ids.push(rows[i].dep_id);
            }
            alert(ids.join(''));


        },
        showDetails: function () {
            var row = $('#dg').datagrid('getSelected');
            showModalDialog('../Sales/Sa_OrderTest_Trace_Details.aspx?mo_id=' + row.mo_id, 'subpage', 'dialogWidth:1024px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');
        },
        redo: function () {
            this.editRow = undefined;
            $('#save,#redo').hide();
            $('#dg').datagrid('rejectChanges');
        },
        cancelEdit: function () {
            this.editRow = undefined;
            $('#save,#redo').hide();
            $("#dg").datagrid("uncheckAll");// 此两行排除页面删除的记忆功能的bug
            $("#dg").datagrid("unselectAll");
            $("#dg").datagrid("reload");
        },
        edit: function () {
            var rows = $('#dg').datagrid('getSelections');
            if (rows.length == 1) {
                if (this.editRow != undefined) {
                    $('#dg').datagrid('endEdit', obj.editRow);
                }
                if (this.editRow == undefined) {
                    var index = $('#dg').datagrid('getRowIndex', rows[0])
                    $('#save,#redo').show();
                    $('#dg').datagrid('beginEdit', index);
                    this.editRow = index;
                }
            } else {
                $.messager.alert('警告', '修改必须或只能选择一行！', 'warning');
            }
        },
        removed: function () {
            var row = $('#dg').datagrid('getSelections');
            if (row.length > 0) {
                $.messager.confirm('确定操作', '你正在要删除所选的记录吗？', function (flag) {
                    if (flag) {
                        var ids = [];
                        var rows = $('#dg').datagrid('getSelections');
                        //var index = $('#dg').datagrid('getRowIndex', rows[0])//獲取選擇的行數
                        ids.push(row[0].invoice_id);
                        ////循環讀取表格的每一行
                        //for (var i = 0; i < row.length; i++) {
                        //    ids.push(row[i].invoice_id);
                        //}
                        // console.log(ids.join(','));
                        $.ajax({
                            type: 'POST',
                            url: "../ashx/Ax_SaOrderTest_Trace.ashx/GetItem?paraa=delete_OrderTestInvoice",
                            data: {
                                'param': ids.join(','),
                            },
                            //data: { 'param': obja }, //参数
                            datatype: "json",
                            beforeSend: function () {
                                $('#dg').datagrid('loading');
                            },
                            success: function (data) {
                                if (data) {
                                    $('#dg').datagrid('loaded');
                                    $('#dg').datagrid('load');
                                    $('#dg').datagrid('unselectAll');
                                    $.messager.show({
                                        title: '提示',
                                        msg: data,
                                    });
                                }
                            },
                        });
                    }
                });
            } else {
                $.messager.alert('提示', '请选择要删除的记录', 'info');
            }
        },

    };
    $('#dg').datagrid({
        //width: 500,
        //width: 'auto',
        //height: 'auto',
        sortable: true,
        //url: '../ashx/Ax_SaOrderTest_Trace.ashx',
        url: "../ashx/Ax_SaQuotation_Query.ashx/GetItem?paraa=getquotation",
        //title: '訂單測試記錄',
        iconCls: 'icon-search',
        striped: true,
        nowrap: true,
        loadMsg: 'Loading....',
        rownumbers: true,
        fitColumns: true,
        border: true,
        columns: [[


            {
                field: 'prd_item', title: 'Item Class', width: fixWidth(0.1), editor: {
                    type: 'validatebox',

                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'size_id', title: 'Size', width: fixWidth(0.1), editor: {
                    type: 'validatebox',

                    options: {
                        required: true,
                    },
                },
            },


            {
                field: 'size_cdesc', title: 'Size Description', width: fixWidth(0.1), editor: {
                    type: 'validatebox',

                    options: {
                        required: true,
                    },
                },
            },


            {
                field: 'clr_code', title: 'Color', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'clr_cdesc', title: 'Color Desc', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'ex_fty', title: 'EX-fty', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'fob', title: 'FOB', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'vat', title: 'VAT', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'clr_grp', title: 'Color Group', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'clr_grp_cdesc', title: 'Group Desc', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            }

        ]],
        singleSelect: true,
        toolbar: '#tb',
        pagination: true,
        pageSize: 10,
        pageList: [10, 20, 50, 100, 200],
        loadFilter: pagerFilter,
        rowStyler: function (index, row) {
            if ($.trim(row.WBIVLD) != '') {
                return 'color:#ff0000';
            } else if ($.trim(row.WBCHKSTATE) == 'C' && $.trim(row.WBCHKUPLST) == 'C') {
                return 'background-color:#c4e1ff';
            }
        },


        onDblClickRow: function (rowIndex, rowData) {
            if (obj.editRow != undefined) {
                $('#dg').datagrid('endEdit', obj.editRow);
            }
            if (obj.editRow == undefined) {
                $('#save,#redo').show();
                $('#dg').datagrid('beginEdit', rowIndex);
                obj.editRow = rowIndex;
            }

        },
        onLoadSuccess: function (data) {
            $("a[name='opera']").linkbutton({ text: '編輯', plain: true, iconCls: 'icon-edit' });
        },

        showDetails1: function (index) {
            $('#dg').datagrid('selectRow', index);// 关键在这里  
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                //$('#dlg').dialog('open').dialog('setTitle','修改学生信息');  
                //$('#fm').form('load',row);  
                //url = '${ctx}updateStudent.do?id='+row.id;  
                showModalDialog('../Sales/Sa_OrderTest_Invoice_Details.aspx?mo_id=' + row.mo_id, 'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');
            }

        },
        //onClickRow:function(rowIndex,rowData){
        //    alert("单击");
        //},
        onAfterEdit: function (rowIndex, rowData, changes) {
            // console.log(rowData);

            $('#save,#redo').hide();
            var inserted = $('#dg').datagrid('getChanges', 'inserted');
            var updated = $('#dg').datagrid('getChanges', 'updated');
            if (inserted.length > 0) {//添加

                uri = 'add.ashx';
            }
            if (updated.length > 0) {//修改
                uri = 'update.ashx?id=' + rowData.id + '';
            }
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
                    $('#dg').datagrid('loading');
                },
                success: function (data) {
                    if (data) {
                        $('#dg').datagrid('loaded');
                        $('#dg').datagrid('load');
                        $('#dg').datagrid('unselectAll');
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
        },
    });


});
