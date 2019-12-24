<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="getProdTypeCode.aspx.cs" Inherits="WebPortal.PublicWebForm.getProdTypeCode" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
    <%--<meta charset="utf-8">--%>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <link rel="stylesheet" href="../css/vue/demo.css" />
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/demo/demo.css"/>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>

    <script type="text/javascript">

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }

        $(function () {
            //initList();
            //$('#dg').datagrid({               //根据自身情况更改
            //    width: $(window).width() - 30,    //根据自身情况更改
            //    height: $(window).height() - 100,  //根据自身情况更改

            //    onDblClickRow: function (index, row) {
            //        var obj = window.parent.document.getElementById("txtMat");
            //        obj.value = row.id;
            //        window.parent.closeWindow();
            //    }
            //});

            ////$("#dg").datagrid({
            ////    //双击事件
            ////    onDblClickRow: function (index, row) {
            ////        var obj = window.parent.document.getElementById("txtMat");
            ////        obj.value = row.id;
            ////        window.parent.closeWindow();
            ////    }
            ////});

            //$(window).resize(function () {
            //    $('#dg').datagrid('resize', {               //根据自身情况更改
            //        width: $(window).width() - 30,    //根据自身情况更改
            //        height: $(window).height() - 100  //根据自身情况更改
            //    }).datagrid('resize', {
            //        width: $(window).width() - 30,      //根据自身情况更改
            //        height: $(window).height() - 100   //根据自身情况更改
            //    });
            //});

            //按照条件进行查询，首先我们得到数据
            $("#btnSerach").click(function () {
                //得到用户输入的参数
                var queryData = {
                    //UserName: $("#txtUserNameSerach").val(),
                    //ClassId: $("#txtClassIdSerach").combobox("getValue"),
                    search_val: $("#txtVal").val()//
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            });
            $("#btnConf").click(function () {
                var obj = window.parent.document.getElementById("txtMat");
                var row = $('#dg').datagrid('getSelected');

                //var w = window.dialogArguments.getElementById;
                if (row) {
                    //alert('Item ID:' + row.itemid + "\nPrice:" + row.listprice);
                    //alert('Item ID:' + row.id);
                    obj.value = row.id;
                    window.parent.closeWindow();
                    //closeWindow();



                    //window.opener = null;
                    //window.open('', '_self');
                    //window.close();
                    //obj = window.parent.document.getElementById("showMatDialog");

                    //obj.style.display = "none";
                    //window.parent.document.removeChild("showMatDialog");
                    //document.body.removeChild("showMatDialog");
                    //obj.dialog('close');
                }
            });

            //$(".clsSetPrdTypeaaa").click(function () {
            //    var obj = $(".clsSetPrdType").parent();
            //    var obj2 = obj.find("p");//.val();

            //    var txt = obj2[0].innerHTML;
            //    alert(obj2[0].innerHTML);
            //    alert(obj2[1].innerHTML);
            //});
            $("#btnFindPrdType").click(function () {
                //$("#divSetPrdType").append("<a class='btnSetPrdType' href='javascript:void(0)' id='btnSetPrdType1'>abc</a>");

                var json = [];
                var j = {};
                j.search_val = $("#txtSearch_val").val();
                json.push(j);
                var obja = JSON.stringify(json);
                var strUl = "";
                $.ajax({
                    //url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_work_type&parab=b",    //后台webservice里的方法名称  
                    //type: "post",
                    //dataType: "json",
                    //contentType: "application/json",

                    url: "../ashx/Base_Select.ashx/GetItem?paraa=get_prdtype&parab=table",
                    type: 'post',
                    data: { 'param': obja }, //参数
                    dataType: 'json',

                    
                    traditional: true,
                    success: function (data) {
                        strUl = "<ul>";
                        for (var i in data) {
                            var jsonObj = data[i];
                            //var optionstring = "";
                            //for (var j = 0; j < jsonObj.length; j++) {
                            //    optionstring += "<option value=\"" + jsonObj[j].work_type_id + "\" >" + jsonObj[j].work_type_desc + "</option>";
                            //}
                            //$("#selWork_type").html("<option value='0'>请选择...</option> " + optionstring);
                            strUl += "<li class='clsSetPrdType12'>";
                            strUl += "<a class='clsSetPrdTypeaaa' href=javascript:void(0) onclick=getClass(this) >" + jsonObj.id + "</a>";
                            //strUl+="<button id='btnSelect  class='clsSetPrdType13'>選取</button>";
                            strUl += "<p>";
                            strUl += "<a>" + jsonObj.prd_type_cdesc + "</a>";
                            strUl += "<a>" + jsonObj.prd_type_desc + "</a>";
                            strUl += "</p>";
                            strUl += "</li>";
                        }
                        strUl += "</ul>";
                        $("#divSetPrdType").append(strUl);
                    },
                    error: function (msg) {
                        alert("出错了！");
                    }
                });

            });
            //("#btnSerach").click(function () {
                //var obj = window.parent.document.getElementById("txtMat");
                //var row = $('#dg').datagrid('getSelected');
                //if (row) {
                //    //alert('Item ID:' + row.itemid + "\nPrice:" + row.listprice);
                //    alert('Item ID:' + row.id);
                //    //obj.value = row.id;
                //}
                //var obj_to = window.parent.document.getElementById("txtMat");
                //var val = obj_to.value;
                //alert(val);
                //obj_f = document.getElementById("s");
                //obj_to.value = obj_f.value;
            //});
            //InitSearch();//查询
        });
        $(".clsSetPrdTypeaaa").click(function () {
            var obj = $(".clsSetPrdType").parent();
            var obj2 = obj.find("p");//.val();

            var txt = obj2[0].innerHTML;
            alert(obj2[0].innerHTML);
            alert(obj2[1].innerHTML);
            alert(obj2[2].innerHTML);
        });
        function getClass(fobj) {
            var box = document.getElementsByClassName("clsSetPrdTypeaaa");
            var obj = fobj;
            //var ind = $(this).index;
            var obj2 = obj.parentNode;//.find("p");//.val();
            var txt = obj2.childNodes[1].childNodes[0].innerHTML;//obj.innerHTML;
            var val = box[0].value;
            alert(txt);
            alert(obj2.childNodes[1].childNodes[1].innerHTML);
            var obj = window.parent.document.getElementById("txtPrdType");
            obj.value = txt;
        }
        function initList(queryData) {
            $('#dg').datagrid({

                url: "../ashx/Base_Select.ashx/GetItem?paraa=get_prdtype&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
                iconCls: 'icon-view',//图标
                //height: 500,
                //fit: true,//自动适屏功能，表格會自動適應屏幕，就算設置了高度也無效的
                //width: function () { return document.body.clientWidth * 0.9 },//自动宽度
                nowrap: true,
                autoRowHeight: false,//自动行高
                striped: true,
                collapsible: true,
                singleSelect: true,
                //sortName: 'Id',//排序列名为ID
                sortOrder: 'asc',//排序为将序
                remoteSort: false,
                idField: 'Id',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#dg',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: '选择', checkbox: 'true', width: 30 },
                { field: 'id', title: '原料編號', width: 80 },
                { field: 'mat_cdesc', title: '中文描述', width: 100 },
                { field: 'mat_desc', title: '英文描述', width: 100 }
                ]],
                loadFilter: pagerFilter,
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

        //初始化搜索框
        function InitSearch() {
            //按照条件进行查询，首先我们得到数据
            $("#btnSerach").click(function () {
                //得到用户输入的参数
                var queryData = {
                    //UserName: $("#txtUserNameSerach").val(),
                    //ClassId: $("#txtClassIdSerach").combobox("getValue"),
                    search_val: $("#txtVal").val()//
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            });
        }


        function closeWindow() {
            window.opener = null;
            //window.open(' ', '_self', ' ');
            window.open('', '_self');
            window.close();

            
        }
   
        function setPrdType() {
            var obj = $(".setPrdType").parent();
            var obj2 = obj.find("p");//.val();
            var txt = obj2[0].innerHTML;
            alert(obj2[0].innerHTML);
            alert(obj2[1].innerHTML);
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


    <style>
    /* 隐藏未编译的变量 */

    [v-cloak] {
      display: none;
    }

    *{
        margin:0;
        padding:0;
    }

    body{
        font:15px/1.3 'Open Sans', sans-serif;
        color: #5e5b64;
        text-align:center;
    }

    a, a:visited {
        outline:none;
        color:#389dc1;
    }

    a:hover{
        text-decoration:none;
    }

    section, footer, header, aside, nav{
        display: block;
    }


    /*-------------------------
        搜索输入框
    --------------------------*/

    .bar{
        background-color:#5c9bb7;

        background-image:-webkit-linear-gradient(top, #5c9bb7, #5392ad);
        background-image:-moz-linear-gradient(top, #5c9bb7, #5392ad);
        background-image:linear-gradient(top, #5c9bb7, #5392ad);

        box-shadow: 0 1px 1px #ccc;
        border-radius: 2px;
        width: 400px;
        padding: 14px;
        margin: 5px auto 20px;
        position:relative;
    }

    .bar input{
        background:#fff no-repeat 13px 13px;
        background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyBpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNSBXaW5kb3dzIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkU5NEY0RTlFMTA4NzExRTM5RTEzQkFBQzMyRjkyQzVBIiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkU5NEY0RTlGMTA4NzExRTM5RTEzQkFBQzMyRjkyQzVBIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6RTk0RjRFOUMxMDg3MTFFMzlFMTNCQUFDMzJGOTJDNUEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6RTk0RjRFOUQxMDg3MTFFMzlFMTNCQUFDMzJGOTJDNUEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4DjA/RAAABK0lEQVR42pTSQUdEURjG8dOY0TqmPkGmRcqYD9CmzZAWJRHVRIa0iFYtM6uofYaiEW2SRJtEi9YxIklp07ZkWswu0v/wnByve7vm5ee8M+85zz1jbt9Os+WiGkYdYxjCOx5wgFeXUHmtBSzpcCGa+5BJTCjEP+0nKWAT8xqe4ArPGEEVC1hHEbs2oBwdXkM7mj/JLZrad437sCGHOfUtcziutuYu2v8XUFF/4f6vMK/YgAH1HxkBYV60AR31gxkBYd6xAeF3VzMCwvzOBpypX8V4yuFRzX2d2gD/l5yjH4fYQEnzkj4fae5rJulF2sMXVrAsaTWttRFu4Osb+1jEDT71/ZveyhouTch2fINQL9hKefKjuYFfuznXWzXMTabyrvfyIV3M4vhXgAEAUMs7K0J9UJAAAAAASUVORK5CYII=);

        border: none;
        width: 70%;
        line-height: 19px;
        padding: 11px 0;

        border-radius: 2px;
        box-shadow: 0 2px 8px #c4c4c4 inset;
        text-align: left;
        font-size: 14px;
        font-family: inherit;
        color: #738289;
        font-weight: bold;
        outline: none;
        text-indent: 40px;
    }
    .bar button {
        width: 20%;
    }
    ul{
        list-style: none;
        width: 428px;
        height:400px;
        margin: 0 auto;
        text-align: left;
    }

    ul li{
        border-bottom: 1px solid #ddd;
        padding: 10px;
        overflow: hidden;
    }

    ul li img{
        width:60px;
        height:60px;
        float:left;
        border:none;
    }

    ul li p{
        margin-left: 75px;
        font-weight: bold;
        padding-top: 12px;
        color:#6e7a7f;
    }
    </style>



</head>
<body>
 <%--   <div id="container">  

    <div id="content"> --%>
    <!--存放内容的主区域-->
   <%-- <div data-options="region:'north'" title="請輸入查詢內容" style="height: 60px;">
        <div class="easyui-layout" id="tb" style="padding: 0px; height: auto">--%>
            <!-------------------------------搜索框----------------------------------->
<%--            <fieldset>
                <legend>查詢條件</legend>
                <form id="ffSearch" method="post">
                    <div style="margin-bottom: 5px">
                         <input type="text" class="easyui-validatebox" id="txtVal" name="txtVal" data-options="required:true, missingMessage:'請輸入原料編號/中文描述/英文描述'" style="width:260px"" />
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:80px;height:25px">查詢</a>
                        <a href="#" class="easyui-linkbutton" iconcls="icon-save" id="btnConf" style="width:80px;height:25px">確認</a>
                    </div>
                </form>
            </fieldset>
            <table id="dg" padding-left: 0px;></table>--%>
    
    <div id="app" v-cloak style="display:none">
        <div class="bar">
        <!-- searchString 模型与文本域创建绑定 -->
        <input id="txtSearch_valaa" type="text" v-model="search_val"/>
        <button v-on:click="findPrdType">查找</button>
        </div>
    <div class="div_search_frame">
        <ul>
        <!-- 循环输出数据 -->
             
        <li v-for="item in prdTypeList">
            <a class="setPrdType" href="javascript:void(0)" id="btnSetPrdType1">{{item.id}}</a>
            <p>{{item.prd_type_cdesc}}{{item.prd_type_desc}}</p>
        </li>
        </ul>
    </div>
    </div>
    <div class="bar">
    <input id="txtSearch_val" type="text"/>
    <button id="btnFindPrdType">查找</button>
    </div>
    <div id="divSetPrdType" class="div_search_frame" style="width:500px;height:300px">
    
    
    </div>
    <%--</div>
    </div>--%>
    <script src="../js/vue.js"></script>

    <script>
    new Vue({
        el: '#app',
        data: {
            prdTypeList: [],
            search_val: ""
        },
        methods: {
            findPrdType: function () {
                // // 方法内 `this` 指向 vm
                var self = this;
                var json = [];
                var j = {};
                j.search_val = self.search_val;
                json.push(j);
                var obja = JSON.stringify(json);
                //为了在内部函数能使用外部函数的this对象，要给它赋值了一个名叫self的变量。

                $.ajax({
                    url: "../ashx/Base_Select.ashx/GetItem?paraa=get_prdtype&parab=table&search_val=" + self.search_val,
                    type: 'post',
                    data: { 'param': obja }, //参数
                    dataType: 'json'
                }).then(function (res) {
                    //console.log(res);
                    //把从json获取的数据赋值给数组
                    self.prdTypeList = res;
                }).fail(function () {
                    console.log('失败');
                })
            }
        }
    })


    </script>



</body>
</html>
