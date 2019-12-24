<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Iv_SalesByGroupBrand.aspx.cs" Inherits="WebPortal.Sales.Sa_Iv_SalesByGroupBrand" %>

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
        function txtNowDate_from_click(a) {
            var val = a.cal.getNewDateStr();
            var old_date = (parseInt(val.substring(0, 4)) - 1).toString() + val.substring(4, 10);//上期日期
            $('#txtNowDate_to').val(val);//$('#txtNowDate_from').val();
            $('#txtOldDate_from').val(old_date);
            $('#txtOldDate_to').val(old_date);
        }
        function txtNowDate_to_click(a) {
            var val = a.cal.getNewDateStr();//document.getElementById('txtNowDate_from').value;
            $('#txtOldDate_to').val((parseInt(val.substring(0, 4))-1).toString() + val.substring(4, 10));
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

                url: "../ashx/Ax_Iv_SalesByGroupBrand.ashx/GetItem?paraa=get_matdata&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'mo_group',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#tbInvList',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'mo_group', title: '組別', width: 80 },
                { field: 'brand_id', title: '牌子編號', width: 100 },
                { field: 'brand_cdesc', title: '牌子描述', width: 100 },
                { field: 'amt_hkd_o', title: '上期金額(HKD)', width: 100 },
                { field: 'amt_hkd_n', title: '本期金額(HKD)', width: 100 },
                { field: 'amt_def', title: '金額差額', width: 100 },
                { field: 'amt_def_per', title: '金額百分比(%)', width: 100 }
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
                    now_date_from: $("#txtNowDate_from").val(),//.textbox("getValue"),//.val(),
                    now_date_to: $("#txtNowDate_to").val(),
                    old_date_from: $("#txtOldDate_from").val(),
                    old_date_to: $("#txtOldDate_to").val(),
                    brand_from: $("#txtBrand_from").val(),
                    brand_to: $("#txtBrand_to").val(),
                    data_type: $('input:checkbox:checked').val(),
                    cust_from: $("#txtCust_from").val(),
                    cust_to: $("#txtCust_to").val(),
                    mo_from: $("#txtMo_from").val(),
                    mo_to: $("#txtMo_to").val(),
                    season_from: $("#txtSeason_from").combobox('getValue'),
                    season_to: $("#txtSeason_to").combobox('getValue')
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            });
        }

        function chkDataValid()
        {
            if($("#txtNowDate_from").val()=="")
            {
                alert("日期不能為空!");
                return false;
            }
            return true;
        }


        function JsonToExcel(excel_type) {
            if (!chkDataValid())
                return;
            var json = [];
            var j = {};
            if (excel_type == 0)//總表
                j.rpt_type = 0;
            else
                j.rpt_type = 1;//明細表
            j.now_date_from = document.getElementById('txtNowDate_from').value;
            j.now_date_to = document.getElementById('txtNowDate_to').value;
            j.old_date_from = document.getElementById('txtOldDate_from').value;
            j.old_date_to = document.getElementById('txtOldDate_to').value;
            j.brand_from = $("#txtBrand_from").val();
            j.brand_to = $("#txtBrand_to").val();
            j.cust_from = $("#txtCust_from").val();
            j.cust_to = $("#txtCust_to").val();
            j.mo_from = $("#txtMo_from").val();
            j.mo_to = $("#txtMo_to").val();
            j.season_from = $("#txtSeason_from").combobox('getValue');
            j.season_to = $("#txtSeason_to").combobox('getValue');
            //獲取Checkbox的選取值
            var obj = document.getElementsByName('chkDataType');
            j.data_type = obj[0].checked;
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_Iv_SalesByGroupBrand.ashx/GetItem?paraa=get_data"
            //總表
            if (excel_type == 0) {
                $.ajax({
                    url: url,
                    type: "post",
                    data: { 'param': obja }, //参数
                    datatype: "json",
                    async: true,    //默認异步，要改為同步：true
                    beforeSend: BefLoadFunction, //加载执行方法
                    error: erryFunction, //错误执行方法
                    success: LoadFunctionSum

                });
            }
            else//明細表
            {
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
            function LoadFunctionSum(data) {
                //alert(data);

                var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
                var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
                var l = $('<input type="hidden" id="txtName" name="txtName" />');
                var dataJson = JSON.parse(data);
                i.val(JSONToExcelConvertorSum("我的excel", dataJson));
                i.appendTo(f);
                l.val('匯總表');
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

        }

        function LoadFunctionDetails(data) {
            //alert(data);

            var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            var l = $('<input type="hidden" id="txtName" name="txtName" />');
            var dataJson = JSON.parse(data);
            i.val(JSONToExcelConvertorDetails("我的excel", dataJson));
            i.appendTo(f);
            l.val('發票明細表');
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

            row += '<td>' + '發票編號' + '</td>';
            row += '<td>' + '發票日期' + '</td>';
            row += '<td>' + '序號' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '產品編號' + '</td>';
            row += '<td>' + '產品描述' + '</td>';
            row += '<td>' + '數量(PCS)' + '</td>';
            row += '<td>' + '金額(HKD)' + '</td>';
            row += '<td>' + '金額(USD)' + '</td>';
            row += '<td>' + '發票數量' + '</td>';
            row += '<td>' + '數量單位' + '</td>';
            row += '<td>' + '單價' + '</td>';
            row += '<td>' + '單價單位' + '</td>';
            row += '<td>' + '貨幣代號' + '</td>';
            row += '<td>' + '牌子編號' + '</td>';
            row += '<td>' + '牌子描述' + '</td>';
            row += '<td>' + '客戶編號' + '</td>';
            row += '<td>' + '季度' + '</td>';
            row += '<td>' + '客戶產品編號' + '</td>';
            row += '<td>' + '客戶顏色編號' + '</td>';
            row += '<td>' + '重量' + '</td>';
            row += '<td>' + '營業員' + '</td>';
            row += '<td>' + '組別' + '</td>';
            row += '<td>' + '送貨目的地' + '</td>';
            row += '<td>' + '產品類型代號' + '</td>';
            row += '<td>' + '產品類型描述' + '</td>';
            row += '<td>' + '期間' + '</td>';

            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["oi_date"] + '</td>';
                row += '<td>' + arrData[i]["sequence_id"] + '</td>';
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_cname"] + '</td>';
                row += '<td>' + arrData[i]["qty_pcs"] + '</td>';
                row += '<td>' + arrData[i]["amt_hkd"] + '</td>';
                row += '<td>' + arrData[i]["amt_usd"] + '</td>';
                row += '<td>' + arrData[i]["u_invoice_qty"] + '</td>';
                row += '<td>' + arrData[i]["goods_unit"] + '</td>';
                row += '<td>' + arrData[i]["invoice_price"] + '</td>';
                row += '<td>' + arrData[i]["p_unit"] + '</td>';
                row += '<td>' + arrData[i]["m_id"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["brand_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["it_customer"] + '</td>';
                row += '<td>' + arrData[i]["season"] + '</td>';
                row += '<td>' + arrData[i]["customer_goods"] + '</td>';
                row += '<td>' + arrData[i]["customer_color_id"] + '</td>';
                row += '<td>' + arrData[i]["sec_qty"] + '</td>';
                row += '<td>' + "=\"" + arrData[i]["seller_id"] + "\"" + '</td>';
                row += '<td>' + arrData[i]["mo_group"] + '</td>';
                row += '<td>' + arrData[i]["final_destination"] + '</td>';
                row += '<td>' + arrData[i]["base_class"] + '</td>';
                row += '<td>' + arrData[i]["base_class_cname"] + '</td>';
                row += '<td>' + arrData[i]["period_type"] + '</td>';

                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion



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

            row += '<td>' + '組別' + '</td>';
            row += '<td>' + '牌子編號' + '</td>';
            row += '<td>' + '牌子描述' + '</td>';
            row += '<td>' + '上期金額(HKD)' + '</td>';
            row += '<td>' + '本期金額(HKD)' + '</td>';
            row += '<td>' + '金額差額' + '</td>';
            row += '<td>' + '差額百分比(%)' + '</td>';

            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["mo_group"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["brand_cdesc"] + '</td>';
                row += '<td>' + arrData[i]["amt_hkd_o"] + '</td>';
                row += '<td>' + arrData[i]["amt_hkd_n"] + '</td>';
                row += '<td>' + arrData[i]["amt_def"] + '</td>';
                row += '<td>' + arrData[i]["amt_def_per"] + '</td>';

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
                        <a href="#" id="btnExp" class="easyui-linkbutton" iconCls="icon-excel"  plain="false" onclick="Export('組別牌子銷貨匯總報表', $('#tbInvList'));" style="width:120px;height:25px">匯出總表(本頁)</a>
                        <a href="#" id="A1" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(0)" style="width:120px;height:25px">匯出總表(全部)</a>
                        <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(1)" style="width:120px;height:25px">匯出明細表</a>
                    </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblInv_date">發票日期(本期)</label>
                        <input size="10" type="text" id="txtNowDate_from" style="height:18px;width:120px" class="Wdate" onclick="WdatePicker({ lang: 'zh-cn', dateFmt: 'yyyy/MM/dd', readOnly: true, onpicking: txtNowDate_from_click })"//>
                        <input size="10" type="text" id="txtNowDate_to" style="height:18px;width:120px" readonly="readonly" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd', onpicking: txtNowDate_to_click})"/>
                        <label for="lblInv_date">發票日期(上期)</label>
                        <input size="10" type="text" id="txtOldDate_from" style="height:18px;width:120px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})""/>
                        <input size="10" type="text" id="txtOldDate_to" style="height:18px;width:120px" readonly="readonly" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                    </div>
                    <div style="margin-bottom: 5px">
                        &nbsp; &nbsp; &nbsp; &nbsp; <label for="lblBrand">牌子編號</label>
                        <input type="text" class="easyui-validatebox" id="txtBrand_from" name="txtBrand_from" style="width:120px" onchange="setValue(this,txtBrand_to)" />
                        <input type="text" class="easyui-validatebox" id="txtBrand_to" name="txtBrand_to" style="width:120px" />&nbsp; 
                        &nbsp; &nbsp; &nbsp; &nbsp;<label for="lblCust">客戶編號</label>
                        <input type="text" class="easyui-validatebox" id="txtCust_from" name="txtCust_from" style="width:120px" onchange="setValue(this,txtCust_to)" />
                        <input type="text" class="easyui-validatebox" id="txtCust_to" name="txtCust_to" style="width:120px" />
                    </div>
                    <div style="margin-bottom: 5px">
                        <%--<div class="box1">--%>
                        &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<label for="lblMo">制單編號</label>
                        <input type="text" class="easyui-validatebox" id="txtMo_from" name="txtMo_from" style="width:120px" onchange="setValue(this,txtMo_to)" />
                        <input type="text" class="easyui-validatebox" id="txtMo_to" name="txtMo_to" style="width:120px" />
                        <%--</div>--%>
                        &nbsp; &nbsp; &nbsp; &nbsp;<label for="lblSeason">季度編號</label>
                        <input class="easyui-combobox" id="txtSeason_from" name="txtSeason_from" style="width:120px;height:22px" data-options="valueField: 'id', textField: 'id',editable:'false', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_season&parab=list'" />
                        <input class="easyui-combobox" id="txtSeason_to" name="txtSeason_to" style="width:120px;height:22px" data-options="valueField: 'id', textField: 'id',editable:'false', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_season&parab=list'" />
                    </div>
                    <div style="margin-bottom: 5px">
                        <div class="box2">
		                    &nbsp; &nbsp; &nbsp;
                            <label>
			                    <input runat="server" id="chkDataType" type="checkbox"/>只提取本期資料
		                    </label>
	                    </div>
                        <div id="divShowLoadMsg" style="color:blue" class="box2">

                        </div>
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
