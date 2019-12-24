<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bs_Mat_Rate_Add.aspx.cs" Inherits="WebPortal.Bs.Bs_Mat_Rate_Add" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>測試報告發票錄入</title>

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

    <script>  
        var edit_mode = '0';//新增狀態
      function myformatter(date){  
           var y = date.getFullYear();  
           var m = date.getMonth()+1;  
            var d = date.getDate();  
            return y+'/'+(m<10?('0'+m):m)+'/'+(d<10?('0'+d):d);  
        }  
          
        function myparser(s){  
            if (!s) return new Date();  
            var ss = (s.split('/'));  
            var y = parseInt(ss[0],10);  
            var m = parseInt(ss[1],10);  
            var d = parseInt(ss[2],10);  
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)){  
                return new Date(y,m-1,d);  
            } else {  
                return new Date();  
            }  
        }  
  
       //页面加载  
  
        $(function () {

            //设置时间  
            var curr_time = new Date();
            $("#txtTransfer_Date").datebox("setValue", myformatter(curr_time));
            $("#selLoc_no").textbox('setValue', "J00");
            //$('#txtId').textbox('textbox').attr('readonly', true);

            $('#btnSave').click(function () {
                saveData();
            });
            $('#btnNew').click(function () {
                addNew();
            });
            $('#btnDelete').click(function () {
                deleteData();
            });
            $("input", $("#txtPrd_item").next("span")).blur(function () {
                getPrd_item_desc('prd_item');
                getExistPrd_item();
            });
            $("input", $("#txtMat_item").next("span")).blur(function () {
                getPrd_item_desc('mat_item');

            });
            //var invoice_id = GetQueryString("invoice_id");
            var Dep_id = getUrlParam("Dep_id");
            var Prd_item = getUrlParam("Prd_item");
            var Mat_item = getUrlParam("Mat_item");
            if (Prd_item != '' && Prd_item != null) {
                edit_mode = '0';
                $("#selDep_id").textbox('setValue', Dep_id);
                $("#txtPrd_item").textbox('setValue', Prd_item);
                $("#txtMat_item").textbox('setValue', Mat_item);
                getExistPrd_item();
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
            $("#txtPrd_item").textbox('setValue', '');
            cleanText();
            edit_mode = '1';
        }
        function cleanText() {
            $("#txtPrd_item_cdesc").textbox('setValue', '');
            $("#txtMat_item").textbox('setValue', '');
            $("#txtMat_item_cdesc").textbox('setValue', '');
            $("#txtPrd_weg").textbox('setValue', '');
            $("#txtWaste_weg").textbox('setValue', '');
            $("#txtUse_weg").textbox('setValue', '');
            $("#txtHour_std_qty").textbox('setValue', '');
            $("#txtKg_qty_rate").textbox('setValue', '');
            $("#selDep_id").textbox('setValue', '');
            edit_mode = '1';
        }
        //獲取產品、原料物料描述
        function getPrd_item_desc(item_type) {
            var Prd_item;
            if (item_type == "prd_item") {
                if (document.getElementById('txtPrd_item').value == '')
                    return;
                Prd_item = document.getElementById('txtPrd_item').value;
            }
            else
            {
                if (document.getElementById('txtMat_item').value == '')
                    return;
                Prd_item = document.getElementById('txtMat_item').value;
            }
            
            $.ajax({
                //url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=b",    //后台webservice里的方法名称  
                url: "../ashx/Ax_Bs_Mat_Rate.ashx?paraa=get_prd_item&Prd_item=" + Prd_item,///GetPrdItem
                type: "post",
                dataType: "json",
                async: true,    //同步
                contentType: "application/json",
                traditional: true,
                success: function (data) {

                    for (var i in data) {
                        var jsonObj = data[i];
                        if (item_type == "prd_item")
                            $("#txtPrd_item_cdesc").textbox('setValue', jsonObj.goods_name);
                        else
                            $("#txtMat_item_cdesc").textbox('setValue', jsonObj.goods_name);
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

        //獲取已存在的物料記錄
        function getExistPrd_item() {
            
            if (document.getElementById('txtPrd_item').value == '')
                return;
            var Prd_item;
            var Prd_dep;
            var Mat_item;
            Prd_item = document.getElementById('txtPrd_item').value;
            Mat_item = document.getElementById('txtMat_item').value;
            Dep_id = $("#selDep_id").textbox('getValue');
            cleanText();
            $.ajax({
                url: "../ashx/Ax_Bs_Mat_Rate.ashx?paraa=get_mat_rate&parab=list&Prd_item=" + Prd_item + "&Mat_item=" + Mat_item + "&Dep_id=" + Dep_id,///GetPrdItem
                type: "post",
                dataType: "json",
                async: true,    //同步
                contentType: "application/json",
                traditional: true,
                success: function (data) {

                    for (var i in data) {
                        var jsonObj = data[i];
                        $("#txtPrd_item_cdesc").textbox('setValue', jsonObj.prd_item_cdesc);
                        $("#txtMat_item").textbox('setValue', jsonObj.mat_item);
                        $("#txtMat_item_cdesc").textbox('setValue', jsonObj.mat_item_cdesc);
                        $("#selDep_id").textbox('setValue', jsonObj.dep_id);
                        $("#txtPrd_weg").textbox('setValue', jsonObj.prd_weg);
                        $("#txtWaste_weg").textbox('setValue', jsonObj.waste_weg);
                        $("#txtUse_weg").textbox('setValue', jsonObj.use_weg);
                        $("#txtHour_std_qty").textbox('setValue', jsonObj.hour_std_qty);
                        $("#txtKg_qty_rate").textbox('setValue', jsonObj.kg_qty_rate);
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
            j.Prd_item = $("#txtPrd_item").textbox('getValue');
            j.Mat_item = $("#txtMat_item").textbox('getValue');
            j.Prd_weg = $("#txtPrd_weg").textbox('getValue');
            j.Waste_weg = $("#txtWaste_weg").textbox('getValue');
            j.Use_weg = $("#txtUse_weg").textbox('getValue');
            j.Hour_std_qty = $("#txtHour_std_qty").textbox('getValue');
            j.Kg_qty_rate = $("#txtKg_qty_rate").textbox('getValue');
            j.Dep_id = $("#selDep_id").textbox('getValue');
            json.push(j);

            var obja = JSON.stringify(json);


            //            异步提交数据

            $.ajax({
                url: "../ashx/Ax_Bs_Mat_Rate.ashx?paraa=update",
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
            if ($("#txtPrd_item").val() == '') {
                alert("成品編號編號不能為空!");
                $('#txtPrd_item').textbox('textbox').focus();
                return false;
            }
            if ($("#txtMat_item").textbox('getValue') == '') {
                alert("原料編號不能為空!");
                $('#txtPrd_item').textbox('textbox').focus();
                return false;
            }
            if ($("#selDep_id").textbox('getValue') == '') {
                alert("生產部門不能為空!");
                $('#selDep_id').textbox('textbox').focus();
                return false;
            }
            if ($("#txtPrd_weg").val() != "" && !isFloatValue($("#txtPrd_weg").val())) {
                alert("1000成品重量格式錯誤!");
                $('#txtPrd_weg').textbox('textbox').focus();
                return false;
            }
            if ($("#txtWaste_weg").val() != "" && !isFloatValue($("#txtWaste_weg").val())) {
                alert("1000廢料重量格式錯誤!");
                $('#txtWaste_weg').textbox('textbox').focus();
                return false;
            }
            if ($("#txtUse_weg").val() != "" && !isFloatValue($("#txtUse_weg").val())) {
                alert("1000總用量格式錯誤!");
                $('#txtUse_weg').textbox('textbox').focus();
                return false;
            }
            if ($("#txtHour_std_qty").val() != "" && !isInt($("#txtHour_std_qty").val())) {
                alert("產能格式錯誤!");
                $('#txtHour_std_qty').textbox('textbox').focus();
                return false;
            }
            if ($("#txtKg_qty_rate").val() != "" && !isInt($("#txtKg_qty_rate").val())) {
                alert("1Kg數量格式錯誤!");
                $('#txtKg_qty_rate').textbox('textbox').focus();
                return false;
            }
        }


        function deleteData() {
            var Prd_item = $("#txtPrd_item").textbox('getValue');
            var Mat_item = $("#txtMat_item").textbox('getValue');
            var Dep_id = $("#selDep_id").textbox('getValue');

            //            异步提交数据

            $.ajax({
                url: "../ashx/Ax_Bs_Mat_Rate.ashx?paraa=delete&Prd_item="+Prd_item+"&Mat_item="+Mat_item+"&Dep_id="+Dep_id,
                type: "post",
                dataType: "text",//json//這個要同context.Response.ContentType = "text/plain";對應的
                //async: true,    //同步
                //contentType: "application/json",//"application/json"
                //traditional: true,
                error: erryFunction, //错误执行方法
                success: LoadFunction
            });

            function LoadFunction(data) {
                $.messager.alert({ title: '系統信息', msg: data, icon: 'info' });
            }
            function erryFunction(data) {
                alert("error");
            }


        }


</script>  


</head>
<body>
    <%--<div class="easyui-panel" title="新增/編輯" style="width:98%;padding:3px 3px">--%>
    <div class="easyui-panel" style="width:98%;padding:3px 3px">
        <div>
            <a id="btnNew" href="#" class="easyui-linkbutton" iconCls="icon-add" style="width:80px;height:25px">新增</a>
			<a id="btnSave" href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:80px;height:25px">儲存</a>
            <a id="btnDelete" href="#" class="easyui-linkbutton" iconCls="icon-cancel" style="width:80px;height:25px">刪除</a>
            <hr />
		</div>
        <table class="tb-transfer" border="0" style="width:100%">

            <tr>
                <td style="width:15%;text-align:right">產品編號:</td>
                <td style="width:30%;text-align:left">
                    <input id="txtPrd_item" class="easyui-textbox" data-options="prompt:'輸入物料編號...'" maxlength="9"/>
                </td>
                <td style="width:15%;text-align:right">產品描述:</td>
                <td style="width:30%;text-align:left">
                    <input id="txtPrd_item_cdesc" class="easyui-textbox"/>
                </td>
            </tr>
            <tr>
                <td style="text-align:right">原料編號:</td>
                <td style="text-align:left">
                    <input id="txtMat_item" class="easyui-textbox" data-options="prompt:'輸入原料編號...'" maxlength="9"/>
                </td>
                <td style="text-align:right">原料描述:</td>
                <td style="text-align:left">
                    <input id="txtMat_item_cdesc" class="easyui-textbox"/>
                </td>
            </tr>
            <tr>
                <td style="text-align:right">1000成品重量:</td>
                <td style="text-align:left">
                    <input id="txtPrd_weg" class="easyui-textbox"/></td>
                <td style="text-align:right">1000廢料重量:</td>
                <td style="text-align:left">
                    <input id="txtWaste_weg" class="easyui-textbox"/></td>
            </tr>
            <tr>
                <td style="text-align:right">1000總用量:</td>
                <td style="text-align:left">
                    <input id="txtUse_weg" class="easyui-textbox"/></td>
                <td style="text-align:right">產能(PCS/h):</td>
                <td style="text-align:left">
                    <input id="txtHour_std_qty" class="easyui-textbox"/></td>
            </tr>
            <tr>
                <td style="text-align:right">1Kg數量:</td>
                <td style="text-align:left">
                    <input id="txtKg_qty_rate" class="easyui-textbox"/></td>
                <td style="text-align:right">生產部門:</td>
                <td style="text-align:left"><select id="selDep_id" name="selDep_id" class="easyui-combobox" data-options="width:180, valueField: 'id', textField: 'name', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_jx_dep&parab=list'" /></td>
            </tr>
        </table>

	</div>
</body>
</html>
