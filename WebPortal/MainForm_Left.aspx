<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainForm_Left.aspx.cs" Inherits="WebPortal.MainForm_Left" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script>
        function addTab(title, url) {
            if ($('#tabs').tabs('exists', title)) {
                $('#tabs').tabs('select', title);
                var selTab = $('#tabs').tabs('getSelected');
                var url = $(selTab.panel('options').content).attr('src');
                $('#tabs').tabs('update', {
                    tab: selTab,
                    options: {
                        content: createFrame(url)
                    }
                })

            } else {
                var content = '<iframe scrolling="auto" frameborder="0"  src="' + url + '" style="width:100%;height:100%"></iframe>';
                $('#tabs').tabs('add', {
                    title: title,
                    content: content,
                    closable: true
                });
            }
        }

    </script>
</head>
<body>
    <div style="margin-bottom:10px">
	<a href="#" class="easyui-linkbutton" onclick="addTab('頁數匯總','../Sales/Sa_Oc_ShowStatus.aspx')">頁數匯總</a>
	<a href="#" class="easyui-linkbutton" onclick="addTab('辦單跟蹤','../Sales/Sa_Order_Trace.aspx')">辦單跟蹤</a>
	<a href="#" class="easyui-linkbutton" onclick="addTab('easyui','http://jeasyui.com/')">easyui</a>
</div>
</body>
</html>
