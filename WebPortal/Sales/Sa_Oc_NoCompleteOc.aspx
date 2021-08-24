<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Oc_NoCompleteOc.aspx.cs" Inherits="WebPortal.Sales.Sa_Oc_NoCompleteOc" %>

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
        <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
          <script type="text/javascript" src="../js/Sales/Js_Oc_NoCompleteOc.js"></script>
        <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>

          <style type="text/css"> 
        .textbox { 
          height:20px;           margin:0; 
          padding:0 2px; 
          box-sizing:content-box;         }
          </style>



    <script>

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }

        $(function () {

            //$('#txtDate_from').textbox('textbox').attr('readonly', true);
            //$('#txtDate_to').textbox('textbox').attr('readonly', true);
            $('#dg').datagrid({               //根据自身情况更改
                width: $(window).width() - 10,    //根据自身情况更改
                height: $(window).height() - 180  //根据自身情况更改
            });

            $("input", $("#txtDate_from").next("span")).blur(function () {
                $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));

            });

            $("button").click(function(){  
                             var box= $("#dg");  
                             var text="height="+box.height()+"<br/>"  
                                     +"width="+box.width()+"<br/>"  
                                     +"innerWidth="+box.innerWidth()+"<br/>"  
                                     +"innerHeight="+box.innerHeight()+"<br/>"  
                                     +"outerWidth="+box.outerWidth()+"<br/>"  
                                     +"outerHeight="+box.outerHeight()+"<br/>";  
                              $("p").append(text);  
            })


            $(window).resize(function () {
                $('#dg').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 10,    //根据自身情况更改
                    height: $(window).height() - 180  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 10,      //根据自身情况更改
                    height: $(window).height() - 180   //根据自身情况更改
                });
            });

            //onChangeDate(function(date) {
            //    $("#txtDate_to").textbox('setValue', date);
            //});
        //    $('#txtMo_from').textbox({
        //            onChange: function(value) {
        //                //fee();
        //                $("#txtMo_to").textbox('setValue', value);
        //            }
        //});
            $("input", $("#txtMo_from").next("span")).keyup(function (event) {
                //var v = $('#txtMo_from').next().children().val();
                $("#txtMo_to").textbox('setValue', $('#txtMo_from').next().children().val());
                //alert(v);
            });
            $("input", $("#txtMo_from").next("span")).keyup(function (event) {
                $("#txtMo_to").textbox('setValue', $('#txtMo_from').next().children().val());
                //alert(v);
            });
            $("input", $("#txtDate_from").next("span")).keyup(function (event) {
                var obj = $('#txtDate_from').next().children();
                var v = $('#txtDate_from').next().children().val();
                $("#txtDate_to").textbox('setValue', v);
                //alert(v);
            });
            $("#chkShowA_part").prop("checked", true);//設置复選框默認選中
            $("#selShowPeriod").textbox('setValue', '03');
            //$('#selShowPeriod').combobox('setValues', ['001', '002']);
            //$("input", $("#selMo_group").next("span")).keyup(function (event) {
            //    var v = $('#selMo_group').next().children().val();
            //    alert(v);
            //});
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
        function onChangeBrand() {

            //var obj = document.getElementById('txtDate_from');
            //obj.textbox('setValue', date);
            //alert("选中的时间为：" + date);

            $("#txtBrand_to").textbox('setValue', $("#txtBrand_from").textbox('getValue'));
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


    <script>


        function JsonToExcel() {

            var json = [];
            var j = {};
            j.period_type = $("#selShowPeriod").textbox("getValue");
            j.crdate1 = document.getElementById('crDate_from').value;
            j.crdate2 = document.getElementById('crDate_to').value;
            j.date1 = document.getElementById('txtDate_from').value;
            j.date2 = document.getElementById('txtDate_to').value;
            j.mo1 = $("#txtMo_from").textbox('getValue');
            j.mo2 = $("#txtMo_to").textbox('getValue');
            j.crby = $("#txtCrBy").textbox('getValue');
            j.mo_group = $("#selMo_group").textbox("getValue");
            j.cust1 = $("#txtCust").textbox('getValue');
            j.brand1 = $("#txtBrand").textbox('getValue');
            j.pono = $("#txtPoNo").textbox('getValue');
            j.agent1 = $("#txtAgent1").textbox('getValue');
            j.season = $("#txtSeason").textbox('getValue');
            j.ocno = $("#txtOcNo").textbox('getValue');
            j.goods_id = $("#txtGoods_id").textbox('getValue');
            j.cust_style = $("#txtCust_Style").textbox('getValue');
            j.cs_date1 = document.getElementById('txtReqDate_from').value;
            j.cs_date2 = document.getElementById('txtReqDate_to').value;
            j.cust_goods = $("#txtCust_Goods").textbox('getValue');
            j.cust_color = $("#txtCust_Color").textbox('getValue');
            //獲取Checkbox的選取值
            var obj = document.getElementsByName('chkShowA_part');
            j.only_apart_chk = obj[0].checked;
            json.push(j);
            var obja = JSON.stringify(json);


            $.ajax({
                url: "../ashx/Ax_Oc_NoCompleteOc_New.ashx/GetItem?paraa=get_data",
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
                //alert(data);
                closeLoadingWindow();
                var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
                var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
                var l = $('<input type="hidden" id="txtName" name="txtName" />');
                var dataJson = JSON.parse(data);
                i.val(JSONToExcelConvertor("我的excel", dataJson));
                i.appendTo(f);
                l.val('Oc未完成報表');
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
                alert(data);
            }


            //var json =
            //                '[' +
            //                '{"申请流水号":"123456","保险公司":"测试数据","发票抬头":"测试数据","发票金额":4,"联系人":"小明","联系人手机号":"1234563333","申请状态":"开票成功"},' +
            //                '{"申请流水号":"123456","保险公司":"测试数据","发票抬头":"测试数据","发票金额":4,"联系人":"小明","联系人手机号":"1234563333","申请状态":"开票成功"},' +
            //                '{"申请流水号":"123456","保险公司":"测试数据","发票抬头":"测试数据","发票金额":4,"联系人":"小明","联系人手机号":"1234563333","申请状态":"开票成功"},' +
            //                '{"申请流水号":"123456","保险公司":"测试数据","发票抬头":"测试数据","发票金额":4,"联系人":"小明","联系人手机号":"1234563333","申请状态":"开票成功"},' +
            //                '{"申请流水号":"123456","保险公司":"测试数据","发票抬头":"测试数据","发票金额":4,"联系人":"小明","联系人手机号":"1234563333","申请状态":"开票成功"},' +
            //                '{"申请流水号":"123456","保险公司":"测试数据","发票抬头":"测试数据","发票金额":4,"联系人":"小明","联系人手机号":"1234563333","申请状态":"开票成功"},' +
            //                '{"申请流水号":"123456","保险公司":"测试数据","发票抬头":"测试数据","发票金额":4,"联系人":"小明","联系人手机号":"1234563333","申请状态":"开票成功"},' +
            //                '{"申请流水号":"123456","保险公司":"测试数据","发票抬头":"测试数据","发票金额":4,"联系人":"小明","联系人手机号":"1234563333","申请状态":"开票成功"},' +
            //                '{"申请流水号":"123456","保险公司":"测试数据","发票抬头":"测试数据","发票金额":4,"联系人":"小明","联系人手机号":"1234563333","申请状态":"开票成功"},' +
            //                '{"申请流水号":"123456","保险公司":"测试数据","发票抬头":"测试数据","发票金额":4,"联系人":"小明","联系人手机号":"1234563333","申请状态":"开票成功"}' +
            //                ']';
            //var dataJson = JSON.parse(json);

            ////调用方法
            //JSONToExcelConvertor("我的excel", dataJson);


            //var f = $('<form action="../ExportToExcel.aspx" method="post" id="fm1"></form>');
            //var i = $('<input type="hidden" id="txtContent" name="txtContent" />');
            //var l = $('<input type="hidden" id="txtName" name="txtName" />');
            //i.val(JSONToExcelConvertor("我的excel", dataJson));
            ////i.val("abc");
            //i.appendTo(f);
            //l.val('abc');
            //l.appendTo(f);
            //f.appendTo(document.body).submit();
            ////document.body.removeChild(f);
            ////f.submit();
            ////document.body.removeChild(f.get(0));
            //$(document.body).remove("form:last");

        }


        function JSONToExcelConvertor(fileName, jsonData) {
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
            row += '<td>' + '開單日期' + '</td>';
            row += '<td>' + '訂單日期' + '</td>';
            row += '<td>' + '產品編號' + '</td>';
            row += '<td>' + '產品描述' + '</td>';
            row += '<td>' + '未完成貨品' + '</td>';
            row += '<td>' + '訂單數量(PCS)' + '</td>';
            row += '<td>' + '實際回港數量(PCS)' + '</td>';
            row += '<td>' + '客人要求交貨期' + '</td>';
            row += '<td>' + '計劃回港日期' + '</td>';
            row += '<td>' + '實際回港日期' + '</td>';
            row += '<td>' + '計劃生產數量(PCS)' + '</td>';
            row += '<td>' + '完成數量(PCS)' + '</td>';
            row += '<td>' + '要求包裝日期' + '</td>';
            row += '<td>' + '包裝實際完成日期' + '</td>';
            row += '<td>' + '過期天數' + '</td>';
            row += '<td>' + '負責部門' + '</td>';
            row += '<td>' + '收貨部門' + '</td>';
            row += '<td>' + '生產備註' + '</td>';
            row += '<td>' + 'OC編號' + '</td>';
            row += '<td>' + '產品編號A件' + '</td>';
            row += '<td>' + '訂單數量' + '</td>';
            row += '<td>' + '數量單位' + '</td>';
            row += '<td>' + '單價' + '</td>';
            row += '<td>' + '單價單位' + '</td>';
            row += '<td>' + '貨幣代號' + '</td>';
            row += '<td>' + '客戶編號' + '</td>';
            row += '<td>' + '客戶描述' + '</td>';
            row += '<td>' + '牌子編號' + '</td>';
            row += '<td>' + '洋行代號' + '</td>';
            row += '<td>' + '開單人' + '</td>';
            row += '<td>' + '組別' + '</td>';
            row += '<td>' + '顏色描述' + '</td>';
            row += '<td>' + '顏色做法' + '</td>';
            row += '<td>' + '客人產品編號' + '</td>';
            row += '<td>' + '客人產品顏色' + '</td>';
            row += '<td>' + '季度' + '</td>';
            row += '<td>' + '客戶PO' + '</td>';
            row += '<td>' + '客戶款號' + '</td>';
            row += '<td>' + '補正單頁數' + '</td>';

            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["create_date"] + '</td>';
                row += '<td>' + arrData[i]["order_date"] + '</td>';
                row += '<td>' + arrData[i]["goods_id"] + '</td>';
                row += '<td>' + arrData[i]["goods_name"] + '</td>';
                row += '<td>' + arrData[i]["wp_goods_id"] + '</td>';
                row += '<td>' + arrData[i]["qty_pcs"] + '</td>';
                row += '<td>' + arrData[i]["act_to_hk_qty"] + '</td>';
                row += '<td>' + arrData[i]["cs_req_date"] + '</td>';
                row += '<td>' + arrData[i]["hk_req_date"] + '</td>';
                row += '<td>' + arrData[i]["act_to_hk_date"] + '</td>';
                row += '<td>' + arrData[i]["prod_qty"] + '</td>';
                row += '<td>' + arrData[i]["c_qty_ok"] + '</td>';
                row += '<td>' + arrData[i]["t_complete_date"] + '</td>';
                row += '<td>' + arrData[i]["f_complete_date"] + '</td>';
                row += '<td>' + arrData[i]["period_day"] + '</td>';
                row += '<td>' + arrData[i]["wp_id"] + '</td>';
                row += '<td>' + arrData[i]["next_wp_id"] + '</td>';
                row += '<td>' + arrData[i]["production_remark"] + '</td>';
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["goods_id_part"] + '</td>';
                row += '<td>' + arrData[i]["order_qty"] + '</td>';
                row += '<td>' + arrData[i]["goods_unit"] + '</td>';
                row += '<td>' + arrData[i]["unit_price"] + '</td>';
                row += '<td>' + arrData[i]["p_unit"] + '</td>';
                row += '<td>' + arrData[i]["m_id"] + '</td>';
                row += '<td>' + arrData[i]["cust_code"] + '</td>';
                row += '<td>' + arrData[i]["cust_cname"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["agent"] + '</td>';
                row += '<td>' + arrData[i]["create_by"] + '</td>';
                row += '<td>' + arrData[i]["mo_group"] + '</td>';
                row += '<td>' + arrData[i]["color_name"] + '</td>';
                row += '<td>' + arrData[i]["do_color"] + '</td>';
                row += '<td>' + arrData[i]["customer_goods"] + '</td>';
                row += '<td>' + arrData[i]["customer_color_id"] + '</td>';
                row += '<td>' + arrData[i]["season"] + '</td>';
                row += '<td>' + arrData[i]["contract_id"] + '</td>';
                row += '<td>' + arrData[i]["table_head"] + '</td>';
                row += '<td>' + arrData[i]["repair_mo_id"] + '</td>';
                ////循環將JASON中的記錄傳入EXCEL
                //for (var index in arrData[i]) {

                //    var value = arrData[i][index] === "." ? "" : arrData[i][index];

                //    row += '<td style="text-align:center;">' + value + '</td>';//将值放入td
                //}
                ////循環將JASON中的記錄傳入EXCEL

                //将td 放入tr,将tr放入table
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            return excel;
            // #endregion


            //// #region 拼接html

            //var excelFile = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:excel' xmlns='http://www.w3.org/TR/REC-html40'>";
            //excelFile += '<meta http-equiv="content-type" content="application/vnd.ms-excel"; charset="UTF-8">';
            //excelFile += '<meta http-equiv="content-type" content="application/vnd.ms-excel"';
            //excelFile += '; charset="UTF-8">';
            //excelFile += "<head>";
            //excelFile += "<!--[if gte mso 9]>";
            //excelFile += "<xml>";
            //excelFile += "<x:ExcelWorkbook>";
            //excelFile += "<x:ExcelWorksheets>";
            //excelFile += "<x:ExcelWorksheet>";
            //excelFile += "<x:Name>";
            //excelFile += "{worksheet}";
            //excelFile += "</x:Name>";
            //excelFile += "<x:WorksheetOptions>";
            //excelFile += "<x:DisplayGridlines/>";
            //excelFile += "</x:WorksheetOptions>";
            //excelFile += "</x:ExcelWorksheet>";
            //excelFile += "</x:ExcelWorksheets>";
            //excelFile += "</x:ExcelWorkbook>";
            //excelFile += "</xml>";
            //excelFile += "<![endif]-->";
            //excelFile += "</head>";
            //excelFile += "<body>";
            //excelFile += excel;//将table 拼接
            //excelFile += "</body>";
            //excelFile += "</html>";

            

            //// #endregion

            //var uri = 'data:application/vnd.ms-excel;charset=utf-8,' + encodeURIComponent(excelFile);

            ////创建a标签
            //var link = document.createElement("a");
            ////指定url
            //link.href = uri;
            ////设置为隐藏
            //link.style = "visibility:hidden";
            ////指定文件名和文件后缀格式
            //link.download = fileName + ".xls";
            ////追加a标签
            //document.body.appendChild(link);
            ////触发点击事件
            //link.click();
            ////移除a标签
            //document.body.removeChild(link);
        }



    </script>
    


</head>
<body>
    <div id="container">  

    <div id="content"> 

    <form id="form1" runat="server">

    
        
       <%--<div title="訂單測試記錄"style="padding: 10px">  --%>
           
           <%--<form runat="server">--%>
        <div class="div_search_frame">

            <table style="width:1450px" border="0">
                    <tr>
                        <td colspan="4">
                            <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="addDetails()" style="width:80px;height:25px">新增</a>--%>
                           <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="showMessageDialog('../Sales/Sa_OrderTest_Invoice_Details.aspx','新增',800,500,true)" style="width:80px;height:25px">新增</a>
                           <a href="#" class="easyui-linkbutton"iconCls="icon-remove"  plain="false" onclick="oobj.removed()">删除</a> --%>
                           <a href="#" id="btnFind" class="easyui-linkbutton" iconCls="icon-search"  plain="false" onclick="oobj.search()" style="width:80px;height:25px">查询</a>
                           <a href="#" id="btnExp" class="easyui-linkbutton" iconCls="icon-excel"  plain="false" onclick="Export('Oc未完成報表', $('#dg'));" style="width:80px;height:25px">匯出本頁</a>
                            <a href="#" id="btnExpAll" class="easyui-linkbutton" runat="server" iconCls="icon-excel"  plain="false" onclick="JsonToExcel()" style="width:80px;height:25px">匯出全部</a>
                           <%--<a href="#" class="easyui-linkbutton" onclick="Export('訂單測試發票資料', $('#dg'));" iconCls="icon-save" plain="true" title="导出excel文件"></a>--%>
                           <%--<a href="#" class="easyui-linkbutton" onclick="return Save_Excel()" iconCls="icon-save" plain="true" title="导出excel文件"></a>--%>
                           <%--<asp:Button ID="btnExpToExcel1" Width="80px" Height="25px" runat="server" Text="Excel" OnClick="btnExpToExcel_Click" />--%>
                        </td>
                    </tr>
                   <tr style="height:25px">

                       <td style="width:25%">
                            訂單日期:
                           <input size="10" type="text" id="txtDate_from" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})" onchange="setValue(this,txtDate_to)"/>
                           <input size="10" type="text" id="txtDate_to" style="height:18px;width:120px" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                            <%--<input id="txtDate_from" runat="server" name="txtDate_from" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser,onSelect:onChangeDate"/>
                           <input id="txtDate_to" runat="server" name="txtDate_to" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/>--%>
                       </td>
                       <td style="width:25%">
                            開單日期:
                           <input size="10" type="text" id="crDate_from" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})" onchange="setValue(this,crDate_to)"/>
                           <input size="10" type="text" id="crDate_to" style="height:18px;width:120px" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                       </td>
                       <td style="width:25%">
                            客人要求交貨期:
                           <input size="10" type="text" id="txtReqDate_from" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})" onchange="setValue(this,txtReqDate_to)"/>
                           <input size="10" type="text" id="txtReqDate_to" style="height:18px;width:120px" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                       </td>
                       <td style="width:25%">
                           
                       </td>
                   </tr>
                   <tr style="height:25px">
                       <td>
                           制單編號:
                        <input id="txtMo_from" type="text" class="easyui-textbox" name="txtMo_from" style="width:120px;height:20px" data-options="formatter:myformatter,parser:myparser,onSelect:onChangeBrand" />
                        <input id="txtMo_to" type="text" class="easyui-textbox" name="txtMo_to" style="width:120px;height:20px" />
                       </td>
                       <td style="width:25%">
                           &nbsp;&nbsp;開單人:
                            <input id="txtCrBy" type="text" class="easyui-textbox" name="txtCrBy" style="width:120px;height:20px" />
                           &nbsp;&nbsp;&nbsp;&nbsp;組別:
                           <select id="selMo_group" name="selMo_group" class="easyui-combobox" style="width:120px;height:22px" data-options="width:80, valueField: 'mo_group', textField: 'mo_group', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_mogroup&parab=list'" />
                        </td>
                       <td style="width:10%">
                           客戶編號:
                            <input id="txtCust" type="text" class="easyui-textbox" name="txtCust" style="width:120px;height:20px" />
                           客戶PO:
                            <input id="txtPoNo" type="text" class="easyui-textbox" name="txtPoNo" style="width:120px;height:20px" />
                           
                        </td>
                       <td>
                           
                       </td>
                       
                       
                </tr>
                   <tr>
                       <td style="width:25%">
                           牌子編號:
                            <input id="txtBrand" type="text" class="easyui-textbox" name="txtBrand" style="width:120px;height:20px" />
                           洋行代號:
                            <input id="txtAgent1" type="text" class="easyui-textbox" name="txtAgent1" style="width:120px;height:20px" />
                        </td>
                       <td style="width:25%">
                           OC編號:
                            <input id="txtOcNo" type="text" class="easyui-textbox" name="txtOcNo" style="width:120px;height:20px" />
                           客人款號:
                            <input id="txtCust_Style" type="text" class="easyui-textbox" name="txtCust_Style" style="width:120px;height:20px" />
                        </td>
                       <td>
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;季度:
                            <input id="txtSeason" type="text" class="easyui-textbox" name="txtSeason" style="width:120px;height:20px" />
                        </td>
                       
                   </tr>
                   <tr>
                       <td>
                           產品編號:
                            <input id="txtGoods_id" type="text" class="easyui-textbox" name="txtGoods_id" style="width:200px;height:20px" />
                       </td>
                       <td>
                           客人產品編號:
                            <input id="txtCust_Goods" type="text" class="easyui-textbox" name="txtGoods_id" style="width:200px;height:20px" />
                       </td>
                       <td colspan="2">
                           客人產品顏色:
                            <input id="txtCust_Color" type="text" class="easyui-textbox" name="txtGoods_id" style="width:200px;height:20px" />
                       </td>
                   </tr>
                   <tr>
                       
                       <td>
                           是否顯示過期單:
                           <select id="selShowPeriod" name="selShowPeriod" class="easyui-combobox" style="width:260px;height:22px" data-options="width:80, valueField: 'flag_id', textField: 'flag_desc', url: '../ashx/Base_Select.ashx/GetItem?paraa=getSa_Oc_NoCompleteOc&parab=list'" />
                       </td>
                       <td>
                           <div class="checkbox">
		                    <label>
			                    <input runat="server" id="chkShowA_part" type="checkbox"/>只顯示A件
		                    </label>
	                        </div>
                           
                       </td>
                       <td>
                           <div id="divShowLoadMsg" style="color:blue">

                           </div>
                       </td>
                   </tr>
               </table>
    </div>
    <%--</form>--%>
           

  <table id="dg" padding-left: 200px;" >


            </table>  
            <%--<div id="tb">
                
                
   
        </div>--%>

        </form>
        </div>
        </div>
</body>
</html>
