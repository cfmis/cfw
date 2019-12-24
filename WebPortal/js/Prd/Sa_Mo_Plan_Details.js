$(function () {
    oobj = {
        editRow: undefined,
        search: function () {
            //$('#dg').datagrid('load', {
            //    dep_id: $("#txtPrd_dep").val(),//$.trim($('input[name="txtDep"]').val()),
            //    mo_id: $.trim($('input[name="txtPrd_mo"]').val()),
            //    prd_item: $("#txtPrd_item").val(),
            //    now_date:$("#txtNow_date").val(),
            //    //dep_id:'abcd',
            //    //prd_cdesc: $("#dlDep").text(),
            //    //now_date: $("#dateArrange").val(),
            //    //dep_id: $("#dldep").find("option:selected").val(),
            //    //dep_id: $('#dldep option:selected').val(),
            //    //dep_id: $("#<%=dlDep.ClientID%>").val(),
            //    //mo_id: $("#idMo").val(),
            //    //dep_id: $.trim($('select[name="<%=dlDep.ClientID%>"]').val()),//$("#<%=dlDep.ClientID%>").val(),
            //    //dep_id: $('#<%=dlDep.ClientID%> option:selected').val(),
            //});
            $('#dg').datagrid('load', {
                prd_dep: $("#txtPrd_dep").val(),//$.trim($('input[name="txtDep"]').val()),
                prd_mo: $.trim($('input[name="txtPrd_mo"]').val()),
                prd_item: $("#txtPrd_item").val(),
                now_date: $("#txtNow_date").val(),
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
            //$('#dg').datagrid('endEdit', this.editRow);
            if ($("#txtWorker_id").val() == '') {
                $.messager.alert({
                    title: '系統信息',
                    msg: '工號不能為空!',
                    icon: 'info',
                });
                return;
            }
            if ($("#selWork_type").val() == '0') {
                $.messager.alert({
                    title: '系統信息',
                    msg: '工作類型無效!',
                    icon: 'info',
                });
                return;
            }
            $.ajax({
                type: 'POST',
                url: '../ashx/Sa_Mo_Plan_Details.ashx?tb_type=upd_prd01',
                data: {
                    //prd_dep: $("#txtPrd_dep").val(),//$.trim($('input[name="txtDep"]').val()),
                    //prd_mo: $.trim($('input[name="txtPrd_mo"]').val()),
                    //prd_item: $("#txtPrd_item").val(),
                    //now_date: $("#txtNow_date").val(),
                    worker_id: $("#txtWorker_id").val(),
                    work_type_id: $("#selWork_type").val(),
                },
                //beforeSend: function () {
                //    console.log(rowData);
                //    $('#dg').datagrid('loading');
                //},
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
            showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id=' + row.dep_id + '&dep_cdesc=' + row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no');
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
                        //var ids = [];
                        //for (var i = 0; i < row.length; i++) {
                        //    ids.push(row[i].prd_dep);
                        //    ids.push(row[i].prd_dep);
                        //}
                        // console.log(ids.join(','));

                        $.ajax({
                            type: 'POST',
                            url: '../ashx/Sa_Mo_Plan_Details.ashx?tb_type=delete_prd01',
                            //data: {
                            //    ids: ids.join(','),
                            //},
                            data: {
                                prd_dep: $("#txtPrd_dep").val(),//$.trim($('input[name="txtDep"]').val()),
                                prd_mo: $.trim($('input[name="txtPrd_mo"]').val()),
                                prd_item: $("#txtPrd_item").val(),
                                now_date: $("#txtNow_date").val(),
                                worker_id: row[0].worker_id,//worker_id,
                                work_type_id: row[0].work_type_id,//work_type_id,
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
        width: 460,
        url: '../ashx/Sa_Mo_Plan_Details.ashx?tb_type=prd01',
        title: '已排員工信息',
        iconCls: 'icon-search',
        striped: true,
        nowrap: false,
        loadMsg: 'Loading....',
        rownumbers: true,
        fitColumns: true,
        columns: [[


            {
                field: 'worker_id', title: '工號', width: 80, editor: {
                    type: 'validatebox',

                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'hrm1name', title: '姓名', width: 80, editor: {
                    type: 'validatebox',

                    options: {
                        required: true,
                    },
                },
            },

            {
                field: 'work_type_id', title: '工作類型', width: 80, editor: {
                    type: 'validatebox',

                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'work_type_desc', title: '類型描述', width: 80, editor: {
                    type: 'validatebox',

                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'operate', title: '操作', align: 'center', width: 60,
                formatter: function (value, row, index) {
                    var str = '<a href="#" name="opera" onclick="showDetails1(' + index + ')" class="easyui-linkbutton" ></a>';
                    
                    //str="showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id='+row.dep_id+'&dep_cdesc='+row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no')";
                    return str;
                    //return '<a href="#" onclick="showDetails1(' + index + ')">修改</a>';
                }
            }


        ]],
        //singleSelect:true,
        pagination: true,
        pageSize: 10,
        pageList: [5, 10, 15, 20],
        toolbar: '#wtb',
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
            $("a[name='opera']").linkbutton({ text: '移除', plain: true, iconCls: 'icon-remove' });
        },

        showDetails1: function (index) {
            $('#dg').datagrid('selectRow', index);// 关键在这里  
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                //$('#dlg').dialog('open').dialog('setTitle','修改学生信息');  
                //$('#fm').form('load',row);  
                //url = '${ctx}updateStudent.do?id='+row.id;  
                showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id=' + row.dep_id + '&dep_cdesc=' + row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no');
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
