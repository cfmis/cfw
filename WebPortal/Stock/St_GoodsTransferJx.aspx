<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="St_GoodsTransferJx.aspx.cs" Inherits="WebPortal.Stock.St_GoodsTransferJx" %>

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
    <style> 
        .box1 {width:400px; float:left; display:inline;} 
        .box2 {width:200px; float:left; display:inline;} 
    </style>
    <script type="text/javascript">

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


        });

        
        function initList(queryData) {
            $('#tbInvList').datagrid({

                url: "../ashx/Ax_GoodsTransferJx.ashx?paraa=get_transfer&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                { field: 'prd_mo', title: '制單編號', width: 120 },
                { field: 'prd_item', title: '物料編號', width: 200 },
                { field: 'prd_item_cdesc', title: '物料描述', width: 200 },
                { field: 'qty', title: '未回數量', width: 80 },
                { field: 'weg', title: '未回重量', width: 80 },
                { field: 'out_date', title: '最近發貨日期', width: 120 },
                { field: 'in_date', title: '最近收貨日期', width: 120 },
                { field: 'cpl_flag', title: '完成標識', width: 80 },
                { field: 'prd_dep', title: '部門', width: 80 },
                {
                    field: 'oprate', title: '操作', align: 'center', width: 80,
                    formatter: function (value, row, index) {
                        var str = '<a href="#" name="opera" onclick="setCplFlag(' + index + ')" class="easyui-linkbutton" >強制完成</a>';
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
                SearchData();
            });
        }
        function SearchData() {
            if (!chkDataValid()) {
                return;
            }
            var not_cpl_flag = "";
            if ($(chkNotCpl).is(":checked")) {
                not_cpl_flag = "1";
            }
            var cpl_flag = "";
            if ($(chkCplFlag).is(":checked")) {
                cpl_flag = "1";
            }
            //得到用户输入的参数
            var queryData = {
                rpt_type: 0,
                Prd_dep: $("#txtDep").val(),
                Mo_group: $("#txtMo_group").val(),
                Prd_mo_from: $("#txtMo_from").val(),
                Prd_mo_to: $("#txtMo_to").val(),
                Prd_item_from: $("#txtPrd_item_from").val(),
                Not_cpl_flag:not_cpl_flag,
                Cpl_flag:cpl_flag
            };
            //将值传递给initTable
            initList(queryData);
            return false;
        }
        function setCplFlag(index) {
            $('#tbInvList').datagrid('selectRow', index);// 关键在这里  
            var row = $('#tbInvList').datagrid('getSelected');
            if (row) {
                var msg = "";
                if (row.cpl_flag == "1")
                    msg = "確定取消強制完成嗎？";
                else
                    msg = "确认強制完成吗？";
                $.messager.confirm("系統信息", msg, function (deleteClient) {
                    if (deleteClient) {
                        $.ajax({
                            url: "../ashx/Ax_GoodsTransferJx.ashx?paraa=set_cpl_flag&prd_dep="
                                + row.prd_dep + "&prd_mo=" + row.prd_mo + "&prd_item=" + row.prd_item+"&cpl_flag="+row.cpl_flag,///GetPrdItem
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
            var not_cpl_flag = "";
            if ($(chkNotCpl).is(":checked")) {
                not_cpl_flag = "1";
            }
            var cpl_flag = "";
            if ($(chkCplFlag).is(":checked")) {
                cpl_flag = "1";
            }
            j.Prd_dep = $("#txtDep").val();
            j.Mo_group = $("#txtMo_group").val();
            j.Prd_mo_from = $("#txtMo_from").val();
            j.Prd_mo_to = $("#txtMo_to").val();
            j.Prd_item_from = $("#txtPrd_item_from").val();
            j.Not_cpl_flag = not_cpl_flag;
            j.Cpl_flag = cpl_flag;
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_GoodsTransferJx.ashx?paraa=get_transfer"

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
            l.val('收發記錄表');
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
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '物料編號' + '</td>';
            row += '<td>' + '物料描述' + '</td>';
            row += '<td>' + '未回數量' + '</td>';
            row += '<td>' + '未回重量' + '</td>';
            row += '<td>' + '最近發貨日期' + '</td>';
            row += '<td>' + '最近收貨日期' + '</td>';
            row += '<td>' + '完成標識' + '</td>';
            row += '<td>' + '部門' + '</td>';

            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["prd_mo"] + '</td>';
                row += '<td>' + arrData[i]["prd_item"] + '</td>';
                row += '<td>' + arrData[i]["prd_item_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["qty"] + '</td>';
                row += '<td>' + arrData[i]["weg"] + '</td>';
                row += '<td>' + arrData[i]["out_date"] + '</td>';
                row += '<td>' + arrData[i]["in_date"] + '</td>';
                row += '<td>' + arrData[i]["cpl_flag"] + '</td>';
                row += '<td>' + arrData[i]["prd_dep"] + '</td>';
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
                <%--<form id="ffSearch" method="post">--%>
                    <div style="margin-bottom: 5px">
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:120px;height:25px">查詢</a>
                        <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel()" style="width:120px;height:25px">Excel</a>
                    </div>

                
                <%--</form>--%>
            </fieldset>
            <table>
                <tr>
                    <td style="text-align:right"><label for="lblDep">部門編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtDep" value="102" name="txtDep" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblPrd_item">物料編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtPrd_item_from" name="txtPrd_item_from" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblMo_group">組別</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMo_group" name="txtMo_group" style="width:120px" /></td>
                </tr>
                <tr>
                    <td style="text-align:right"><label for="lblMo">制單編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMo_from" name="txtMo_from" style="width:120px" onchange="setValue(this,txtMo_to)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMo_to" name="txtMo_to" style="width:120px" /></td>
                    <td colspan="2">
                        <input type="checkbox" id="chkNotCpl" checked="checked"/><span>只顯示未回齊數量的記錄</span>
                        <input type="checkbox" id="chkCplFlag" checked="checked"/><span>不顯示已強制完成的記錄</span>
                    </td>
                </tr>
                <tr>
                    
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
