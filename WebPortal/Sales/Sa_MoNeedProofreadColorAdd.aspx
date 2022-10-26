<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_MoNeedProofreadColorAdd.aspx.cs" Inherits="WebPortal.Sales.Sa_MoNeedProofreadColorAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>對色登記</title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />

     <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
      
       <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
         <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>
    <script src="../js/json2.js" type="text/javascript"></script>
    <script>
        $(function () {
            $("#txtMo_id").textbox('setValue', getUrlParam("request_mo_id"));
            if (getUrlParam("edit_flag") == "0")
                $("#divpRroofread_status").css('display', 'none');
            var data, json;
            //json = '[{"id":0 , "text":"0--未對色" },{"id":1 ,"text":"1--已對色","selected":true},{"id":2 , "text":"2--取消對色"}]';
            json = '[{"id":0 , "text":"0--未對色" },{"id":2 , "text":"2--取消對色"}]';
            data = $.parseJSON(json);
            $("#selProofread_status").combobox("loadData", data);
            $("#selProofread_status").textbox('setValue', getUrlParam("request_proofread_status"));
            $('#btnSave').click(function () {
                saveData();
            });
        });

    </script>
    <script type="text/javascript">
        function saveData() {
            if (validData() == false)
                return;
            var json = [];

            var j = {};
            j.mo_id = $("#txtMo_id").textbox('getValue');
            j.proofread_status = $("#selProofread_status").textbox('getValue');
            json.push(j);



            var obja = JSON.stringify(json);


            //            异步提交数据

            $.ajax({
                url: "../ashx/Ax_Sa_MoNeedProofreadColor.ashx/GetItem?paraa=update",
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
                $("#txtMo_id").textbox('setValue', '');
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
            if ($("#txtMo_id").textbox('getValue') == '') {
                alert("制單編號不能為空!");
                $('#txtMo_id').textbox('textbox').focus();
                return false;
            }
        }


    </script>
</head>
<body>
	<div class="easyui-panel" style="width:98%;padding:3px 3px">
        <div>
			<a id="btnSave" href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:80px;height:25px">儲存</a>
            <hr />
		</div>
        <table border="0" style="width:100%">
            <tr>
                <td align="left" style="width:50%">
			制單編號:<input id="txtMo_id" class="easyui-textbox" data-options="prompt:'輸入制單編號...'" style="width:120px;height:22px" maxlength="9"/>
            </td>
                <td align="left">
                    <div id="divpRroofread_status">
                    設置標識:
                    <select id="selProofread_status" name="selProofread_status" class="easyui-combobox" data-options="width:120, valueField: 'id', textField: 'text'" />
                    </div>
                </td>
            </tr>

        </table>

	</div>
</body>
</html>
