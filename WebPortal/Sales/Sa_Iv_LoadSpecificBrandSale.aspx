<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Iv_LoadSpecificBrandSale.aspx.cs" Inherits="WebPortal.Sales.Sa_Iv_LoadSpecificBrandSale" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>按牌子統計訂單MOQ</title>
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
            
            ////设置时间  
            //var curr_time = new Date();

            //添加以下兩行賦值代碼後，會導致JQUERY載入實效，導致不能查詢數據的
            //$("#txtDate_from").val(myformatter(curr_time));
            //$('#selPrd_dep').textbox('setValue', 'J03');

            initList();
            //SearchData();
            
            $('#tbDetails').datagrid({               //根据自身情况更改
                width: $(window).width() - 40,    //根据自身情况更改
                height: $(window).height() - 200,  //根据自身情况更改

            });

            //$("#tbDetails").datagrid({
            //    //双击事件
            //    onDblClickRow: function (index, row) {
            //        var obj = window.parent.document.getElementById("txtMat");
            //        obj.value = row.id;
            //        window.parent.closeWindow();
            //    }
            //});

            $(window).resize(function () {
                $('#tbDetails').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 40,    //根据自身情况更改
                    height: $(window).height() - 200  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 40,      //根据自身情况更改
                    height: $(window).height() - 200   //根据自身情况更改
                });
            });
            InitSearch();//查询

            $("input", $("#txtDate_from").next("span")).blur(function () {
                $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));
            });

        });

        
        function initList(queryData) {
            $('#tbDetails').datagrid({

                url: "../ashx/Ax_Iv_LoadSpecificBrandSale.ashx",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'brand_id',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#tbDetails',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'year1', title: '年份', width: 60 },
                { field: 'inm8mo', title: '組別', width: 60 },
                { field: 'inm8type', title: '類型', width: 60 },
                { field: 'inm8sort', title: '排序', width: 60 },
                { field: 'inm8loc', title: '牌子編號', width: 80 },
                { field: 'inm8cdesc', title: '牌子描述', width: 120 },
                { field: 'inm8lot', title: '區域', width: 60 },
                { field: 'amt_s', title: 'S單金額', width: 80 },
                { field: 'qty_s', title: 'S單數量', width: 80 },
                { field: 'po_s', title: 'S單張數', width: 80 },
                { field: 'amt_g', title: 'G單金額', width: 80 },
                { field: 'qty_g', title: 'G單數量', width: 80 },
                { field: 'po_g', title: 'G單張數', width: 80 },
                { field: 'amt_p', title: 'P單金額', width: 80 },
                { field: 'qty_p', title: 'P單數量', width: 80 },
                { field: 'po_p', title: 'P單張數', width: 80 },
                { field: 'amt_t', title: 'T單金額', width: 80 },
                { field: 'qty_t', title: 'T單數量', width: 80 },
                { field: 'po_t', title: 'T單張數', width: 80 },
                { field: 'amt_tot', title: '合計金額', width: 80 },
                { field: 'qty_tot', title: '合計數量', width: 80 },
                { field: 'po_tot', title: '合計張數', width: 80 },
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
                //SearchData();
                if (!chkDataValid()) {
                    return;
                }
                //得到用户输入的参数
                var queryData = {
                    rpt_type: 0,
                    Date_from: $('#txtDate_from').datebox('getValue'),//$("#txtDate_from").val(),
                    Date_to: $('#txtDate_to').datebox('getValue'),
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            });
        }

        function SearchData() {
            
        }

        function chkDataValid()
        {
            if ($('#txtDate_from').datebox('getValue') == "")
            {
                alert("發票日期不能為空!");
                return false;
            }
            return true;
        }



        function JsonToExcel(rpt_type) {
            if (!chkDataValid())
                return;
            var json = [];
            var j = {};
            //debugger;
            //$("#YWaitDialog").show();
            //$("#divMsg").html('Hello');
            //return;
            j.rpt_type = rpt_type;
            j.Date_from = $('#txtDate_from').datebox('getValue'),
            j.Date_to = $('#txtDate_to').datebox('getValue'),
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_Iv_LoadSpecificBrandSale.ashx"
            $.ajax({
                url: url,
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                async: true,    //默認异步，要改為同步：true
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: function (data) { LoadFunctionDetails(rpt_type,data); }

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

        function LoadFunctionDetails(rpt_type,data) {
            //$('#YWaitDialog').dialog('close');
            //closeWindow();
            closeLoadingWindow();
            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            var fileName = '牌子銷售報表';
            if (rpt_type == 0)
                i.val(JSONToExcelConvertorSum("我的excel", dataJson));
            else
            {
                fileName = '牌子銷售明細表';
                i.val(JSONToExcelConvertorDetails("我的excel", dataJson));
            }
            i.appendTo(f);
            l.val(fileName);
            l.appendTo(f);
            f.appendTo(document.body).submit();
            $(document.body).remove("form:last");


            //document.getElementById('btnFind').click();

            $("#divShowLoadMsg").html('');
        }
        function BefLoadFunction() {
            //$("#divShowLoadMsg").html('加载中...');
            //$("#YWaitDialog").show();
            //$('#YWaitDialog').dialog('open').dialog('setTitle', '正在加載，請稍候。。。');
            //showMessageDialog();
            showLoadingDialog();
        }
        function erryFunction(data) {
            closeLoadingWindow();
            if (data.status == 500)
                alert("提取數據失敗!");
        }

        function JSONToExcelConvertorSum(fileName, jsonData) {
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
            row += '<td>' + '年份' + '</td>';
            row += '<td>' + '組別' + '</td>';
            row += '<td>' + '類型' + '</td>';
            row += '<td>' + '排序' + '</td>';
            row += '<td>' + '牌子編號' + '</td>';
            row += '<td>' + '牌子描述' + '</td>';
            row += '<td>' + '區域' + '</td>';
            row += '<td>' + 'S單金額' + '</td>';
            row += '<td>' + 'S單數量' + '</td>';
            row += '<td>' + 'S單張數' + '</td>';
            row += '<td>' + 'G單金額' + '</td>';
            row += '<td>' + 'G單數量' + '</td>';
            row += '<td>' + 'G單張數' + '</td>';
            row += '<td>' + 'P單金額' + '</td>';
            row += '<td>' + 'P單數量' + '</td>';
            row += '<td>' + 'P單張數' + '</td>';
            row += '<td>' + 'T單金額' + '</td>';
            row += '<td>' + 'T單數量' + '</td>';
            row += '<td>' + 'T單張數' + '</td>';
            row += '<td>' + '合計金額' + '</td>';
            row += '<td>' + '合計數量' + '</td>';
            row += '<td>' + '合計張數' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["year1"] + '</td>';
                row += '<td>' + arrData[i]["inm8mo"] + '</td>';
                row += '<td>' + arrData[i]["inm8type"] + '</td>';
                row += '<td>' + arrData[i]["inm8sort"] + '</td>';
                row += '<td>' + arrData[i]["inm8loc"] + '</td>';
                row += '<td>' + arrData[i]["inm8cdesc"] + '</td>';
                row += '<td>' + arrData[i]["inm8lot"] + '</td>';
                row += '<td>' + arrData[i]["amt_s"] + '</td>';
                row += '<td>' + arrData[i]["qty_s"] + '</td>';
                row += '<td>' + arrData[i]["po_s"] + '</td>';
                row += '<td>' + arrData[i]["amt_g"] + '</td>';
                row += '<td>' + arrData[i]["qty_g"] + '</td>';
                row += '<td>' + arrData[i]["po_g"] + '</td>';
                row += '<td>' + arrData[i]["amt_p"] + '</td>';
                row += '<td>' + arrData[i]["qty_p"] + '</td>';
                row += '<td>' + arrData[i]["po_p"] + '</td>';
                row += '<td>' + arrData[i]["amt_t"] + '</td>';
                row += '<td>' + arrData[i]["qty_t"] + '</td>';
                row += '<td>' + arrData[i]["po_t"] + '</td>';
                row += '<td>' + arrData[i]["amt_tot"] + '</td>';
                row += '<td>' + arrData[i]["qty_tot"] + '</td>';
                row += '<td>' + arrData[i]["po_tot"] + '</td>';
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion



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
            row += '<td>' + '發票編號' + '</td>';
            row += '<td>' + '發票日期' + '</td>';
            row += '<td>' + '序號' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '產品編號' + '</td>';
            row += '<td>' + '產品描述' + '</td>';
            row += '<td>' + '發票數量(PCS)' + '</td>';
            row += '<td>' + '金額(HKD)' + '</td>';
            row += '<td>' + '附加費' + '</td>';
            row += '<td>' + '合計金額(HKD)' + '</td>';
            row += '<td>' + '發票數量' + '</td>';
            row += '<td>' + '數量單位' + '</td>';
            row += '<td>' + '發票單價' + '</td>';
            row += '<td>' + '單價單位' + '</td>';
            row += '<td>' + '貨幣代號' + '</td>';
            row += '<td>' + '單位轉換率' + '</td>';
            row += '<td>' + '貨幣轉換率' + '</td>';
            row += '<td>' + '牌子代號' + '</td>';
            row += '<td>' + '單據編號' + '</td>';
            row += '<td>' + '單據日期' + '</td>';
            row += '<td>' + '單據類型' + '</td>';
            row += '<td>' + '組別' + '</td>';
            row += '<td>' + '營業員' + '</td>';
            row += '<td>' + '客戶PO' + '</td>';
            row += '<td>' + '收費標識' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["dat"] + '</td>';
                row += '<td>' + arrData[i]["sequence_id"] + '</td>';
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_cname"] + '</td>';
                row += '<td>' + arrData[i]["qty_pcs"] + '</td>';
                row += '<td>' + arrData[i]["amt_hkd"] + '</td>';
                row += '<td>' + arrData[i]["fare_hkd"] + '</td>';
                row += '<td>' + arrData[i]["total_hkd"] + '</td>';
                row += '<td>' + arrData[i]["u_invoice_qty"] + '</td>';
                row += '<td>' + arrData[i]["goods_unit"] + '</td>';
                row += '<td>' + arrData[i]["invoice_price"] + '</td>';
                row += '<td>' + arrData[i]["p_unit"] + '</td>';
                row += '<td>' + arrData[i]["m_id"] + '</td>';
                row += '<td>' + arrData[i]["rate1"] + '</td>';
                row += '<td>' + arrData[i]["exchange_rate"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["doc"] + '</td>';
                row += '<td>' + arrData[i]["s_dat"] + '</td>';
                row += '<td>' + arrData[i]["doc_type"] + '</td>';
                row += '<td>' + arrData[i]["mo_group"] + '</td>';
                row += '<td>' + arrData[i]["seller_id"] + '</td>';
                row += '<td>' + arrData[i]["contract_id"] + '</td>';
                row += '<td>' + arrData[i]["is_free"] + '</td>';

                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion



        }

        function closeWindow() {
            //window.opener = null;
            ////window.open(' ', '_self', ' ');
            //window.open('', '_self');
            //window.close();

            $('#msgwindow').dialog('close');
            //$('msgwindow').dialog('close');
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


        function showMessageDialog() {
            var title = '正在查詢記錄，請稍候。。。';
            var content = '';
            content+='<p style="text-align: center; vertical-align: central;">';
            content+='<img src="../images/splash.gif" />';
            content+='</p>';
            var boarddiv = '<div id="msgwindow" title="' + title + '"></div>';//style="overflow:hidden;"可以去掉滚动条
            
            $(document.body).append(boarddiv);
            var win = $('#msgwindow').dialog({
                content: content,
                width: 200,
                height: 130,
                modal: true,
                title: title,
                closable:false,
            });
            win.dialog('open');
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
                        <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(0)" style="width:160px;height:25px">Excel</a>
                        <a href="#" id="A1" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(1)" style="width:160px;height:25px">Excel明細</a>
                    </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblDate">發票日期</label>
                        <input id="txtDate_from" style="width:160px" class="easyui-datebox-expand"/>
                        <input id="txtDate_to" style="width:160px" class="easyui-datebox-expand"/>
                    </div>
                <%--</form>--%>
            </fieldset>

        <%--<div id="YWaitDialog" 
	style="background-color: #e0e0e0; 
	position: absolute; 
	margin: auto; 
	top: 150px; 
	left: 300px; 
	display:normal;
	height: 60px; 
	width: 300px;">
    <p style="text-align: center; vertical-align: central;">
        请等待，正在查询数据  <img src="~/images/splash.gif" />
    </p>
</div>--%>
        <%--<div id="YWaitDialog" style="display:none;">--%>
    <%--<div id="YWaitDialog" class="easyui-dialog" style="width: 600px; height:500px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">--%>
<%--    <div id="YWaitDialog" class="easyui-dialog" style="width: 200px; height:130px; padding: 0px 0px;" closed="true" closable="false" resizable="false" modal="true"">
    <p style="text-align: center; vertical-align: central;">
        <img src="../images/splash.gif" />
    </p>--%>
</div>

  <%--      </div>
    </div>--%>
    <!-------------------------------详细信息展示表格----------------------------------->
    <%--<div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true" style="background: #ccc;">--%>
            <table id="tbDetails" padding-left: 0px;></table>
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
