﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Quotation_Query.aspx.cs" Inherits="WebPortal.Sales.Sa_Quotation_Query" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
      
       <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
         <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
        <%--<script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>--%>
          <script type="text/javascript" src="../js/Sales/Js_SaQuotationQuery.js"></script>

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
                width: $(window).width() - 10,    //根据自身情况更改
                height: $(window).height() - 80  //根据自身情况更改
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
                    width: $(window).width() - 10,    //根据自身情况更改
                    height: $(window).height() - 80  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 10,      //根据自身情况更改
                    height: $(window).height() - 80   //根据自身情况更改
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

                    //window.showModelessDialog('../Sales/Sa_OrderTest_Invoice_Details.aspx?invoice_id=' + row.invoice_id,
                    //    'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');

                    var url = '../Sales/Sa_OrderTest_Invoice_Details.aspx?invoice_id=' + row.invoice_id;
                    var title = '編輯';
                    var width = 800;
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

            window.showModelessDialog('../Sales/Sa_OrderTest_Invoice_Details.aspx',
                        'subpage', 'dialogWidth:800px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');
            //location.href = "../Sales/Sa_OrderTest_Trace_Details.aspx";// + str;

            //showModalDialog('../Sales/Sa_OrderTest_Trace_Details.aspx', 'subpage', 'dialogWidth:1024px;dialogHeight:500px;center:yes;help:no;resizable:no;status:no');
            //$('#btnFind').click();
            //document.getElementById('btnFind').onclick();
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

    <form runat="server">

    
        
       <%--<div title="訂單測試記錄"style="padding: 10px">  --%>
           
           <%--<form runat="server">--%>
               <table style="width:100%" border="0">

                   <tr style="height:30px">

                       <td style="width:85%">
                            Item Class:
                            <input id="txtPrd_item" runat="server" type="text" class="easyui-textbox" name="txtPrd_item" style="width:120px;height:20px" />
                           Size:
                <input id="txtSize" runat="server" type="text" class="easyui-textbox" name="txtSize" style="width:120px;height:20px" />
                Color:
                <input id="txtClr" runat="server" type="text" class="easyui-textbox" name="txtClr" style="width:120px;height:20px" />
                       </td>

                       <td style="width:15%">
                           <a href="#" id="btnFind" class="easyui-linkbutton" iconCls="icon-search"  plain="false" onclick="oobj.search()" style="width:80px;height:25px">Search</a>
                       </td>
                   </tr>

               </table>
    <%--</form>--%>
           

  <table id="dg" padding-left: 200px;" >


            </table>  
            <%--<div id="tb">
                
                
   
        </div>--%>

        </form>
        </div>
        </div>
</body>
</html>
