<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bs_Mat_Rate.aspx.cs" Inherits="WebPortal.Bs.Bs_Mat_Rate" %>

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
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>
    <style> 
        .box1 {width:400px; float:left; display:inline;} 
        .box2 {width:200px; float:left; display:inline;} 
    </style>
    <script type="text/javascript">

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }

        $(function () {
            initList();
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
        });

        
        function initList(queryData) {
            $('#tbInvList').datagrid({

                url: "../ashx/Ax_Bs_Mat_Rate.ashx?paraa=get_mat_rate&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'Prd_item',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#tbInvList',
                pagination: true,
                pageSize: 50,
                pageList: [50, 100, 150, 200, 250],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'dep_id', title: '部門編號', width: 80 },
                { field: 'prd_item', title: '成品編號', width: 200 },
                { field: 'prd_item_cdesc', title: '成品描述', width: 200 },
                { field: 'mat_item', title: '原料編號', width: 200 },
                { field: 'mat_item_cdesc', title: '原料描述', width: 200 },
                { field: 'prd_weg', title: '1千成品重量', width: 100 },
                { field: 'waste_weg', title: '1千廢料重量', width: 100 },
                { field: 'use_weg', title: '1千總用量', width: 100 },
                { field: 'hour_std_qty', title: '產能(PCS/h)', width: 100 },
                { field: 'kg_qty_rate', title: '每Kg數量', width: 80 },
                { field: 'group_cdesc', title: '組別', width: 80 },
                {
                    field: 'oprate_edit', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        //var title1 = "'編輯'";
                        var str = '<a href="#" name="opera_edit" onclick="showMessageDialog('+"'編輯'"+',' + index + ')" class="easyui-linkbutton" >編輯</a>';
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
                if (!chkDataValid()) {
                    return;
                }
                //得到用户输入的参数
                var queryData = {
                    rpt_type: 0,
                    Dep_id: $("#selPrd_dep").textbox('getValue'),
                    Prd_item: $("#txtPrd_item").val(),
                    Mat_item: $("#txtMat_item").val()
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            });
        }
        
        //新增、修改記錄
        function showMessageDialog(title,index) {

            //var index = -1;
            var Prd_dep = "";
            var Prd_item = "";
            var Mat_item = "";
            if (index >= 0) {
                $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
                var row = $('#tbInvList').datagrid('getSelected');
                if (row) {
                    Prd_dep = row.dep_id;
                    Prd_item = row.prd_item;
                    Mat_item = row.mat_item;
                }
            }

            var url = '../Bs/Bs_Mat_Rate_Add.aspx?Prd_dep=' + Prd_dep + '&Prd_item=' + Prd_item + '&Mat_item=' + Mat_item;
            var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
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
                            url: "../ashx/Ax_Bs_Mat_Rate.ashx?paraa=delete&Dep_id="+row.dep_id+'&Prd_item=' + row.prd_item+'&Mat_item='+row.mat_item,///GetPrdItem
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
            j.Dep_id = $("#selPrd_dep").textbox('getValue');
            j.Prd_item = $("#txtPrd_item").val();
            j.Mat_item = $("#txtMat_item").val();
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_Bs_Mat_Rate.ashx?paraa=get_mat_rate"
 
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

        function LoadFunctionDetails(data) {
            //alert(data);

            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            i.val(JSONToExcelConvertorDetails("我的excel", dataJson));
            i.appendTo(f);
            l.val('成品編號換算表');
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
            row += '<td>' + '成品編號' + '</td>';
            row += '<td>' + '成品描述' + '</td>';
            row += '<td>' + '原料編號' + '</td>';
            row += '<td>' + '原料描述' + '</td>';
            row += '<td>' + '1000成品重量' + '</td>';
            row += '<td>' + '1000廢料重量' + '</td>';
            row += '<td>' + '1000總用量' + '</td>';
            row += '<td>' + '產能(PCS/h)' + '</td>';
            row += '<td>' + '每Kg數量' + '</td>';
            row += '<td>' + '組別' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["dep_id"] + '</td>';
                row += '<td>' + arrData[i]["prd_item"] + '</td>';
                row += '<td>' + arrData[i]["prd_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["mat_item"] + '</td>';
                row += '<td>' + arrData[i]["mat_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["prd_weg"] + '</td>';
                row += '<td>' + arrData[i]["waste_weg"] + '</td>';
                row += '<td>' + arrData[i]["use_weg"] + '</td>';
                row += '<td>' + arrData[i]["hour_std_qty"] + '</td>';
                row += '<td>' + arrData[i]["kg_qty_rate"] + '</td>';
                row += '<td>' + arrData[i]["group_cdesc"] + '</td>';
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
    <!--存放内容的主区域-->
   <%-- <div data-options="region:'north'" title="請輸入查詢內容" style="height: 60px;">
        <div class="easyui-layout" id="tb" style="padding: 0px; height: auto">--%>
            <!-------------------------------搜索框----------------------------------->
            <fieldset>
                <legend>查詢條件</legend>
                <form id="ffSearch" method="post">
                    <div style="margin-bottom: 5px">
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:120px;height:25px">查詢</a>
                        <a href="#" id="A1" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel()" style="width:120px;height:25px">Excel(全部)</a>
                        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="showMessageDialog('新增',-1)" style="width:120px;height:25px">新增</a>
                        <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="editRecord(-1)" style="width:120px;height:25px">新增</a>--%>
                    </div>
                    <div style="margin-bottom: 5px">
                        <label>部門編號</label>
                        <input id="selPrd_dep" name="txtLoc_no" class="easyui-combobox" data-options="width:120, valueField: 'id', textField: 'name', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_jx_dep&parab=list'" />
                        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<label>產品編號</label>
                        <input type="text" class="easyui-validatebox" id="txtPrd_item" name="txtPrd_item" style="width:200px" />
                        &nbsp; &nbsp; &nbsp; &nbsp;<label>原料編號</label>
                        <input type="text" class="easyui-validatebox" id="txtMat_item" name="txtPrd_item" style="width:200px" />
                    </div>
                </form>
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
