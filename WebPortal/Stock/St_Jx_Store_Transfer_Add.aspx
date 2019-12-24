<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="St_Jx_Store_Transfer_Add.aspx.cs" Inherits="WebPortal.Stock.St_Jx_Store_Transfer_Add" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>庫存物料交易錄入</title>

    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />

     <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
      <style>
          .easyui-textbox {
              width:180px;
              height:18px;
          }
          select {
              width:180px;
              height:18px;
          }
      </style>
       <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
         <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>
    <script type="text/javascript" src="../js/easyuiDatePicker.js"></script>
    <script>  
        var edit_mode = '0';//新增狀態
  
       //页面加载  
  
        $(function () {

            //设置时间  
            $("#txtTransfer_Date").datebox("setValue", changeDateToChar(new Date()));
            $("#selLoc_no").textbox('setValue', "J82");
            $("#txtPrd_mo").textbox('setValue', 'ZZZZZZZZZ');
            $("#txtLot_no").textbox('setValue', '0000000000');
            var request_no = getUrlParam("request_no");
            var loc_no = getUrlParam("loc_no");
            var request_qty = getUrlParam("request_qty");
            var request_weg = getUrlParam("request_weg");
            var prd_item = getUrlParam("prd_item");
            if (request_no != '' && request_no != null) {
                $("#txtRequestNo").textbox('setValue', request_no);
                $("#selLoc_no").textbox('setValue', loc_no);
                $("#txtQty").textbox('setValue', request_qty);
                $("#txtWeg").textbox('setValue', request_weg);
                $("#selFlag_id").textbox('setValue', "01");
                $("#txtPrd_item").textbox('setValue', prd_item);
            }

            $('#btnSave').click(function () {
                saveData();
            });
            $('#btnNew').click(function () {
                addNew();
            });
            $("input", $("#selFlag_id").next("span")).blur(function () {
                var Flag_id = $("#selFlag_id").textbox('getValue');
                if (Flag_id == '01')
                {
                    $("#selLoc_no").textbox('setValue', 'J82');
                }
                else if(Flag_id=='02')
                    $("#selLoc_no").textbox('setValue', '');
                $("#selWip_id").textbox('setValue', '');
            });

            $("input", $("#txtPrd_item").next("span")).blur(function () {
                findDataByPrd_item('prd_item');
                
            });
            $("input", $("#txtUse_item").next("span")).blur(function () {
                findDataByPrd_item('use_item');

            });

            $('#btnShowDlg').click(function () {
                var Loc_no = $('#selLoc_no').textbox('getValue');
                var url = '../Stock/St_Jx_Store_Summary.aspx?Transfer_flag=2&Loc_no=' + Loc_no;
                var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
                //content += '<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="javascript:$(' + '\'#ShowDialog\'' + ').dialog(' + '\'close\'' + ')">' + '关闭' + '</a>';
                $('#ShowStoreDialog').html(content);

                $('#ShowDialog').dialog('open').dialog('setTitle', '查詢庫存');
            });

            //var invoice_id = GetQueryString("invoice_id");
            var invoice_id = getUrlParam("invoice_id");
            if (invoice_id != '' && invoice_id != null) {
                edit_mode = '0';
                $("#txtInvoice_Id").textbox('setValue', invoice_id);
                findDataById();
            }
            else
                edit_mode = '1';
        });

        
        //function GetQueryString(name) {

        //    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");

        //    var r = window.location.search.substr(1).match(reg);

        //    if (r != null) return unescape(r[2]); return null;

        //}

        function addNew() {
            $("#txtPrd_mo").textbox('setValue', 'ZZZZZZZZZ'); 
            $("#txtPrd_item").textbox('setValue', '');
            $("#txtPrd_item_cdesc").textbox('setValue', '');
            $("#txtWeg").textbox('setValue', '');
            $("#txtQty").textbox('setValue', '');
            $("#txtLot_no").textbox('setValue', '0000000000');
            $("#selFlag_id").textbox('setValue', '');
            $("#selWip_id").textbox('setValue', '');
            $("#txtUse_item").textbox('setValue', '');
            $("#txtUse_item_cdesc").textbox('setValue', '');
            $("#txtRequestNo").textbox('setValue', '');
            edit_mode = '1';
        }

        //通過發票編號查找資料
        function findDataByPrd_item(item_type) {
            if (item_type == 'prd_item') {
                if (document.getElementById('txtPrd_item').value == '')
                    return;
                var Prd_item = document.getElementById('txtPrd_item').value;
            }
            else
            {
                if (document.getElementById('txtUse_item').value == '')
                    return;
                var Prd_item = document.getElementById('txtUse_item').value;
            }
            $.ajax({
                //url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=b",    //后台webservice里的方法名称  
                url: "../ashx/Ax_St_Jx_Store_Summary.ashx?paraa=get_prd_item&Prd_item=" + Prd_item,///GetPrdItem
                type: "post",
                dataType: "json",
                async: true,    //同步
                contentType: "application/json",
                traditional: true,
                success: function (data) {

                    for (var i in data) {
                        var jsonObj = data[i];
                        if (item_type == 'prd_item')
                            $("#txtPrd_item_cdesc").textbox('setValue', jsonObj.goods_name);
                        else
                            $("#txtUse_item_cdesc").textbox('setValue', jsonObj.goods_name);
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



        function saveData() {
            if (validData() == false)
                return;
            edit_mode = '0';
            var json = [];

            var j = {};
            j.Flag_id = $("#selFlag_id").textbox('getValue');
            j.Transfer_date = $("#txtTransfer_Date").textbox('getValue');
            j.Prd_mo = $("#txtPrd_mo").textbox('getValue');
            j.Prd_item = $("#txtPrd_item").textbox('getValue');
            j.Weg = $("#txtWeg").textbox('getValue');
            j.Qty = $("#txtQty").textbox('getValue');
            j.Lot_no = $("#txtLot_no").textbox('getValue');
            j.Loc_no = $("#selLoc_no").textbox('getValue');
            j.Wip_id = $("#selWip_id").textbox('getValue');
            j.Use_item = $("#txtUse_item").textbox('getValue');
            j.RequestNo = $("#txtRequestNo").textbox('getValue');
            json.push(j);



            var obja = JSON.stringify(json);


            //            异步提交数据

            $.ajax({
                url: "../ashx/Ax_St_Jx_Store_Summary.ashx/GetItem?paraa=update",
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
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
                alert(data);
                $("#txtWeg").textbox('setValue', '');
                $("#txtQty").textbox('setValue', '');
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
            if ($("#selFlag_id").textbox('getValue') == '') {
                alert("操作類型不能為空!");
                $('#selFlag_id').textbox('textbox').focus();
                return false;
            }
            if ($("#selLoc_no").textbox('getValue') == '') {
                alert("倉庫編號不能為空!");
                $('#txtLoc_no').textbox('textbox').focus();
                return false;
            }
            if ($("#txtPrd_item").val() == '') {
                alert("物料編號編號不能為空!");
                $('#txtPrd_item').textbox('textbox').focus();
                return false;
            }
            //如果是發貨時，要輸入收貨車間
            if ($("#selFlag_id").textbox('getValue') == '02') {
                if ($("#selWip_id").textbox('getValue') == '') {
                    alert("收貨車間不能為空!");
                    $('#selWip_id').textbox('textbox').focus();
                    return false;
                }
                if ($("#selLoc_no").textbox('getValue') == $("#selWip_id").textbox('getValue')) {
                    alert("發貨倉庫不能和收貨車間相同!");
                    $('#selWip_id').textbox('textbox').focus();
                    return false;
                }
            }
            //如果是庫存調整
            if ($("#selFlag_id").textbox('getValue') == '06') {
                if ($("#txtQty").val() != "" && !isNumber($("#txtQty").val())) {
                    alert("數量格式錯誤!");
                    $('#txtQty').textbox('textbox').focus();
                    return false;
                }
                if (!isNumber($("#txtWeg").val())) {
                    alert("重量格式錯誤!");
                    $('#txtWeg').textbox('textbox').focus();
                    return false;
                }
            }
            else
            {
                if ($("#txtQty").val() != "" && !isInt($("#txtQty").val())) {
                    alert("數量格式錯誤!");
                    $('#txtQty').textbox('textbox').focus();
                    return false;
                }
                if (!isFloatValue($("#txtWeg").val())) {
                    alert("重量格式錯誤!");
                    $('#txtWeg').textbox('textbox').focus();
                    return false;
                }
            }
        }


        //查詢庫存
        function showStore() {
            var Loc_no = $("#selLoc_no").textbox('getValue');
            var title = '查詢庫存';
            var url = '../Stock/St_Jx_Store_Summary.aspx?Transfer_flag=2&Loc_no=J03';// + Loc_no;
            var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
            var boarddiv = '<div id="msgwindow" title="' + title + '"></div>'//style="overflow:hidden;"可以去掉滚动条  
            $(document.body).append(boarddiv);
            var win = $('#msgwindow').dialog({
                content: content,
                width: 700,
                height: 500,
                modal: true,
                title: title,
                onClose: function () {
                    //$(this).dialog('destroy');//后面可以关闭后的事件  
                    //document.getElementById('btnSerach').click();
                }
            });
            win.dialog('open');
        }

        function closeWindow() {
            //window.opener = null;
            ////window.open(' ', '_self', ' ');
            //window.open('', '_self');
            //window.close();

            $('#ShowDialog').dialog('close');
            //$('msgwindow').dialog('close');
        }
        function parentCloseWindow()
        {
            window.parent.closeWindow();
        }
        function setPrd_item_value(Prd_item, prd_item_cdesc,prd_mo,lot_no)
        {
            $("#txtPrd_item").textbox('setValue', Prd_item);
            $("#txtPrd_item_cdesc").textbox('setValue', prd_item_cdesc);
            $("#txtPrd_mo").textbox('setValue', prd_mo);
            $("#txtLot_no").textbox('setValue', lot_no);
        }
        
</script>  


</head>
<body>
    <%--<div class="easyui-panel" title="新增/編輯" style="width:98%;padding:3px 3px">--%>
    <div class="easyui-panel" style="width:98%;padding:3px 3px">
        <div>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="parentCloseWindow()">关闭</a>
            <a id="btnNew" href="#" class="easyui-linkbutton" iconCls="icon-add" style="width:80px;height:25px">新增</a>
			<a id="btnSave" href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:80px;height:25px">儲存</a>
            <%--<a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnShowDlg1" style="width:100px;height:25px" onclick="showStore()">庫存</a>--%>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnShowDlg" style="width:80px;height:25px">庫存</a>
            <hr />
		</div>
        <table class="tb-transfer" border="0" style="width:100%">

            <tr>
                <td style="width:10%;text-align:right">操作類型:</td>
                <td style="width:23%;text-align:left"><input id="selFlag_id" name="selFlag_id" class="easyui-combobox" data-options="width:180, valueField: 'flag_id', textField: 'flag_desc', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_transfer_flag&parab=list'" /></td>
                <td style="width:10%;text-align:right">倉庫號:</td>
                <td style="width:23%;text-align:left">
                    <select id="selLoc_no" name="selLoc_no" class="easyui-combobox" data-options="width:180, valueField: 'id', textField: 'name', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_jx_dep&parab=list'" />
                </td>
                <td style="width:10%;text-align:right">日期:</td>
			    <td style="width:24%;text-align:left">
                <%--<input id="txtTransfer_Date" class="easyui-datebox" data-options="formatter:myformatter,parser:myparser"/>--%>
                <input id="txtTransfer_Date" class="easyui-datebox-expand"/>
                </td>

                

            </tr>
            <tr>
                <td style="text-align:right">物料編號:</td>
                <td style="text-align:left">
			    <input id="txtPrd_item" class="easyui-textbox" data-options="prompt:'輸入物料編號...'" maxlength="9"/>
                </td>
                <td style="text-align:right">物料描述:</td>
                <td style="text-align:left" colspan="3">
                    <input id="txtPrd_item_cdesc" class="easyui-textbox"/>
                </td>

            </tr>
            <tr>
                <td style="text-align:right">重量:</td>
                <td style="text-align:left">
                    <input id="txtWeg" class="easyui-textbox"/></td>
                <td style="text-align:right">數量:</td>
                <td style="text-align:left">
                    <input id="txtQty" class="easyui-textbox"/></td>
                <td style="text-align:right">來料單號:</td>
			    <td style="text-align:left">
			        <input id="txtRequestNo" class="easyui-textbox" data-options="prompt:'輸入來料申請單編號...'"/>
                </td>
            </tr>
            <tr>
                <td style="text-align:right">制單編號:</td>
			    <td style="text-align:left">
			    <input id="txtPrd_mo" class="easyui-textbox" data-options="prompt:'輸入制單編號...'"/>
                </td>
                <td style="text-align:right">批號:</td>
                <td style="text-align:left">
                    <input id="txtLot_no" class="easyui-textbox"/></td>
                
                <td style="text-align:right">收貨車間:</td>
                <td style="text-align:left"><select id="selWip_id" name="selWip_id" class="easyui-combobox" data-options="width:180, valueField: 'id', textField: 'name', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_jx_dep&parab=list'" /></td>
            </tr>
            <tr>
                <td style="text-align:right">用料編號:</td>
			    <td style="text-align:left">
			        <input id="txtUse_item" class="easyui-textbox" data-options="prompt:'輸入用料編號...'"/>
                </td>
                <td style="text-align:right">用料描述:</td>
                <td style="text-align:left" colspan="3">
                    <input id="txtUse_item_cdesc" class="easyui-textbox"/>
                </td>
            </tr>
        </table>

	</div>
    

    <div id="ShowDialog" class="easyui-dialog" style="width: 700px; height:500px; padding: 10px 10px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
        <%--<iframe src="../Stock/St_Jx_Store_Summary.aspx?Transfer_flag=2&Loc_no=J03" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>--%>
        <%--<a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="javascript:$('#ShowDialog').dialog('close')">关闭</a>--%>
    <div id="ShowStoreDialog" style="width: 650px; height:400px"">
    </div>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="javascript:$('#ShowDialog').dialog('close')">关闭</a>
    </div>
</body>
</html>
