<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pd_Mo_OutSide_ReWork_SetMark.aspx.cs" Inherits="WebPortal.Products.Pd_Mo_OutSide_ReWork_SetMark" %>

<%--<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>--%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
    <link rel="stylesheet" href="/css/form_view_frame.css"/>
    <%--<link rel="stylesheet" href="/css/bootstrap.min.css"/>  --%>
   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>

    <style type="text/css">
    #addMian_b {width:980px;height:450px;background:#000;-moz-opacity:0.2; filter:alpha(opacity=25);margin:-30px 10 0 10px; position:absolute;}
#addMian_t { z-index:20;border:1px solid #a4d5e3;width:960px;height:450px;background:#FFF;margin:-15px 0 0 5px; position:absolute;}
body {
	margin-left: 10px;
	margin-top: 0px;
}
    
    </style>

    <script type="text/javascript">

        function fixgrid() {

            $('.flexme2').flexigrid();
            ///$('.flexme2').flexigrid({height:'auto',striped:false});
        }

</script>

    <script type="text/javascript">

        function showDetails(obj) {
            
                //$('#dg').datagrid('selectRow',index);// 关键在这里  
                //var row = $('#dg').datagrid('getSelected');  
                //if (row){  
                //        //$('#dlg').dialog('open').dialog('setTitle','修改学生信息');  
                //        //$('#fm').form('load',row);  
                //    //url = '${ctx}updateStudent.do?id='+row.id;  
                //    //showModalDialog('../Products/Pd_Mo_Plan_Details.aspx?dep_id=' + row.dep_id + '&dep_cdesc=' + row.dep_cdesc, 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no');
                //    //window.open('../Products/Pd_Mo_Plan_Details.aspx');
                //    window.showModelessDialog('../Products/Pd_Mo_Plan_Details.aspx?prd_mo=' + row.prd_mo
                //        + '&prd_item=' + row.prd_item + '&arrange_id=' + row.arrange_id,
                //        'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no');
                //    }  
            }  

 
    </script>
    <script type="text/javascript">
    var selectedTr = null;
    function c1(obj) {
        //obj.style.backgroundColor = 'blue'; //把点到的那一行变希望的颜色; 
        //if (selectedTr != null)
        //    selectedTr.style.removeAttribute("backgroundColor");
        //if (selectedTr == obj)
        //    selectedTr = null;//加上此句，以控制点击变白，再点击反灰 
        //else
        //    selectedTr = obj;
        var table = document.getElementById("tableExcel");
        var child = table.getElementsByTagName("tr")[this.index + 1];
        alert(child);
    }
    /*得到选中行的第一列的值*/
    function check() {
        if (selectedTr != null) {
            var str = selectedTr.cells[1].childNodes[0].value;
            //document.getElementById("lab").innerHTML = str;
            alert(str);
        } else {
            alert("请选择一行");
        }
    }
    /*删除选中行*/
    function del() {
        if (selectedTr != null) {
            if (confirm("确定要删除吗?")) {
                alert(selectedTr.cells[0].childNodes[0].value);
                var tbody = selectedTr.parentNode;
                tbody.removeChild(selectedTr);
            }
        } else {
            alert("请选择一行");
        }
    }
</script>
    

    <script type="text/javascript">
        function rep(t) {
            var tb = document.getElementById('tableExcel');
            rows = tb.rows;
            var row = t.parentNode.parentNode.parentNode.rowIndex;
            var cells = rows[row].cells;
            
            //獲取复選框的值
            var chk = cells[0].childNodes[0].firstChild.checked;


            var arrange_id = cells[0].childNodes[0].firstChild.value;
            var prd_mo = cells[2].innerText;
            var prd_item = cells[5].innerText;
            //獲取下拉框的值
            var cb = cells[4].childNodes[0].childNodes[0];
            var val = cb.options[cb.selectedIndex].value;
            //獲取文本框的值
            var qty = cells[8].childNodes[0].firstChild.value;
            //alert(str);
            
            //window.showModelessDialog('../Products/Pd_Mo_Plan_Details.aspx?prd_mo=' + prd_mo
            //            + '&prd_item=' + prd_item + '&arrange_id=' + arrange_id,
            //            'subpage', 'dialogWidth:500px;dialogHeight:400px;center:yes;help:no;resizable:no;status:no');
            

            var url = '../Products/Pd_Mo_Plan_Details.aspx?prd_mo=' + prd_mo + '&prd_item=' + prd_item + '&arrange_id=' + arrange_id;
            var title = '生產排期--員工安排';
            var width = 500;
            var height = 400;
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
</script>
    <script>   
  function   alert_table()   
  {   
  if   (event.srcElement.tagName   ==   "TD")   
  {   
  var   objTD   =   event.srcElement,   objTR   =   objTD.parentElement;   
  alert("现在在第"   +   (objTR.rowIndex   +   1)   +   "行，第"   +   (objTD.cellIndex   +   1)   +"列");   
  }   
  }   
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

        

        <form runat="server">

            <asp:FileUpload ID="fileId" runat="server" Width ="400px" Height ="25px" />

        <asp:Button ID="btnUpload" runat="server" Text="上传" onclick="btnUpload_Click" Width ="80px" Height="25px" />
            <label style="color:blue">將排期文件匯入系統，必須為正確格式的Excel文件！</label>
            


    <%--<div id="tt"class="easyui-tabs" style="width: 100%; height: 600px;margin-top: 15px">
        
       <div title="排期錄入"style="padding: 10px">  --%>
           

           <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
        </asp:ScriptManager>
    
        <asp:UpdatePanel ID="UpdatePanel" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>


           <%--<form runat="server">--%>
               <table style="width:800px" border="0">
                   <tr style="height:30px">
                       <td style="width:50%">
                           部門:
                <asp:DropDownList ID="dlDep" Width="120px" Height="26px"  runat="server" />
                <%--<div id="message" style="color:blue;"></div>--%>
                供應商:
                <input type="text" id="txtVendor_id" style="width:120px" runat="server" />
                       </td>
                       <td style="width:30%">
                           制單編號:
                           <input type="text" id="txtPrd_mo" style="width:120px" runat="server" />
                       </td>
                       <td style="width:20%">
                           <asp:Button ID="btnFind" Width="90%" runat="server"
              Text="查询" OnClick="Select_Click" /></td>
                   </tr>
                  <%-- <tr style="height:30px">
                       <td colspan="3">
        

                           
                           </td>
                       </tr>--%>
               </table>



           <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="show_query_img">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
    </asp:UpdateProgress> 


           <table id="tableExcel"  class="flexme2">
	<thead>
    		<tr>
                <th width="60">
                    部門</th>

            	<th width="80">
                    供應商</th>
            
            	<th width="100">
                    制單編號</th>
            	<th width="160">
                    貨品編碼</th>
            	<th width="260">
                    電鍍回覆</th>
            	
            	<th width="80">
                    建立人</th>
   
                <th width="160">
                    建立日期</th>
                
            	


                <th width="30"></th>

    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
               
               <td>
            	<%#Eval("dep_id")%>
            	
            	</td>
               <td><%#Eval("vendor_id")%></td>
               <td><%#Eval("mo_id")%></td>
                <td><%#Eval("goods_id")%></td>
                <td><%#Eval("remark")%> </td>
                <td><%#Eval("crusr")%> </td>
            	<td><%#Eval("crtim")%> </td>

    		     <td></td>
    		</tr>
        
        </ItemTemplate>
        </asp:Repeater>
      
    		
    </tbody>
</table>


           <table>
        <tr>
            <td align="right" colspan="9">
                第<asp:DropDownList ID="dlCurrentPage" OnSelectedIndexChanged="dlCurrentPage_Click" AutoPostBack="true" Width="50px" Height="22px" runat="server"></asp:DropDownList>页&nbsp;/&nbsp;共
                <asp:Literal id="lTotalPage" runat="server" />页
            <asp:Button ID="firstBtn" runat="server" Text="首页" onclick="firstBtn_Click" />
            <asp:Button ID="prevBtn" runat="server" Text="上页" onclick="prevBtn_Click" />
            <asp:Button ID="nextBtn" runat="server" Text="下页" onclick="nextBtn_Click" />
            <asp:Button ID="lastBtn" runat="server" Text="末页" onclick="lastBtn_Click" />
  			             <%--第<asp:Literal ID="CurrentPage" runat="server" />页&nbsp;/&nbsp;共<asp:Literal ID="TotalPage" runat="server" />页 
  			              &nbsp;&nbsp;&nbsp;&nbsp;
  			                <asp:Button ID="firstBtn" runat="server" Text="首页" onclick="firstBtn_Click" />
  			                <asp:Button ID="prevBtn" runat="server" Text="上页" onclick="prevBtn_Click" />
  			                <asp:Button ID="nextBtn" runat="server" Text="下页" onclick="nextBtn_Click" />
  			                <asp:Button ID="lastBtn" runat="server" Text="末页" onclick="lastBtn_Click" />--%>
  			            </td>
  			        </tr> 
            </table>
  			        <input type=button id="Ajax_Btn" style="display:none;" onclick="Ajax_GetHourse();" />



           </ContentTemplate>
        </asp:UpdatePanel>

           <%--</div>--%>


        <%--<br />
           <div class="pageLink" id="pageLink">
        <cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
            backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
            pagesize="10" showfirstlast="true" showpagenumbers="true" PagingMode="PostBack"></cc1:collectionpager>
            </div>--%>
          

        


 <script type="text/javascript">



     $('.flexme2').flexigrid();
     ///$('.flexme2').flexigrid({height:'auto',striped:false});


</script>
            

        <%--</div>--%>

            

            </form>


        </div>
        </div>
</body>
</html>
