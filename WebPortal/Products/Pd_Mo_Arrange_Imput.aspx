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
        function parentCloseWindow() {
            window.parent.closeWindow();
        }
        //網頁打開時自動執行
        window.onload = function () {
            $('#txtArrangeDate').datebox('setValue', changeDateToChar(new Date()));
        }
    </script>
</head>
<body>
    <div id="container">  

    <div id="content">
        <fieldset id="fdUpload">
                <legend><label style="color:red;font-size:16px">注意：請確保為正確的Excel文件格式！</label></legend>
            
        <form runat="server">
            <div>
                <label for="lblDep">生產部門:</label>
                <asp:DropDownList ID="dlDep" Width="120px" Height="22px"  runat="server" />
            <label for="lblDate">日期:</label>
                    <%--<input type="text" id="txtArrangeDate" name="txtArrangeDate" runat="server" style="height:20px;width:120px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>--%>
                <input id="txtArrangeDate" runat="server" style="width:120px" class="easyui-datebox-expand"/>
            </div>
            <div>
            <asp:FileUpload ID="fileId" runat="server" Width ="400px" Height ="25px" />

        <asp:Button ID="btnUpload" runat="server" Text="上传" onclick="btnUpload_Click" Width ="80px" Height="25px" />
            
            </div>
            
        </form>
        </fieldset>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" style="width:80px" onclick="parentCloseWindow()">关闭</a>
        </div>
    </div>
</body>
</html>
