<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_LoadOcTestCharge.aspx.cs" Inherits="WebPortal.Sales.Sa_LoadOcTestCharge" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>提取OC測試費用</title>
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

            $("input", $("#txtOwnFrom").next("span")).blur(function () {
                $("#txtOwnTo").textbox('setValue', $("#txtOwnFrom").textbox('getValue'));
            });
            $("input", $("#txtBrandFrom").next("span")).blur(function () {
                $("#txtBrandTo").textbox('setValue', $("#txtBrandFrom").textbox('getValue'));
            });
            $("input", $("#txtDateFrom").next("span")).blur(function () {
                $("#txtDateTo").textbox('setValue', $("#txtDateFrom").textbox('getValue'));
            });
            $("input", $("#txtIdFrom").next("span")).blur(function () {
                $("#txtIdTo").textbox('setValue', $("#txtIdFrom").textbox('getValue'));
            });
            $("input", $("#txtMoFrom").next("span")).blur(function () {
                $("#txtMoTo").textbox('setValue', $("#txtMoFrom").textbox('getValue'));
            });
            $("#txtFeeType").textbox('setValue', 'AC-12');
        });

        
        function initList(queryData) {
            $('#tbDetails').datagrid({

                url: "../ashx/Ax_SaLoadOcTestCharge.ashx",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'id',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#tbDetails',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'id', title: 'OC編號', width: 100 },
                { field: 'mo_id', title: '制單編號', width: 80 },
                { field: 'goods_id', title: '產品編號', width: 100 },
                { field: 'goods_name', title: '產品描述', width: 220 },
                { field: 'order_qty', title: '訂單數量', width: 80 },
                { field: 'goods_unit', title: '數量單位', width: 80 },
                { field: 'order_date', title: '訂單日期', width: 120 },
                { field: 'fare_id', title: '費用類型', width: 60 },
                { field: 'oth_price', title: '測試費用', width: 80 },
                { field: 'm_id', title: '貨幣代號', width: 60 },
                { field: 'brand_id', title: '牌子編號', width: 80 },
                { field: 'it_customer', title: '客戶編號', width: 80 },
                { field: 'cust_cname', title: '客戶描述', width: 120 },
                { field: 'agent', title: '洋行代號', width: 80 },
                { field: 'cs_req_date', title: '客人要求交貨期', width: 100 },
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
                var queryData = getParas();
                //将值传递给initTable
                initList(queryData);
                return false;
            });
        }

        function getParas() {
            var queryData = {
                fee_type: $("#txtFeeType").val(),
                moFrom: $("#txtMoFrom").val(),
                moTo: $("#txtMoTo").val(),
                dateFrom: $('#txtDateFrom').datebox('getValue'),
                dateTo: $('#txtDateTo').datebox('getValue'),
                idFrom: $("#txtIdFrom").val(),
                idTo: $("#txtIdTo").val(),
                custFrom: $("#txtCustFrom").val(),
                custTo: $("#txtCustTo").val(),
                idFrom: $("#txtIdFrom").val(),
                idTo: $("#txtIdTo").val(),
                brandFrom: $("#txtBrandFrom").val(),
                brandTo: $("#txtBrandTo").val(),
                ownFrom: $("#txtOwnFrom").val(),
                ownTo: $("#txtOwnTo").val(),
            };
            return queryData;
        }

        function SearchData() {
            
        }

        function chkDataValid()
        {
            if ($('#txtDateFrom').datebox('getValue') == "")
            {
                alert("訂單日期不能為空!");
                return false;
            }
            return true;
        }



        function JsonToExcel() {
            if (!chkDataValid())
                return;
            var json = [];
            var queryData = getParas();
            json.push(queryData);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_SaLoadOcTestCharge.ashx"
            $.ajax({
                url: url,
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                async: true,    //默認异步，要改為同步：true
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: function (data) { LoadFunctionDetails(data); }

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
            closeLoadingWindow();
            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            var fileName = '收測試費的制單';

            i.val(JSONToExcelConvertorDetails("我的excel", dataJson));
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

            var excel = '<table border="1">';

            //设置表头
            var row = "<tr>";


            //------------用JASON的標頭作為EXCEL的表頭----------------

            //for (var name in arrData[0]) {
            //    //每个单元格都可以指定样式. eg color:red   生成出来的就是 红色的字体了.
            //    row += "<td style='color:red;text-align:center;'>" + name + '</td>';
            //}
            //------------用JASON的標頭作為EXCEL的表頭----------------
            row += '<td>' + 'OC編號' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '產品編號' + '</td>';
            row += '<td>' + '產品描述' + '</td>';
            row += '<td>' + '訂單數量' + '</td>';
            row += '<td>' + '數量單位' + '</td>';
            row += '<td>' + '訂單日期' + '</td>';
            row += '<td>' + '費用類型' + '</td>';
            row += '<td>' + '測試費用' + '</td>';
            row += '<td>' + '貨幣代號' + '</td>';
            row += '<td>' + '牌子編號' + '</td>';
            row += '<td>' + '客戶編號' + '</td>';
            row += '<td>' + '客戶描述' + '</td>';
            row += '<td>' + '洋行代號' + '</td>';
            row += '<td>' + '客人要求交貨期' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_name"] + '</td>';
                row += '<td>' + arrData[i]["order_qty"] + '</td>';
                row += '<td>' + arrData[i]["goods_unit"] + '</td>';
                row += '<td>' + arrData[i]["order_date"] + '</td>';
                row += '<td>' + arrData[i]["fare_id"] + '</td>';
                row += '<td>' + arrData[i]["oth_price"] + '</td>';
                row += '<td>' + arrData[i]["m_id"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["it_customer"] + '</td>';
                row += '<td>' + arrData[i]["cust_cname"] + '</td>';
                row += '<td>' + arrData[i]["agent"] + '</td>';
                row += '<td>' + arrData[i]["cs_req_date"] + '</td>';
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
                    <div style="margin-bottom: 8px">
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:120px;height:25px">查詢</a>
                        <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel()" style="width:120px;height:25px">Excel</a>
                    </div>
                    <div style="margin-bottom: 8px">
                        <label for="lblDate">訂單日期</label>
                        <input id="txtDateFrom" style="width:160px" class="easyui-datebox-expand"/>
                        <input id="txtDateTo" style="width:160px" class="easyui-datebox-expand"/>
                        <label for="lblBrand">牌子代號</label>
                        <input type="text" class="easyui-textbox" id="txtBrandFrom" name="txtBrandFrom" style="width:160px" />
                        <input type="text" class="easyui-textbox" id="txtBrandTo" name="txtBrandTo" style="width:160px" />
                     </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblId">OC編號</label>
                        <input type="text" class="easyui-textbox" id="txtIdFrom" name="txtIdFrom" style="width:160px" />
                        <input type="text" class="easyui-textbox" id="txtIdTo" name="txtIdTo" style="width:160px" />
                        <label for="lblOwn">制單編號</label>
                        <input type="text" class="easyui-textbox" id="txtMoFrom" name="txtMoFrom" style="width:160px" />
                        <input type="text" class="easyui-textbox" id="txtMoTo" name="txtMoTo" style="width:160px" />
                     </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblBrand">客戶編號</label>
                        <input type="text" class="easyui-textbox" id="txtCustFrom" name="txtCustFrom" style="width:160px" />
                        <input type="text" class="easyui-textbox" id="txtCustTo" name="txtCustTo" style="width:160px" />
                        <label for="lblOwn">洋行編號</label>
                        <input type="text" class="easyui-textbox" id="txtOwnFrom" name="txtOwnFrom" style="width:160px" />
                        <input type="text" class="easyui-textbox" id="txtOwnTo" name="txtOwnTo" style="width:160px" />
                     </div>
                <div style="margin-bottom: 5px">
                        <label for="lblFeeType">費用類型</label>
                        <input type="text" class="easyui-textbox" id="txtFeeType" name="txtFeeType" style="width:160px" />
                     </div>
                <%--</form>--%>
            </fieldset>
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
