<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sy_FuncLanguage.aspx.cs" Inherits="WebPortal.User.Sy_FuncLanguage" %>

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
    <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>
    <style> 
        .box1 {width:400px; float:left; display:inline;} 
        .box2 {width:200px; float:left; display:inline;} 
    </style>
    <script type="text/javascript">

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }

        $(function () {

            //var groupid = getUrlParam('groupid');
            //alert(groupid);
            
            //initList(queryData);
            
            $('#dg').datagrid({               //根据自身情况更改
                width: $(window).width() - 40,    //根据自身情况更改
                height: $(window).height() - 200,  //根据自身情况更改

            });
            $("#btnSave").click(function () {
                UpdateList();
            });

            $(window).resize(function () {
                $('#dg').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 40,    //根据自身情况更改
                    height: $(window).height() - 200  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 40,      //根据自身情况更改
                    height: $(window).height() - 200   //根据自身情况更改
                });
            });
            InitSearch();
        });

        ////获取url中的参数
        //function getUrlParam(name) {
        //    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
        //    var r = window.location.search.substr(1).match(reg);  //匹配目标参数
        //    if (r != null) return unescape(r[2]); return null; //返回参数值
        //}

        
        function initList(queryData) {
            $('#dg').datagrid({

                url: "../ashx/Ax_FuncManager.ashx/GetItem?edit_mode=loadfunclang",   //指向后台的Action来获取当前用户的信息的Json格式的数据
                iconCls: 'icon-view',//图标
                height: 300,
                //fit: true,//自动适屏功能，表格會自動適應屏幕，就算設置了高度也無效的
                //width: function () { return document.body.clientWidth * 0.9 },//自动宽度
                nowrap: true,
                autoRowHeight: false,//自动行高
                striped: true,
                collapsible: true,
                singleSelect: true,
                //fitColumns: true,
                //sortName: 'Id',//排序列名为ID
                sortOrder: 'asc',//排序为将序
                remoteSort: false,
                idField: 'authorityid',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#dg',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'langid', title: '語言編號', width: 60 },
                { field: 'authorityname', title: '語言描述', width: 260 },
                ]],
                loadFilter: pagerFilter,
                onLoadSuccess: function (data) {
                },
                onClickRow: onClickRow,//單擊表格的行時，給文本框賦值
                //toolbar: [{
                //    id: 'btnreload',
                //    text: '刷新',
                //    iconCls: 'icon-reload',
                //    handler: function () {
                //        $("#btnSerach").datagrid("reload");
                //    }
                //}]



            });
        }
        function fixWidth(percent) {
            return document.body.clientWidth * percent; //这里你可以自己做调整  
        }
        //初始化搜索框
        function InitSearch() {
            $('#txtAuthorityID').val(getUrlParam('authorityid'));
            $('#txtAuthorityName').val(getUrlParam('authorityname'));

            //從上頁中接收参数
            var queryData = {
                authorityid: $('#txtAuthorityID').val(),//.textbox("getValue"),//.val(),
            };
            //将值传递给initTable
            initList(queryData);
            return false;

        }
        //單擊表格的行時，給文本框賦值
        function onClickRow(rowNum, record) {
            var Rows = $('#dg').datagrid("getSelections");
            if (Rows.length == 1) {
                $('#selLang').combobox('setValue', Rows[0].langid);
                $('#txtLangCdesc').val(Rows[0].authorityname);
            }
        }

        function UpdateList() {
            if (!chkDataValid())
                return;
            var json = [];
                var j = {};
                j.authorityid = $('#txtAuthorityID').val();
                j.langid = $("#selLang").combobox('getValue');
                j.langcdesc = $('#txtLangCdesc').val();
                json.push(j);


            var obja = JSON.stringify(json);
            var url = "../ashx/Ax_FuncManager.ashx/GetItem?edit_mode=updatefunclang";
            $.ajax({
                url: url,
                type: "post",
                data: { 'param': obja }, //参数
                datatype: "json",
                async: true,    //默認异步，要改為同步：true
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
                if (data == "OK") {
                    alert("儲存成功!");
                    $("#dg").datagrid("reload");
                    $("#divShowLoadMsg").html('');
                }
                else {
                    alert("儲存失敗!");
                }
            }
            function BefLoadFunction() {
                $("#divShowLoadMsg").html('儲存中...');
            }
            function erryFunction(data) {
                alert(data);
            }

        }
        function chkDataValid() {
            if ($("#selLang").combobox('getValue') == "") {
                alert("語言編號不能為空!");
                return false;
            }
            return true;
        }

    </script>


    <script type="text/javascript">

        function cellStyler(value, row, index) {  
                if ($.trim(value) == '已拒绝') {  
                        return 'color:#ff0000';  
                    }  
            }               
        
        //分页功能      
        function pagerFilter(data) {  
                if (typeof data.length == 'number' && typeof data.splice == 'function') {  
                        data = {  
                                total: data.length,  
                                rows: data  
                       }  
               }  
           var dg = $(this);  
           var opts = dg.datagrid('options');  
           var pager = dg.datagrid('getPager');  
           pager.pagination({  
                   onSelectPage: function (pageNum, pageSize) {  
                           opts.pageNumber = pageNum;  
                           opts.pageSize = pageSize;  
                           pager.pagination('refresh', {  
                                   pageNumber: pageNum,  
                                   pageSize: pageSize  
                           });  
                   dg.datagrid('loadData', data);  
               }  
           });  
           if (!data.originalRows) {  
                   if(data.rows)  
                           data.originalRows = (data.rows);  
                   else if(data.data && data.data.rows)  
                           data.originalRows = (data.data.rows);  
                   else  
                       data.originalRows = [];  
               }  
           var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);  
           var end = start + parseInt(opts.pageSize);  
           data.rows = (data.originalRows.slice(start, end));  
           return data;  
       }  


    </script>



</head>
<body>
    <div id="container">  

    <div id="content"> 
    <!--存放内容的主区域-->
   <%-- <div data-options="region:'north'" title="請輸入查詢內容" style="height: 60px;">
        <div class="easyui-layout" id="tb" style="padding: 0px; height: auto">--%>
            <!-------------------------------搜索框----------------------------------->

                    <div style="margin-bottom: 5px">
                        <label for="lblAuthorityID">程序編號</label>
                        <input type="text" class="easyui-validatebox" id="txtAuthorityID" name="txtAuthorityID" style="width:80px" />
                        <label for="lblAuthorityName">程序描述</label>
                        <input type="text" class="easyui-validatebox" id="txtAuthorityName" name="txtAuthorityName" style="width:220px" />&nbsp; 
                        <a href="#" class="easyui-linkbutton" iconcls="icon-save" id="btnSave" style="width:80px;height:25px">儲存</a>
                    </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblLang">語言代號</label>
                        <input class="easyui-combobox" id="selLang" name="selLang" style="width:80px;height:22px" data-options="valueField: 'flag_id', textField: 'flag_desc',editable:'false', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_lang&parab=list'" />
                        <label for="lblLangCdesc">程序描述</label>&nbsp; 
                        <input type="text" class="easyui-validatebox" id="txtLangCdesc" name="txtLangCdesc" style="width:220px" />
                    </div>
            <div id="divShowLoadMsg"></div>
  <%--      </div>
    </div>--%>
    <!-------------------------------详细信息展示表格----------------------------------->
    <%--<div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true" style="background: #ccc;">--%>
            <table id="dg" padding-left: 0px;></table>
        <%--</div>
    </div>--%>


    </div>
    </div>
</body>
</html>
