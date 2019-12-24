<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pd_DepAverageProduct.aspx.cs" Inherits="WebPortal.Sales.Pd_DepAverageProduct" %>

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
            $('#txtNowDate_to').val(val);//$('#txtNowDate_from').val();
        }
        $(function () {
            initList();
            $('#dg').datagrid({               //根据自身情况更改
                width: $(window).width() - 40,    //根据自身情况更改
                height: $(window).height() - 200,  //根据自身情况更改

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

                url: "../ashx/Ax_Pd_DepAverageProduct.ashx/GetItem?paraa=get_matdata&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
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
                idField: 'prd1stat2',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#dg',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'prd1stat2', title: '部門編號', width: 80 },
                { field: 'it11name', title: '部門描述', width: 100 },
                { field: 'prd1dat', title: '生產日期', width: 100 },
                { field: 'produce_type', title: '生產類型', width: 100 },
                { field: 'work_type_desc', title: '類型描述', width: 100 },
                { field: 'jq_rate', title: '每天標準生產數量', width: 100 },
                { field: 'prd2pqty', title: '實際生產數量', width: 100 },
                { field: 'day_qty_def', title: '數量差額', width: 100 },
                { field: 'day_qty_per', title: '差額百分比(%)', width: 100 },
                { field: 'prd2wh', title: '生產時間', width: 100 },
                { field: 'q_rate', title: '標準每小時平均產量', width: 100 },
                { field: 'hour_qty', title: '實際平均每小時產量', width: 100 },
                { field: 'hour_qty_def', title: '數量差額', width: 100 },
                { field: 'hour_qty_per', title: '差額百分比(%)', width: 100 },
                { field: 'prd2sweg', title: '實際總重量', width: 100 },
                { field: 'prd2cwid', title: '人次', width: 100 },
                { field: 'prd2swid', title: '生產人數', width: 100 },
                { field: 'prd2cmould', title: '校模次數', width: 100 }
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
                    dep_from: $("#txtDep_from").val(),
                    dep_to: $("#txtDep_to").val(),
                    mo_from: $("#txtMo_from").val(),
                    mo_to: $("#txtMo_to").val(),
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
            j.dep_from = $("#txtDep_from").val();
            j.dep_to = $("#txtDep_to").val();
            j.mo_from = $("#txtMo_from").val();
            j.mo_to = $("#txtMo_to").val();
            json.push(j);
            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_Pd_DepAverageProduct.ashx/GetItem?paraa=get_data"
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
                l.val('部門生產總表');
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
            l.val('部門生產明細表');
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
            row += '<td>' + '部門描述' + '</td>';
            row += '<td>' + '生產日期' + '</td>';
            row += '<td>' + '序號' + '</td>';
            row += '<td>' + '制單編號' + '</td>';
            row += '<td>' + '物料編號' + '</td>';
            row += '<td>' + '物料描述' + '</td>';
            row += '<td>' + '生產類型' + '</td>';
            row += '<td>' + '類型描述' + '</td>';
            row += '<td>' + '生產機器' + '</td>';
            row += '<td>' + '工號' + '</td>';
            row += '<td>' + '生產數量' + '</td>';
            row += '<td>' + '生產開始時間' + '</td>';
            row += '<td>' + '生產結束時間' + '</td>';
            row += '<td>' + '生產正常班工時' + '</td>';
            row += '<td>' + '生產加班工時' + '</td>';
            row += '<td>' + '正常+加班(工時)' + '</td>';
            row += '<td>' + '校模開始時間' + '</td>';
            row += '<td>' + '校模結束時間' + '</td>';
            row += '<td>' + '校模正常班工時' + '</td>';
            row += '<td>' + '校模加班工時' + '</td>';
            row += '<td>' + '正常+加班(工時)' + '</td>';
            row += '<td>' + '標準產量' + '</td>';
            row += '<td>' + '碑數' + '</td>';
            row += '<td>' + '標準每碑' + '</td>';
            row += '<td>' + '實際每碑' + '</td>';
            row += '<td>' + '生產重量' + '</td>';
            row += '<td>' + '組別' + '</td>';
            row += '<td>' + '工種' + '</td>';
            row += '<td>' + '工種描述' + '</td>';
            row += '<td>' + '難度' + '</td>';
            row += '<td>' + '標準編碼' + '</td>';
            

            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + "=\"" + arrData[i]["prd1stat2"] + "\"" + '</td>';
                row += '<td>' + arrData[i]["it11name"] + '</td>';
                row += '<td>' + arrData[i]["prd1dat"] + '</td>';
                row += '<td>' + "=\"" + arrData[i]["prd2seq"] + "\"" + '</td>';
                row += '<td>' + arrData[i]["prd2mo"] + '</td>';
                row += '<td>' + arrData[i]["prd2item"] + '</td>';
                row += '<td>' + arrData[i]["goods_name"] + '</td>';
                row += '<td>' + arrData[i]["produce_type"] + '</td>';
                row += '<td>' + arrData[i]["work_type_desc"] + '</td>';
                row += '<td>' + arrData[i]["prd2mac"] + '</td>';
                row += '<td>' + "=\"" + arrData[i]["prd2wid"] + "\"" + '</td>';
                row += '<td>' + arrData[i]["prd2pqty"] + '</td>';
                row += '<td>' + "=\"" + arrData[i]["prd2stim"] + "\"" + '</td>';
                row += '<td>' + "=\"" + arrData[i]["prd2etim"] + "\"" + '</td>';
                row += '<td>' + arrData[i]["prd2wkh"] + '</td>';
                row += '<td>' + arrData[i]["prd2oth"] + '</td>';
                row += '<td>' + arrData[i]["prd2wh"] + '</td>';
                row += '<td>' + "=\"" + arrData[i]["prd2mdtim1"] + "\"" + '</td>';
                row += '<td>' + "=\"" + arrData[i]["prd2mdtim2"] + "\"" + '</td>';
                row += '<td>' + arrData[i]["prd2mdtim"] + '</td>';
                row += '<td>' + arrData[i]["prd2mdtim3"] + '</td>';
                row += '<td>' + arrData[i]["prd2mdh"] + '</td>';
                row += '<td>' + arrData[i]["prd2sta"] + '</td>';
                row += '<td>' + arrData[i]["prd2mold"] + '</td>';
                row += '<td>' + arrData[i]["prd2stmul"] + '</td>';
                row += '<td>' + arrData[i]["prd2moldunit"] + '</td>';
                row += '<td>' + arrData[i]["prd2sweg"] + '</td>';
                row += '<td>' + arrData[i]["prd1group"] + '</td>';
                row += '<td>' + arrData[i]["prd2hd1"] + '</td>';
                row += '<td>' + arrData[i]["it17cdesc"] + '</td>';
                row += '<td>' + arrData[i]["prd2hd2"] + '</td>';
                row += '<td>' + arrData[i]["prd2stdno"] + '</td>';
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

            row += '<td>' + '部門編號' + '</td>';
            row += '<td>' + '部門描述' + '</td>';
            row += '<td>' + '生產日期' + '</td>';
            row += '<td>' + '生產類型' + '</td>';
            row += '<td>' + '每天標準生產數量' + '</td>';
            row += '<td>' + '實際生產數量' + '</td>';
            row += '<td>' + '數量差額' + '</td>';
            row += '<td>' + '差額百分比(%)' + '</td>';
            row += '<td>' + '生產時間' + '</td>';
            row += '<td>' + '標準每小時平均產量' + '</td>';
            row += '<td>' + '實際平均每小時產量' + '</td>';
            row += '<td>' + '數量差額' + '</td>';
            row += '<td>' + '差額百分比(%)' + '</td>';
            row += '<td>' + '實際總重量' + '</td>';
            row += '<td>' + '人次' + '</td>';
            row += '<td>' + '生產人數' + '</td>';
            row += '<td>' + '校模次數' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];
                var row = "<tr>";
                row += '<td>' + "=\"" + arrData[i]["prd1stat2"] + "\"" + '</td>';
                row += '<td>' + arrData[i]["it11name"] + '</td>';
                row += '<td>' + arrData[i]["prd1dat"] + '</td>';
                row += '<td>' + arrData[i]["produce_type"] + '</td>';
                row += '<td>' + arrData[i]["work_type_desc"] + '</td>';
                row += '<td>' + arrData[i]["jq_rate"] + '</td>';
                row += '<td>' + arrData[i]["prd2pqty"] + '</td>';
                row += '<td>' + arrData[i]["day_qty_def"] + '</td>';
                row += '<td>' + arrData[i]["prd2wh"] + '</td>';
                row += '<td>' + arrData[i]["q_rate"] + '</td>';
                row += '<td>' + arrData[i]["hour_qty"] + '</td>';
                row += '<td>' + arrData[i]["hour_qty_def"] + '</td>';
                row += '<td>' + arrData[i]["hour_qty_per"] + '</td>';
                row += '<td>' + arrData[i]["prd2sweg"] + '</td>';
                row += '<td>' + arrData[i]["prd2cwid"] + '</td>';
                row += '<td>' + arrData[i]["prd2swid"] + '</td>';
                row += '<td>' + arrData[i]["prd2cmould"] + '</td>';
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
                        <a href="#" id="btnExp" class="easyui-linkbutton" iconCls="icon-excel"  plain="false" onclick="Export('部門生產總表', $('#dg'));" style="width:120px;height:25px">匯出總表(本頁)</a>
                        <a href="#" id="A1" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(0)" style="width:120px;height:25px">匯出總表(全部)</a>
                        <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel(1)" style="width:120px;height:25px">匯出明細表</a>
                    </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblInv_date">生產日期</label>
                        <input size="10" type="text" id="txtNowDate_from" style="height:18px;width:120px" class="Wdate" onclick="WdatePicker({ lang: 'zh-cn', dateFmt: 'yyyy/MM/dd', readOnly: true, onpicking: txtNowDate_from_click })"//>
                        <input size="10" type="text" id="txtNowDate_to" style="height:18px;width:120px" class="Wdate" onclick="WdatePicker({ lang: 'zh-cn', dateFmt: 'yyyy/MM/dd', readOnly: true })"/>
                        <label for="lblBrand">部門</label>
                        <input type="text" class="easyui-validatebox" id="txtDep_from" name="txtDep_from" style="width:120px" onchange="setValue(this,txtDep_to)" />
                        <input type="text" class="easyui-validatebox" id="txtDep_to" name="txtDep_to" style="width:120px" />&nbsp; 
                    </div>
                    <div style="margin-bottom: 5px">
                        <div class="box1">
                        <label for="lblMo">制單編號</label>
                        <input type="text" class="easyui-validatebox" id="txtMo_from" name="txtMo_from" style="width:120px" onchange="setValue(this,txtMo_to)" />
                        <input type="text" class="easyui-validatebox" id="txtMo_to" name="txtMo_to" style="width:120px" />
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
