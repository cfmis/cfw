<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Oc_MoSummary.aspx.cs" Inherits="WebPortal.Sales.Sa_Oc_MoSummary" %>

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

            //添加以下兩行賦值代碼後，會導致JQUERY載入實效，導致不能查詢數據的
            ////设置时间  
            //var curr_time = new Date();
            //$("#txtDate_from").val(myformatter(curr_time));
            //$("#txtDate_to").val(myformatter(curr_time));
            //$('#selLoc_no').textbox('setValue', 'J03');

            //initList();
            $("#selIsComplete").textbox('setValue', "01");
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
            //InitSearch();//查询

            $('#txtDateFrom').datebox({
                onSelect: function (value) {
                    $('#txtDateTo').datebox('setValue', $('#txtDateFrom').datebox('getValue'));//, changeDateToChar(value)

                }
            });
            $('#txtOrderDateFrom').datebox({
                onSelect: function (value) {
                    $('#txtOrderDateTo').datebox('setValue', $('#txtOrderDateFrom').datebox('getValue'));//, changeDateToChar(value)

                }
            });
            
            $("#btnSerach").click(function () {
                SearchData();
            });
        });

        
        function initList(queryData) {
            $('#tbInvList').datagrid({

                url: "../ashx/Ax_Sa_Oc_MoSummary.ashx",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                { field: 'create_date', title: '新增期', width: 80 },
                { field: 'mo_group', title: '組別', width: 60 },
                { field: 'mo_id', title: '制單編號', width: 80 },
                { field: 'hk_req_date', title: '計劃回港期', width: 80 },
                { field: 'order_date', title: '客人落單期', width: 80 },
                { field: 'cs_req_date', title: '客人要求期', width: 80 },
                { field: 'brand_id', title: '牌子編號', width: 80 },
                { field: 'cust_code', title: '客戶編號', width: 80 },
                { field: 'cust_cname', title: '客戶描述', width: 160 },
                { field: 'create_by', title: '開單人', width: 80 },
                { field: 'urgent', title: '急單', width: 60 },
                { field: 'remark', title: '備註', width: 180 },
                { field: 'item_part', title: '配件編號', width: 160 },
                { field: 'a_part', title: '主件', width: 160 },
                { field: 'curr_dep', title: '當前部門', width: 80 },
                { field: 'prd_dep', title: '經過部門', width: 120 },
                { field: 'curr_next_dep', title: '下部門', width: 80 },
                { field: 'goods_id', title: '物料編號', width: 160 },
                { field: 'goods_name', title: '物料描述', width: 260 },
                { field: 'end_wp_id', title: '最後部門', width: 80 },
                { field: 'end_ok_qty', title: '最後發貨數', width: 100 },
                { field: 'period_wp_id', title: '交配件部門', width: 100 },
                { field: 'period_ok_qty', title: '收到配件數', width: 100 },
                { field: 'agent', title: '洋行代號', width: 80 },
                { field: 'order_qty', title: '訂單數量', width: 100 },
                { field: 'goods_unit', title: '數量單位', width: 80 },
                { field: 'actual_bto_hk_date', title: '實際回港日期', width: 100 },
                { field: 'id', title: 'OC編號', width: 100 },
                { field: 'csColor', title: '客人顏色編號', width: 100 }
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

        //////初始化搜索框
        //function InitSearch() {
        //    ////按照条件进行查询，首先我们得到数据
        //    //$("#btnSerach").click(function () {
        //    //    SearchData();
        //    //});
        //}
        function SearchData() {
            if (!chkDataValid()) {
                return;
            }
            var IsAPart = "";
            var SourceType = 1;
            if ($("#chkShowAPart").prop("checked"))
                IsAPart = "1";
            if ($("#chkBatchMo").prop("checked"))
                SourceType = 2;
            //得到用户输入的参数
            var queryData = {
                MoGroup: $("#selMoGroup").textbox('getValue'),
                CreateBy: $("#txtCreateBy").val(),
                csColor: $("#txtCsColor").val(),
                DateFrom: $('#txtDateFrom').datebox('getValue'),
                DateTo: $('#txtDateTo').datebox('getValue'),
                OrderDateFrom: $('#txtOrderDateFrom').datebox('getValue'),
                OrderDateTo: $('#txtOrderDateTo').datebox('getValue'),
                MoFrom: $("#txtMoFrom").val(),
                MoTo: $("#txtMoTo").val(),
                BrandFrom: $("#txtBrandFrom").val(),
                BrandTo: $("#txtBrandTo").val(),
                OwnFrom: $("#txtOwnFrom").val(),
                OwnTo: $("#txtOwnTo").val(),
                CustFrom: $("#txtCustFrom").val(),
                CustTo: $("#txtCustTo").val(),
                IsComplete: $("#selIsComplete").textbox('getValue'),
                IsAPart: IsAPart,
                SourceType: SourceType
            };
            //将值传递给initTable
            initList(queryData);
            return false;
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
            var IsAPart = "";
            var SourceType = 1;
            if ($("#chkShowAPart").prop("checked"))
                IsAPart = "1";
            if ($("#chkBatchMo").prop("checked"))
                SourceType = 2;
            j.MoGroup = $("#selMoGroup").textbox('getValue');
            j.CreateBy = $("#txtCreateBy").val();
            j.csColor = $("#txtCsColor").val();
            j.DateFrom = $('#txtDateFrom').datebox('getValue');
            j.DateTo = $('#txtDateTo').datebox('getValue');
            j.OrderDateFrom = $('#txtOrderDateFrom').datebox('getValue');
            j.OrderDateTo = $('#txtOrderDateTo').datebox('getValue');
            j.MoFrom = $("#txtMoFrom").val();
            j.MoTo = $("#txtMoTo").val();
            j.BrandFrom = $("#txtBrandFrom").val();
            j.BrandTo = $("#txtBrandTo").val();
            j.OwnFrom = $("#txtOwnFrom").val();
            j.OwnTo = $("#txtOwnTo").val();
            j.CustFrom = $("#txtCustFrom").val();
            j.CustTo = $("#txtCustTo").val();
            j.IsComplete = $("#selIsComplete").textbox('getValue');
            j.IsAPart = IsAPart;
            j.SourceType = SourceType;
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_Sa_Oc_MoSummary.ashx"

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
            closeLoadingWindow();
            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            i.val(JSONToExcelConvertorDetails("我的excel", dataJson));
            i.appendTo(f);
            l.val('頁數匯總');
            l.appendTo(f);
            f.appendTo(document.body).submit();
            $(document.body).remove("form:last");


            //document.getElementById('btnFind').click();

            $("#divShowLoadMsg").html('');
        }
        function BefLoadFunction() {
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
            row += '<td>' + '新增期' + '</td>';
            row += '<td>' + '組別' + '</td>';
            row += '<td>' + '未完成頁數' + '</td>';
            row += '<td>' + '計劃回港期' + '</td>';
            row += '<td>' + '客人落單期' + '</td>';
            row += '<td>' + '要求完成期' + '</td>';
            row += '<td>' + '牌子編號' + '</td>';
            row += '<td>' + '客戶編號' + '</td>';
            row += '<td>' + '開單人' + '</td>';
            row += '<td>' + '急/特急狀態' + '</td>';
            row += '<td>' + '有否採購' + '</td>';
            row += '<td>' + '備註' + '</td>';
            row += '<td>' + '當前部門' + '</td>';
            row += '<td>' + '經過部門' + '</td>';
            row += '<td>' + '配件編號' + '</td>';
            row += '<td>' + '主件' + '</td>';
            row += '<td>' + '物料編號' + '</td>';
            row += '<td>' + '物料描述' + '</td>';
            row += '<td>' + '下部門' + '</td>';
            row += '<td>' + '洋行代號' + '</td>';
            row += '<td>' + '訂單數量' + '</td>';
            row += '<td>' + '數量單位' + '</td>';
            row += '<td>' + '實際回港日期' + '</td>';
            row += '<td>' + 'OC編號' + '</td>';
            row += '<td>' + '客戶顏色編號' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["create_date"] + '</td>';
                row += '<td>' + arrData[i]["mo_group"] + '</td>';
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["hk_req_date"] + '</td>';
                row += '<td>' + arrData[i]["order_date"] + '</td>';
                row += '<td>' + arrData[i]["cs_req_date"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["cust_code"] + '</td>';
                row += '<td>' + arrData[i]["create_by"] + '</td>';
                row += '<td>' + arrData[i]["urgent"] + '</td>';
                row += '<td>' + "" + '</td>';
                row += '<td>' + arrData[i]["remark"] + '</td>';
                row += '<td>' + arrData[i]["curr_dep"] + '</td>';
                row += '<td>' + arrData[i]["prd_dep"] + '</td>';
                row += '<td>' + arrData[i]["item_part"] + '</td>';
                row += '<td>' + arrData[i]["a_part"] + '</td>';
                row += '<td>' + arrData[i]["goods_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_name"] + '</td>';
                row += '<td>' + arrData[i]["curr_next_dep"] + '</td>';
                row += '<td>' + arrData[i]["agent"] + '</td>';
                row += '<td>' + arrData[i]["order_qty"] + '</td>';
                row += '<td>' + arrData[i]["goods_unit"] + '</td>';
                row += '<td>' + arrData[i]["actual_bto_hk_date"] + '</td>';
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["csColor"] + '</td>';
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion



        }



    </script>
    <script type="text/javascript">
 

        function closeWindow() {
            //window.opener = null;
            ////window.open(' ', '_self', ' ');
            //window.open('', '_self');
            //window.close();

            $('#msgwindow').dialog('close');
            //$('msgwindow').dialog('close');
        }


        function showMessageDialog(url, title, width, height, shadow) {

            var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
            //content += '<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="javascript:$(' + '\'#msgwindow\'' + ').dialog(' + '\'close\'' + ')">' + '关闭' + '</a>';
            var boarddiv = '<div id="msgwindow" title="' + title + '"></div>'//style="overflow:hidden;"可以去掉滚动条  
            $(document.body).append(boarddiv);
            var win = $('#msgwindow').dialog({
                content: content,
                width: width,
                height: height,
                modal: shadow,
                title: title,
                onClose: function () {
                    //$(this).dialog('destroy');//后面可以关闭后的事件  
                    //document.getElementById('btnSerach').click();
                }
            });
            win.dialog('open');
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
                        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="showMessageDialog('../Sales/Sa_Mo_BatchPrint.aspx','設定制單編號',800,600,true)" style="width:120px;height:25px">設定制單編號</a>
                    </div>

                <%--</form>--%>
            
            <table>
                <tr>
                    <td style="text-align:right"><label for="lblMoGroup">組別</label></td>
                    <td><select id="selMoGroup" name="selMoGroup" class="easyui-combobox" data-options="width:120, valueField: 'group_id', textField: 'group_desc', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_ocmogroup&parab=list'" /></td>
                    <td><label><input type="checkbox" id="chkShowAPart"/><span>只顯示面件</span></label></td>
                    <td colspan="3"><label><input type="checkbox" id="chkBatchMo"/><span>只查找已設定的制單</span></label></td>
                </tr>
                <tr>
                    <td style="text-align:right"><label for="lblDate">開單日期</label></td>
                    <td><input id="txtDateFrom" style="width:120px" class="easyui-datebox-expand"/></td>
                    <td><input id="txtDateTo" style="width:120px" class="easyui-datebox-expand"/></td>
                    <td style="text-align:right"><label for="lblOrderDate">訂單日期</label></td>
                    <td><input id="txtOrderDateFrom" style="width:120px" class="easyui-datebox-expand"/></td>
                    <td><input id="txtOrderDateTo" style="width:120px" class="easyui-datebox-expand"/></td>
                    <td style="text-align:right"><label for="lblCsColor">客人顏色</label>
                    <input type="text" class="easyui-validatebox" id="txtCsColor" style="width:120px" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:right"><label for="lblMo">制單編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMoFrom" style="width:120px" onchange="setValue(this,txtMoTo)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtMoTo" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblPrd_item">牌子編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtBrandFrom" style="width:120px" onchange="setValue(this,txtBrandTo)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtBrandTo" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblIsComplete">完成狀態</label>
                    <select id="selIsComplete" class="easyui-combobox" data-options="width:120, valueField: 'flag_id', textField: 'flag_desc', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_order_complete_flag&parab=list'" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align:right"><label for="lblPrd_item">客戶編號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtCustFrom" style="width:120px" onchange="setValue(this,txtCustTo)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtCustTo" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblMo">洋行代號</label></td>
                    <td><input type="text" class="easyui-validatebox" id="txtOwnFrom" style="width:120px" onchange="setValue(this,txtOwnTo)" /></td>
                    <td><input type="text" class="easyui-validatebox" id="txtOwnTo" style="width:120px" /></td>
                    <td style="text-align:right"><label for="lblMo">開單人員</label>
                    <input type="text" class="easyui-validatebox" id="txtCreateBy" style="width:120px" />
                    </td>
                </tr>
            </table>
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
