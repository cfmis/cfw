$(function () {
    oobj = {
        editRow: undefined,
        search: function () {
            $('#dg').datagrid('load', {
                date1: $("#txtDate_from").val(),//.textbox("getValue"),//.val(),
                date2: $("#txtDate_to").val(),//.textbox("getValue"),//.val(),
                crdate1: $("#crDate_from").val(),
                crdate2: $("#crDate_to").val(),
                mo_from: $("#txtMo_from").textbox("getValue"),
                mo_to: $("#txtMo_to").textbox("getValue"),
                crby: $("#txtCrBy").textbox("getValue"),
                mo_group: $("#selMo_group").textbox("getValue"),
                cust1: $("#txtCust").textbox("getValue"),
                brand1: $("#txtBrand").textbox("getValue"),
                pono: $("#txtPoNo").textbox("getValue"),
                agent1: $("#txtAgent1").textbox("getValue"),
                season: $("#txtSeason").textbox("getValue"),
                ocno: $("#txtOcNo").textbox("getValue"),
                goods_id: $("#txtGoods_id").textbox("getValue"),
                cust_style: $("#txtCust_Style").textbox("getValue"),
                cs_date1: $("#txtReqDate_from").val(),
                cs_date2: $("#txtReqDate_to").val(),
                cust_goods: $("#txtCust_Goods").textbox("getValue"),
                cust_color: $("#txtCust_Color").textbox("getValue"),
                only_apart: $('input:checkbox:checked').val(),
                period_type: $("#selShowPeriod").textbox("getValue")
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
        //sortable: true,
        remoteSort: false,
        sortName: '',
        sortorder: '',
        multisort: true,
        //url: "../ashx/Ax_Oc_NoCompleteOc_New.ashx/GetItem?paraa=get_data",//&parab=" + mo_id,//'',//
        url: "../ashx/Ax_Oc_NoCompleteOc_New.ashx/GetItem?paraa=get_data",//&parab=" + mo_id,//'',//
        //title: '訂單測試記錄',
        iconCls: 'icon-search',
        striped: true,
        nowrap: true,
        loadMsg: 'Loading....',
        rownumbers: true,
        fitColumns: false,
        border: true,
        columns: [[

            {
                field: 'mo_id', title: '制單編號', width: 80, sortable: true, 
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'create_date', title: '開單日期', width: 80,
                //formatter: function (value, row, index) {
                //    if (value != null && '' != value)
                //        return new Date(value).format("yyyy/MM/dd");
                //},
                sortable: true,
                sorter: function (a, b) {
                    a = a.split('/');
                    b = b.split('/');
                    if (a[0] == b[0]) {
                        if (a[1] == b[1]) {
                            return (a[2] > b[2] ? 1 : -1);
                        } else {
                            return (a[1] > b[1] ? 1 : -1);
                        }
                    } else {
                        return (a[0] > b[0] ? 1 : -1);
                    }
                },

            },


            {
                field: 'order_date', title: '訂單日期', width: 80, sortable: true,
                sorter: function (a, b) {
                    a = a.split('/');
                    b = b.split('/');
                    if (a[0] == b[0]) {
                        if (a[1] == b[1]) {
                            return (a[2] > b[2] ? 1 : -1);
                        } else {
                            return (a[1] > b[1] ? 1 : -1);
                        }
                    } else {
                        return (a[0] > b[0] ? 1 : -1);
                    }
                },
            },


            {
                field: 'goods_id', title: '產品編號', width: 160, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'goods_name', title: '產品描述', width: 220,
            },
            {
                field: 'wp_goods_id', title: '未完成貨品', width: 120,
            },
            {
                field: 'qty_pcs', title: '訂單數量(PCS)', width: 100,
            },

            {
                field: 'act_to_hk_qty', title: '實際回港數量(PCS)', width: 120,
            },

            {
                field: 'cs_req_date', title: '客人要求交貨期', width: 120, sortable: true,
                sorter: function (a, b) {
                    a = a.split('/');
                    b = b.split('/');
                    if (a[0] == b[0]) {
                        if (a[1] == b[1]) {
                            return (a[2] > b[2] ? 1 : -1);
                        } else {
                            return (a[1] > b[1] ? 1 : -1);
                        }
                    } else {
                        return (a[0] > b[0] ? 1 : -1);
                    }
                },
            },
            {
                field: 'hk_req_date', title: '計劃回港日期', width: 100, sortable: true,
                sorter: function (a, b) {
                    a = a.split('/');
                    b = b.split('/');
                    if (a[0] == b[0]) {
                        if (a[1] == b[1]) {
                            return (a[2] > b[2] ? 1 : -1);
                        } else {
                            return (a[1] > b[1] ? 1 : -1);
                        }
                    } else {
                        return (a[0] > b[0] ? 1 : -1);
                    }
                },
            },
            {
                field: 'act_to_hk_date', title: '實際回港日期', width: 100, sortable: true,
                sorter: function (a, b) {
                    a = a.split('/');
                    b = b.split('/');
                    if (a[0] == b[0]) {
                        if (a[1] == b[1]) {
                            return (a[2] > b[2] ? 1 : -1);
                        } else {
                            return (a[1] > b[1] ? 1 : -1);
                        }
                    } else {
                        return (a[0] > b[0] ? 1 : -1);
                    }
                },
            },
            {
                field: 'prod_qty', title: '計劃生產數量(PCS)', width: 120,
            },
            
            {
                field: 'c_qty_ok', title: '完成數量(PCS)', width: 100,
            },
            {
                field: 't_complete_date', title: '要求包裝日期', width: 100,
            },
            {
                field: 'f_complete_date', title: '包裝實際完成日期', width: 100,
            },
            {
                field: 'period_day', title: '過期天數', width: 80, sortable: true,
                sorter: function (a, b) {
                    return (parseInt(a) > parseInt(b) ? 1 : -1);
                },
            },
            {
                field: 'wp_id', title: '負責部門', width: 60, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'next_wp_id', title: '收貨部門', width: 60, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'production_remark', title: '生產備註', width: 160,
            },
            {
                field: 'id', title: 'OC編號', width: 100, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'goods_id_part', title: '產品編號A件', width: 100, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'order_qty', title: '訂單數量', width: 80,
            },
            {
                field: 'goods_unit', title: '數量單位', width: 60,
            },
            {
                field: 'unit_price', title: '單價', width: 80,
            },
            {
                field: 'p_unit', title: '單價單位', width: 60,
            },
            {
                field: 'm_id', title: '貨幣代號', width: 60,
            },
            {
                field: 'cust_code', title: '客戶編號', width: 80, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'cust_cname', title: '客戶描述', width: 120,
            },
            {
                field: 'brand_id', title: '牌子編號', width: 80, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'agent', title: '洋行代號', width: 80, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'create_by', title: '開單人', width: 80, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'mo_group', title: '組別', width: 60, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'color_name', title: '顏色描述', width: 80,
            },
            {
                field: 'do_color', title: '顏色做法', width: 80,
            },
            {
                field: 'customer_goods', title: '客人產品編號', width: 80, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'customer_color_id', title: '客人產品顏色', width: 80, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'season', title: '季度', width: 60, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'contract_id', title: '客戶PO', width: 80, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'table_head', title: '客戶款號', width: 80, sortable: true,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            },
            {
                field: 'repair_mo_id', title: '補正單頁數', width: 80,
                sorter: function (a, b) {
                    return (a > b ? 1 : -1);
                },
            }
            
        ]],
        singleSelect: true,
        toolbar: '#tb',
        pagination: true,
        pageSize: 200,
        pageList: [200, 400, 600, 800, 1000],
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
