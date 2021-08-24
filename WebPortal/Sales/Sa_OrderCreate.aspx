<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_OrderCreate.aspx.cs" Inherits="WebPortal.Sales.Sa_OrderCreate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Order</title>
    <link rel="stylesheet" href="../css/vue/demo.css" />
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $("#btnShowMat").click(function () {
                $('#showMatDialog').dialog('open').dialog('setTitle', '質地');

                //PopSetMat();
                //see();
            });
            $("#btnShowPrdType").click(function () {
                $('#showPrdTypeDialog').dialog('open').dialog('setTitle', '產品類型');

                //PopSetMat();
                //see();
            });
            $('#btnAdd').click(function () {
                $('#AddDialog').dialog('open').dialog('setTitle', '添加信息');
            });
        });
    </script>
    
    <script type="text/javascript" >
        function PopMat() {
            var result = showModalDialog('../Base/ShowMatCode.aspx', 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no'); //打开模态子窗体,并获取返回值
            document.getElementById("txtMat").value = result.split("'")[0]; //返回值分别赋值给相关文本框
        }
        function PopSetMat() {
            var result = showModalDialog('../PublicWebForm/getMatCode.aspx', 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no', window); //打开模态子窗体,并获取返回值
            //document.getElementById("txtMat").value = result.split("'")[0]; //返回值分别赋值给相关文本框
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
                    //document.getElementById('btnFind').onclick();
                }
            });
            win.dialog('open');
        }


        function closeWindow() {
            //window.opener = null;
            ////window.open(' ', '_self', ' ');
            //window.open('', '_self');
            //window.close();

            $('#showMatDialog').dialog('close');
        }

    </script>

</head>
<body>
    <div id="tabs" class="easyui-tabs" style="width:800px;height:600px;">
    <div title="訂單基本資料">
        <p>訂單基本資料</p>
	</div>
    
    <!--訂單明細Tab-->
    <div id="tab2" title="訂單明細資料">
    <a href="javascript:void(0)" class="easyui-linkbutton" id="btnAdd" iconcls="icon-ok">產品明細</a>
    <!--设置添加的弹出层-->
    <div id="AddDialog" class="easyui-dialog" style="width: 800px; height:600px; padding: 10px 20px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
    <div id="app" title="訂單明細資料">
        <div>
            <fieldset>
                <legend>
                    Create New Item
                </legend>
                <div class="form-group">
                    <label>質地:</label>
                    <input type="text" id="txtMat" placeholder="質地(Mat)" @input="joinItem" v-model="textBox.mat_code" />
                    <%--<input type="text" id="s"  />--%>
                    <%--<button id="btnShowMat1" onclick="showMessageDialog('../PublicWebForm/getMatCode.aspx','新增',800,500,true)">Mat</button>--%>
                    <button id="btnShowMat">質地</button>
                </div>
                <div class="form-group">
                    <label>產品類型:</label>
                    <input type="text" id="txtPrdType" placeholder="產品類型(Product Type)" @input="joinItem" v-model="textBox.prd_type" />
                    <button id="btnShowPrdType">產品類型</button>
                </div>
                <div class="form-group">
                    <label>產品尺寸:</label>
                    <input type="text" placeholder="尺寸(Size)" @input="joinItem" v-model="textBox.size_code" />
                </div>
                <div class="form-group">
                    <label>產品描述:</label>
                    <input type="text" placeholder="產品描述(Product Description)" v-model="textBox.prd_item" />
                </div>
                
            </fieldset>
            <div class="form-group1">
                <label>訂單數量:</label>
                <input type="text" placeholder="Order Qty" v-model="textBox.order_qty" />
                <label>單位:</label>
                <select v-model="textBox.goods_unit">
                    <option v-for="unit in units" v-bind:value="unit.id">{{ unit.id }}</option>
                </select>
                <label>單價:</label>
                <input type="text" placeholder="Price" v-model="textBox.price" size="20" />
                <label>單價單位:</label>
                <select v-model="textBox.price_unit">
                    <option v-for="unit in units" v-bind:value="unit.id">{{ unit.id }}</option>
                </select>
            </div>
            <div>
                <label>牌子代號:</label>
                <input type="text" placeholder="Brand" v-model="textBox.brand_id" />
            </div>

            <div class="form-group">
                <label></label>
                <button v-on:click="createOrderList">Create</button>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>產品描述</th>
                        <th>數量單位</th>
                        <th>Delete</th>
                        <th>搭配</th>
                        <th>搭配</th>
                        <th>搭配</th>
                        <th>搭配</th>
                        <th>搭配</th>
                        <th>搭配</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="item in orderList">
                        <td>{{ item.prd_item }}</td>
                        <td>{{ item.goods_unit }}</td>
                        <td class="'text-center'"><button v-on:click="deleteOrderList($index)">Delete</button></td>
                        <td class="'text-center'"><button v-on:click="deleteOrderList($index)">搭配</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="showMatDialog" class="easyui-dialog" style="width: 600px; height:400px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <%--<div style="width: 300px; height:200px; padding: 0px 0px;">--%>
            <iframe src="../PublicWebForm/getMatCode.aspx" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
            <%--</div>--%>
            <%--<div style="width: 800px; height:100px; padding: 10px 20px;">
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="javascript:$('#showMatDialog').dialog('close')">关闭</a>
                <a id="btnShowMsg" href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel">顯示</a>
            </div>--%>
        </div>
        <div id="showPrdTypeDialog" class="easyui-dialog" style="width: 600px; height:500px; padding: 0px 0px;" closed="true" resizable="true" modal="true" data-options="iconCls: 'icon-add',buttons: '#dlg-buttons'">
            <%--<div style="width: 300px; height:200px; padding: 0px 0px;">--%>
            <iframe src="../PublicWebForm/getProdTypeCode.aspx" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>
            <%--</div>--%>
            <%--<div style="width: 800px; height:100px; padding: 10px 20px;">
                <a href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel" onclick="javascript:$('#showMatDialog').dialog('close')">关闭</a>
                <a id="btnShowMsg" href="javascript:void(0)" class="easyui-linkbutton" iconcls="icon-cancel">顯示</a>
            </div>--%>
        </div>
    </div>

    </div>
    </div>
    </div>
    <script src="../js/vue.js"></script>

    <script>
        var vm = new Vue({
            el: '#app',
            data: {
                textBox: {
                    mat_code: '',
                    mat_cdesc: '',
                    mat_desc:'',
                    prd_type: '',
                    prd_type_cdesc: '',
                    prd_type_desc:'',
                    size_code: '',
                    size_cdesc: '',
                    size_desc:'',
                    goods_unit:'',
                    prd_item: '',
                    prd_item_cdesc: '',
                    prd_item_desc: '',
                    order_qty: '',
                    price:'',
                    price_unit: '',
                    brand_id:''
                },
                orderList: [],
                units:[]
            },
            created: function () {
                var self = this;
                //var json = [];
                //var j = {};
                //j.id = self.id;
                //j.name = self.name;
                //json.push(j);
                //var obja = JSON.stringify(json);
                //为了在内部函数能使用外部函数的this对象，要给它赋值了一个名叫self的变量。

                $.ajax({
                    url: "../ashx/Base_Select.ashx/GetItem?paraa=get_unit&parab=table",
                    type: 'post',
                    //data: { 'param': obja }, //参数
                    dataType: 'json'
                }).then(function (res) {
                    //console.log(res);
                    //把从json获取的数据赋值给数组
                    debugger;
                    self.units = res;
                }).fail(function () {
                    console.log('失败');
                })
            },
            methods:{
                createOrderList: function () {
                    this.orderList.push(this.textBox);
                    // 添加完newPerson对象后，重置newPerson对象
                    this.textBox = { mat_code: '',mat_cdesc:'',mat_desc:'', prd_type: '', size_code: '', goods_unit: '', prd_item: '' }
                },
                deleteOrderList: function(index){
                    // 删一个数组元素
                    this.orderList.splice(index, 1);
                },
                joinItem: function () {
                    var self = this;
                    self.textBox.prd_item = self.textBox.mat_code + ';' + self.textBox.prd_type + ';' + self.textBox.size_code;
                }

            }
        })


    </script>

</body>
</html>
