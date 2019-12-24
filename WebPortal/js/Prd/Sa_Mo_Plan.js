$(function () {
    oobj = {
        editRow: undefined,
        search: function () {
            $('#dg').datagrid('load', {
                mo_id: $.trim($('input[name="txtMo"]').val()),
                prd_dep: $("#dlDep").val(),//$.trim($('input[name="txtDep"]').val()),
                prd_cdesc: $("#dlDep").text(),
                now_date: $("#dateArrange").val(),
                //dep_id: $("#dldep").find("option:selected").val(),
                //dep_id: $('#dldep option:selected').val(),
                //dep_id: $("#<%=dlDep.ClientID%>").val(),
                //mo_id: $("#idMo").val(),
                //dep_id: $.trim($('select[name="<%=dlDep.ClientID%>"]').val()),//$("#<%=dlDep.ClientID%>").val(),
                //dep_id: $('#<%=dlDep.ClientID%> option:selected').val(),
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
            if (row){
                alert('Dept ID:'+row.dep_id+"Cdesc:"+row.dep_cdesc);
                }

        },
        selectAllRow: function () {
            var ids = [];
            var rows = $('#dg').datagrid('getSelections');
            for(var i=0; i<rows.length; i++){
                ids.push(rows[i].dep_id);
                }
            alert(ids.join(''));


        },
        showDetails:function(){
            var row = $('#dg').datagrid('getSelected');
            showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id='+row.dep_id+'&dep_cdesc='+row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no');
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
        width: 1500,
        url: '../ashx/Pd_Mo_Plan.ashx',
        title: '排期信息',
        iconCls: 'icon-search',
        striped: true,
        nowrap: false,
        loadMsg: 'Loading....',
        rownumbers: true,
        fitColumns: true,
        columns: [[
            {
                field: 'arrange_id',
                title: '序號',
                sortable: true,
                width: 100,
                checkbox: true,
            },
            {
                field: 'operate', title: '操作', align: 'center', width: 100,
                formatter: function (value, row, index) {
                    var str = '<a href="#" name="opera" onclick="showDetails1(' + index + ')" class="easyui-linkbutton" ></a>';
                    //str="showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id='+row.dep_id+'&dep_cdesc='+row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no')";
                    return str;
                    //return '<a href="#" onclick="showDetails1(' + index + ')">修改</a>';
                }
            },
            
            {
                field: 'prd_mo', title: '制單編號', width: 120, editor: {
                    type: 'validatebox',
                    
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'arrange_date',
                title:'排期日期' ,
                width:100 ,
                sortable : true ,
                editor:{
                    type:'datebox' , 
                    options:{
                        required:true , 
                        missingMessage:'排期日期必填!' ,
                        editable:false 
                    }
                }
            },
            {
                field: 'urgent_status', title: '急單狀態', width: 80, editor: {
                    type: 'combobox',
                    options: {
                        required: true,
                        valueField: 'status',
                        textField: 'status',
                        data: [{ status: '01' }, { status: '02' }, { status: '03' }, { status: '04' }],
                    },
                },
            },
            {
                field: 'prd_item', title: '物料編號', width: 220, editor: {
                    type: 'validatebox',
                    
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'order_date',
                title: '落單日期',
                width: 100,
                sortable: true,
                editor: {
                    type: 'datebox',
                    options: {
                        required: true,
                        missingMessage: '落單日期必填!',
                        editable: false
                    }
                }
            },
            {
                field: 'req_time',
                title: '要求完成日期',
                width: 100,
                sortable: true,
                editor: {
                    type: 'datebox',
                    options: {
                        required: true,
                        missingMessage: '要求完成日期必填!',
                        editable: false
                    }
                }
            },
            {
                field: 'order_qty', title: '訂單數量', width: 100, editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'req_qty', title: '要求數量', width: 100, editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'cpl_qty', title: '完成數量', width: 100, editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'wait_cpl_qty', title: '待完成數量', width: 100, editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'prd_cpl_qty', title: '生產數量', width: 100, editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'dep_rep_date',
                title: '部門復期',
                width: 100,
                sortable: true,
                editor: {
                    type: 'datebox',
                    options: {
                        required: true,
                        missingMessage: '部門復期必填!',
                        editable: false
                    }
                }
            },
            {
                field: 'arrange_machine', title: '生產設備', width: 100, editor: {
                    type: 'validatebox',
                    options: {
                        required: true,
                    },
                },
            },
            {
                field: 'now_date',
                title: '建立日期',
                width: 100,
                sortable: true,
                editor: {
                    type: 'datebox',
                    options: {
                        required: true,
                        missingMessage: '建立日期必填!',
                        editable: false
                    }
                }
            },
            {
                field: 'prd_dep', title: '部門編號', width: 100, editor: {
                    type: 'validatebox',
                    options: {
                        //required: true,
                        editable: false,
                    },

                },
            }
            
           

        ]],
        //singleSelect:true,
        pagination: true,
        pageSize: 10,
        pageList: [5, 10, 15, 20],
        toolbar: '#tb',
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
        onLoadSuccess:function(data){    
                    $("a[name='opera']").linkbutton({text:'安排',plain:true,iconCls:'icon-add'});    
            },  

        showDetails1:function(index){
            $('#dg').datagrid('selectRow',index);// 关键在这里  
                var row = $('#dg').datagrid('getSelected');  
                if (row){  
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

    $("#editWin").dialog({
        title: "编辑",
        width: 600,
        height: 400,
        modal: true,
        closed: true,
        href: "../Products/Pd_Mo_Plan_Details.aspx"

    });

});
