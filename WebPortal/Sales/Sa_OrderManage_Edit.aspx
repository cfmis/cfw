<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_OrderManage_Edit.aspx.cs" Inherits="WebPortal.Sales.Sa_OrderManage_Edit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
      
       <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
         <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>
        <%--<script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>--%>
          <%--<script type="text/javascript" src="../js/Sales/Js_SaOrderManage.js"></script>--%>

          <style type="text/css"> 
        .textbox { 
          height:20px;           margin:0; 
          padding:0 2px; 
          box-sizing:content-box;         }
          </style>

    <style>
        #tabs .tabs-panels>.panel>.panel-body {  
overflow: hidden;  
}  
        </style>

    <style type="text/css">
            table {
                /*为表格设置合并边框模型*/
                border-collapse: collapse;
                /*列宽由表格宽度和列宽度设定*/
                table-layout: fixed;
            }
            
            td {
                border: 1px solid #ddd;
                /*允许在单词内换行。*/
                word-break: break-word;
                /*设置宽度*/
                width: 100px;
            }
        </style>



    <script>
        var edit_mode = '0';
        $(function () {

            //$('#txtDate_from').textbox('textbox').attr('readonly', true);
            //$('#txtDate_to').textbox('textbox').attr('readonly', true);
            $('#dg1').datagrid({               //根据自身情况更改
                width: $(window).width() - 10,    //根据自身情况更改
                height: $(window).height() - 80  //根据自身情况更改
            });
            setLabelDesc();
            initControls();
            fillData();
            $("input", $("#txtDate_from").next("span")).blur(function () {
                $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));

            });
            $('#btnNew').click(function () {
                addNew();
            });
            $('#btnSave').click(function () {
                saveData();
            });

            $("#btnShowMat").click(function () {
                $('#showMatDialog').dialog('open').dialog('setTitle', '質地');

                //PopSetMat();
                //see();
            });
            $("#btnShowPrdType").click(function () {
                $('#showPrdTypeDialog').dialog('open').dialog('setTitle', '產品類型');

                //PopSetMat();
                //see();
            });

            $(window).resize(function () {
                $('#dg1').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 10,    //根据自身情况更改
                    height: $(window).height() - 80  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 10,      //根据自身情况更改
                    height: $(window).height() - 80   //根据自身情况更改
                });

                //$("#tabHead").css("height", $(window).height() - 10);
            });

            //onChangeDate(function(date) {
            //    $("#txtDate_to").textbox('setValue', date);
            //});
            //var uname = $("#txtUser").val();
            $("#selCust").combobox({
                valueField: 'custcode',
                textField: 'custcname',
                method: 'post',
                panelHeight: "auto",
                url: '../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=get_custuser',// + '&uname=' + uname,
                //queryParams: { "enterpriseId": eid, "hazardsGroupType": 1 },
                success: function (data) {
                    var val = $('#selCust').combobox("getData");
                    for (var item in val[0]) {
                        if (item == "groupName") {
                            $(this).combobox("select", val[0][item]);
                        }
                    }
                },
            });


            

        });
        
        function fixWidth(percent) {
            return document.body.clientWidth * percent; //这里你可以自己做调整  
        }

        function myformatter(date) {
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            var d = date.getDate();
            return y + '/' + (m < 10 ? ('0' + m) : m) + '/' + (d < 10 ? ('0' + d) : d);
        }

        function myparser(s) {
            if (!s) return new Date();
            var ss = (s.split('/'));
            var y = parseInt(ss[0], 10);
            var m = parseInt(ss[1], 10);
            var d = parseInt(ss[2], 10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
                return new Date(y, m - 1, d);
            } else {
                return new Date();
            }
        }

        function onChangeDate() {
            
            //var obj = document.getElementById('txtDate_from');
            //obj.textbox('setValue', date);
            //alert("选中的时间为：" + date);

            $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));
        }

        function fillData() {
            var id = GetQueryString("order_id");
            if (id != '' && id != null) {
                edit_mode = '0';
                $("#txtId").textbox('setValue', id);
                findDataById();
            }
            else
                edit_mode = '1';
        }

        function GetQueryString(name) {

            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");

            var r = window.location.search.substr(1).match(reg);

            if (r != null) return unescape(r[2]); return null;

        }
        //設置語言
        function setLabelDesc() {
            var AttributeGrid = "#dg";
            $.ajax({
                //url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=b",    //后台webservice里的方法名称  
                url: "../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=get_initInterface&formname=Sa_OrderManage_Edit&obj_type=lbl",
                type: "post",
                async: false,
                dataType: "json",
                contentType: "application/json",
                traditional: true,
                success: function (data) {

                    for (var i in data) {
                        var jsonObj = data[i];
                        var obj_id = jsonObj.obj_id;
                        var show_name = jsonObj.show_name;
                        switch (obj_id)
                        {
                            case 'custcode': $("#divCust_Code").html(show_name);
                                break;
                            case 'order_date': $("#divOrder_Date").html(show_name);
                                break;
                            case 'pono': $("#divPoNo").html(show_name);
                                break;
                            case 'btnnew_w': $("#divAdd").text(show_name);
                                break;
                            case 'btnsave_w': $("#divSave").text(show_name);
                                break;
                            case 'id': $("#divId").html(show_name);
                                break;
                            case 'custcode': $("#divCust_Code").html(show_name);
                                break;
                            case 'pono': $("#divPoNo").html(show_name);
                                break;
                            case 'own': $("#divOwn").html(show_name);
                                break;
                            case 'cust_item': $("#divCust_Item").html(show_name);
                                break;
                            case 'cust_color': $("#divCust_Color").html(show_name);
                                break;
                            case 'cust_size': $("#divCust_Size").html(show_name);
                                break;
                            case 'cust_style': $("#divCust_Style").html(show_name);
                                break;
                            case 'brand': $("#divBrand").html(show_name);
                                break;
                            case 'season': $("#divSeason").html(show_name);
                                break;
                            case 'order_qty': $("#divOrder_Qty").html(show_name);
                                break;
                            case 'unit': $("#divUnit").html(show_name);
                                break;
                            case 'req_date': $("#divReq_Date").html(show_name);
                                break;
                            case 'cust_item_cdesc': $("#divCust_Item_Cdesc").html(show_name);
                                break;
                            case 'cf_prd_item': $("#divCf_Prd_Item").html(show_name);
                                break;
                            case 'test_item': $("#divTest_Item").html(show_name);
                                break;
                            case 'cf_size': $("#divCf_Size").html(show_name);
                                break;
                            case 'packing': $("#divPacking").html(show_name);
                                break;
                            case 'cf_color': $("#divCf_Color").html(show_name);
                                break;
                        }

                        //if (obj_id == 'custcode')
                        //    $("#divCust_Code").html(show_name);
                        //if (obj_id == 'order_date')
                        //    $("#divOrder_Date").html(show_name);
                        //if (obj_id == 'pono')
                        //    $("#divPoNo").html(show_name);
                        //if (obj_id == 'btnnew_w')
                        //    $("#divAdd").text(show_name);
                        //if (obj_id == 'btnsave_w')
                        //    $("#divSave").text(show_name);
                    }
                },
                error: function (msg) {
                    //alert("出错了！");
                    if (edit_mode == '0')
                        alert(msg.responseText);
                    //alert(mo_id);
                }
            });
        };

        //設置下拉框數據來源，並默認選擇第1個
        function initControls() {
            //var uname = $("#txtUser").val();
            var url = '../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=get_custuser';//+ '&uname=' + uname;
            //$('#selCust').combobox('reload', url);

            $("#selCust").combobox({
                url: url,
                valueField: 'custcode',
                textField: 'custcname',
                hasDownArrow: true,
                editable: false,

                
                onLoadSuccess: function () {
                    var data = $(this).combobox("getData");
                    $('#selCust').combobox('select', data[0].custcode);
                   
                }
            });

        }

        //通過發票編號查找資料
        function findDataById() {
            if (document.getElementById('txtId').value == '')
                return;
            var id = document.getElementById('txtId').value;

            $.ajax({
                //url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=b",    //后台webservice里的方法名称  
                url: "../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=getorder_a&id=" + id,
                type: "post",
                dataType: "json",
                contentType: "application/json",
                traditional: true,
                success: function (data) {

                    for (var i in data) {
                        var jsonObj = data[i];
                        $("#txtOrderDate").textbox('setValue', jsonObj[0].order_date);
                        $("#txtPoNo").textbox('setValue', jsonObj[0].pono);
                        $("#txtOwn").textbox('setValue', jsonObj[0].own);
                        $("#txtCustItem").textbox('setValue', jsonObj[0].cust_item);
                        $("#txtCustColor").textbox('setValue', jsonObj[0].cust_color);
                        $("#txtCustSize").textbox('setValue', jsonObj[0].cust_size);
                        $("#txtCustItemCdesc").textbox('setValue', jsonObj[0].cust_item_cdesc);
                        $("#txtStyle").textbox('setValue', jsonObj[0].style);
                        $("#txtBrand").textbox('setValue', jsonObj[0].brand);
                        $("#txtOrderQty").textbox('setValue', jsonObj[0].order_qty);
                        $("#selUnit").textbox('setValue', jsonObj[0].unit);
                        $("#txtReqDate").textbox('setValue', jsonObj[0].req_date);
                        $("#txtTestItem").textbox('setValue', jsonObj[0].test_item);
                        $("#txtPack").textbox('setValue', jsonObj[0].packing);
                        $("#txtPrd_Item").textbox('setValue', jsonObj[0].prd_item);
                        $("#txtSize").textbox('setValue', jsonObj[0].size);
                        $("#txtColor").textbox('setValue', jsonObj[0].color);
                    }
                },
                error: function (msg) {
                    //alert("出错了！");
                    if (edit_mode == '0')
                        alert(msg.responseText);
                    //alert(mo_id);
                }
            });

        };


        //新增記錄
        function addNew() {
            var curr_time = new Date();
            $("#txtOrderDate").datebox("setValue", myformatter(curr_time));
            $("#txtId").textbox('setValue', '');
            //$("#txtOrderDate").textbox('setValue', '');
            $("#txtCustItem").textbox('setValue', '');
            $("#txtCustColor").textbox('setValue', '');
            $("#txtCustSize").textbox('setValue', '');
            $("#txtCustItemCdesc").textbox('setValue', '');
            $("#txtStyle").textbox('setValue', '');
            $("#txtBrand").textbox('setValue', '');
            $("#txtOrderQty").textbox('setValue', '');
            $("#selUnit").textbox('setValue', '');
            $("#txtTestItem").textbox('setValue', '');
            $("#txtPack").textbox('setValue', '');
            $("#txtReqDate").textbox('setValue', '');
            $("#txtPrd_Item").textbox('setValue', '');
            $("#txtSize").textbox('setValue', '');
            $("#txtColor").textbox('setValue', '');
            //$("#txtCustItem").focus();
            //document.getElementById("txtCustItem").focus();
            $('#txtCustItem').next('span').find('input').focus();
            edit_mode = '1';
        }

        //儲存記錄
        function saveData() {
            if (validData() == false)
                return;
            
            var json = [];

            var j = {};
            j.id = $("#txtId").textbox('getValue');
            j.custcode = $("#selCust").textbox('getValue');
            j.pono = document.getElementById('txtPoNo').value;
            j.order_date = $("#txtOrderDate").textbox('getValue');
            j.own = $("#txtOwn").textbox('getValue');
            j.cust_item = $("#txtCustItem").textbox('getValue');
            j.cust_color = $("#txtCustColor").textbox('getValue');
            j.cust_size = $("#txtCustSize").textbox('getValue');
            j.cust_item_cdesc = $("#txtCustItemCdesc").textbox('getValue');
            j.cust_style = $("#txtStyle").textbox('getValue');
            j.brand = $("#txtBrand").textbox('getValue');
            j.season = $("#selSeason").textbox('getValue');
            j.order_qty = $("#txtOrderQty").textbox('getValue');
            j.unit = $("#selUnit").textbox('getValue');
            j.req_date = $("#txtReqDate").textbox('getValue');
            j.test_item = $("#txtTestItem").textbox('getValue');
            j.packing = $("#txtPacking").textbox('getValue');
            j.cf_prd_item = $("#txtPrd_Item").textbox('getValue');
            j.cf_size = $("#txtSize").textbox('getValue');
            j.cf_color = $("#txtColor").textbox('getValue');
            json.push(j);



            var obja = JSON.stringify(json);


            //            异步提交数据

            $.ajax({
                url: "../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=update_order",
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                beforeSend: BefLoadFunction, //加载执行方法
                error: erryFunction, //错误执行方法
                success: LoadFunction

            });
            function succFunction(data) {
                edit_mode = '0';
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
                alert(data);
                //document.getElementById('btnFind').click();
            }
            function BefLoadFunction() {
                $("#ddd").html('加载中...');
            }
            function erryFunction() {
                alert("error");
            }


        }

        function validData() {
            if (document.getElementById('txtPoNo').value == '') {
                alert("Po No.不能為空!");
                $('#txtPoNo').textbox('textbox').focus();
                return false;
            }
            if (isInt(document.getElementById('txtOrderQty').value) == false) {
                alert("訂單數量必須為數值!");
                $('#txtOrderQty').textbox('textbox').focus();
                return false;
            }
        }

        //function isInt(value) {         //验证是否为数字
        //    var patrn = /^\+?[1-9][0-9]*$/;
        //    if (patrn.exec(value) == null || value == "") {
        //        return false
        //    } else {
        //        return true
        //    }
        //}

    </script>
    
    <script type="text/javascript">

        function showDetails1(index){  
                $('#dg').datagrid('selectRow',index);// 关键在这里  
                var row = $('#dg').datagrid('getSelected');  
                if (row){  

                    //window.showModelessDialog('../Sales/Sa_OrderTest_Invoice_Details.aspx?invoice_id=' + row.invoice_id,
                    //    'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');

                    var url = '../Sales/Sa_OrderTest_Invoice_Details.aspx?invoice_id=' + row.invoice_id;
                    var title = '編輯';
                    var width = 800;
                    var height = 500;
                    var shadow = true;
                    var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
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
                            document.getElementById('btnFind').onclick();
                        }
                    });
                    win.dialog('open');


                    }  
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
<%--    <div id="tabs" class="easyui-tabs">--%>
<%--	<div id="tabHead" title="訂單錄入">--%>

        <div>
            <a href="#" id="btnNew" class="easyui-linkbutton" iconCls="icon-add" plain="false" style="width:80px;height:25px"><div id="divAdd">新增</div></a>
            <a id="btnSave" href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:80px;height:25px"><div id="divSave">儲存</div></a>
            <hr />
        </div>

        <table border="1">
            <tr>
                <td style="width:12%">
                     <div id="divId" style="text-align:right">單據編號:</div>
                </td>
                <td style="width:18%">
                    <input type="text" id="txtId" class="easyui-textbox" style="width:90%" />
                </td>
                <td style="width:12%">
                    <div id="divCust_Code" style="text-align:right">客戶編號:</div>
                </td>
                <td style="width:23%">
                    <%--<select id="selCust" class="easyui-combobox" style="width:120px;height:22px" data-options="width:120, valueField: 'custcode', textField: 'custcname', url: '../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=get_custuser'" />--%>
                    <%--<select id="selCust" class="easyui-combobox" style="width:120px;height:22px" data-options="width:120, valueField: 'custcode', textField: 'custcname'" />--%>
                    <select id="selCust" class="easyui-combobox" style="width:90%;height:22px" />
                </td>
                <td style="width:12%"></td>
                <td style="width:23%"></td>
            </tr>
            <tr>
                <td style="width:12%">
                     <div id="divItem" style="text-align:right">產品編號:</div>
                </td>
                <td style="width:18%">
                    <input type="text" id="txtItem" class="easyui-textbox" style="width:90%" />
                </td>
                <td><button id="btnShowMat">質地</button></td>
                <td><button id="btnShowPrdType">產品類型</button></td>
            </tr>
            <tr>
                <td>
                    <div id="divPoNo" style="text-align:right">PO No.:</div>
                </td>
                <td>
                    <input type="text" id="txtPoNo" class="easyui-textbox" style="width:90%" />
                </td>
                <td>
                    <div id="divOrder_Date" style="text-align:right">訂單日期:</div>
                </td>
                <td>
                    <input id="txtOrderDate" runat="server" name="txtOrderDate" type="text" class="easyui-datebox" style="width:90%" data-options="formatter:myformatter,parser:myparser"/>
                </td>
                <td>
                    <div id="divOwn" style="text-align:right">洋行代號:</div>
                </td>
                <td>
                    <input type="text" id="txtOwn" class="easyui-textbox" style="width:90%" />
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divCust_Item" style="text-align:right">客人產品編號:</div>
                </td>
                <td>
                    <input type="text" id="txtCustItem" class="easyui-textbox" style="width:90%" />
                </td>
                <td>
                    <div id="divCust_Color" style="text-align:right">客人產品顏色:</div>
                </td>
                <td>
                    <input type="text" id="txtCustColor" class="easyui-textbox" style="width:90%" />
                </td>
                <td>
                    <div id="divCust_Size" style="text-align:right">客人產品尺寸:</div>
                </td>
                <td>
                    <input type="text" id="txtCustSize" class="easyui-textbox" style="width:90%" />
                </td>
            </tr>
            
            <tr>
                <td>
                    <div id="divCust_Style" style="text-align:right">產品款號:</div>
                </td>
                <td>
                    <input type="text" id="txtStyle" class="easyui-textbox" style="width:90%" />
                </td>
                <td>
                    <div id="divBrand" style="text-align:right">牌子編號:</div>
                </td>
                <td>
                    <input type="text" id="txtBrand" class="easyui-textbox" style="width:90%" />
                </td>
                <td>
                    <div id="divSeason" style="text-align:right">季度:</div>
                </td>
                <td>
                    <select id="selSeason" class="easyui-combobox" style="width:90%" data-options="valueField: 'id', textField: 'cdesc', url: '../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=get_season'" />
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divOrder_Qty" style="text-align:right">訂單數量:</div>
                </td>
                <td>
                    <input type="text" id="txtOrderQty" class="easyui-textbox" style="width:90%" />
                </td>
                <td>
                    <div id="divUnit" style="text-align:right">數量單位:</div>
                </td>
                <td>
                    <select id="selUnit" class="easyui-combobox" style="width:90%" data-options="valueField: 'unit_id', textField: 'unit_cdesc', url: '../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=get_unit'" />
                </td>
                <td>
                    <div id="divReq_Date" style="text-align:right">要求交貨期:</div>
                </td>
                <td>
                    <input id="txtReqDate" type="text" class="easyui-datebox" style="width:90%" data-options="formatter:myformatter,parser:myparser"/>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divCust_Item_Cdesc" style="text-align:right">產品詳細說明:</div>
                </td>
                <td colspan="3">
                    <input type="text" id="txtCustItemCdesc" class="easyui-textbox" style="width:96%" />
                </td>
                <td>
                    <div id="divCf_Prd_Item" style="text-align:right">CF Code:</div>
                </td>
                <td>
                    <input type="text" id="txtPrd_Item" class="easyui-textbox" style="width:90%" />
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divTest_Item" style="text-align:right">&nbsp;&nbsp;測試項目:</div>
                </td>
                <td colspan="3">
                    <input type="text" id="txtTestItem" class="easyui-textbox" style="width:96%" />
                </td>
                <td>
                    <div id="divCf_Size" style="text-align:right">CF尺寸:</div>
                </td>
                <td>
                    <input type="text" id="txtSize" class="easyui-textbox" style="width:90%" />
                </td>
            </tr>
            <tr>
                <td>
                    <div id="divPacking" style="text-align:right">&nbsp;&nbsp;&nbsp;&nbsp;包裝方法:</div>
                </td>
                <td colspan="3">
                    <input type="text" id="txtPacking" class="easyui-textbox" style="width:96%" />
                </td>
                <td>
                    <div id="divCf_Color" style="text-align:right">CF顏色:</div>
                </td>
                <td>
                    <input type="text" id="txtColor" class="easyui-textbox" style="width:90%" />
                </td>
            </tr>
            
        </table>
<%--        </div>


	</div>--%>

    <div id="showMatDialog" class="easyui-dialog" style="width: 600px; height:400px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <iframe src="../PublicWebForm/getMatCode.aspx" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
    </div>
    <div id="showPrdTypeDialog" class="easyui-dialog" style="width: 600px; height:500px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <iframe src="../PublicWebForm/getProdTypeCode.aspx" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
    </div>
    </div>
    </div>
</body>
</html>
