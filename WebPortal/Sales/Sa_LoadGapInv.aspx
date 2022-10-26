<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_LoadGapInv.aspx.cs" Inherits="WebPortal.Sales.Sa_LoadGapInv" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>提取GAP發票</title>
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
            $("#txtAgent_from").textbox('setValue', 'G009');
            $("#txtAgent_to").textbox('setValue', 'G009');

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

            $("input", $("#txtAgent_from").next("span")).blur(function () {
                $("#txtAgent_to").textbox('setValue', $("#txtAgent_from").textbox('getValue'));
            });
            $("input", $("#txtBrand_from").next("span")).blur(function () {
                $("#txtBrand_to").textbox('setValue', $("#txtBrand_from").textbox('getValue'));
            });
            $("input", $("#txtDate_from").next("span")).blur(function () {
                $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));
            });
            $("input", $("#txtVatDate_from").next("span")).blur(function () {
                $("#txtVatDate_to").textbox('setValue', $("#txtVatDate_from").textbox('getValue'));
            });
        });

        
        function initList(queryData) {
            $('#tbDetails').datagrid({

                url: "../ashx/Ax_Sa_LoadGapInv.ashx",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                { field: 'sp_name', title: 'Supplier Name', width: 80 },
                { field: 'brand_id', title: '牌子Code', width: 80 },
                { field: 'prd_cate', title: 'Product Category', width: 80 },
                { field: 'inv_month', title: 'Month', width: 100 },
                { field: 'inv_year', title: 'Year', width: 80 },
                { field: 'c_name', title: 'Country of Origin', width: 100 },
                { field: 'cust_name', title: 'Vendor Name', width: 120 },
                { field: 'vend_dest', title: 'Destination Country', width: 120 },
                { field: 'amt_usd', title: 'Total Sales(in USD)', width: 80 },
                { field: 'qty_pcs', title: 'Volume', width: 120 },
                { field: 'unit_pcs', title: 'UNIT', width: 120 },
                { field: 'blueprint_id', title: 'Supplier Article', width: 80 },
                { field: 'customer_goods', title: 'GAP RD #', width: 120 },
                { field: 'prd_type_name', title: 'Trim Type', width: 120 },
                { field: 'size_name', title: 'Size', width: 160 },
                { field: 'season', title: 'Season', width: 160 },
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
                var doc_type = 1;
                if ($("#chkShowVat").prop("checked"))
                    doc_type = 2;
                //得到用户输入的参数
                var queryData = {
                    Date_from: $('#txtDate_from').datebox('getValue'),//$("#txtDate_from").val(),
                    Date_to: $('#txtDate_to').datebox('getValue'),
                    vatDate_from: $('#txtVatDate_from').datebox('getValue'),//$("#txtDate_from").val(),
                    vatDate_to: $('#txtVatDate_to').datebox('getValue'),
                    Brand_from: $("#txtBrand_from").val(),
                    Brand_to: $("#txtBrand_to").val(),
                    Agent_from: $("#txtAgent_from").val(),
                    Agent_to: $("#txtAgent_to").val(),
                    doc_type: doc_type,
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



        function JsonToExcel() {
            if (!chkDataValid())
                return;
            var json = [];
            var j = {};
            var doc_type = 1;
            if ($("#chkShowVat").prop("checked"))
                doc_type = 2;
            j.Date_from = $('#txtDate_from').datebox('getValue'),
            j.Date_to = $('#txtDate_to').datebox('getValue'),
            j.vatDate_from = $('#txtVatDate_from').datebox('getValue'),
            j.vatDate_to = $('#txtVatDate_to').datebox('getValue'),
            j.Brand_from = $("#txtBrand_from").val();
            j.Brand_to = $("#txtBrand_to").val();
            j.Agent_from = $("#txtAgent_from").val();
            j.Agent_to = $("#txtAgent_to").val();
            j.doc_type = doc_type;
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_Sa_LoadGapInv.ashx"
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
            var fileName = 'GAP發票記錄';

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
            alert(data);
        }


        function JSONToExcelConvertorDetails(fileName, jsonData) {
            ///<summary>json转excel下载</summary>
            ///<param name="fileName">文件名</param>
            ///<param name="jsonData">数据</param>        

            //json
            var arrData = typeof jsonData != 'object' ? JSON.parse(jsonData) : jsonData;

            // #region 拼接数据
            var excel = '';
            excel += "<meta http-equiv=Content-Type; content=text/html;charset=utf-8> ";
            excel += '<table border="1">';

            //设置表头
            var row = "<tr>";


            //------------用JASON的標頭作為EXCEL的表頭----------------

            //for (var name in arrData[0]) {
            //    //每个单元格都可以指定样式. eg color:red   生成出来的就是 红色的字体了.
            //    row += "<td style='color:red;text-align:center;'>" + name + '</td>';
            //}
            //------------用JASON的標頭作為EXCEL的表頭----------------
            row += '<td>' + 'Supplier Name' + '</td>';
            row += '<td>' + '牌子Code' + '</td>';
            row += '<td>' + 'Product Category' + '</td>';
            row += '<td>' + 'Month' + '</td>';
            row += '<td>' + 'Year' + '</td>';
            row += '<td>' + 'Country of Origin' + '</td>';
            row += '<td>' + 'Vendor Name' + '</td>';
            row += '<td>' + 'Destination Country' + '</td>';
            row += '<td>' + 'Total Sales(in USD)' + '</td>';
            row += '<td>' + 'Volume' + '</td>';
            row += '<td>' + 'UNIT' + '</td>';
            row += '<td>' + 'Supplier Article' + '</td>';
            row += '<td>' + 'GAP RD #' + '</td>';
            row += '<td>' + 'Trim Type' + '</td>';
            row += '<td>' + 'Size' + '</td>';
            row += '<td>' + 'Season' + '</td>';
            row += '<td>' + 'Finsh(顏色)' + '</td>';
            row += '<td>' + '發票編號' + '</td>';
            row += '<td>' + '序號' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '產品編號' + '</td>';
            row += '<td>' + '產品類型代號' + '</td>';
            row += '<td>' + '尺寸代號' + '</td>';
            row += '<td>' + '數量' + '</td>';
            row += '<td>' + '數量單位' + '</td>';
            row += '<td>' + '單價' + '</td>';
            row += '<td>' + '單價單位' + '</td>';
            row += '<td>' + '貨幣代號' + '</td>';
            row += '<td>' + 'HKD轉換率' + '</td>';
            row += '<td>' + '金額(HKD)' + '</td>';
            row += '<td>' + '洋行代號' + '</td>';
            row += '<td>' + '發票(VAT)日期' + '</td>';
            row += '<td>' + '送貨日期' + '</td>';
            row += '<td>' + '標識' + '</td>';
            
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["sp_name"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["prd_cate"] + '</td>';
                row += '<td>' + arrData[i]["inv_month"] + '</td>';
                row += '<td>' + arrData[i]["inv_year"] + '</td>';
                row += '<td>' + arrData[i]["c_name"] + '</td>';
                row += '<td>' + arrData[i]["cust_name"] + '</td>';
                row += '<td>' + arrData[i]["vend_dest"] + '</td>';
                row += '<td>' + arrData[i]["amt_usd"] + '</td>';
                row += '<td>' + arrData[i]["qty_pcs"] + '</td>';
                row += '<td>' + arrData[i]["unit_pcs"] + '</td>';
                row += '<td>' + arrData[i]["blueprint_id"] + '</td>';
                row += '<td>' + arrData[i]["customer_goods"] + '</td>';
                row += '<td>' + arrData[i]["prd_type_name"] + '</td>';
                row += '<td>' + arrData[i]["size_name"] + '</td>';
                row += '<td>' + arrData[i]["season"] + '</td>';
                row += '<td>' + arrData[i]["color_name"] + '</td>';
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["sequence_id"] + '</td>';
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_id"] + '</td>';
                row += '<td>' + arrData[i]["prod_type"] + '</td>';
                row += '<td>' + arrData[i]["size_id"] + '</td>';
                row += '<td>' + arrData[i]["u_invoice_qty"] + '</td>';
                row += '<td>' + arrData[i]["goods_unit"] + '</td>';
                row += '<td>' + arrData[i]["invoice_price"] + '</td>';
                row += '<td>' + arrData[i]["p_unit"] + '</td>';
                row += '<td>' + arrData[i]["m_id"] + '</td>';
                row += '<td>' + arrData[i]["m_rate"] + '</td>';
                row += '<td>' + arrData[i]["amt_hkd"] + '</td>';
                row += '<td>' + arrData[i]["agent"] + '</td>';
                row += '<td>' + arrData[i]["oi_date"] + '</td>';
                row += '<td>' + arrData[i]["sent_goods_date"] + '</td>';
                row += '<td>' + arrData[i]["select_flag"] + '</td>';
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
                        <label for="lblDate">發票日期</label>
                        <input id="txtDate_from" style="width:160px" class="easyui-datebox-expand"/>
                        <input id="txtDate_to" style="width:160px" class="easyui-datebox-expand"/>
                        <label for="lblAgent">洋行編號</label>
                        <input type="text" class="easyui-textbox" id="txtAgent_from" name="txtAgent_from" style="width:160px" />
                        <input type="text" class="easyui-textbox" id="txtAgent_to" name="txtAgent_to" style="width:160px" />
                     </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblBrand">牌子代號</label>
                        <input type="text" class="easyui-textbox" id="txtBrand_from" name="txtBrand_from" style="width:160px" />
                        <input type="text" class="easyui-textbox" id="txtBrand_to" name="txtBrand_to" style="width:160px" />
                     </div>
                    <div style="margin-bottom: 5px">
                        <label><input type="checkbox" id="chkShowVat"/><span>包含VAT的記錄</span></label>
	                </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblVatDate">送貨日期(VAT)</label>
                        <input id="txtVatDate_from" style="width:160px" class="easyui-datebox-expand"/>
                        <input id="txtVatDate_to" style="width:160px" class="easyui-datebox-expand"/>
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
