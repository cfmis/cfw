<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Order_Trace_New.aspx.cs" Inherits="WebPortal.Sales.Sa_Order_Trace_New" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css" /> 
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>--%>
    <%--<link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>--%>
   <%-- <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>  
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>--%>

    <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/css/form_view_frame.css"/>
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
    <script src="../js/util.js" type="text/javascript"></script> 
    <script src="../js/json2.js" type="text/javascript"></script>
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <script type="text/javascript" src="../js/jq.js"></script>
    <script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>



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

    <script language="JavaScript" type="text/javascript">

    function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }
    </script>

    <%--選擇所有記錄--%>
    <script type="text/javascript">
        function selectAll() {
            var tb = document.getElementById('tableExcel');
            var rows = tb.rows;
            if (rows.length > 0) {
                for (var i = 0; i < rows.length; i++) {
                    var cells = rows[i].cells;
                    var ck = document.getElementById('chkSelectAll');
                    if (document.getElementById('chkSelectAll').checked) {
                        cells[0].childNodes[0].childNodes[0].checked = true;
                    }
                    else
                        cells[0].childNodes[0].childNodes[0].checked = false;
                }
            }
            else {
                alert("沒有記錄!");
                document.getElementById('chkSelectAll').checked = false;
                return;
            }
        }
    </script>

    <script type="text/javascript">
        function SaveData() {


//            //這個是另一種轉換成Json的方法，但在C#中暫未有解決轉換成字符的方法
//            var OrderObj =
//            {
//            id: "",
//            mo_id: ""
//            }

//            var a = JSON.parse("{\"title\":\"\",\"data\":[]}");
//            var rows = document.getElementById("tableExcel").rows.length; //获得行数(包括thead)
//            var colums = document.getElementById("tableExcel").rows[0].cells.length; //获得列数
//            if (rows > 1) {//
//                for (var i = 1; i < rows; i++) { //每行 从第二行开始因为第一行是表格的标题
//                    var OrderObj1 = new Object(OrderObj); //这里一定要new新的对象，要不然保存的都是一样的数据；都是最后一行的数据
//                    OrderObj1.id = document.getElementById("tableExcel").rows[i].cells[1].innerText;
//                    OrderObj1.mo_id = document.getElementById("tableExcel").rows[i].cells[8].innerText;

//                    a.data.push(OrderObj1); //向JSON数组添加JSON对象的方法；很关键
//                }

//                ///格式化数据
//                var obj = JSON.stringify(a); //这一行很关键
//            }





            var tb = document.getElementById('tableExcel');
            rows = tb.rows;
            if (rows.length > 0) {
//            var selectinput=tb.getElementsByTagName("select");//選擇表格中所有select的對象

            var select_flag = false;
                var json = [];
                for (var i = 0; i < rows.length; i++) {
                    var cells = rows[i].cells;
                    //這個是循環取表格中所有select的值
//                    var rowIndex = i-1;
//                    var text1 = selectinput[rowIndex].options[selectinput[rowIndex].selectedIndex].text;
//                    var value1 = selectinput[rowIndex].options[selectinput[rowIndex].selectedIndex].value;
                    if (cells[0].childNodes[0].childNodes[0].checked) {
                        select_flag = true;
                        var j = {};
                        var cb;
                        j.id = cells[5].innerText;//OC編號
                        j.order_date = cells[1].innerText;//訂單日期
                        j.mo_id = cells[8].innerText;//制單編號
                        cb = cells[11].childNodes[0].childNodes[0];
                        j.prd_status = cb.options[cb.selectedIndex].value; //生產情況
                        cb = cells[12].childNodes[0].childNodes[0];
                        j.ret_hk_status = cb.options[cb.selectedIndex].value; //大貨回港情況
                        cb = cells[14].childNodes[0].childNodes[0];
                        j.sample_hk_status = cb.options[cb.selectedIndex].value; //大貨辦情況
                        cb = cells[15].childNodes[0].childNodes[0];
                        j.chk_color_status = cb.options[cb.selectedIndex].value; //大貨批色情況
                        j.chk_color_oth = cells[16].childNodes[0].childNodes[0].value; //大貨批色說明
                        j.chk_color_date = cells[17].childNodes[0].childNodes[0].value; //批復日期
                        j.job_no = cells[18].childNodes[0].childNodes[0].value; //Job No.
                        cb = cells[19].childNodes[0].childNodes[0];
                        j.test_result = cb.options[cb.selectedIndex].value; //測試結果
                        j.test_status = cells[20].childNodes[0].childNodes[0].value; //測試情況其它
                        j.test_inv_no = cells[21].childNodes[0].childNodes[0].value; //試發票編號
                        j.test_inv_date = cells[22].childNodes[0].childNodes[0].value; //測試發票日期
                        cb = cells[23].childNodes[0].childNodes[0];
                        j.shipment = cb.options[cb.selectedIndex].value; //ShipMent
                        j.shipment_oth = cells[24].childNodes[0].childNodes[0].value; //ShipMent其它
                        j.awb_no = cells[25].childNodes[0].childNodes[0].value; //AWB No.
                        j.sent_date = cells[26].childNodes[0].childNodes[0].value; //出貨日期
                        j.remark = cells[27].childNodes[0].childNodes[0].value; //備註
                        cb = cells[28].childNodes[0].childNodes[0];
                        j.mo_status = cb.options[cb.selectedIndex].value;//制單完成情況
                        j.obj = i;
                        json.push(j);

//                        //測試下拉框取值
//                        var cb = cells[11].childNodes[0];
//                        var selectvalue = cb.options[cb.selectedIndex].value;
//                        var selecttext = cb.options[cb.selectedIndex].text;
//                        alert('row: '+i+' value: '+selectvalue+' text:' +selecttext);
//                        cb.options[cb.selectedIndex].value = "2";

                    }



                }
                if (select_flag == true) {
                    var obja = JSON.stringify(json);
                } else {
                    alert("沒有選擇更新的記錄!");
                    return;
                }

                
            }
            else {
                alert("沒有查詢的選擇記錄!");
                return;
            }



//            $.post("Sa_Order_Trace_Excel.aspx=" + new Date().getTime(), { JsonStr: obja });
            //                        $.post("../sales/Sa_Order_Trace_Excel.aspx", { name: "John", time: "2pm" });
//            $.post("../sales/Sa_Order_Trace_Excel.aspx/SayHello");






//            异步提交数据

            $.ajax({
                url: "../ashx/Sa_Order_Trace.ashx",
                type: "post",
                data: { 'param': obja }, //参数
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
                alert(data);
                document.getElementById('btnFind').click();
            }
            function BefLoadFunction() {
                $("#ddd").html('加载中...');
            }
            function erryFunction() {
                alert("error");
            }


        }
    </script>
    <script type="text/javascript">
        function exportExcel() {
            var adate = $("#adate").val();
            if (adate == "") {
                alert("日期不能为空！");
                return;
            } else {
                $(":button:not(:disabled)").attr("di", "di").attr("disabled", true);              //将所有button置为disabled  
                setTimeout(function () { $(":button[di=di]").attr("disabled", false).removeAttr("di"); }, 4000);//定时将上面disabled button复原  
                //fm.action = "relatedTransReportAction_exportExcel";
                //fm.submit();
                document.getElementById('btnExpToExcel').click();
            }
        }

    </script>
    <%--<script type="text/javascript">  
    $(document).ready(function(){  
        var height1 = $(window).height()-20;  
        $("#main_layout").attr("style","width:100%;height:"+height1+"px");  
        $("#main_layout").layout("resize",{  
            width:"100%",  
            height:height1+"px"  
        });  
    });  
      
      
    $(window).resize(function(){  
        var height1 = $(window).height()-30;  
        $("#main_layout").attr("style","width:100%;height:"+height1+"px");  
        $("#main_layout").layout("resize",{  
            width:"100%",  
            height:height1+"px"  
        });  
    });   
    </script>--%>

</head>
<body>
    <div id="container">
        <div id="content"> 
    <form runat="server">
    <%--<div style="margin-top:5px;margin-left:5px;margin-right:5px;margin-bottom:5px;">
        <div id="main_layout" class="easyui-layout"  style="width:100%; height:680px;">--%>


        <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
        </asp:ScriptManager>
    
        <asp:UpdatePanel ID="UpdatePanel" UpdateMode="Conditional"  runat="server" >
            
        <ContentTemplate>


            <%--<div data-options="region:'north',title:'查詢條件'" style="height: 40px;background-color:#95B8E7;">--%>
    <div class="div_search_frame">
            <table style="width:1000px;" border="1" cellspacing="1" cellpadding="0">
                <tr>
            <td style="width:25%">
                <div>
                <asp:Button ID="btnFind" Width="55px" runat="server" Text="查詢" OnClick="btnFind_Click" />
        
      <label>
			<input style="width:20px" runat="server" id="chkSelectExistRec" type="checkbox"/>顯示已加入追蹤表的記錄
		</label>
        </div>

        </td>

                    <td style="width:25%">
                        <div>
        <input type="button" style="width:55px;" value="更新" id="btnSaveData" onclick="SaveData()" />

        <input type="button" style="width:55px" value="取消" id="Submit1" onclick="javascript:if(!confirm('您确定要操作吗'))return  false;shenheSubmit('shenhe')" />
        
      <label>
			<input style="width:20px" runat="server" id="chkSelectAll" onclick="javascript:selectAll()" type="checkbox" />選擇所有記錄
            </label>
        </div>
        </td>
        <td style="width:50%">

            <asp:Button ID="btnExpToExcel" Width="120px" runat="server" Text="匯出到Excel" OnClick="btnExpToExcel_Click" />
            <%--<input type="button" style="width:120px;" value="匯出" id="btnExpData" onclick="exportExcel()" />--%>
            
        </td>
                    </tr>
                </table>

            
            <table style="width:1000px" border="1" cellspacing="1" cellpadding="0">
                <tr>
                    <td style="width:30%">開單日期:
                        <input type="text" id="dateStart" style="height:18px;width:90px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                        To:
                        <input type="text" id="dateEnd" style="height:18px;width:90px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                    </td>
                
                
                    <td style="width:30%">
                        制單編號:
                        <asp:TextBox ID="txtMo1" Width="90px" onKeyUp="setValue(this,txtMo2)" runat="server"></asp:TextBox>
                        To:
                        <asp:TextBox ID="txtMo2" Width="90px" runat="server"></asp:TextBox>
                    </td>
                    <td style="width:50%">
                        客戶編號:
                        <asp:TextBox ID="txtCust1" Width="80px" onKeyUp="setValue(this,txtCust2)" runat="server"></asp:TextBox>
                        To:
                        <asp:TextBox ID="txtCust2" Width="80px" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;&nbsp;OC編號:
                        <asp:TextBox ID="txtOc1" Width="90px" onKeyUp="setValue(this,txtOc2)" runat="server"></asp:TextBox>
                        To:
                        <asp:TextBox ID="txtOc2" Width="90px" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;&nbsp;客戶PO:
                        <asp:TextBox ID="txtPo1" Width="90px" onKeyUp="setValue(this,txtPo2)" runat="server"></asp:TextBox>
                        To:
                        <asp:TextBox ID="txtPo2" Width="90px" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;組別:
                        <asp:DropDownList ID="dlMo_group" Width="80px" Height="22px"  runat="server" />
                        
                    </td>
                </tr>
                </table>
   <table style="width:1000px" border="1" cellspacing="1" cellpadding="0">
    <tr>
        <td colspan="6"><label style="color:Red">注：以下查詢條件只對已加入追蹤表的記錄生效。</label>

        </td>
    </tr>
    <tr>
    <td>
    制單狀態:
    <asp:DropDownList ID="dlMo_status" Width="80px" Height="22px" runat="server" />
    </td>
    <td>
    生產情況:
    <asp:DropDownList ID="dlPrd_state" Width="80px" Height="22px" runat="server" />
    </td>
    <td>
    大貨回港情況:
    <asp:DropDownList ID="dlRet_hk_status" Width="80px" Height="22px" runat="server" />
    </td>

    <td>
    大貨辦情況:
    <asp:DropDownList ID="dlSample_hk_status" Width="80px" Height="22px" runat="server" />
    </td>
    <td>
    大貨批色情況:
    <asp:DropDownList ID="dlChk_color_status" Width="80px" Height="22px" runat="server" />
    </td>
    <td>
    <div class="checkbox">
      <label>
			<input style="width:20px" runat="server" id="chkShowNoJobNo" type="checkbox"/>只顯示沒有JobNo的記錄
		</label>
        </div>
    </td>
    </tr>
    </table>
    </div>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="show_query_img">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        <label style="font-size:12px">正在查詢,請稍候...</label>
                    </div>
                </ProgressTemplate>
    </asp:UpdateProgress>
    <%--<div id="showMsg" runat="server" visible="true">
        正在匯出數據，請等待。。。
    </div>--%>

            <%--</div>--%>

            <%--<div data-options="region:'center',title:'CCCCCCC',iconCls:'icon-ok'">  --%>
                <%--<div> --%>
            
                <table id="tableExcel"  class="flexme2">
	<thead>
    		<tr>
   				        <th width="30">選擇</th>
				        <th width="80">訂單日期</th>
                        <th width="80">客戶編號</th>
                        <th width="140">客戶描述</th>
                        <th width="80">客戶PO</th>
                        <th width="80">OC編號</th>
                        <th width="80">客戶產品編號</th>
                        <th width="80">客戶顏色編號</th>
                        <th width="100">制單編號</th>
                        <th width="80">PI貨期</th>
                        <th width="80">客人要求日期</th>
                        <th width="80">生產情況</th>
                        <th width="80">大貨回港情況</th>
                        <th width="80">大貨回港日期</th>
                        <th width="80">大貨辦情況</th>
                        <th width="80">大貨批色情況</th>
                        <th width="80">大貨批色說明</th>
                        <th width="80">批復日期</th>
                        <th width="160">Job No.</th>
                        <th width="80">測試情況</th>
                        <th width="80">測試情況其它</th>
                        <th width="80">測試發票編號</th>
                        <th width="80">測試發票日期</th>
                        <th width="80">ShipMent</th>
                        <th width="80">ShipMent其它</th>
                        <th width="100">AWB No.</th>
                        <th width="80">出貨日期</th>
                        <th width="160">備註</th>
                        <th width="80">制單狀態</th>
                        <th width="80">測試狀況</th>

                        <th width="80">發票編號</th>
                        <th width="80">發票日期</th>
                        <th width="60">發票數量(PCS)</th>
                        <th width="60">訂單數量(PCS)</th>
                        <th width="80">發貨狀態</th>
                        <th width="80">發貨日期</th>
                        <th width="80">運輸途徑</th>
                        <th width="80">客人簽收</th>
                        <th width="80">客人簽收日期</th>
                        <th width="80">回單狀態</th>
                        <th width="80">发票狀態</th>
                        <th width="80">確認人</th>
                        <th width="30"></th>
  			 </tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr> 
                    <td><input type="checkbox" style="width:20px" name="selOrder" value="<%#Eval("id")%>" /></td>
      			    <td><%#Eval("order_date")%></td>
                    <td><%#Eval("it_customer")%></td>
      			    <td><%#Eval("cust_cname")%></td>
                    <td><%#Eval("contract_id")%></td>
                    <td><%#Eval("id")%></td>
                    <td><%#Eval("customer_goods")%></td>
                    <td><%#Eval("customer_color_id")%></td>
                    <td><a target="_blank" href="Sa_Mo_ShowStatus.aspx?to_mo_id=<%#Eval("mo_id")%>"><%#Eval("mo_id")%></a></td>
                    <td><%#Eval("hk_req_date")%></td>
                    <td><%#Eval("cs_req_date")%></td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("prd_status")%>"><%#Eval("prd_status_desc")%></option>
                        <option value="01">未完成</option>
                        <option value="02">已完成</option>
                        <option value="03">強制完成</option>
                        <option value="04">已取消</option>
                        <option value="05">生產中</option>
                        </select>
                    </td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("ret_hk_status")%>"><%#Eval("ret_hk_status_desc")%>
                        </option><option value="01">未回港</option>
                        <option value="02">已回港</option>
                        </select>
                    </td>
                    <td><input type="text" name="colAct_hk_date" style="width:80%" value="<%#Eval("act_hk_date")%>"/></td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("sample_hk_status")%>"><%#Eval("sample_hk_status_desc")%>
                        </option><option value="01">未回港</option>
                        <option value="02">已回港</option>
                        <option value="03">未完成</option>
                        <option value="04">已完成</option>
                        </select>
                    </td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("chk_color_status")%>"><%#Eval("chk_color_status_desc")%></option>
                        <option value="1">待批</option>
                        <option value="2">已批</option>
                        <option value="4">已回</option>
                        <option value="5">不用批色</option>
                        </select>
                    </td>
                    <td><input type="text" name="colChk_color_oth" style="width:80%" value="<%#Eval("chk_color_oth")%>"/></td>
                    <td><input type="text" name="colChk_color_date" style="width:80%" value="<%#Eval("chk_color_date")%>"/></td>
                    <td><input type="text" name="colJob_no" style="width:80%" value="<%#Eval("job_no")%>"/></td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("test_result")%>"><%#Eval("test_result_desc")%>
                        </option><option value="01">不合格</option>
                        <option value="02">合格</option>
                        </select>
                    </td>
                    <td><input type="text" name="colTest_status" style="width:80%" value="<%#Eval("test_status")%>"/></td>
                    <td><input type="text" name="colTestInv_no" style="width:80%" value="<%#Eval("test_inv_no")%>"/></td>
                    <td><input type="text" name="colTestInv_date" style="width:80%" value="<%#Eval("test_inv_date")%>"/></td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("shipment")%>"><%#Eval("shipment_desc")%></option>
                        <option value="01">DHL</option>
                        <option value="02">HS</option>
                        <option value="03">HT</option>
                        <option value="04">司機送貨</option>
                        </select>
                    </td>
                    <td><input type="text" name="colShipment" style="width:80%" value="<%#Eval("shipment_oth")%>"/></td>
                    
                    <td><input type="text" name="colAwb_no" style="width:80%" value="<%#Eval("awb_no")%>"/></td>
                    <td><input type="text" name="colSent_date" style="width:80%" value="<%#Eval("sent_date")%>"/></td>
                    <td><input type="text" name="colRemark" style="width:80%" value="<%#Eval("remark")%>"/></td>
                    <td><select style="width:90%">
                        <option value="<%#Eval("mo_status")%>"><%#Eval("mo_status_desc")%>
                        </option><option value="01">未完成</option>
                        <option value="02">已完成</option>
                        </select>
                    </td>
                    <td><a target="_blank" href="Sa_Mo_View_Test.aspx?to_mo_id=<%#Eval("mo_id")%>"><%#Eval("customer_test_id")%></a></td>
                    <td><%#Eval("inv_id")%></td>
                    <td><%#Eval("inv_date")%></td>
                    <td><%#Eval("inv_qty_pcs")%></td>
                    <td><%#Eval("order_qty_pcs")%></td>
                    <td><%#Eval("issues_state")%></td>
                    <td><%#Eval("consignment_date")%></td>
                    <td><%#Eval("transport_style")%></td>
                    <td><%#Eval("receipt_person")%></td>
                    <td><%#Eval("receipted_date")%></td>
                    <td><%#Eval("return_state")%></td>
                    <td><%#Eval("inv_state")%></td>
                    <td><%#Eval("check_by")%></td>

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

  			            </td>
  			        </tr> 
            </table>
  			        <input type=button id="Ajax_Btn" style="display:none;" onclick="Ajax_GetHourse();" />

  
           <%-- </div>--%>


       <%-- </div>
    </div>--%>
            </ContentTemplate>

            <Triggers>

 <asp:PostBackTrigger ControlID="btnExpToExcel" />
 </Triggers>

        </asp:UpdatePanel>


        <script type="text/javascript">



     $('.flexme2').flexigrid();
     ///$('.flexme2').flexigrid({height:'auto',striped:false});


</script>


    </form>
            </div>
        </div>
</body>
</html>
