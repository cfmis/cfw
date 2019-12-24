<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pd_Mo_Plan_New.aspx.cs" Inherits="WebPortal.Products.Pd_Mo_Plan_New" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>--%>
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
     <title>排期錄入</title>
    
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
     <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
      
       <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
         <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
          <script type="text/javascript" src="../js/Prd/Sa_Mo_Plan.js"></script>

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
                    window.showModelessDialog('../Products/Pd_Mo_Plan_Details.aspx?prd_mo=' + row.prd_mo
                        + '&prd_item=' + row.prd_item + '&arrange_id=' + row.arrange_id,
                        'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no');
                    }  
            }  

 
    </script>


    <script type="text/javascript">

        $(document).ready(function () {
            //addItems();
        });

    //动态绑定下拉框项  
        function addItems() {

           $.ajax({  
               url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=b",    //后台webservice里的方法名称  
               type: "post",
               dataType: "json",
               contentType: "application/json",  
               traditional: true,  
                success: function (data) {  
                    for (var i in data) {  
                        var jsonObj =data[i];  
                        var optionstring = "";  
                        for (var j = 0; j < jsonObj.length; j++) {  
                            optionstring += "<option value=\"" + jsonObj[j].dep_id + "\" >" + jsonObj[j].dep_cdesc + "</option>";  
                        }  
                        $("#selDep").html("<option value='0'>请选择...</option> " + optionstring);
                    }  
                },  
                error: function (msg) {  
                    alert("出错了！");  
                }  
            });            
        };  
         
    </script>   

    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=dlDep.ClientID%>").bind("change", function () {
                if ($(this).val() != "") {
                    //$("#message").text("Text：" + $(this).find(":selected").text() + "  Value:" + $(this).val());
                    $("#idDep").val($(this).val());

                }
 
            });
        });
       
    </script>



</head>
<body>
    <div id="container">  
        <table class="table_SiteMapPath">
    <tr>
    <td>
    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
          </asp:SiteMapPath>
    </td>
    </tr>
    </table>

    <div id="content"> 
    <%--<div id="tt" style="width: 500px; height: 230px;margin-top: 15px;overflow:scroll;overflow-y:scroll;">--%>
        <%--<div id="tt"class="easyui-tabs" style="width: 1100px; height: 530px;margin-top: 15px">  --%>
    <%--<table id="dg" ></table> --%>
<%--</div>--%>
<%--<div id="tb" style="padding:5px;"> 
<div>
<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="obj.add()">添加</a>
<a href="#"class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="obj.edit()" >修改</a>
<a href="#" class="easyui-linkbutton"iconCls="icon-remove"  plain="true" onclick="obj.removed()">删除</a> 
<a href="#"class="easyui-linkbutton" iconCls="icon-save" plain="true" style="display:none" id="save" onclick="obj.save()">保存</a> 


<a href="#" class="easyui-linkbutton"iconCls="icon-redo" plain="true"  style="display:none"id="redo" onclick="obj.redo()">取消编辑 </a>

&nbsp;&nbsp;&nbsp;&nbsp;

查询学号：<input type="text" name="code" class="textbox" />


 
<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="obj.search()">查询</a> 
</div>
</div>--%>

    <form runat="server">

    <div id="tt"class="easyui-tabs" style="width: 100%; height: 600px;margin-top: 15px">
        
       <div title="排期錄入"style="padding: 10px">  
           
           <%--<form runat="server">--%>
               <table style="width:1500px" border="0">
                   <tr style="height:30px">
                       <td>
                           排期部門:
                <asp:DropDownList ID="dlDep" Width="120px" Height="26px"  runat="server" />
                <%--<div id="message" style="color:blue;"></div>--%>
                排單日期:
                <input type="text" id="dateArrange" name="txtArrangeDate" runat="server" style="height:20px;width:120px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                       </td>
                   </tr>
                   <tr style="height:30px">
                       <td>
        <asp:FileUpload ID="fileId" runat="server" Width ="400px" Height ="25px" />

        <asp:Button ID="btnUpload" runat="server" Text="上传" onclick="btnUpload_Click" Width ="80px" Height="25px" />

                           <label style="color:blue">將排期文件匯入系統，必須為正確格式的Excel文件！</label>
                           </td>
                       </tr>
               </table>
    <%--</form>--%>
           

           <%--<table id="dg"title="原始数据录入情况" class="easyui-datagrid" style="width:1050px; height: 480px; padding-left: 200px;"
               toolbar="#bar" pagination="true" rownumbers="true" fitcolumns="true" striped="true" singleselect="true"> --%> 
  <table id="dg" style="height: 480px; padding-left: 200px;" >

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
                
                制單編號:
                <input type="text" name="txtMo" style="width:120px;height:20px" />
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="oobj.search()" style="width:120px;height:26px">查询</a>
                <%--<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="oobj.add()">添加</a>
                <a href="#"class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="oobj.edit()" >修改</a>
                <a href="#" class="easyui-linkbutton"iconCls="icon-remove"  plain="true" onclick="oobj.removed()">删除</a> 
                <a href="#"class="easyui-linkbutton" iconCls="icon-save" plain="true" style="display:none" id="save" onclick="oobj.save()">保存</a> 


                <a href="#" class="easyui-linkbutton"iconCls="icon-redo" plain="true"  style="display:none"id="redo" onclick="oobj.redo()">取消编辑 </a>


                
                
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="oobj.selectRow()">顯示記錄</a> 
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="oobj.selectAllRow()">顯示選中行記錄</a> 
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="oobj.showDetails()">顯示詳細記錄</a> --%>
            </div>  
   
        </div>
        
        
          
        </div>
        </form>
        </div>
        </div>
    
</body>
</html>
