<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pd_Mo_Arrange_Imput.aspx.cs" Inherits="WebPortal.Products.Pd_Mo_Arrange_Imput" %>

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
    <%--<script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>--%>
    <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>
    <script type="text/javascript" src="../js/easyuiDatePicker.js"></script>
    <script>
        $(function () {
            //$('#fileId').change(function (event) {
            //    var file = event.target.files[0];
            //    var formData = new FormData();
            //    formData.append('file', file);
            //    update_type = 2;
            //    $.ajax({
            //        url: "../ashx/Ax_Pd_Mo_ArrangeImput.ashx?paraa=" + update_type + "&parab=table",
            //        type: 'POST',
            //        //data: { 'source_file': filevalue,'dst_file':file.name,'formData':formData },
            //        data:formData,
            //        datatype: "json",
            //        contentType: false,
            //        processData: false,
            //        success: function (response) {
            //            // 上传成功后的处理
            //        },
            //        error: function () {
            //            // 上传失败后的处理
            //        }
            //    });
            //});


        })
        function parentCloseWindow() {
            window.parent.closeWindow();
        }
        //網頁打開時自動執行
        window.onload = function () {
            $('#txtArrangeDate').datebox('setValue', changeDateToChar(new Date()));
        }
        function DoExcel() {
            var file = fileId.files[0];
            var formData = new FormData();
            formData.append('file', file);
            var dep = $('#selPrd_dep').datebox('getValue');
            var now_date = $('#txtArrangeDate').datebox('getValue');
            if (dep == "")
            {
                alert("部門不能為空!");
                $('#selPrd_dep').focus();
                return;
            }
            if (now_date == "") {
                alert("日期不能為空!");
                $('#txtArrangeDate').focus();
                return;
            }
            //$("#imgProcess").show();
            $.ajax({
                url: "../ashx/Ax_Pd_Mo_ArrangeImput.ashx?dep=" + dep + "&now_date="+now_date,
                type: 'POST',
                //data: { 'source_file': filevalue,'dst_file':file.name,'formData':formData },//這個是傳參數的
                data: formData,//這個是傳文件的
                datatype: "json",
                contentType: false,//這個是傳文件的，傳參數的不用
                processData: false,//這個是傳文件的，傳參數的不用
                beforeSend: BefLoadFunction, //加载执行方法
                success: function (response) {
                    // 上传成功后的处理
                    closeLoadingWindow();
                    alert(response);
                    parentCloseWindow();
                },
                error: function () {
                    // 上传失败后的处理
                    closeLoadingWindow();
                    alert(response);
                }
            });
        }

        function BefLoadFunction() {
            showLoadingDialog();
        }

    </script>

</head>
<body>
    <div id="container">  

    <div id="content">
        <div>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="parentCloseWindow()">关闭</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-save" style="width:80px" onclick="DoExcel()">儲存</a>
        </div>
        
        <div style="margin-top:10px">
            <input type="file" id="fileId" />
         </div>

        <div style="margin-top:10px">
        <span id="lblDep">所屬部門:</span>
        <input id="selPrd_dep" name="selPrd_dep" class="easyui-combobox" data-options="width:160, valueField: 'dep_id', textField: 'dep_cdesc', url: '../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=list'" />
        <span id="lblDate">日期</span>
        <input id="txtArrangeDate" style="width:160px" class="easyui-datebox-expand"/>
        </div>
        <div style="margin-top:10px;font-size:16px">
            <span style="color:red">請確保為正確的Excel文件格式！</span>
            <br />
            <span style="color:red">提交後將會覆蓋當日已有的排期表！</span>
        </div>
        <%--<asp:DropDownList ID="dlDep" Width="120px" Height="22px"  runat="server" />--%>
        <%--<form runat="server">
            <div>
                <label for="lblDep">生產部門:</label>
                <asp:DropDownList ID="dlDep" Width="120px" Height="22px"  runat="server" />
            <label for="lblDate">日期:</label>
                <input id="txtArrangeDate" runat="server" style="width:120px" class="easyui-datebox-expand"/>
            </div>
            <div>
            

        <asp:Button ID="btnUpload" runat="server" Text="上传" onclick="btnUpload_Click" Width ="80px" Height="25px" />
            
            </div>
            <img src="../images/process3.gif" id="imgProcess" style="width:80px;height:80px" runat="server" visible="false"/>
            
        </form>--%>
        
        
    </div>
    </div>
</body>
</html>
