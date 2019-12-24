<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_OrderTest_Invoice_Details.aspx.cs" Inherits="WebPortal.Sales.Sa_OrderTest_Invoice_Details" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>測試報告發票錄入</title>

    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />

     <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
      
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
            $("#dd").datebox("setValue", myformatter(curr_time));
            //$('#txtId').textbox('textbox').attr('readonly', true);

            $('#btnSave').click(function () {
                saveData();
            });
            $('#btnNew').click(function () {
                addNew();
            });

            $("input", $("#txtInvoice_Id").next("span")).blur(function () {
                findDataById();
                
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
            $("#txtInvoice_Id").textbox('setValue', '');
            $("#txtInvoice_Date").textbox('setValue', '');
            $("#txtReport_No").textbox('setValue', '');
            $("#txtAmount").textbox('setValue', '');
            $("#selCurr").textbox('setValue', '');
            $("#txtRef_Report").textbox('setValue', '');
            $("#txtMo_id").textbox('setValue', '');
            $("#txtCust_code").textbox('setValue', '');
            $("#txtBrand_id").textbox('setValue', '');
            edit_mode = '1';
        }

        //通過發票編號查找資料
        function findDataById() {
            if (document.getElementById('txtInvoice_Id').value == '')
                return;
            var invoice_id = document.getElementById('txtInvoice_Id').value;
            
            $.ajax({
                //url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=b",    //后台webservice里的方法名称  
                url: "../ashx/Ax_SaOrderTest_Trace.ashx/GetItem?paraa=get_invoice_a&parab=" + invoice_id,
                type: "post",
                dataType: "json",
                async: true,    //同步
                contentType: "application/json",
                traditional: true,
                success: function (data) {

                    for (var i in data) {
                        var jsonObj = data[i];
                        $("#txtInvoice_Date").textbox('setValue', jsonObj[0].invoice_date);
                        $("#txtReport_No").textbox('setValue', jsonObj[0].report_no);
                        $("#txtAmount").textbox('setValue', jsonObj[0].amount);
                        $("#selCurr").textbox('setValue', jsonObj[0].curr);
                        $("#txtRef_Report").textbox('setValue', jsonObj[0].ref_report);
                        $("#txtMo_id").textbox('setValue', jsonObj[0].mo_id);
                        $("#txtCust_code").textbox('setValue', jsonObj[0].custcode);
                        $("#txtBrand_id").textbox('setValue', jsonObj[0].brand);
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
            j.invoice_id = document.getElementById('txtInvoice_Id').value;
            j.invoice_date = $("#txtInvoice_Date").textbox('getValue');
            j.report_no = $("#txtReport_No").textbox('getValue');
            j.amount = $("#txtAmount").textbox('getValue');
            j.curr = $("#selCurr").textbox('getValue');
            j.ref_report = $("#txtRef_Report").textbox('getValue');
            j.mo_id = $("#txtMo_id").textbox('getValue');
            j.custcode = $("#txtCust_code").textbox('getValue');
            j.brand = $("#txtBrand_id").textbox('getValue');
            json.push(j);



            var obja = JSON.stringify(json);


            //            异步提交数据

            $.ajax({
                url: "../ashx/Ax_SaOrderTest_Trace.ashx/GetItem?paraa=update_invoice",
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
            if (document.getElementById('txtInvoice_Id').value == '') {
                alert("發票編號不能為空!");
                $('#txtInvoice_Id').textbox('textbox').focus();
                return false;
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
            <hr />
		</div>
        <table border="0" style="width:100%">

            <tr>
                <td align="right" style="width:22%">
			Invoice:<input id="txtInvoice_Id" class="easyui-textbox" data-options="prompt:'輸入發票編號...'" style="width:120px;height:22px" maxlength="9"/>
            </td>
                <td align="right" style="width:26%">
			Date:
            <input id="txtInvoice_Date" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/>
                    </td>

        <td align="right" style="width:30%">
			Report No.:
			<input id="txtReport_No" class="easyui-textbox" style="width:120px;height:22px"/>
            </td>

        </tr>
        <tr>
            
            <td align="right">Amount:<input id="txtAmount" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Curr:<select id="selCurr" name="selLab_House" class="easyui-combobox" style="width:120px;height:22px" data-options="width:120, valueField: 'curr_id', textField: 'curr_desc', url: '../ashx/Ax_SaOrderTest_Trace.ashx/GetItem?paraa=get_curr'" /></td>
            <td align="right">Own Reference Report:<input id="txtRef_Report" class="easyui-textbox" style="width:120px;height:22px"/></td>
        </tr>
        <tr>
            
            <td align="right">Mo:<input id="txtMo_id" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Cust Code:<input id="txtCust_code" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Brand:<input id="txtBrand_id" class="easyui-textbox" style="width:120px;height:22px"/></td>
        </tr>
        </table>

	</div>
</body>
</html>
