<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestPrint.aspx.cs" Inherits="WebPortal.Sales.TestPrint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">

     body{margin:0 auto;    
          width: 1010px;
          height: 369px;
          }
     .ipt{
                cursor: pointer;
            }
    </style>

    <script type="text/javascript">
            function printit(){
                if (confirm('确定打印吗？')){
                    try{
                        print.portrait   =  false    ;//横向打印 
                    }catch(e){
                        //alert("不支持此方法");
                    }
                     var bdhtml=window.document.body.innerHTML;//获取当前页的html代码    
                        var sprnstr="<!--begin-->";//设置打印开始区域    
                        var eprnstr="<!--end-->";//设置打印结束区域    
                        var prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)); //从开始代码向后取html    
                        var prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));//从结束代码向前取html    
                        window.document.body.innerHTML=prnhtml;    
                        window.print();    
                        window.document.body.innerHTML=bdhtml;    
                }

            }
        </script>


</head>
<body>
    <object id="WebBrowser"  class="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height="0" name="wb1" width="3"></object>      
            <div id="kpr" style="margin:30px">      
            <input class="ipt" type="button"  value="打印"           onclick ="javascript:printit();"/>      
            <input class="ipt" type="button"   value="关闭"           onclick ="javascript:window.close();"/>    
            </div>
     <!--begin-->
            <h3>打印标题</h3>
           <table>
               <tr>
                  <td>内容</td>
                  <td>内容</td>
                  <td>内容</td>
                  <td>内容</td>
                  <td>内容</td>
                  <td>内容</td>
                  <td>内容</td>
                  <td>内容</td>
               </tr>
               <tr>
                  <td>内容2</td>
                  <td>内容2</td>
                  <td>内容2</td>
                  <td>内容2</td>
                  <td>内容2</td>
                  <td>内容2</td>
                  <td>内容2</td>
                  <td>内容2</td>
               </tr>
           </table> 
    <!--end-->

</body>
</html>
