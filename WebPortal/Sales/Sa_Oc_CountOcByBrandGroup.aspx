<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Oc_CountOcByBrandGroup.aspx.cs" Inherits="WebPortal.Sales.Sa_Oc_CountOcByBrandGroup" %>

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
        <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
          <script type="text/javascript" src="../js/Sales/Js_Oc_CountOcByBrandGroup.js"></script>
        <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>

          <style type="text/css"> 
        .textbox { 
          height:20px;           margin:0; 
          padding:0 2px; 
          box-sizing:content-box;         }
          </style>



    <script>

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }

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
        function onChangeBrand() {

            //var obj = document.getElementById('txtDate_from');
            //obj.textbox('setValue', date);
            //alert("选中的时间为：" + date);

            $("#txtBrand_to").textbox('setValue', $("#txtBrand_from").textbox('getValue'));
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
                   <tr>
                       <td colspan="4">
                           <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="addDetails()" style="width:80px;height:25px">新增</a>--%>
                           <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="showMessageDialog('../Sales/Sa_OrderTest_Invoice_Details.aspx','新增',800,500,true)" style="width:80px;height:25px">新增</a>
                           <a href="#" class="easyui-linkbutton"iconCls="icon-remove"  plain="false" onclick="oobj.removed()">删除</a> --%>
                           <a href="#" id="btnFind" class="easyui-linkbutton" iconCls="icon-search"  plain="false" onclick="oobj.search()" style="width:80px;height:25px">查询</a>
                           <a href="#" id="btnExp" class="easyui-linkbutton" iconCls="icon-excel"  plain="false" onclick="Export('落單數量按牌子組別統計', $('#dg'));" style="width:80px;height:25px">匯出</a>
                           <%--<a href="#" class="easyui-linkbutton" onclick="Export('訂單測試發票資料', $('#dg'));" iconCls="icon-save" plain="true" title="导出excel文件"></a>--%>
                           <%--<a href="#" class="easyui-linkbutton" onclick="return Save_Excel()" iconCls="icon-save" plain="true" title="导出excel文件"></a>--%>
                           <%--<asp:Button ID="btnExpToExcel1" Width="80px" Height="25px" runat="server" Text="Excel" OnClick="btnExpToExcel_Click" />--%>
                       </td>
                   </tr>
                   <tr style="height:30px">

                       <td style="width:25%">
                            訂單日期:
                           <input size="10" type="text" id="txtDate_from" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})" onchange="setValue(this,txtDate_to)"/>
                           <input size="10" type="text" id="txtDate_to" style="height:18px;width:120px" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                            <%--<input id="txtDate_from" runat="server" name="txtDate_from" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser,onSelect:onChangeDate"/>
                           <input id="txtDate_to" runat="server" name="txtDate_to" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/>--%>
                       </td>
                       <td style="width:10%">
                           組別:
                           <select id="selMo_group" name="selMo_group" class="easyui-combobox" style="width:80px;height:22px" data-options="width:80, valueField: 'mo_group', textField: 'mo_group', url: '../ashx/Base_Select.ashx/GetItem?paraa=get_mogroup&parab=list'" />
                    </td>
                <td style="width:25%">
                           牌子編號:
                <input id="txtBrand_from" runat="server" type="text" class="easyui-textbox" name="txtBrand_from" style="width:120px;height:20px" data-options="formatter:myformatter,parser:myparser,onSelect:onChangeBrand" />
                <input id="txtBrand_to" runat="server" type="text" class="easyui-textbox" name="txtBrand_to" style="width:120px;height:20px" />
                       </td>
                       <td style="width:40%"></td>
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
