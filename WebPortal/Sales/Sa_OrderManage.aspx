<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_OrderManage.aspx.cs" Inherits="WebPortal.Sales.Sa_OrderManage" %>

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
        <%--<script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>--%>
          <script type="text/javascript" src="../js/Sales/Js_SaOrderManage.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>


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


    <script>
        var edit_mode = '0';
        $(function () {

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
            $("#btnShowSize").click(function () {
                $('#showSizeDialog').dialog('open').dialog('setTitle', '產品尺寸');

                //PopSetMat();
                //see();
            });
            $("#btnShowClr").click(function () {
                $('#showClrDialog').dialog('open').dialog('setTitle', '產品顏色');

                //PopSetMat();
                //see();
            });
            $("#btnFromOrder").click(function () {
                $('#showOrderDialog').dialog('open').dialog('setTitle', '訂單資料');

                //PopSetMat();
                //see();
            });
            //$('#txtDate_from').textbox('textbox').attr('readonly', true);
            //$('#txtDate_to').textbox('textbox').attr('readonly', true);
            $('#dg').datagrid({               //根据自身情况更改
                width: $(window).width() - 10,    //根据自身情况更改
                height: $(window).height() - 280  //根据自身情况更改
            });
            //currentOper();
            initControls();
            setLabelDesc();
            setTableHead();
            $("input", $("#txtDate_from").next("span")).blur(function () {
                $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));

            });

            $(window).resize(function () {
                $('#dg').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 10,    //根据自身情况更改
                    height: $(window).height() - 280  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 10,      //根据自身情况更改
                    height: $(window).height() - 280   //根据自身情况更改
                });

                //$("#tabHead").css("height", $(window).height() - 10);
            });

            //onChangeDate(function(date) {
            //    $("#txtDate_to").textbox('setValue', date);
            //});
            var uname = $("#txtUser").val();
            $("#selCust").combobox({
                valueField: 'custcode',
                textField: 'custcname',
                method: 'post',
                panelHeight: "auto",
                url: '../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=get_custuser' + '&uname=' + uname,
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


        //動態
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

        function currentOper() {
            var name = !$("#input_name").val() ? "undefined" : $("#input_name").val();
            var version = !$("#input_version").val() ? "undefined" : $("#input_version").val();
            var url = "/UpgradeRS/dataController/getCurrentRs?name=" + name
                        + "&version=" + version;
            var tableHeader = ["pid", "selfuuid", "midname", "realname",
                    "moduleversion", "upgradetime"];
            var len = tableHeader.length;
            var temp = [];
            for (var i = 0; i < len; i++) {
                var obj = {
                    "field": tableHeader[i],
                    title: tableHeader[i],
                    width: 100
                }
                temp.push(obj);
            }
            getData(url, [temp]);
        }


        function getData(url, columns) {
            $("#dg").datagrid({
                //url: url,
                pagination: true,
                pageList: [30, 50, 100, 250, 500],
                pageSize: 30,
                fitColumns: true,
                rownumbers: true,
                singleSelect: true,
                columns: columns
            })
            var p = $("#dg").datagrid("getPager");
            $(p).pagination({
                pagePosition: "bottom",
                beforePageText: '第', // 页数文本框前显示的汉字
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
            });
            $(p).pagination("refresh", {
                pageNumber: 1
            })
        }

        //function setTableHead() {
        //    var AttributeGrid = "#dg"
        //    var as = $(AttributeGrid).datagrid("getColumnOption", "id");
        //    as.title = "子项 01";
        //    $('#dg').datagrid();
        //}

        //設置語言
        function setLabelDesc() {
            var AttributeGrid = "#dg";
            $.ajax({
                //url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=b",    //后台webservice里的方法名称  
                url: "../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=get_initInterface&formname=Sa_OrderManage&obj_type=lbl",
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
                        if (obj_id == 'custcode')
                            $("#divCust_Code").html(show_name);
                        if (obj_id == 'order_date')
                            $("#divOrder_Date").html(show_name);
                        if (obj_id == 'pono')
                            $("#divPoNo").html(show_name);
                        if (obj_id == 'btnnew_w')
                            $("#divAdd").text(show_name);
                        if (obj_id == 'btndel_w')
                            $("#divDelete").text(show_name);
                        if (obj_id == 'btnfind_w')
                            $("#divFind").text(show_name);
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
        //根據選擇的語言，設置表頭的描述
        function setTableHead() {
            var AttributeGrid = "#dg";
            $.ajax({
                //url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=b",    //后台webservice里的方法名称  
                url: "../ashx/Ax_SaOrderManage.ashx/GetItem?paraa=get_initInterface&formname=Sa_OrderManage&obj_type=dg",
                type: "post",
                async: false,
                dataType: "json",
                contentType: "application/json",
                traditional: true,
                success: function (data) {

                    for (var i in data) {
                        var jsonObj = data[i];
                        var as = $(AttributeGrid).datagrid("getColumnOption", jsonObj.obj_id);
                        if (as != null)
                            as.title = jsonObj.show_name;
                    }
                },
                error: function (msg) {
                    //alert("出错了！");
                    if (edit_mode == '0')
                        alert(msg.responseText);
                    //alert(mo_id);
                }
            });
            $('#dg').datagrid();
        };

        function closeWindow() {
            //window.opener = null;
            ////window.open(' ', '_self', ' ');
            //window.open('', '_self');
            //window.close();

            $('#showMatDialog').dialog('close');
        }

    </script>
    
    <script type="text/javascript">

        function showDetails1(index){  
                $('#dg').datagrid('selectRow',index);// 关键在这里  
                var row = $('#dg').datagrid('getSelected');  
                if (row){  

                    //window.showModelessDialog('../Sales/Sa_OrderTest_Invoice_Details.aspx?invoice_id=' + row.invoice_id,
                    //    'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');

                    var url = '../Sales/Sa_OrderManage_Edit.aspx?order_id=' + row.id;
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
        function addDetails() {

            window.showModelessDialog('../Sales/Sa_OrderTest_Invoice_Details.aspx',
                        'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');
            //location.href = "../Sales/Sa_OrderTest_Trace_Details.aspx";// + str;

            //showModalDialog('../Sales/Sa_OrderTest_Trace_Details.aspx', 'subpage', 'dialogWidth:1024px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');
            //$('#btnFind').click();
            //document.getElementById('btnFind').onclick();
        }

        //onclick = "showMessageDialog('../Sales/Sa_OrderManage_Edit.aspx','新增',800,500,true)"
        function showMessageDialog(url, title, width, height, shadow) {

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


        <table border="0">
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
                <td style="width:12%"><a href="#" id="btnFromOrder" class="easyui-linkbutton" iconCls="icon-add" plain="false" style="width:160px;height:25px">從已有訂單</a></td>
                <td style="width:23%"></td>
            </tr>
            <tr>
                <td style="width:12%">
                     <div id="divItem" style="text-align:right">產品編號:</div>
                </td>
                <td style="width:18%">
                    <input type="text" id="txtItem" class="easyui-textbox1" style="width:90%" />
                </td>
                <td><a href="#" id="btnShowMat" class="easyui-linkbutton" iconCls="icon-add" plain="false" style="width:80px;height:25px">質地</a></td>
                <td><a href="#" id="btnShowPrdType" class="easyui-linkbutton" iconCls="icon-add" plain="false" style="width:80px;height:25px">產品類型</a></td>
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
                    <input type="text" id="txtSize" class="easyui-textbox" style="width:70%" />
                    <a href="#" id="btnShowSize" class="easyui-linkbutton" iconCls="icon-add" plain="false" style="width:80px;height:25px">尺寸</a>
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
                    <input type="text" id="txtColor" class="easyui-textbox" style="width:70%" />
                    <a href="#" id="btnShowClr" class="easyui-linkbutton" iconCls="icon-add" plain="false" style="width:80px;height:25px">顏色</a>
                </td>
            </tr>
            
        </table>


        <%--<div>--%>
        <%--<table style="width:100%" border="0">
           <tr>
               <td colspan="4">
                   <a href="#" id="btnNew" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="showMessageDialog('../Sales/Sa_OrderManage_Edit.aspx','新增',800,500,true)" style="width:80px;height:25px"><div id="divAdd">新增</div></a>
                   <a href="#" id="btnDelete" class="easyui-linkbutton"iconCls="icon-remove"  plain="false" onclick="oobj.removed()" style="width:80px;height:25px"><div id="divDelete">删除</div></a> 
                   <a href="#" id="btnFind" class="easyui-linkbutton" iconCls="icon-search"  plain="false" onclick="oobj.search()" style="width:80px;height:25px"><div id="divFind">查询</div></a>
               </td>
           </tr>
           <tr>
               <td style="width:5%">
                   <div id="divCust_Code" style="text-align:right">客戶編號:</div>
                </td>
               <td style="width:10%">
                   <select id="selCust" class="easyui-combobox" data-options="width:160" />
               </td>
               <td style="width:5%">
                       <div id="divOrder_Date" style="text-align:right">訂單日期:</div>
                </td>
               <td style="width:25%">
                       <input id="txtDate_from" name="txtDate_from" type="text" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser,onSelect:onChangeDate"/>
                       <input id="txtDate_to" name="txtDate_to" type="text" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser"/>
                </td>
               <td style="width:5%">
               <div id="divPoNo" style="text-align:right">PO No.:</div>
                </td>
               <td style="width:10%">
               <input id="txtPoNo" type="text" class="easyui-textbox" />
                
               </td>
               <td style="width:40%"></td>
          </tr>

         </table>--%>

        <%--</div>--%>

        <table id="dg" padding-left: 200px;" >


            </table>

        </div>
    </div>

    <div id="showMatDialog" class="easyui-dialog" style="width: 600px; height:400px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <iframe src="../PublicWebForm/getMatCode.aspx" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
    </div>
    <div id="showPrdTypeDialog" class="easyui-dialog" style="width: 600px; height:500px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <iframe src="../PublicWebForm/getProdTypeCode.aspx" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
    </div>
    <div id="showSizeDialog" class="easyui-dialog" style="width: 600px; height:500px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <iframe src="../PublicWebForm/getSizeCode.aspx" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
    </div>
    <div id="showClrDialog" class="easyui-dialog" style="width: 600px; height:500px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <iframe src="../PublicWebForm/getClrCode.aspx" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
    </div>
    <div id="showOrderDialog" class="easyui-dialog" style="width: 600px; height:500px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <iframe src="../PublicWebForm/getOrder.aspx" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
    </div>
</body>
</html>
