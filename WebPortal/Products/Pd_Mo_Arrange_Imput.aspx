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

    <%--這兩行是用插件jquery.form.js來做上傳的，要注意不能于其它jquery.min.js混用，不然有衝突--%>
    <%--<script type="text/javascript" src="../js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="../js/jquery.form.js"></script>--%>

    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
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

            $("#uploadBtn").click(function () {
                var dep = $('#selPrd_dep').datebox('getValue');
                var now_date = $('#txtArrangeDate').datebox('getValue');
                if (dep == "") {
                    alert("部門不能為空!");
                    $('#selPrd_dep').focus();
                    return;
                }
                if (now_date == "") {
                    alert("日期不能為空!");
                    $('#txtArrangeDate').focus();
                    return;
                }
                //////////上傳方法一：用插件jquery.form.js，但IE8前的版本不能用
                //$.messager.progress({ text: '上传中，请稍候' });
                //$('#uploadForm').ajaxSubmit({
                //    type: 'post',
                //    url: "../ashx/Ax_Pd_Mo_ArrangeImput.ashx?dep=" + "102" + "&now_date=" + "2023/11/10", //上传文件的地址
                //    onSubmit: function () {
                //        $.messager.progress({ text: '上传中，请稍候' });
                //    },
                //    success: function (data) {
                //        $.messager.progress('close');
                //        //closeLoadingWindow();
                //        //$.messager.alert('上传成功', data);
                //        alert(data);
                //        parentCloseWindow();
                //    }
                //});
                //return;

                //获取filebox的文件值
                var fileName = $('#file').filebox('getValue');
                //var file1=$('#file').datebox('getValue');
                //var fileName = $('#file').val();
                ////判断是否是excel文件
                var file_typename = fileName.substring(fileName.lastIndexOf('.'), fileName.length).toLowerCase();
                //$.messager.alert("asdsad", file_typename);
                if (file_typename != ".xlsx" && file_typename != ".xls") {
                    $.messager.alert('错误', "未选择文件或选择文件不是xls文件!");
                    return;
                }

                //////上傳方法二：這個兼容IE8可以正常用的，但IE11以上也可以用，但沒有顯示返回界面
                $('#uploadForm').form('submit', {
                    //type: 'post',
                    async: false,
                    url: "../ashx/Ax_Pd_Mo_ArrangeImput.ashx?dep=" + dep + "&now_date=" + now_date, //上传文件的地址
                    onSubmit: function () {
                        $.messager.progress({ text: '上传中，请稍候' });
                    },
                    success: function (result) {
                        //////留意：IE11不能返回到這裡，IE8就可以。
                        $.messager.progress('close');
                        //if (result.errorMsg) {
                        //    $.messager.alert('上传失败', result.errorMsg, 'error');
                        //} else {
                        //    $.messager.alert('上传成功', result.successMsg);
                        //}
                        //$.messager.alert(result, result);
                        alert(result);
                        //parentCloseWindow();
                    },
                    error: function () {
                        // 上传失败后的处理
                        alert(response);
                    }
                });

                //$.messager.progress({
                //    title: '上传中',
                //    msg: '文件努力上传中，请稍后片刻',
                //    text: '上传中...',
                //    interval: 100
                //});
                //setTimeout(function () {
                //    $("#uploadForm").form('submit', {
                //    async: true,
                //    url: "../ashx/Ax_Pd_Mo_ArrangeImput.ashx?dep=" + "102" + "&now_date=" + "2023/11/10", //上传文件的地址

                //    success: function (data) {

                //        debugger;
                //        $.messager.progress('close');
                            
                //        $.messager.alert("提示", data);
                //        refresh();
                //        parentCloseWindow();
                //    }



                //});},2000);


            });

        })
        function parentCloseWindow() {
            window.parent.closeWindow();
        }
        //網頁打開時自動執行
        window.onload = function () {
            $('#txtArrangeDate').datebox('setValue', changeDateToChar(new Date()));
        }

        //上傳方法三，這個是最新的做法，但IE8不能用，只能IE11以上能用
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


    <script>

        //這個是另一種上傳文件的界面

        function change(_obj){

            var tempFile = $("#uploadFileid");
            var value=tempFile.filebox('getValue');

            // 取后缀名
            var ext=value.substring(value.lastIndexOf(".")+1).toLowerCase();
            if(ext!='xls'){
                if(ext!='xlsx'){
                    $.messager.alert("消息提示", "文件格式不对！请重新上传", "error");
                    return;
                }
             
            }

            //取file

            var file = $(_obj).context.ownerDocument.activeElement.files[0]

       

        }

    </script>

</head>
<body>


<%--<form id="uploadForm">
    <input id="fileUpload" name="fileUpload" type="file" onchange="previewFile()"/>
    <input id="filePath" name="filePath" type="hidden"/>
</form>
<div id="preview"></div>--%>



    <div id="container">  

    <div id="content">
        <div>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="parentCloseWindow()">关闭</a>
           
        </div>
        <%--這個是方法三--%>
        <%--<div style="margin-top:10px">
            <input type="file" id="fileId" />
             <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-save" style="width:80px" onclick="DoExcel()">儲存</a>
         </div>--%>

        <div style="margin-top:10px">
        <span id="lblDep">所屬部門:</span>
        <input id="selPrd_dep" name="selPrd_dep" class="easyui-combobox" data-options="width:160, valueField: 'dep_id', textField: 'dep_cdesc', url: '../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=list'" />
        <span id="lblDate">日期:</span>
        <input id="txtArrangeDate" style="width:160px" class="easyui-datebox-expand"/>
        </div>
        
        <form id="uploadForm" method="post" enctype="multipart/form-data" style="margin-top:10px">
            <span id="lblFile">選擇文件:</span>
            <input name="file" id="file" class="easyui-filebox" data-options="prompt:'选择文件', buttonText:'浏览', width:'360'"/>
            <a href="javascript:void(0)" id="uploadBtn" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="width:80px">上传</a>
        </form>

        <%--這個是另一種上傳文件的界面--%>
        <%--<input class="easyui-filebox" name="uploadFile" id="uploadFileid" data-options="required:true,validType:'suffix[\'xls,xlsx\']',prompt:'请选择文件',buttonText:' 选 择 文 件',onChange:function c(){change(this)}" style="width:100%"/>--%>

        <div style="margin-top:10px;font-size:16px">
            <span style="color:red">注意：</span>
            <br />
            <span style="color:red">1、請確保為正確的Excel文件格式！</span>
            <br />
            <span style="color:red">2、提交後將會覆蓋當日已有的排期表！</span>
        </div>

    </div>
    </div>
</body>
</html>
