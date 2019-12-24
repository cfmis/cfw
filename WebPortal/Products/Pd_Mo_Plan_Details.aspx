<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pd_Mo_Plan_Details.aspx.cs" Inherits="WebPortal.Products.Pd_Mo_Plan_Details" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=big5"/>
    <title>排期詳細</title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
      
       <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
         <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
          <script type="text/javascript" src="../js/Prd/Sa_Mo_Plan_Details.js"></script>

          <style type="text/css"> 
        .textbox { 
          height:20px;           margin:0; 
          padding:0 2px; 
          box-sizing:content-box;         }
          </style>

    <script type="text/javascript">

        function showDetails1(index){  
                $('#dg').datagrid('selectRow',index);// 关键在这里  
                var row = $('#dg').datagrid('getSelected');  
                if (row){  
                        //$('#dlg').dialog('open').dialog('setTitle','修改学生信息');  
                        //$('#fm').form('load',row);  
                    //url = '${ctx}updateStudent.do?id='+row.id;  
                    //showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id=' + row.dep_id + '&dep_cdesc=' + row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no');
                    //window.open('../Products/Pd_Mo_Plan_Details.aspx');
                    //window.showModelessDialog('../Products/Pd_Mo_Plan_Details.aspx?prd_dep=' + row.prd_dep + '&prd_mo=' + row.prd_mo + '&prd_item=' + row.prd_item + '&now_date=' + row.now_date,
                    //    'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no');
                    oobj.removed();
                    }  
            }  

 
    </script>
    <script type="text/javascript">

        $(document).ready(function () {
            //oobj.search();
            bindWork_type();
            //document.getElementById("txtWorker_id").focus();
            $("#txtWorker_id").focus();
            //getValue();
            //$("#txtPrd_dep").val('abc');
        });

    //动态绑定下拉框项  
        function bindWork_type() {

           $.ajax({  
               url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_work_type&parab=b",    //后台webservice里的方法名称  
               type: "post",
               dataType: "json",
               contentType: "application/json",  
               traditional: true,  
                success: function (data) {  
                    for (var i in data) {  
                        var jsonObj =data[i];  
                        var optionstring = "";  
                        for (var j = 0; j < jsonObj.length; j++) {  
                            optionstring += "<option value=\"" + jsonObj[j].work_type_id + "\" >" + jsonObj[j].work_type_desc + "</option>";
                        }  
                        $("#selWork_type").html("<option value='0'>请选择...</option> " + optionstring);
                    }  
                },  
                error: function (msg) {  
                    alert("出错了！");  
                }  
           });
          
        };

        function getValue() {
            document.getElementById("txtPrd_dep").innerText = $.getUrlParam('prd_dep');// "abc";
        }
         
    </script>   



</head>
<body>

    <div id="container">
        <div id="content">

    <input type="text" id="txtPrd_mo" style="width:120px;" readonly="true" runat="server" />
    <input type="text" id="txtPrd_item" style="width:220px" readonly="true" runat="server" />
    <%--<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="oobj.search()" style="width:90%;height:26px">查询</a>--%>
    <div id="tt"class="easyui-tabs" style="width: 100%; height: 360px;margin-top: 15px">
        
       <div title="排期--安排人員"style="padding: 10px">  
           <table style="width:100%;height:300px" border="0">
               <%--<tr>--%>
                   <%--<td>--%>
  <%--<table id="dg" style="width:1050px; height: 480px; padding-left: 200px;" >


            </table>  --%>

                       <%--</td>--%>
                  <%-- </tr>--%>
               <tr>
                   <td style="height:30px">
                       工號:

                       <input type="text" id="txtWorker_id" style="height:20px;width:120px" />

                       工作類型:

                       <select id="selWork_type" style="width:120px;height:25px"></select>

                   <a href="#" class="easyui-linkbutton" style="width:120px" iconCls="icon-add" plain="true" onclick="oobj.save()">添加</a>

                       </td>
                   </tr>
               <tr>
                   <td>
                       <table id="dg" style="height: 270px; padding-left: 200px;" >


            </table>  
                   </td>
                       </tr>
                   
   </table>
        </div>

        </div>

            </div>
    </div>
</body>
</html>
