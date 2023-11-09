<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pd_Mo_Update_Status.aspx.cs" Inherits="WebPortal.Products.Pd_Mo_Update_Status" %>

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
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>
    <script>
        function parentCloseWindow() {
            window.parent.closeWindow();
        }
    </script>
</head>
<body>
    <div id="container">  

    <div id="content">
        <div style="margin-bottom:10px">
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="parentCloseWindow()">关闭</a>
        </div>
        
        <fieldset id="fdUpload">
                <legend><label style="color:blue">將計劃單匯入系統，必須為正確格式的Excel文件</label></legend>
            
        <form runat="server">
            <div>
            <asp:FileUpload ID="fileId" runat="server" Width ="400px" Height ="25px" />

        <asp:Button ID="btnUpload" runat="server" Text="上传" onclick="btnUpload_Click" Width ="80px" Height="25px" />
            
            </div>
            
        </form>
        </fieldset>
            
        </div>
    </div>
</body>
</html>
