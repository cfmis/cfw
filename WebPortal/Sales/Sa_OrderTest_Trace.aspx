<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_OrderTest_Trace.aspx.cs" Inherits="WebPortal.Sales.Sa_OrderTest_Trace" %>

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
          <script type="text/javascript" src="../js/Sales/Js_SaOrderTestTrace.js"></script>
        <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>

          <style type="text/css"> 
        .textbox { 
          height:20px;           margin:0; 
          padding:0 2px; 
          box-sizing:content-box;         }
          </style>
    
    <script>

        $(function () {

            //$('#txtDate_from').textbox('textbox').attr('readonly', true);
            //$('#txtDate_to').textbox('textbox').attr('readonly', true);
            $('#dg').datagrid({               //根据自身情况更改
                width: $(window).width() - 30,    //根据自身情况更改
                height: $(window).height() - 220  //根据自身情况更改
            });

            $("#btnSet").click(function () {
                //$("#dg").width(200);
                $("#dg").height("500px").width("1500px");
                //var wd = document.getElementById('dg').style.width;
                //alert(wd);
                var box = $("#dg");
                var text = "width=" + box.width();
                alert(text);


                
            });

            $("input", $("#txtDate_from").next("span")).blur(function () {
                $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));

            });

            $("button").click(function(){  
                             var box= $("#dg");  
                             var text="height="+box.height()+"<br/>"  
                                     +"width="+box.width()+"<br/>"  
                                     +"innerWidth="+box.innerWidth()+"<br/>"  
                                     +"innerHeight="+box.innerHeight()+"<br/>"  
                                     +"outerWidth="+box.outerWidth()+"<br/>"  
                                     +"outerHeight="+box.outerHeight()+"<br/>";  
                              $("p").append(text);  
            })


            $(window).resize(function () {
                $('#dg').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 30,    //根据自身情况更改
                    height: $(window).height() - 220  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 30,      //根据自身情况更改
                    height: $(window).height() - 220   //根据自身情况更改
                });
            });

            //onChangeDate(function(date) {
            //    $("#txtDate_to").textbox('setValue', date);
            //});

        });
        
        function fixWidth(percent) {
            return document.body.clientWidth * percent; //这里你可以自己做调整  
        }

        function myformatter(date) {
            var y = date.getFullYear();
            var m = date.getMonth() + 1;
            var d = date.getDate();
            return y + '/' + (m < 10 ? ('0' + m) : m) + '/' + (d < 10 ? ('0' + d) : d);
        }

        function myparser(s) {
            if (!s) return new Date();
            var ss = (s.split('/'));
            var y = parseInt(ss[0], 10);
            var m = parseInt(ss[1], 10);
            var d = parseInt(ss[2], 10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
                return new Date(y, m - 1, d);
            } else {
                return new Date();
            }
        }

        function onChangeDate() {
            
            //var obj = document.getElementById('txtDate_from');
            //obj.textbox('setValue', date);
            //alert("选中的时间为：" + date);

            $("#txtDate_to").textbox('setValue', $("#txtDate_from").textbox('getValue'));
        }

    </script>
    
    <script type="text/javascript">

        function showDetails1(index){  
                $('#dg').datagrid('selectRow',index);// 关键在这里  
                var row = $('#dg').datagrid('getSelected');  
                if (row){  

                    //window.showModelessDialog('../Sales/Sa_OrderTest_Trace_Details.aspx?mo_id=' + row.mo_id,
                    //    'subpage', 'dialogWidth:1024px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');

                    var url = '../Sales/Sa_OrderTest_Trace_Details.aspx?mo_id=' + row.mo_id;
                    var title = '編輯';
                    var width = 1024;
                    var height = 500;
                    var shadow = true;
                    var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
                    var boarddiv = '<div id="msgwindow" title="' + title + '"></div>'//style="overflow:hidden;"可以去掉滚动条  
                    $(document.body).append(boarddiv);
                    var win = $('#msgwindow').dialog({
                        content: content,
                        width: width,
                        height: height,
                        modal: shadow,
                        title: title,
                        onClose: function () {
                            //$(this).dialog('destroy');//后面可以关闭后的事件  
                            document.getElementById('btnFind').onclick();
                        }
                    });
                    win.dialog('open');

                    }  
            }  

 
    </script>

    <script type="text/javascript">
        function addDetails() {

            window.showModelessDialog('../Sales/Sa_OrderTest_Trace_Details.aspx',
                        'subpage', 'dialogWidth:1024px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');
            //location.href = "../Sales/Sa_OrderTest_Trace_Details.aspx";// + str;

            //showModalDialog('../Sales/Sa_OrderTest_Trace_Details.aspx', 'subpage', 'dialogWidth:1024px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');
        }

        function showMessageDialog(url, title, width, height, shadow) {

            var content = '<iframe src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>';
            var boarddiv = '<div id="msgwindow" title="' + title + '"></div>'//style="overflow:hidden;"可以去掉滚动条  
            $(document.body).append(boarddiv);
            var win = $('#msgwindow').dialog({
                content: content,
                width: width,
                height: height,
                modal: shadow,
                title: title,
                onClose: function () {
                    //$(this).dialog('destroy');//后面可以关闭后的事件  
                    document.getElementById('btnFind').onclick();
                }
            });
            win.dialog('open');
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
    <div data-options="region:'north'" title="查詢條件" style="height: 160px;">
        <div class="easyui-layout" id="tb1" style="padding: 5px; height: auto">
            <!-------------------------------搜索框----------------------------------->
            <fieldset>
                <legend>操作區域</legend>
                <form id="ffSearch" method="post">
                    <div style="margin-bottom: 5px">
                        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="showMessageDialog('../Sales/Sa_OrderTest_Trace_Details.aspx','新增',1024,500,true)" style="width:80px;height:25px">新增</a>
                        <a href="#" id="btnFind" class="easyui-linkbutton" iconCls="icon-search"  plain="false" onclick="oobj.search()" style="width:80px;height:25px">查询</a>
                        <a href="#" id="btnExp" class="easyui-linkbutton" iconCls="icon-excel"  plain="false" onclick="Export('訂單測試記錄表', $('#dg'));" style="width:80px;height:25px">匯出</a>
                    </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblMo_group">&nbsp; &nbsp; 組別:</label>
                        <select id="selMo_group" name="selMo_group" class="easyui-combobox" data-options="width:120, valueField: 'mo_group', textField: 'mo_group', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_mogroup&parab=list'"></select>
                        <label for="lblDate">記錄日期:</label>
                        <input id="txtDate_from" name="txtDate_from" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser,onSelect:onChangeDate"/>
                        <input id="txtDate_to" name="txtDate_to" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/>
                        <label for="lblMo">&nbsp; &nbsp;制單編號:</label>
                        <input id="txtMo" type="text" class="easyui-textbox" name="txtMo" style="width:120px;height:20px" />
                    </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblRef_no">Ref No.:</label>
                        <input id="txtRef_no" type="text" class="easyui-textbox" name="txtRef_no" style="width:120px;height:20px" />
                        <label for="lblItem">&nbsp; &nbsp;Item:</label>
                        <input id="txtItem" type="text" class="easyui-textbox" name="txtItem" style="width:120px;height:20px" />
                        <label for="lblColor">Color:</label>
                        <input id="txtColor" type="text" class="easyui-textbox" name="txtColor" style="width:120px;height:20px" />
                        <label for="lblSize">Size:</label>
                        <input id="txtSize" type="text" class="easyui-textbox" name="txtSize" style="width:120px;height:20px" />
                        
                        
                    </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblSeason">Season:</label>
                        <input id="txtSeason" type="text" class="easyui-textbox" name="txtSeason" style="width:120px;height:20px" />
                    </div>
                </form>
            </fieldset>
        </div>
    </div>

           <%--<table id="dg"title="原始数据录入情况" class="easyui-datagrid" style="width:1050px; height: 480px; padding-left: 200px;"
               toolbar="#bar" pagination="true" rownumbers="true" fitcolumns="true" striped="true" singleselect="true"> --%> 
    <%--<div id="tt" class="easyui-panel" style="width: 100%; height: 350px;margin-top: 0px">--%>
  <%--<table id="dg" style="height: 300px; padding-left: 200px;" >--%>
  <table id="dg" padding-left: 5px;" >

               <%--<thead> --%> 
                  <%--设置绑定表格的列名，列名与数据库相同--%>  
                   <%--<tr>  
                       <th field='dep_id',width:100">部門編號</th>  
                        <th field='dep_desc',width:100">英文描述</th>  
                        <th field='dep_cdesc',width:100">中文描述</th>  
 
                    </tr> --%> 
                <%--</thead>  --%>
   </table>  
            <div id="tb">
                
                
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="oobj.add()">添加</a>
                <a href="#"class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="oobj.edit()" >修改</a>
                <a href="#" class="easyui-linkbutton"iconCls="icon-remove"  plain="true" onclick="oobj.removed()">删除</a> 
                <a href="#"class="easyui-linkbutton" iconCls="icon-save" plain="true" style="display:none" id="save" onclick="oobj.save()">保存</a> 


                <a href="#" class="easyui-linkbutton"iconCls="icon-redo" plain="true"  style="display:none"id="redo" onclick="oobj.redo()">取消编辑 </a>


                
                
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="oobj.selectRow()">顯示記錄</a> 
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="oobj.selectAllRow()">顯示選中行記錄</a> 
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="oobj.showDetails()">顯示詳細記錄</a> 
            <%--</div>  --%>
   
       </div>
        
        
          
        <%--</div>--%>

        </div>
        </div>
</body>
</html>
