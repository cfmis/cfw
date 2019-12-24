<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="check_in_table.aspx.cs" Inherits="WebPortal.Sales.check_in_table" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        table {
            font-size: 12px;
            border-collapse: collapse;
            border: 1px solid black;
        }
 
            table tr {
                height: 20px;
                line-height: 20px;
            }
 
                table tr td {
                    text-align: center;
                    width: 200px;
                }
    </style>
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("input[type=button]").click(function () {
                //获取选中的数据组
                var array = $("table input[type=checkbox]:checked").map(function () {
                    return { "cell2": $.trim($(this).closest("tr").find("td:eq(2)").text()), "cell4": $.trim($(this).closest("tr").find("td:eq(4)").text()) };
                }).get();

                $.each(array, function (i, d) {
                    alert(d.cell2 + "|" + d.cell4);
                })
            })



            var checkboxes = document.getElementsByName('select_item');
            $("#select_all").click(function () {
                for (var i = 0; i < checkboxes.length; i++) {
                    var checkbox = checkboxes[i];
                    if (!$(this).get(0).checked) {
                        checkbox.checked = false;
                    } else {
                        checkbox.checked = true;
                    }
                }
            });


        })
    </script>
</head>
<body>
    <table border="1">
        <tr>
            <td><input type='checkbox' name="select_item"/></td>
            <td><input type="text" /></td>
            <td>1
            </td>
            <td></td>
            <td>2
            </td>
            
        </tr>
        <tr>
            <td><input type='checkbox' name="select_item"/></td>
            <td><input type="text" /></td>
            <td>3
            </td>
            <td></td>
            <td>4
            </td>
            
        </tr>
        <tr>
            <td><input type='checkbox' name="select_item"/></td>
            <td><input type="text" /></td>
            <td>5
            </td>
            <td></td>
            <td>6
            </td>
            
        </tr>
    </table>
    <input type="button" value='选择' />
    <input type="checkbox" id="select_all" value='全選' />
</body>
</html>
