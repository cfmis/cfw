<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pd_Mo_Plan.aspx.cs" Inherits="WebPortal.Products.Pd_Mo_Plan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.4.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.4.5/themes/icon.css"/>
      
       <script type="text/javascript" src="../js/jquery-easyui-1.4.5/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery-easyui-1.4.5/jquery.easyui.min.js"></script>
         <script type="text/javascript" src="../js/jquery-easyui-1.4.5/locale/easyui-lang-zh_CN.js"></script>

    <script type="text/javascript">
        function QueryData() {


                //var json = [];

                //        var j = {};
                //        var cb;
                //        j.mo_id = document.getElementById('txtMo').value;

                //        json.push(j);


                //    var obja = JSON.stringify(json);



//            异步提交数据

            $.ajax({
                url: "../ashx/Pd_Mo_Plan.ashx",
                type: "post",
                //data: { 'param': obja }, //参数
                data: {
                    mo_id: document.getElementById('txtMo').value,

                },
                datatype: "json",
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
                //alert(data);
                $("HaveInput").html(data);

            }
            function BefLoadFunction() {
                $("#ddd").html('加载中...');
            }
            function erryFunction() {
                alert("error");
            }


        }
    </script>

</head>
<body>
    <input type="text" id="txtMo" />
    <input type="button" value="查詢記錄" id="btnQuery" onclick="QueryData()" />
    <div id="tt"class="easyui-tabs" style="width: 1100px; height: 530px;margin-top: 15px">  
       <div title="已录入单位"style="padding: 10px">  
           <table id="HaveInput"title="原始数据录入情况" class="easyui-datagrid" style="width:1050px; height: 480px; padding-left: 200px;" data-options="rownumbers:true,url:'../ashx/Pd_Mo_Plan.ashx',pageSize:5,pageList:[5,10,15,20],method:'get',toolbar:'#tb',"  
               toolbar="#bar" pagination="true" rownumbers="true" fitcolumns="true" striped="true" singleselect="true">  
  
               <thead>  
                  <%--设置绑定表格的列名，列名与数据库相同--%>  
                   <tr>  
                       <th field='dep_id',width:100">部門編號</th>  
                        <th field='dep_desc',width:100">英文描述</th>  
                        <th field='dep_cdesc',width:100">中文描述</th>  
 
                    </tr>  
                </thead>  
            </table>  
            <div id="bar">  
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-edit" plain="true" onclick="editUser()">修改数据</a>  
            </div>  
   
        </div>  
        </div>

</body>
</html>
