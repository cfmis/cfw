<%@ Page Language="C#" AutoEventWireup="true" Inherits="ZText_text" Codebehind="text.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>
    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/demo/demo.css"/>
    <style type="text/css">
        @media screen and (min-width: 1400px) and (max-width: 1865px) {
            .dv0 {
                width: 1400px;
                border: 1px;
                background-color: aqua;
            }

            

                .dv1 input {
                    height: 38px;
                    width: 100px;
                    border: 0px;
                    font-size: 18px;
                }
        }
        @media screen and (min-width: 750px) and (max-width: 1099px) {
            body {
                min-width: 655px;
            }

            .dv0 {
                width: 800px;
                border: 1px;
                background-color: blue;
            }

                .dv1 input {
                    height: 18px;
                    width: 100px;
                    border: 0px;
                    font-size: 9px;
                }
        }
        @media screen and (min-width: 1100px) and (max-width: 1365px) {
            body {
                min-width: 985px;
            }

            .dv0 {
                width: 1000px;
                border: 1px;
                background-color: red;
            }

                .dv1 input {
                    height: 28px;
                    width: 100px;
                    border: 0px;
                    font-size: 16px;
                }
        }
        table {
                width: 100%;
            }

            td {
                width: 50%;
            }

            .dv1 {
                width: 100%;
            }
    </style>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/easyuiDatePicker.js"></script>
</head>
<body>
    <div class="dv0" id="aa1">
<table border="1">
        <tr>
            <td>
                <div class="dv1">
        <input type="text" class="easyui-textbox ddl" id="ipt11" />
    </div>
            </td>
            <td>
                <div class="dv1">
        <input type="text" class="easyui-datebox-expand ddl" id="ipt12" />
    </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="dv1">
        <input type="text" class="easyui-combobox ddl" id="ipt13" />
    </div>
            </td>
            <td>
                <div class="dv1">
        <input type="text" class="easyui-datebox ddl" id="ipt14" />
    </div>
            </td>
        </tr>
        <tr>
            <td>
                <div class="dv1">
        <input type="text" id="ipt15" />
    </div>
            </td>
            <td>
                <div class="dv1">
        <input type="text" id="ipt16" />
    </div>
            </td>
        </tr>
    </table>
    </div>
    <script type="text/javascript">
        $(function () {
            //$("#ipt11").textbox('textbox').css("font-size", "18pt");
            //$("#ipt11").textbox('textbox').css("height", "18px");
            $("#ipt11").textbox('setValue', "123");
            var ddlw = parseInt($(".dv1").css("width"));
            var borderLeftWidth = parseInt($("ddl").css("border-left-width"));
            
            //setSelectWidth(0.22);
            setSelectWidth(0.6);
            $(window).resize(function () {
                setSelectWidth(0.6);
            });
        })
        function fixWidth() {
            return document.body.clientWidth * 0.3;
        }

        function setSelectWidth(width) {
            var ddlw = parseInt($(".dv1").css("width"));
            var ddlh = parseInt($("#ipt15").css("height"));
            var ddlf = parseInt($("#ipt15").css("font-size"));
            $("#ulPanel").find("input").each(function () {
                //$(this).click(function () {
                //    alert("luozhiping");
                //});
                //alert(this.id);
                //debugger;
                var name = this;
                var id = this.id;
                var result = $(this).find('.easyui-textbox');
                var className = $(this).attr("class");
                if (!className)
                    className = "";
                var name1 = className.substring(0, 6);
                if (name1 == "easyui")//(this.id.length==5)
                {
                    //debugger;
                    var obj = this.id;
                    //alert(this.name);
                    //var obj1 = this;
                    var val = $(this).val();
                    var val1 = $("#ipt11").val();
                    //var width1 = this.;
                    $(this).textbox({
                        height: ddlh,
                        width: ddlw * 0.9,
                    });
                    $(this).textbox('textbox').css("font-size", ddlf);
                    //$(this).textbox('textbox').css("width", "338px");
                    //$(this).textbox('textbox').css("height", "38px");

                    //$(this).textbox('textbox').css("font-size", "38pt");
                    //$(obj).textbox('textbox').css("width", "118px");


                }
            });

        }
    </script>
    

    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <asp:SiteMapPath ID="SiteMapPath1" runat="server">
        </asp:SiteMapPath>
    </div>
    </form>
</body>
</html>
