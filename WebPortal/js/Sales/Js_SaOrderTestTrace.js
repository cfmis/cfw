$(function () {
    oobj = {
        editRow: undefined,
        search: function () {
            $('#dg').datagrid('load', {
                //mo_id: $.trim($('input[name="txtMo"]').val()),
                mo_group: $("#selMo_group").textbox("getValue"),//$.trim($('input[name="txtDep"]').val()),
                mo_group_cdesc: $("#selMo_group").textbox("getValue"),
                date_from: $("#txtDate_from").textbox("getValue"),//.val(),
                date_to: $("#txtDate_to").textbox("getValue"),//.val(),
                mo: $("#txtMo").textbox("getValue"),
                ref_no: $("#txtRef_no").textbox("getValue"),
                item: $("#txtItem").textbox("getValue"),
                color: $("#txtColor").textbox("getValue"),
                size: $("#txtSize").textbox("getValue"),
                season: $("#txtSeason").textbox("getValue")
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
                        for (var i = 0; i < row.length; i++) {
                            ids.push(row[i].id);
                        }
                        // console.log(ids.join(','));
                        $.ajax({
                            type: 'POST',
                            url: 'delete.ashx',
                            data: {
                                ids: ids.join(','),
                            },
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
        url: "../ashx/Ax_SaOrderTest_Trace.ashx/GetItem?paraa=get_oc_b",//&parab=" + mo_id,//'',//
        //title: '訂單測試記錄',
        iconCls: 'icon-search',
        striped: true,
        nowrap: true,
        loadMsg: 'Loading....',
        rownumbers: true,
        fitColumns: false,
        border:true,
        columns: [[
            
            {
                field: 'operate', title: '操作', align: 'center', width: fixWidth(0.05),
                formatter: function (value, row, index) {
                    var str = '<a href="#" name="opera" onclick="showDetails1(' + index + ')" class="easyui-linkbutton" ></a>';
                    //str="showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id='+row.dep_id+'&dep_cdesc='+row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no')";
                    return str;
                    //return '<a href="#" onclick="showDetails1(' + index + ')">修改</a>';
                }
            },

            {
                field: 'rt_from_date', title: 'Rec Test Form Date', width: fixWidth(0.1), editor: {
                    type: 'validatebox',

                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'ref_no', title: 'Ref No.', width: fixWidth(0.1), editor: {
                    type: 'validatebox',

                    options: {
                        required: true,
                    },
                },
            },
            

            {
                field: 'lab_house_desc', title: 'Lab House', width: fixWidth(0.1), editor: {
                    type: 'validatebox',

                    options: {
                        required: true,
                    },
                },
            },


            {
                field: 'mat_desc', title: 'Material', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'cust_item', title: 'Item', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'cust_size', title: 'Size', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'cust_color', title: 'Color', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            
            {
                field: 'mo_id', title: 'MO#', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'season', title: 'Season', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'division', title: 'Division', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'test_method', title: 'Test Method', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'bulk_mo', title: 'Bulk Order MO#', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'sent_to_hk', title: 'SENT TO HK DATE', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'pass_to_lab', title: 'Pass to Lab Date', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'test_results', title: 'Test Results', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'rsl', title: 'RSL', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'rsl_rp_date', title: 'Report Date', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'appearance', title: 'Appearance after washing', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'appearance_rp_date', title: 'Report Date', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'resist', title: 'Resist to water', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'resist_rp_date', title: 'Report Date', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'salvia', title: 'CF to Salvia', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'salvia_rp_date', title: 'Report Date', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'snap', title: 'Snap Action', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'snap_rp_date', title: 'Report Date', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'underpart', title: 'RSL Underpart', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'underpart_rp_date', title: 'Report Date', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'ftc_cmmts', title: 'FTC CMMTS', width: fixWidth(0.1), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'mo_group', title: '組別', width: fixWidth(0.05), editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            }

        ]],
        singleSelect:true,
        toolbar: '#tb',
        pagination: true,
        pageSize: 100,
        pageList: [100, 200, 300, 400,500],
        loadFilter: pagerFilter,  
            rowStyler: function(index, row) {  
                    if ($.trim(row.WBIVLD) != '') {  
                            return 'color:#ff0000';  
                        } else if ($.trim(row.WBCHKSTATE) == 'C' && $.trim(row.WBCHKUPLST) == 'C') {  
                                return 'background-color:#c4e1ff';  
                            }  
                } ,


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
                showModalDialog('../Sales/Sa_OrderTest_Trace_Details.aspx?mo_id=' + row.mo_id, 'subpage', 'dialogWidth:1024px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');
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
