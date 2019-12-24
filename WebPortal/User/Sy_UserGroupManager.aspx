<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sy_UserGroupManager.aspx.cs" Inherits="WebPortal.User.Sy_UserGroupManager" %>

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
    <script type="text/javascript" src="../js/publicfuncs.js"></script>
    <style> 
        .box1 {width:400px; float:left; display:inline;} 
        .box2 {width:200px; float:left; display:inline;} 
    </style>
    <script type="text/javascript">

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }
        function txtNowDate_from_click(a) {
            var val = a.cal.getNewDateStr();
            $('#txtNowDate_to').val(val);//$('#txtNowDate_from').val();
        }
        $(function () {
            initList();
            AddList();
            $('#dg').datagrid({               //根据自身情况更改
                width: $(window).width() - 40,    //根据自身情况更改
                height: $(window).height() - 200,  //根据自身情况更改

            });
            $("#btnConf").click(function () {
                UpdateList(1);
            });
            $("#btnDelete").click(function () {
                UpdateList(2);
                //Delete();
            });
            $("#btnEdit").click(function () {
                EditList();
            });
            $("#btnFunc").click(function () {
                $('#showGroupFuncDialog').dialog('open').dialog('setTitle', '組別功能');
            });
            $(window).resize(function () {
                $('#dg').datagrid('resize', {               //根据自身情况更改
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
            $('#dg').datagrid({

                url: "../ashx/Ax_UserGroupManager.ashx/GetItem?edit_mode=0",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'GroupId',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#dg',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'GroupID', title: '群組編號', width: 80 },
                { field: 'GroupName', title: '群組描述', width: 160 },
                { field: 'Description', title: '群組說明', width: 300 },
                {
                    field: 'operate', title: '功能', align: 'center', width: fixWidth(0.05),
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="opera" onclick="showDetails1(' + index + ')" class="easyui-linkbutton" ></a>';
                        //str="showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id='+row.dep_id+'&dep_cdesc='+row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no')";
                        return str;
                        //return '<a href="#" onclick="showDetails1(' + index + ')">修改</a>';
                    }
                },
                {
                    field: 'users', title: '用戶', align: 'center', width: fixWidth(0.05),
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="users" onclick="showUsers(' + index + ')" class="easyui-linkbutton" ></a>';
                        //str="showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id='+row.dep_id+'&dep_cdesc='+row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no')";
                        return str;
                        //return '<a href="#" onclick="showDetails1(' + index + ')">修改</a>';
                    }
                }
                ]],
                loadFilter: pagerFilter,
                onLoadSuccess: function (data) {
                    $("a[name='opera']").linkbutton({ text: '編輯', plain: true, iconCls: 'icon-edit' });
                    $("a[name='users']").linkbutton({ text: '用戶', plain: true, iconCls: 'icon-add' });
                }

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
        function fixWidth(percent) {
            return document.body.clientWidth * percent; //这里你可以自己做调整  
        }
        //初始化搜索框
        function InitSearch() {
            //按照条件进行查询，首先我们得到数据
            $("#btnSerach").click(function () {

                //得到用户输入的参数
                var queryData = {
                    rpt_type: 0,
                    groupid: $("#txtGroupId").val(),//.textbox("getValue"),//.val(),
                    groupname: $("#txtGroupName").val(),
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            });
        }
        function AddList() {
            $("#btnAdd").click(function () {
                $('#AddDialog').dialog('open').dialog('setTitle', '新增組別');
            });
        }
        function EditList() {
            var Rows = $('#dg').datagrid("getSelections");
            if (Rows.length == 1) {
                $('#txtGroupId1').val(Rows[0].GroupID);
                $('#txtGroupName1').val(Rows[0].GroupName);
                $('#txtCdesc').val(Rows[0].Description);
                $('#AddDialog').dialog('open').dialog('setTitle', '修改組別');
            }
            else {
                alert("沒有選擇修改的記錄!");
            }
        }
        function UpdateList(edit_mode) {
            
            var json = [];
            var j = {};
            
            if (edit_mode == "1") {
                if (!chkDataValid())
                    return;
                j.groupid = $("#txtGroupId1").val();
                j.groupname = $("#txtGroupName1").val();
                j.cdesc = $("#txtCdesc").val();
            }
            else
            {
                var Rows = $('#dg').datagrid("getSelections");
                if (Rows.length == 1) {
                    j.groupid = Rows[0].GroupID;
                }
                else {
                    alert("沒有選擇刪除的記錄!");
                    return;
                }
            }
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_UserGroupManager.ashx/GetItem?edit_mode=" + edit_mode;
            $.ajax({
                url: url,
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                async: true,    //默認异步，要改為同步：true
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: LoadFunction

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
            function LoadFunction(data) {
                if (data == "OK") {
                    alert("儲存成功!");
                    $("#dg").datagrid("reload");
                    $("#divShowLoadMsg").html('');
                }
                else {
                    alert("儲存失敗!");
                }
            }
            function BefLoadFunction() {
                $("#divShowLoadMsg").html('儲存中...');
            }
            function erryFunction(data) {
                alert(data);
            }

        }

        function chkDataValid() {
            var groupid = $("#txtGroupId1").val();
            if (groupid == "")
            {
                alert("組別編號不能為空!");
                return false;
            }
            if (!isInt(groupid))
            {
                alert("組別編號必須為整數!");
                return false;
            }
            return true;
        }

        //調用群組功能
        function showDetails1(index) {
            $('#dg').datagrid('selectRow', index);// 关键在这里  
            var row = $('#dg').datagrid('getSelected');
            if (row) {

            ////    //window.showModelessDialog('../Sales/Sa_OrderTest_Trace_Details.aspx?mo_id=' + row.mo_id,
            ////    //    'subpage', 'dialogWidth:1024px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');

                //var url = '../Sales/Sa_OrderTest_Trace_Details.aspx?mo_id=' + row.GroupID;
                //var title = '編輯';
                //var width = 1024;
                //var height = 500;
                //var shadow = true;
                //var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
                //var boarddiv = '<div id="msgwindow" title="' + title + '"></div>'//style="overflow:hidden;"可以去掉滚动条  
                //$(document.body).append(boarddiv);
                //var win = $('#msgwindow').dialog({
                //    content: content,
                //    width: width,
                //    height: height,
                //    modal: shadow,
                //    title: title,
                //    onClose: function () {
                //        //$(this).dialog('destroy');//后面可以关闭后的事件  
                //        document.getElementById('btnFind').onclick();
                //    }
                //});
                //win.dialog('open');
                var url = '../User/Sy_GroupFunction.aspx?groupid=' + row.GroupID + '&groupname=' + row.GroupName;
                //var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
                $('#gf_frame').attr('src', url);
                //content = '<iframe src="../PublicWebForm/getProdTypeCode.aspx?groupid= width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
                //$('#showGroupFuncDialog').append(content);
            }

            $('#showGroupFuncDialog').dialog('open').dialog('setTitle', '群組功能');
        }


        //調用群組用戶
        function showUsers(index) {
            $('#dg').datagrid('selectRow', index);// 关键在这里  
            var row = $('#dg').datagrid('getSelected');
            if (row) {
                var url = '../User/Sy_GroupUsers.aspx?groupid=' + row.GroupID + '&groupname=' + row.GroupName;
                //var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
                $('#gu_frame').attr('src', url);
                //content = '<iframe src="../PublicWebForm/getProdTypeCode.aspx?groupid= width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
                //$('#showGroupFuncDialog').append(content);
            }

            $('#showGroupUsersDialog').dialog('open').dialog('setTitle', '群組用戶');
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
                <legend>選擇操作</legend>
                <form id="ffSearch" method="post">
                    <div style="margin-bottom: 5px">
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:100px;height:25px">查詢</a>
                        <a href="#" id="btnExp" class="easyui-linkbutton" iconCls="icon-excel"  plain="false" onclick="Export('組別編號', $('#dg'));" style="width:100px;height:25px">匯出</a>
                        <a href="#" class="easyui-linkbutton" iconcls="icon-add" id="btnAdd" style="width:100px;height:25px">新增</a>
                        <a href="#" class="easyui-linkbutton" iconcls="icon-edit" id="btnEdit" style="width:100px;height:25px">修改</a>
                        <a href="#" class="easyui-linkbutton" iconcls="icon-remove" id="btnDelete" style="width:100px;height:25px">刪除</a>
                    </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblGroupId">組別編號</label>
                        <input type="text" class="easyui-validatebox" id="txtGroupId" name="txtGroupId" style="width:120px" />
                        <label for="lblGroupName">組別描述</label>
                        <input type="text" class="easyui-validatebox" id="txtGroupName" name="txtDep_to" style="width:120px" />&nbsp; 
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

        <!--设置添加的弹出层-->
    <div id="AddDialog" class="easyui-dialog" style="width: 300px; height:435px; padding: 10px 20px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
        <form id="addForm" method="post" novalidate="novalidate">
            <fieldset>
                <legend>添加信息填写栏</legend>
                <table id="tblAdd">
                    <tr>
                        <td>
                            <label for="lblGroupId">組別編號:</label>
                        </td>
                        <td>
                            <input class="easyui-validatebox" type="text" id="txtGroupId1" name="txtGroupId1" data-options="required:true,validType:'length[1,200]'" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="lblGroupName">組別描述:</label>
                        </td>
                        <td>
                            <input class="easyui-validatebox" type="text" id="txtGroupName1" name="txtGroupName1" data-options="required:true,validType:'length[1,200]'" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="lblCdesc">詳細說明:</label>
                        </td>
                        <td>
                            <input class="easyui-validatebox" type="text" id="txtCdesc" name="txtCdesc" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="text-align: center">
                            <a href="javascript:void(0)" class="easyui-linkbutton" id="btnConf" iconcls="icon-ok">确定</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="javascript:$('#AddDialog').dialog('close')">关闭</a>
                        </td>
                    </tr>
                </table>
                <div id="divShowLoadMsg"></div>
            </fieldset>
        </form>
    </div>
    <div id="showGroupFuncDialog" class="easyui-dialog" style="width: 600px; height:500px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <%--<div style="width: 300px; height:200px; padding: 0px 0px;">--%>
            <iframe id="gf_frame" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
            <%-- src="../PublicWebForm/getProdTypeCode.aspx"--%>
    </div>
    <div id="showGroupUsersDialog" class="easyui-dialog" style="width: 600px; height:550px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <%--<div style="width: 300px; height:200px; padding: 0px 0px;">--%>
            <iframe id="gu_frame" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
            <%-- src="../PublicWebForm/getProdTypeCode.aspx"--%>
    </div>

    </div>
    </div>
</body>
</html>
