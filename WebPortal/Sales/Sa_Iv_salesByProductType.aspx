<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Iv_salesByProductType.aspx.cs" Inherits="WebPortal.Sales.Sa_Iv_salesByProductType" %>

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
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <script type="text/javascript" src="../js/exportdatagridtoexcel.js"></script>

          <style type="text/css"> 
        .textbox { 
          height:20px;           margin:0; 
          padding:0 2px; 
          box-sizing:content-box;         }
          </style>
    <script type="text/javascript">

        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }

        $(function () {
            initList();
            $('#tbInvList').datagrid({               //根据自身情况更改
                width: $(window).width() - 20,    //根据自身情况更改
                height: $(window).height() - 280  //根据自身情况更改
            });


            $(window).resize(function () {
                $('#tbInvList').datagrid('resize', {               //根据自身情况更改
                    width: $(window).width() - 20,    //根据自身情况更改
                    height: $(window).height() - 280  //根据自身情况更改
                }).datagrid('resize', {
                    width: $(window).width() - 20,      //根据自身情况更改
                    height: $(window).height() - 280   //根据自身情况更改
                });
            });

            
            InitSearch();//查询
        });


        function initList(queryData) {
            $('#tbInvList').datagrid({

                url: "../ashx/Ax_Iv_salesByPrdType.ashx/GetItem?paraa=get_data&parab=table",   //指向后台的Action来获取当前用户的信息的Json格式的数据
                iconCls: 'icon-view',//图标
                //height: 500,
                //fit: true,//自动适屏功能，表格會自動適應屏幕，就算設置了高度也無效的
                //width: function () { return document.body.clientWidth * 0.9 },//自动宽度
                nowrap: true,
                autoRowHeight: false,//自动行高
                striped: true,
                collapsible: true,
                //sortName: 'Id',//排序列名为ID
                sortOrder: 'asc',//排序为将序
                remoteSort: false,
                idField: 'Id',//主键值
                rownumbers: true,//显示行号
                multiSort: true,//启用排序 sortable: true //启用排序列
                //toolbar: '#tbInvList',
                pagination: true,
                pageSize: 100,
                pageList: [100, 200, 300, 400, 500],
                queryParams: queryData, //搜索条件查询
                //frozenColumns 和 columns是有區別的，frozenColumns--沒有滾動，columns--可以滾動，注意是區分大小寫的
                columns: [[
                { field: 'brand_id', title: '牌子編號', width: 80 },
                { field: 'it_customer', title: '客戶編號', width: 100 },
                { field: 'base_class', title: '產品類型', width: 100 },
                { field: 'base_class_cname', title: '類型描述', width: 100 },
                { field: 'qty_pcs', title: '銷售數量(PCS)', width: 100 },
                { field: 'amt_hkd', title: '金額(HKD)', width: 100 },
                { field: 'amt_usd', title: '金額(USD)', width: 100 }
                ]],
                loadFilter: pagerFilter,
                //toolbar: [{
                //    id: 'btnreload',
                //    text: '刷新',
                //    iconCls: 'icon-reload',
                //    handler: function () {
                //        $("#btnSerach").datagrid("reload");
                //    }
                //}]



            });
        }

        //初始化搜索框
        function InitSearch() {
            //按照条件进行查询，首先我们得到数据
            $("#btnSerach").click(function () {
                //得到用户输入的参数
                var queryData = {
                    //UserName: $("#txtUserNameSerach").val(),
                    //ClassId: $("#txtClassIdSerach").combobox("getValue"),
                    rpt_type:0,
                    date_from: $("#txtDate_from").val(),//.textbox("getValue"),//.val(),
                    date_to: $("#txtDate_to").val(),
                    brand_from: $("#txtBrand_from").val(),
                    brand_to: $("#txtBrand_to").val(),
                    cust_from: $("#txtCust_from").val(),
                    cust_to: $("#txtCust_to").val(),
                    mo_from: $("#txtMo_from").val(),
                    mo_to: $("#txtMo_to").val()
                };
                //将值传递给initTable
                initList(queryData);
                return false;
            });
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
    <div data-options="region:'north'" title="角色管理" style="height: 80px;">
        <div class="easyui-layout" id="tb" style="padding: 5px; height: auto">
            <!-------------------------------搜索框----------------------------------->
            <fieldset>
                <legend>查詢條件</legend>
                <form id="ffSearch" method="post">
                    <div style="margin-bottom: 5px">
                        <label for="lblInv_date">發票日期</label>
                        <input size="10" type="text" id="txtDate_from" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})" onchange="setValue(this,txtDate_to)"/>
                        <input size="10" type="text" id="txtDate_to" style="height:18px;width:120px" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                        <label for="lblBrand">牌子編號</label>
                        <input type="text" class="easyui-validatebox" id="txtBrand_from" name="txtBrand_from" style="width:120px" onchange="setValue(this,txtBrand_to)" />
                        <input type="text" class="easyui-validatebox" id="txtBrand_to" name="txtBrand_to" style="width:120px" />&nbsp; 
                        <a href="#" class="easyui-linkbutton" iconcls="icon-search" id="btnSerach" style="width:120px;height:25px">查詢</a>
                        <a href="#" id="btnExp" class="easyui-linkbutton" iconCls="icon-excel"  plain="false" onclick="Export('銷售報表', $('#tbInvList'));" style="width:120px;height:25px">匯出到Excel</a>
                    </div>
                    <div style="margin-bottom: 5px">
                        <label for="lblCust">客戶編號</label>
                        <input type="text" class="easyui-validatebox" id="txtCust_from" name="txtCust_from" style="width:120px" onchange="setValue(this,txtCust_to)" />
                        <input type="text" class="easyui-validatebox" id="txtCust_to" name="txtCust_to" style="width:120px" />
                        <label for="lblMo">制單編號</label>
                        <input type="text" class="easyui-validatebox" id="txtMo_from" name="txtMo_from" style="width:120px" onchange="setValue(this,txtMo_to)" />
                        <input type="text" class="easyui-validatebox" id="txtMo_to" name="txtMo_to" style="width:120px" />
                    </div>
                </form>
            </fieldset>
        </div>
    </div>
    <!-------------------------------详细信息展示表格----------------------------------->
    <%--<div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true" style="background: #ccc;">--%>
            <table id="tbInvList" padding-left: 200px;"></table>
        <%--</div>
    </div>--%>
    <%--<div data-options="region:'center'">
        <div class="easyui-layout" data-options="fit:true" style="background: #ccc;">
            <table id="tbInvList" class="easyui-datagrid" title="銷售統計表" style="width:700px;height:250px"
                   data-options="singleSelect:true,collapsible:true,url:'datagrid_data1.json',method:'get'"></table>
        </div>
    </div>--%>
    </div>
    </div>
</body>
</html>
