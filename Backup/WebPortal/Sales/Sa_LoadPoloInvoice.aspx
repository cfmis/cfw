<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_LoadPoloInvoice.aspx.cs" Inherits="WebPortal.Sales.Sa_LoadPoloInvoice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>

    <script language="JavaScript" type="text/javascript">
        var new_window;
    function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }

        //以下導出導EXCEL，是不用安裝ActiveX控件的，也不用降低IE的安全設定

        function getXlsFromTbl(objWin, inTblId, inWindow) {
            new_window = objWin;
            //判斷表中是否存在記錄
//            var tableObj = document.getElementById(inTblId);
            var tableObj = document.getElementById("tableVend"); 
//            var tableObj = document.getElementsByTagName("tableVend");

//            var nn = tableObj.innerHTML;
            if (tableObj == null) {
                alert('記錄不存在,不能匯出!');
                return false;
            }
            try {
                var allStr = "";
                var curStr = "";
                //alert("getXlsFromTbl"); 
                if (inTblId != null && inTblId != "" && inTblId != "null") {
                    curStr = getTblData(inTblId, inWindow);
                }
                if (curStr != null) {
                    allStr += curStr;
                }
                else {
                    alert("你要导出的表不存在！");
                    return;
                }
                //                var fileName = getExcelFileName();
                //                var office_ver = readOfficeVersion(); //獲取Office版本號，根據不同版本號，得到Excel擴展名
                var file_ext = ".xls";
                var fileName = "polo發票數據";
                //                if (office_ver == "office2007" || office_ver == "office2010")
                //                    file_ext = ".xlsx";
                //                var fileName = "每日結存匯總表";

                //                if (inTblId == "tableVend") {
                //                    fileName = "每日結存明細表";
                //                }
                fileName = fileName + file_ext;
                doFileExport(fileName, allStr);
//                preview(allStr);
            }
            catch (e) {
                alert("导出发生异常:" + e.name + "->" + e.description + "!");
            }
        }
        function getTblData(inTbl, inWindow) {
            var rows = 0;
            //alert("getTblData is " + inWindow); 
            var tblDocument = document;
            if (!!inWindow && inWindow != "") {
                if (!document.all(inWindow)) {
                    return null;
                }
                else {
                    tblDocument = eval(inWindow).document;
                }
            }
            var curTbl = document.getElementById("tableVend"); // tblDocument.getElementById(inTbl);

            var outStr = "";
            var temp_str = "";
            var mo_type = "";


            var DropDownList1_Value = "";
            var DropDownList1_Text = "";

            var DropDownList1 = document.getElementById("dlMo_Type");
            if (DropDownList1 != null) {
                var DropDownList1_Index = DropDownList1.selectedIndex;                 //获取选择项的索引

                if (DropDownList1_Index >= 0) {
                    DropDownList1_Value = DropDownList1.options[DropDownList1_Index].value;   //获取选择项的值
                    DropDownList1_Text = DropDownList1.options[DropDownList1_Index].text;     //获取选择项的文本
                }
                else
                    DropDownList1_Text = "";

                if (DropDownList1_Index == 1)
                    mo_type = "G";
                else
                    if (DropDownList1_Index == 2)
                        mo_type = "T";
                    else
                        if (DropDownList1_Index == 3)
                            mo_type = "S";
                        else
                            if (DropDownList1_Index == 4)
                                mo_type = "O";
            }
            outStr += "<table borderColor='black' border='1' >";
            //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");

            outStr += "<tbody>";
            var mo_type_col;
            var strCol;
            if (curTbl != null) {

                for (var j = 0; j < curTbl.rows.length; j++) {
                    strCol = "";
                    //匯出所有單
                    if (mo_type == "") {
                        for (var i = 0; i < curTbl.rows[j].cells.length; i++) {
                            strCol += "<td>" + curTbl.rows[j].cells[i].innerText + "</td>";

                        }
                    }
                    else {//只匯出G單
                        mo_type_col = curTbl.rows[j].cells.length - 1;
                        if (mo_type == "G" || mo_type == "T" || mo_type == "S") {
                            if (curTbl.rows[j].cells[mo_type_col].innerText == mo_type || j == 0) {
                                for (var i = 0; i < curTbl.rows[j].cells.length; i++) {
                                    strCol += "<td>" + curTbl.rows[j].cells[i].innerText + "</td>";
                                }
                            }
                        }
                        else {//匯出其它單
                            if ((curTbl.rows[j].cells[mo_type_col].innerText != "G" && curTbl.rows[j].cells[mo_type_col].innerText != "T" && curTbl.rows[j].cells[mo_type_col].innerText != "S") || j == 0) {
                                for (var i = 0; i < curTbl.rows[j].cells.length; i++) {
                                    strCol += "<td>" + curTbl.rows[j].cells[i].innerText + "</td>";
                                }
                            }
                        }
                    }
                    if (strCol != "") {
                        outStr += "<tr class='firstTR'>";
                        outStr += strCol;
                        outStr += "</tr>";
                    }
                }
                outStr += "</tbody></table>";

            }
            else {
                outStr = null;
                alert(inTbl + "不存在!");
            }
            return outStr;
        }
        function getExcelFileName() {
            var d = new Date();
            var curYear = d.getYear();
            var curMonth = "" + (d.getMonth() + 1);
            var curDate = "" + d.getDate();
            var curHour = "" + d.getHours();
            var curMinute = "" + d.getMinutes();
            var curSecond = "" + d.getSeconds();
            if (curMonth.length == 1) {
                curMonth = "0" + curMonth;
            }
            if (curDate.length == 1) {
                curDate = "0" + curDate;
            }
            if (curHour.length == 1) {
                curHour = "0" + curHour;
            }
            if (curMinute.length == 1) {
                curMinute = "0" + curMinute;
            }
            if (curSecond.length == 1) {
                curSecond = "0" + curSecond;
            }
            var fileName = "leo_zhang" + "_" + curYear + curMonth + curDate + "_"
             + curHour + curMinute + curSecond + ".csv";
            //alert(fileName); 
            return fileName;
        }
        function doFileExport(inName, inStr) {
            var xlsWin = null;
            if (!!document.all("glbHideFrm")) {
                xlsWin = glbHideFrm;
                
            }
            else {
                var width = 6;
                var height = 4;
                var openPara = "left=" + (window.screen.width / 2 - width / 2)
                 + ",top=" + (window.screen.height / 2 - height / 2)
                 + ",scrollbars=no,width=" + width + ",height=" + height;

//                xlsWin = window.open("", "_blank", openPara);
                xlsWin = new_window;


            }

            xlsWin.document.write(inStr);

            xlsWin.document.close();


            xlsWin.document.execCommand('Saveas', true, inName);//匯出到Excel

//            xlsWin.document.execCommand("print");//打印
            xlsWin.close();
        }

        //加一个确认,可以在这个方法里面执行很多适用于自己的判断...
        function sure_open() {
            if (confirm('确定要打开php爱好者吗？'))
                open_window(url);
            else
                new_window.close(); //关闭窗口
        }

        function open_window(url) {
            new_window.location.href = "TestExpToExcel.aspx"; // url;
        }


    </script>


    <style type="text/css"> 
        .divShowQueryImg{ border:1px solid #000; height:80px;overflow:hidden;} 
        .divShowQueryImg img{max-width:60px;_width:expression(this.width > 300 ? "300px" : this.width);} 
        .div_table_scroll{width:98%;height:625px;overflow:scroll;overflow-y:scroll;margin:0 auto;}
    </style>

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
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>

        <div class="div_search_frame">
        <table border="2" width="800px"> 
	 	<tr>
		<td colspan="2"> 
                <asp:Button class="btn btn-success" ID="Btn_Query" runat="server" onclick="Btn_Query_Click" Text="查询" Width="120px" />
        </td>
        <td colspan="2">
                <button class="btn btn-success" style="width:120px" onclick ="javascript:getXlsFromTbl(window.open(),'tableVend','divVend');">Excel Export</button> 
        </td>
        </tr>
        <tr>
        <td style="width:10%">
	  				制單類型
        </td>
        <td style="width:10%">
                    <asp:DropDownList ID="dlMo_Type" Width ="90%" runat="server" >
                        <asp:ListItem>所有</asp:ListItem>
                        <asp:ListItem>G單</asp:ListItem>
                        <asp:ListItem>T單</asp:ListItem>
                        <asp:ListItem>S單</asp:ListItem>
                        <asp:ListItem>其它</asp:ListItem>
                    </asp:DropDownList>
        </td>

		<td style="width:5%">  
				    部門:
                </td>
                <td style="width:10%">
				    <asp:TextBox id="txtDep" Width ="80%" Text="" ReadOnly="true" runat="server"/>
                </td>
                <td style="width:10%">
                    發票日期:
                </td>
                <td style="width:25%">
	  				<%--<asp:TextBox ID="txtDate1" runat="server" Width="120px" onKeyUp="setValue(this,txtDate2)"></asp:TextBox>--%>
                    <input size="10" type="text" id="dateStart" style="height:18px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:false})"/>
                </td>
                <td style="width:5%">
	  				到
                </td>
                <td style="width:25%">
                    <%--<asp:TextBox ID="txtDate2" Width="120px" runat="server" />--%>
                    <input size="10" type="text" id="dateEnd" style="height:18px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:false})"/>
	  			</td>


  		</tr>

  		</table>
        </div>


        <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="divShowQueryImg" style=" color: Blue; background-color: #FAEBD7; border: 0px solid #FAEBD7;">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
        </asp:UpdateProgress> 



        <div id="divVend" class="div_table_scroll" runat ="server">
        <table class="table-responsive table-hover" id="tableVend" width="100%" border="1" cellspacing="1" cellpadding="2" align="center" style="margin:0px;"> 
        <thead>
  			 <tr class="a1" style="color:#ffffff;font-size:12px;">
   				        <th height="30">sp1</th>
				        <th>sp2</th>
                        <th>sp3</th>
                        <th>sp4</th>
                        <th>sp5</th>
                        <th>sp6</th>
                        <th>sp7</th>
                        <th>客戶產品編號</th>
                        <th>牌子描述</th>
                        <th>產品類型</th>
                        <th>產品描述</th>
                        <th>圖樣</th>
                        <th>圖樣代號</th>
                        <th>尺寸</th>
                        <th>顏色代號</th>
                        <th>顏色描述</th>
                        <th>sp11</th>
                        <th>sp12</th>
                        <th>sp13</th>
                        <th>sp14</th>
                        <th>sp15</th>
                        <th>sp16</th>
                        <th>sp17</th>
                        <th>sp18</th>
                        <th>訂單數量總計PCS</th>
                        <th>sp21</th>
                        <th>sp22</th>
                        <th>sp23</th>
                        <th>sp24</th>
                        <th>金額合計USD</th>
                        <th>圖片路徑</th>
                        <th>產品編號</th>
                        <th>制單編號</th>
                        <th>發票編號</th>
                        <th>發票日期</th>
                        <th>原幣金額</th>
                        <th>貨幣代號</th>
                        <th>金額HKD</th>
                        <th>牌子代號</th>
                        <th>發票類型</th>
                        <th>制單類型</th>

  			 </tr>  
  		</thead>
  			<asp:Repeater ID="rptDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td><%#Eval("sp1")%></td>
      			    <td><%#Eval("sp2")%></td>
      			    <td><%#Eval("sp3")%></td>
                    <td><%#Eval("sp4")%></td>
                    <td><%#Eval("sp5")%></td>
                    <td><%#Eval("sp6")%></td>
                    <td><%#Eval("sp7")%></td>
                    <td><%#Eval("customer_goods")%></td>
                    <td><%#Eval("brand_name")%></td>
                    <td><%#Eval("prd_type_name")%></td>
                    <td><%#Eval("goods_name")%></td>
                    <td><%#Eval("art")%></td>
                    <td><%#Eval("art_name")%></td>
                    <td><%#Eval("size_name")%></td>
                    <td><%#Eval("color_id")%></td>
                    <td><%#Eval("color_name")%></td>
                    <td><%#Eval("sp11")%></td>
                    <td><%#Eval("sp12")%></td>
                    <td><%#Eval("sp13")%></td>
                    <td><%#Eval("sp14")%></td>
                    <td><%#Eval("sp15")%></td>
                    <td><%#Eval("sp16")%></td>
                    <td><%#Eval("sp17")%></td>
                    <td><%#Eval("sp18")%></td>
                    <td><%#Eval("qty_pcs")%></td>
                    <td><%#Eval("sp21")%></td>
                    <td><%#Eval("sp22")%></td>
                    <td><%#Eval("sp23")%></td>
                    <td><%#Eval("sp24")%></td>
                    <td><%#Eval("amt_usd")%></td>
                    <td><%#Eval("art_part")%></td>
                    <td><%#Eval("goods_id")%></td>
                    <td><%#Eval("mo_id")%></td>
                    <td><%#Eval("id")%></td>
                    <td><%#Eval("oi_date")%></td>
                    <td><%#Eval("amt")%></td>
                    <td><%#Eval("m_id")%></td>
                    <td><%#Eval("amt_hkd")%></td>
                    <td><%#Eval("brand_id")%></td>
                    <td><%#Eval("inv_type")%></td>
                    <td><%#Eval("mo_type")%></td>
  			     </tr>
  			    </ItemTemplate>
  			</asp:Repeater>

            
  			 
		</table>
        </div>

        </ContentTemplate>
        </asp:UpdatePanel>
    </form>

    </div>
    </div>


    <%--<ul id="ul_0">
  <li id="li_0">Coffee</li>
  <li id="li_1">Tea</li>
 </ul>
<p id="demo">createDocumentFragment方法</p>
<button onclick="myFunction()">点我</button>
<script type="text/javascript">
    function myFunction() {
        var d = document.createDocumentFragment();
        d.appendChild(document.getElementById("ul_0").cloneNode(true));
        alert(d.getElementById("li_1").innerHTML)
        /*
        测试结果如下：
        Firefox,Chrome,Opera,IE7,8能弹出对话框"Tea";
        IE9,10,11,报告错误:对象不支持“getElementById”属性或方法;
        */
    }
</script>--%>




</body>
</html>
