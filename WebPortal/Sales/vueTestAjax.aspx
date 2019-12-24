<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="vueTestAjax.aspx.cs" Inherits="WebPortal.Sales.vueTestAjax" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="../js/vue.js"></script>
    <script src="../js/jquery.min.js"></script>
    <style>
        * {
            padding: 0;
            margin: 0;
        }

        table {
            margin: 100px auto;
            border: 1px solid #000;
            border-collapse: collapse; /*设置表格的边框是否被合并为一个单一的边框*/
            border-spacing: 0; /*设置相邻单元格的边框间的距离*/
        }

        tr {
            width: 300px;
            height: 50px;
            line-height: 50px;
            border-bottom: 1px solid #000;
            background-color: pink;
        }

        td, th {
            width: 99px;
            height: 50px;
            line-height: 50px;
            text-align: center;
            border-right: 1px solid #000;
        }
    </style>
</head>
<body>
<div id="app">

    <input type="text" v-model="id"/>
    <input type="text" v-model="name"/>
    <div class="form-group">
         <label>Sex:</label>
         <select v-model="mo_group">
         <option v-for="mogp in mogps" v-bind:value="mogp.mo_group">{{ mogp.mo_group }}</option>

<%--         <option value="Female">Female</option>--%>
         </select>
    </div>
    <button v-on:click="greet">Greet</button>
    <button v-on:click="getMoGroup">MoGroup</button>
    <button v-on:click="showMoGroup">ShowMoGroup</button>
    <input type="checkbox" class="weui-check" v-on:click="CheckItem(item)" v-model="item.state" name="checkbox" />

    <table>
        <thead>
        <tr>
            <th>姓名</th>
            <th>年龄</th>
            <th>住址</th>
        </tr>
        </thead>
        <tbody>
            

        <tr v-for="site in sites">
            <td v-text="site.mo_group"></td>
            <td v-text="site.mo_group"></td>
            <td v-text="site.mo_group"></td>
        </tr>
        </tbody>
    </table>
</div>

    <script>
    new Vue({
        el: '#app',
        data: {
            sites: [],
            mogps:[],
            id: "Hello",
            name: "Leavy",
            mo_group: "",
            //items: [],
            item: {
                state:true,
            },
        },
        created: function () {
            var self = this;
            var json = [];
            var j = {};
            j.id = self.id;
            j.name = self.name;
            json.push(j);
            var obja = JSON.stringify(json);
　　　　　　//为了在内部函数能使用外部函数的this对象，要给它赋值了一个名叫self的变量。
            
            $.ajax({
                url: "../ashx/Base_Select.ashx/GetItem?paraa=get_mogroup&parab=table",
                type: 'post',
                data: { 'param': obja }, //参数
                dataType: 'json'
            }).then(function (res) {
                console.log(res);
　　　　　　　　　　//把从json获取的数据赋值给数组
                self.mogps = res;
            }).fail(function () {
                console.log('失败');
            })
        },
        methods: {
            greet: function () {
                // // 方法内 `this` 指向 vm
                alert(this.name)

                var self = this;
                var json = [];
                var j = {};
                j.id = self.id;
                j.name = self.name;
                json.push(j);
                var obja = JSON.stringify(json);
                //为了在内部函数能使用外部函数的this对象，要给它赋值了一个名叫self的变量。

                $.ajax({
                    url: "../ashx/Base_Select.ashx/GetItem?paraa=get_mogroup_para&parab=table",
                    type: 'post',
                    data: { 'param': obja }, //参数
                    dataType: 'json'
                }).then(function (res) {
                    console.log(res);
                    //把从json获取的数据赋值给数组
                    self.sites = res;
                }).fail(function () {
                    console.log('失败');
                })
            },


            getMoGroup: function () {
                // // 方法内 `this` 指向 vm
                alert(this.name)

                var self = this;
                var json = [];
                var j = {};
                j.id = self.id;
                j.name = self.name;
                json.push(j);
                var obja = JSON.stringify(json);
                //为了在内部函数能使用外部函数的this对象，要给它赋值了一个名叫self的变量。

                $.ajax({
                    url: "../ashx/Base_Select.ashx/GetItem?paraa=get_mogroup&parab=table",
                    type: 'post',
                    data: { 'param': obja }, //参数
                    dataType: 'json'
                }).then(function (res) {
                    console.log(res);
                    //把从json获取的数据赋值给数组
                    self.sites = res;
                }).fail(function () {
                    console.log('失败');
                })
            },

            showMoGroup: function () {
                // // 方法内 `this` 指向 vm
                alert(this.mo_group);

                var self = this;
                var json = [];
                var j = {};
                j.id = self.mo_group;
                j.name = self.name;
                json.push(j);
                var obja = JSON.stringify(json);
                //为了在内部函数能使用外部函数的this对象，要给它赋值了一个名叫self的变量。

                $.ajax({
                    url: "../ashx/Base_Select.ashx/GetItem?paraa=get_mogroup_para&parab=table",
                    type: 'post',
                    data: { 'param': obja }, //参数
                    dataType: 'json'
                }).then(function (res) {
                    console.log(res);
                    //把从json获取的数据赋值给数组
                    self.sites = res;
                }).fail(function () {
                    console.log('失败');
                })
            },

            CheckItem: function (item) {
                item.state = !item.state;
                alert(this.item.state);
            }

        }
    })


    </script>

</body>
</html>

