$(document).ready(function() {
    "use strict";
    var mo = {
        init: function() {
            $('.download').click(function () {
                //mo.JsonToExcel();
                var data = $('#txt').val();
                if (data === '') {
                    return;
                }
                mo.JSONToCSVConvertor(data, true);
            });
        },
        //JsonToExcel:function()
        //{
        //    var json = [];
        //    var j = {};
        //    j.Date_from = $("#txtDate_from").val(),
        //    j.Date_to = $("#txtDate_to").val(),
        //    json.push(j);
        //    var obja = JSON.stringify(json);
        //    var url = "../ashx/Ax_Sa_LoadLandInv.ashx/GetItem"

        //    $.ajax({
        //        url: url,
        //        type: "post",
        //        data: { 'param': obja }, //参数
        //        datatype: "json",
        //        async: true,    //默認异步，要改為同步：true
        //        beforeSend: BefLoadFunction, //加载执行方法
        //        error: erryFunction, //错误执行方法
        //        success: LoadFunctionDetails

        //    });
        //},
        //LoadFunctionDetails: function(data)
        //{
        //    $('#txt').val(data);
        //    return;
        //},
        JSONToCSVConvertor: function(JSONData, ShowLabel) {
            var arrData = typeof JSONData !== 'object' ? JSON.parse(JSONData) : JSONData;
            var CSV = '';
            //if (ShowLabel) {
            //    var row = "";
            //    for (var index in arrData[0]) {
            //        row += index + ',';
            //    }
            //    row = row.slice(0, -1);
            //    CSV += row + '\r\n';
            //}
            //for (var i = 0; i < arrData.length; i++) {
            //    var row = "";
            //    for (var index in arrData[i]) {
            //        var arrValue = arrData[i][index] == null ? "" : '="' + arrData[i][index] + '"';
            //        row += arrValue + ',';
            //    }
            //    row.slice(0, row.length - 1);
            //    CSV += row + '\r\n';
            //}
            //if (CSV == '') {
            //    growl.error("Invalid data");
            //    return;
            //}


            var excel = '<table>';

            //设置表头
            var row = "<tr>";


            //------------用JASON的標頭作為EXCEL的表頭----------------

            //for (var name in arrData[0]) {
            //    //每个单元格都可以指定样式. eg color:red   生成出来的就是 红色的字体了.
            //    row += "<td style='color:red;text-align:center;'>" + name + '</td>';
            //}
            //------------用JASON的標頭作為EXCEL的表頭----------------

            row += '<td>' + '編號' + '</td>';
            row += '<td>' + '客戶編號' + '</td>';
            row += '<td>' + '客戶描述' + '</td>';
            row += '<td>' + '貨品名稱' + '</td>';
            row += '<td>' + '客戶產品編號' + '</td>';
            row += '<td>' + '發票數量' + '</td>';
            row += '<td>' + '單位' + '</td>';
            row += '<td>' + '頁數' + '</td>';
            row += '<td>' + '客戶顏色編號' + '</td>';
            row += '<td>' + '牌子編號' + '</td>';
            row += '<td>' + '季度' + '</td>';
            row += '<td>' + '金額HKD' + '</td>';
            row += '<td>' + '金額USD' + '</td>';
            row += '<td>' + '發票日期' + '</td>';
            row += '<td>' + '發票編號' + '</td>';
            row += '<td>' + '訂單日期' + '</td>';
            row += '<td>' + '物料中文描述' + '</td>';
            //列头结束
            excel += row + "</tr>";

            //设置数据
            for (var i = 0; i < arrData.length; i++) {

                //var mo_id = arrData[i]["mo_id"];

                var row = "<tr>";

                row += '<td>' + arrData[i]["goods_id"] + '</td>';
                row += '<td>' + arrData[i]["it_customer"] + '</td>';
                row += '<td>' + arrData[i]["cust_ename"] + '</td>';
                row += '<td>' + arrData[i]["goods_ename"] + '</td>';
                row += '<td>' + arrData[i]["customer_goods"] + '</td>';
                row += '<td>' + arrData[i]["u_invoice_qty"] + '</td>';
                row += '<td>' + arrData[i]["goods_unit"] + '</td>';
                row += '<td>' + arrData[i]["mo_id"] + '</td>';
                row += '<td>' + arrData[i]["customer_color_id"] + '</td>';
                row += '<td>' + arrData[i]["brand_id"] + '</td>';
                row += '<td>' + arrData[i]["season"] + '</td>';
                row += '<td>' + arrData[i]["amt_hkd"] + '</td>';
                row += '<td>' + arrData[i]["amt_usd"] + '</td>';
                row += '<td>' + arrData[i]["inv_dat"] + '</td>';
                row += '<td>' + arrData[i]["id"] + '</td>';
                row += '<td>' + arrData[i]["order_date"] + '</td>';
                row += '<td>' + arrData[i]["goods_cname"] + '</td>';
                excel += row + "</tr>";
            }
            //table结束
            excel += "</table>";

            CSV = excel;


            var fileName = "Result";
            if (mo.msieversion()) {
                var IEwindow = window.open();
                IEwindow.document.write(CSV);
                IEwindow.document.close();
                IEwindow.document.execCommand('SaveAs', true, fileName + ".xls");
                IEwindow.close();
            } else {
                //var uri = 'data:application/csv;charset=utf-8,' + escape(CSV);
                var uri = 'data:text/xls;charset=big5,\uFEFF' + encodeURI(CSV);
                var link = document.createElement("a");
                link.href = uri;
                link.style = "visibility:hidden";
                link.download = fileName + ".xls";
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            }
        },
        msieversion: function() {
            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");
            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./)) // If Internet Explorer, return version number
            {
                return true;
            } else { // If another browser,
                return false;
            }
            return false;
        },
        main: function() {
            mo.init();
        }
    };
    mo.main();
});
