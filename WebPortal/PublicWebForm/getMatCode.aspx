<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="getMatCode.aspx.cs" Inherits="WebPortal.PublicWebForm.getMatCode" %>

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

    <script type="text/javascript">

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }

        $(function () {
            initList();
            $('#dg').datagrid({               //根据自身情况更改
                width: $(window).width() - 30,    //根据自身情况更改
                height: $(window).height() - 100,  //根据自身情况更改

                onDblClickRow: function (index, row) {
                    var obj = window.parent.document.getElementById("txtMat");
                    if (obj != null)
                        obj.value = row.id;
                    obj = window.parent.document.getElementById("txtItem");
                    if (obj != null)
                        obj.value = row.id;
                    window.parent.closeWindow();
                }
            });

            //$("#dg").datagrid({
            //    //双击事件
            //    onDblClickRow: function (index, row) {
            //        var obj = window.parent.document.getElementById("txtMat");
            //        obj.value = row.id;
            //        window.parent.closeWindow();
            //    }
            //});

            $(window).resize(function () {
                $('#dg').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 30,    //根据自身情况更改
                    height: $(window).height() - 100  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 30,      //根据自身情况更改
                    height: $(window).height() - 100   //根据自身情况更改
                });
            });

            //按照条件进行查询，首先我们得到数据
            $("#btnSerach").click(function () {
                //得到用户输入的参数
                var queryData = {
                    //UserName: $("#txtUserNameSerach").val(),
                    //ClassId: $("#txtClassIdSerach").combobox("getValue"),
                    search_val: $("#txtVal").val()//
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            });
            $("#btnConf").click(function () {
                var obj = window.parent.document.getElementById("txtMat");
                var row = $('#dg').datagrid('getSelected');

                //var w = window.dialogArguments.getElementById;
                if (row) {
                    //alert('Item ID:' + row.itemid + "\nPrice:" + row.listprice);
                    //alert('Item ID:' + row.id);
                    obj.value = row.id;
                    window.parent.closeWindow();
                    //closeWindow();



                    //window.opener = null;
                    //window.open('', '_self');
                    //window.close();
                    //obj = window.parent.document.getElementById("showMatDialog");

                    //obj.style.display = "none";
                    //window.parent.document.removeChild("showMatDialog");
                    //document.body.removeChild("showMatDialog");
                    //obj.dialog('close');
                }
            });

            
            //("#btnSerach").click(function () {
                //var obj = window.parent.document.getElementById("txtMat");
                //var row = $('#dg').datagrid('getSelected');
                //if (row) {
                //    //alert('Item ID:' + row.itemid + "\nPrice:" + row.listprice);
                //    alert('Item ID:' + row.id);
                //    //obj.value = row.id;
                //}
                //var obj_to = window.parent.document.getElementById("txtMat");
                //var val = obj_to.value;
                //alert(val);
                //obj_f = document.getElementById("s");
                //obj_to.value = obj_f.value;
            //});
            //InitSearch();//查询
        });

        
        function initList(queryData) {
            $('#dg').datagrid({

                url: "../ashx/Base_Select.ashx/GetItem?paraa=get_matdata&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'Id',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#dg',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: '选择', checkbox: 'true', width: 30 },
                { field: 'id', title: '原料編號', width: 80 },
                { field: 'mat_cdesc', title: '中文描述', width: 100 },
                { field: 'mat_desc', title: '英文描述', width: 100 }
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
                //得到用户输入的参数
                var queryData = {
                    //UserName: $("#txtUserNameSerach").val(),
                    //ClassId: $("#txtClassIdSerach").combobox("getValue"),
                    search_val: $("#txtVal").val()//
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            });
        }


        function closeWindow() {
            window.opener = null;
            //window.open(' ', '_self', ' ');
            window.open('', '_self');
            window.close();

            
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
 <%--                       <label for="lblVal">請輸入查詢內容:</label>--%>
                        <input type="text" class="easyui-validatebox" id="txtVal" name="txtVal" data-options="required:true, missingMessage:'請輸入原料編號/中文描述/英文描述'" style="width:260px"" />
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:80px;height:25px">查詢</a>
                        <a href="#" class="easyui-linkbutton" iconcls="icon-save" id="btnConf" style="width:80px;height:25px">確認</a>
                    </div>
                </form>
            </fieldset>
  <%--      </div>
    </div>--%>
    <!-------------------------------详细信息展示表格----------------------------------->
    <%--<div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true" style="background: #ccc;">--%>
            <table id="dg" padding-left: 0px;></table>
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
