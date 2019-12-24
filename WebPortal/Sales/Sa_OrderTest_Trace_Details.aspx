<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_OrderTest_Trace_Details.aspx.cs" Inherits="WebPortal.Sales.Sa_OrderTest_Trace_Details" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>測試編輯</title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />

     <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
      <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
      
       <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
         <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/publicfuncs.js"></script>

    <%--<script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>--%>

    <%--<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css"/>
    <script type="text/javascript" src="../js/jq.js"></script>--%>
    <script src="../js/json2.js" type="text/javascript"></script>



    <script>  
 
      function myformatter(date){  
           var y = date.getFullYear();  
           var m = date.getMonth()+1;  
            var d = date.getDate();  
            return y+'/'+(m<10?('0'+m):m)+'/'+(d<10?('0'+d):d);  
        }  
          
        function myparser(s){  
            if (!s) return new Date();  
            var ss = (s.split('/'));  
            var y = parseInt(ss[0],10);  
            var m = parseInt(ss[1],10);  
            var d = parseInt(ss[2],10);  
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)){  
                return new Date(y,m-1,d);  
            } else {  
                return new Date();  
            }  
        }  
  
       //页面加载  
  
        $(function () {

            //设置时间  
            var curr_time = new Date();
            $("#dd").datebox("setValue", myformatter(curr_time));
            //$('#txtRt_from_date').textbox('textbox').attr('readonly', true);

            $('#btnSave').click(function () {
                saveData();
            });
            $('#btnNew').click(function () {
                addNew();
            });
            $('#btnAddTest').click(function () {
                addTestMethod();
            });
            //$.setAreabox('selLab_House', "/Report/test/test");//初始销区下拉框
            //$("selLab_House").combobox('setValue', 'value');
            //$("#txtEndTime").datebox("setValue",myformatter(curr_time));  
            ////获取时间  
            //var beginTime=$("#txtBeginTime").datebox("getValue");  
            //var endTime=$("#txtEndTime").datebox("getValue");  
            //addItems();
            $("input", $("#txtMo_id").next("span")).blur(function () {
                //showValue('Hello');
                //findOcByMo();
                findOcByMo();
                
            });
            var mo_id = getUrlParam("mo_id");
            //var mo_id = GetQueryString("mo_id");
            if (mo_id != '') {
                $("#txtMo_id").textbox('setValue', mo_id);
                findOcByMo();
            }
        });


        //function GetQueryString(name) {

        //    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");

        //    var r = window.location.search.substr(1).match(reg);

        //    if (r != null) return unescape(r[2]); return null;

        //}

        function showValue(val) {
            alert(val);
        }

 
        function setValue() {
            document.getElementById('txtRefNo').value = "ABC"; 
        }
        function addNew() {
            $("#txtMo_id").textbox('setValue', '');
            $("#txtRt_from_date").textbox('setValue','');
            $("#txtRefNo").textbox('setValue', '');
            $("#selLab_House").textbox('setValue','');
            $("#txtMat_desc").textbox('setValue','');
            $("#txtCust_Item").textbox('setValue','');
            $("#txtCust_Size").textbox('setValue','');
            $("#txtCust_Color").textbox('setValue','');
            $("#txtSeason").textbox('setValue','');
            $("#txtDivision").textbox('setValue', ''); 
            $("#selTest_method").textbox('setValue', '');
            $("#txtTest_method").textbox('setValue','');
            $("#txtBulk_mo").textbox('setValue','');
            $("#txtSent_to_hk").textbox('setValue','');
            $("#txtPass_to_lab").textbox('setValue','');
            $("#txtTest_results").textbox('setValue','');
            $("#txtRsl").textbox('setValue','');
            $("#txtRsl_rp_date").textbox('setValue','');
            $("#txtAppearance").textbox('setValue','');
            $("#txtAppearance_rp_date").textbox('setValue','');
            $("#txtResist").textbox('setValue','');
            $("#txtResist_rp_date").textbox('setValue','');
            $("#txtSalvia").textbox('setValue','');
            $("#txtSalvia_rp_date").textbox('setValue','');
            $("#txtSnap").textbox('setValue','');
            $("#txtSnap_rp_date").textbox('setValue','');
            $("#txtUnderpart").textbox('setValue','');
            $("#txtUnderpart_rp_date").textbox('setValue','');
            $("#txtFtc_cmmts").textbox('setValue', '');
            $('#txtMo_id').textbox('textbox').focus();
        }
        function addTestMethod() {
            if ($("#selTest_method").textbox('getValue') != '')
                $("#txtTest_method").textbox('setValue', $("#txtTest_method").textbox('getValue') + $("#selTest_method").textbox('getValue') + ';');
        }
        //通過制單編號查找OC資料
        function findOcByMo() {
            if (document.getElementById('txtMo_id').value == '')
                return;
            var mo_id = document.getElementById('txtMo_id').value; 
            
            $.ajax({
                //url: "../ashx/Base_Select.ashx/GetItem?paraa=pd_mo_plan_dep&parab=b",    //后台webservice里的方法名称  
                url: "../ashx/Ax_SaOrderTest_Trace.ashx/GetItem?paraa=get_oc_a&mo=" + mo_id,
                type: "post",
                dataType: "json",
                contentType: "application/json",
                traditional: true,
                success: function (data) {

                    for (var i in data) {
                        var jsonObj = data[i];
                        $("#txtRt_from_date").textbox('setValue', jsonObj[0].rt_from_date);
                        $("#txtRefNo").textbox('setValue',jsonObj[0].ref_no);
                        $("#selLab_House").textbox('setValue',  jsonObj[0].lab_house);
                        $("#txtMat_desc").textbox('setValue', jsonObj[0].mat_desc);
                        $("#txtCust_Item").textbox('setValue', jsonObj[0].cust_item);
                        //$("#txtCust_Size").textbox('setValue', jsonObj[0].add_remark);
                        $("#txtCust_Color").textbox('setValue', jsonObj[0].cust_color);
                        $("#txtSeason").textbox('setValue', jsonObj[0].season);
                        $("#txtDivision").textbox('setValue', jsonObj[0].division);
                        $("#txtTest_method").textbox('setValue', jsonObj[0].test_method);
                        $("#txtBulk_mo").textbox('setValue',  jsonObj[0].bulk_mo);
                        $("#txtSent_to_hk").textbox('setValue',  jsonObj[0].sent_to_hk);
                        $("#txtPass_to_lab").textbox('setValue',  jsonObj[0].pass_to_lab);
                        $("#txtTest_results").textbox('setValue',  jsonObj[0].test_results);
                        $("#txtRsl").textbox('setValue',  jsonObj[0].rsl);
                        $("#txtRsl_rp_date").textbox('setValue',  jsonObj[0].rsl_rp_date);
                        $("#txtAppearance").textbox('setValue',  jsonObj[0].appearance);
                        $("#txtAppearance_rp_date").textbox('setValue',  jsonObj[0].appearance_rp_date);
                        $("#txtResist").textbox('setValue',  jsonObj[0].resist);
                        $("#txtResist_rp_date").textbox('setValue',  jsonObj[0].resist_rp_date);
                        $("#txtSalvia").textbox('setValue',  jsonObj[0].salvia);
                        $("#txtSalvia_rp_date").textbox('setValue',  jsonObj[0].salvia_rp_date);
                        $("#txtSnap").textbox('setValue',  jsonObj[0].snap);
                        $("#txtSnap_rp_date").textbox('setValue',  jsonObj[0].snap_rp_date);
                        $("#txtUnderpart").textbox('setValue',  jsonObj[0].underpart);
                        $("#txtUnderpart_rp_date").textbox('setValue',  jsonObj[0].underpart_rp_date);
                        $("#txtFtc_cmmts").textbox('setValue',  jsonObj[0].ftc_cmmts);
                        

                    }
                },
                error: function (msg) {
                    alert("出错了！");
                    //alert(msg);
                    //alert(mo_id);
                }
            });

        };



        //动态绑定下拉框项  
        function addItems() {

            $.ajax({
                //url: "../ashx/Base_Select.ashx/GetItem?paraa=get_oclab&parab=b",    //后台webservice里的方法名称  
                url: "../ashx/Ax_SaOrderTest_Trace.ashx/GetItem?paraa=get_oclab&parab=b",    //后台webservice里的方法名称  
                type: "post",
                dataType: "json",
                contentType: "application/json",
                traditional: true,
                success: function (data) {
                    for (var i in data) {
                        var jsonObj = data[i];
                        var optionstring = "";
                        for (var j = 0; j < jsonObj.length; j++) {
                            //optionstring += "<option value=\"" + jsonObj[j].dep_id + "\" >" + jsonObj[j].dep_cdesc + "</option>";
                            optionstring += "<option value=\"" + jsonObj[j].id + "\" >" + jsonObj[j].edesc + "</option>";
                        }
                        $("#selLab_House").html("<option value='0'>请选择...</option> " + optionstring);
                    }
                },
                error: function (msg) {
                    alert("出错了！");
                }
            });
        };


        function onChangeDate(date) {
            alert("选中的时间为：" + date);

        }

</script>  

    <script type="text/javascript">
        function saveData() {
            if (validData() == false)
                return;
            var json = [];

            var j = {};
            j.mo_id = document.getElementById('txtMo_id').value;
            j.rt_from_date = $("#txtRt_from_date").textbox('getValue');
            j.ref_no = $("#txtRefNo").textbox('getValue');
            j.lab_house = $("#selLab_House").textbox('getValue');
            j.mat_desc = $("#txtMat_desc").textbox('getValue');
            j.cust_item = $("#txtCust_Item").textbox('getValue');
            j.cust_size=$("#txtCust_Size").textbox('getValue');
            j.cust_color=$("#txtCust_Color").textbox('getValue');
            j.season=$("#txtSeason").textbox('getValue');
            j.division = $("#txtDivision").textbox('getValue'); 
            j.test_method = $("#txtTest_method").textbox('getValue');
            j.bulk_mo=$("#txtBulk_mo").textbox('getValue');
            j.sent_to_hk=$("#txtSent_to_hk").textbox('getValue');
            j.pass_to_lab = $("#txtPass_to_lab").textbox('getValue');
            j.test_results = $("#txtTest_results").textbox('getValue');
            j.rsl = $("#txtRsl").textbox('getValue');
            j.rsl_rp_date = $("#txtRsl_rp_date").textbox('getValue');
            j.appearance = $("#txtAppearance").textbox('getValue');
            j.appearance_rp_date = $("#txtAppearance_rp_date").textbox('getValue');
            j.resist = $("#txtResist").textbox('getValue');
            j.resist_rp_date = $("#txtResist_rp_date").textbox('getValue');
            j.salvia = $("#txtSalvia").textbox('getValue');
            j.salvia_rp_date = $("#txtSalvia_rp_date").textbox('getValue');
            j.snap = $("#txtSnap").textbox('getValue');
            j.snap_rp_date = $("#txtSnap_rp_date").textbox('getValue');
            j.underpart = $("#txtUnderpart").textbox('getValue');
            j.underpart_rp_date = $("#txtUnderpart_rp_date").textbox('getValue');
            j.ftc_cmmts = $("#txtFtc_cmmts").textbox('getValue');
            json.push(j);



            var obja = JSON.stringify(json);


            //            异步提交数据

            $.ajax({
                url: "../ashx/Ax_SaOrderTest_Trace.ashx/GetItem?paraa=update",
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
                //document.getElementById('btnFind').click();
            }
            function BefLoadFunction() {
                $("#ddd").html('加载中...');
            }
            function erryFunction() {
                alert("error");
            }


        }


        function validData() {
            if (document.getElementById('txtMo_id').value == '') {
                alert("制單編號不能為空!");
                $('#txtMo_id').textbox('textbox').focus();
                return false;
            }
        }


    </script>


</head>
<body>

	<%--<div style="margin:20px 0;"></div>--%>
	<div class="easyui-panel" style="width:98%;padding:3px 3px">
        <div>
            <a id="btnNew" href="#" class="easyui-linkbutton" iconCls="icon-add" style="width:80px;height:25px">新增</a>
			<a id="btnSave" href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:80px;height:25px">儲存</a>
            <hr />
		</div>
        <table border="0" style="width:100%">
            <tr>
                <td align="right" style="width:22%">
		<%--<div style="margin-bottom:20px">--%>
			制單編號:<input id="txtMo_id" class="easyui-textbox" data-options="prompt:'輸入制單編號...'" style="width:120px;height:22px" maxlength="9"/>
                    
			<%--<input class="easyui-textbox" data-options="prompt:'輸入制單編號...',validType:'email'" style="width:100%;height:32px"/>--%>
            </td>
                <td align="right" style="width:26%">
		<%--</div>--%>
		<%--<div style="margin-bottom:20px">--%>
			Rec'd Test Form Date:
			<%--<input id="dd" type="text" class="easyui-datebox" style="width:120px;height:22px" required="required"/>--%>
            <input id="txtRt_from_date" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/>
                    </td>
		<%--</div>--%>
                
            
        <td align="right" style="width:30%">
		<%--<div style="margin-bottom:20px">--%>
			Ref No.:
			<input id="txtRefNo" class="easyui-textbox" style="width:120px;height:22px"/>
		<%--</div>--%>
            </td>

            <td align="right" style="width:22%">Lab House:
                <%--<select id="selLab_House" class="easyui-combobox1" style="width:120px;height:22px" />--%>
                <select id="selLab_House" name="selLab_House" class="easyui-combobox" style="width:120px;height:22px" data-options="width:120, valueField: 'id', textField: 'edesc', url: '../ashx/Ax_SaOrderTest_Trace.ashx/GetItem?paraa=get_oclab'" />
            </td>
        </tr>
        <tr>
            
            <td align="right">Material:<input id="txtMat_desc" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Item:<input id="txtCust_Item" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Seze:<input id="txtCust_Size" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Color:<input id="txtCust_Color" class="easyui-textbox" style="width:120px;height:22px"/></td>
        </tr>
        <tr>
            <td align="right">Season:<input id="txtSeason" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Division:<input id="txtDivision" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Test Method:
                <select id="selTest_method" class="easyui-combobox" style="width:90px;height:22px" data-options="width:120, valueField: 'edesc', textField: 'edesc',editable:'false', url: '../ashx/Ax_SaOrderTest_Trace.ashx/GetItem?paraa=get_octest'" />
                <%--<a id="btnAddTest" href="#" class="easyui-linkbutton" style="width:60px;height:22px">添加></a>--%>
                <input id="btnAddTest" type="button" style="width:30px;height:22px" value=">" />
                    
            </td>
            <td align="right">Test Method:
                <input id="txtTest_method" class="easyui-textbox" style="width:120px;height:22px"/>

            </td>
            
        </tr>
        <tr>
            <td align="right">Bulk Order MO#:<input id="txtBulk_mo" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <%--<td align="right">SENT TO HK DATE:<input id="txtSent_to_hk" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="onSelect:onChangeDate"/></td>--%>
            <td align="right">Sent To HK Date:<input id="txtSent_to_hk" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/></td>
            <td align="right">Pass to Lab Date:<input id="txtPass_to_lab" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/></td>
            <td align="right">Test Results:<input id="txtTest_results" class="easyui-textbox" style="width:120px;height:22px"/></td>
            
        </tr>
        <tr>
            <td align="right">RSL:<input id="txtRsl" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Report Date:<input id="txtRsl_rp_date" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/></td>
            <td align="right">Appearance after washing:<input id="txtAppearance" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Report Date:<input id="txtAppearance_rp_date" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/></td>
        </tr>
        <tr>
            <td align="right">Resist to water:<input id="txtResist" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Report Date:<input id="txtResist_rp_date" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/></td>
            <td align="right">CF to Salvia:<input id="txtSalvia" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Report Date:<input id="txtSalvia_rp_date" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/></td>
        </tr>
        <tr>
            <td align="right">Snap Action:<input id="txtSnap" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Report Date:<input id="txtSnap_rp_date" type="text" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/></td>
            <td align="right">RSL Underpart:<input id="txtUnderpart" class="easyui-textbox" style="width:120px;height:22px"/></td>
            <td align="right">Report Date:<input id="txtUnderpart_rp_date" class="easyui-datebox" style="width:120px;height:22px" data-options="formatter:myformatter,parser:myparser"/></td>
        </tr>
        <tr>
            <td colspan="4" align="left">FTC CMMTS:<input id="txtFtc_cmmts" class="easyui-textbox" style="width:92%;height:22px"/></td>
            
            <%--<td></td>--%>
        </tr>
        </table>

	</div>

</body>
</html>
