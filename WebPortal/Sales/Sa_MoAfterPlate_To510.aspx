<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_MoAfterPlate_To510.aspx.cs" Inherits="WebPortal.Sales.Sa_MoAfterPlate_To510" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <meta http-equiv="Content-Type" content="text/html; charset=big5" />
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>


    <%--<script src="/js/jquery/jquery-1.6.2.min.js"  type="text/javascript"></script>  
            <link rel="stylesheet" href="/css/bootstrap.min.css"/>  
                <script type="text/javascript" src="/js/jquery/jquery.base64.js"></script>  
  
                <script type="text/javascript" src="/js/jquery/tableExport.js"></script>  
               
                     <script type="text/javascript" src="/js/jquery/jspdf/libs/sprintf.js"></script>  
                                                  
                     
                        <script type="text/javascript" src="/js/jquery/jspdf/jspdf.js"></script>  
                         <script type="text/javascript" src="/js/jquery/jspdf/libs/base64.js"></script> --%>
    
    
    
    
    
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
            var tableObj = document.getElementById("tableDetail"); 
//            var tableObj = document.getElementsByTagName("tableDetail");

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
                var fileName = "大通電鍍後再噴油報表";
                //                if (office_ver == "office2007" || office_ver == "office2010")
                //                    file_ext = ".xlsx";
                //                var fileName = "每日結存匯總表";

                //                if (inTblId == "tableDetail") {
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
            var curTbl = document.getElementById("tableDetail"); // tblDocument.getElementById(inTbl);

            var outStr = "";
            var temp_str = "";
            outStr += "<table borderColor='black' border='1' >";
            //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");

            outStr += "<tbody>";
            
            if (curTbl != null) {
//                for (var j = 0; j < curTbl.rows.length; j++) {
//                    //alert("j is " + j); 
//                    for (var i = 0; i < curTbl.rows[j].cells.length; i++) {
//                        //alert("i is " + i); 
//                        if (i == 0 && rows > 0) {
//                            outStr += " \t";
//                            rows -= 1;
//                        }
//                        if (i == 1 || i == 4 || i == 5 || i == 10)
//                            temp_str = "=\"" + curTbl.rows[j].cells[i].innerText + "\"";
//                        else
//                            temp_str = curTbl.rows[j].cells[i].innerText;
//                        outStr += temp_str + "\t";
//                        if (curTbl.rows[j].cells[i].colSpan > 1) {
//                            for (var k = 0; k < curTbl.rows[j].cells[i].colSpan - 1; k++) {
//                                outStr += " \t";
//                            }
//                        }
//                        if (i == 0) {
//                            if (rows == 0 && curTbl.rows[j].cells[i].rowSpan > 1) {
//                                rows = curTbl.rows[j].cells[i].rowSpan - 1;
//                            }
//                        }
//                    }
//                    outStr += "\r\n";
//                }


                for (var j = 0; j < curTbl.rows.length; j++) {
                    outStr += "<tr class='firstTR'>";
                    for (var i = 0; i < curTbl.rows[j].cells.length; i++) {

                        if (i == 1 || i == 3 || i == 4 || i == 12)
                            outStr += "<td>" + "=\"" + curTbl.rows[j].cells[i].innerText + "\"" + "</td>";
                        else
                            outStr += "<td>" + curTbl.rows[j].cells[i].innerText + "</td>";

                    }
                    outStr += "</tr>";
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

            //xlsWin.document.execCommand("print");//打印
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

        <table width="100%" border="0" cellspacing="1" cellpadding="2" align="center"  style="margin:0px;"> 
	 	<tr style="height:30px">
		<td> 
                <asp:Button class="btn btn-success" ID="Btn_Query" runat="server" onclick="Btn_Query_Click" Text="查询" Height="30px" Width="120px" />
                <button class="btn btn-success" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail');">Excel Export</button> 
        </td>
                
  			</tr>

  		</table>

        <table width="100%" border="2" cellspacing="1" cellpadding="2" align="center"  style="margin:0px;"> 
	 		<tr>
				<td style="width:10%">  
				    部門:
                </td>
                <td style="width:8%">
				    <asp:TextBox id="txtDep" Height="14px" Width ="60px" Text="" ReadOnly="true" runat="server"/>
                </td>
                <td style="width:14%">
                    開單日期:
                </td>
                <td style="width:8%">
                    <input size="10" type="text" id="dateStart" style="height:14px;width:100px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})"/>
                </td>
                <td style="width:2%">
	  				到
                </td>
                <td style="width:8%">
                    <input size="10" type="text" id="dateEnd" style="height:14px;width:100px" readonly="readonly" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
	  			</td>
                <td style="width:52%">
                <div>
		        <label style="color:Red">
			        <input size="10" runat="server" id="chkAfter501" style="width:20px" type="checkbox"/>電鍍部已申請大通，但噴油未設定供應商的記錄
		        </label>
	            </div>
                </td>

  			</tr>

  		</table>

        <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="show_query_img">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
        </asp:UpdateProgress> 


        <div class="div_table_scroll" id="divDetail" runat ="server">
        <table class="table-responsive table-hover" id="tableDetail" width="100%" border="1" cellspacing="1" cellpadding="2" align="center" style="margin:0px;"> 
        <thead>
  			 <tr class="a1" style="color:#ffffff;font-size:12px;">
   				        <th height="30">電鍍申請單號</th>
				        <th>電鍍申請單日期</th>
                        <th>制單編號</th>
                        <th>計劃單日期</th>
                        <th>計劃回港日期</th>
                        <th>下部門供應商</th>
                        <th>下部門物料顏色做法</th>
                        <th>電鍍物料編號</th>
                        <th>電鍍物料描述</th>
    			        <th>顏色做法</th>
				        <th>外發數量</th>
                        <th>外發重量</th>
				        <th>要求電回日期</th>
                        <th>電回後交下部門</th>
                        <th>電回後交下部門</th>
                        <th>下部門物料編號</th>
                        <th>下部門物料描述</th>
                        <th>申請單序號</th>
                        <th>計劃單序號</th>
                        <th>訂單數量(PCS)</th>
  			 </tr>  
  		</thead>
        <tbody>
  			<asp:Repeater ID="rptDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td><%#Eval("id")%></td>
      			    <td><%#Eval("bill_date")%></td>
      			    <td><%#Eval("mo_id")%></td>
                    <td><%#Eval("wp_bill_date")%></td>
                    <td><%#Eval("req_hk_date")%></td>
                    <td><%#Eval("next_vendor_id")%></td>
                    <td><%#Eval("do_color_510")%></td>
                    <td><%#Eval("goods_id")%></td>
                    <td><%#Eval("goods_name")%></td>
      			    <td><%#Eval("do_color")%></td>
      			    <td><%#Eval("prod_qty")%></td>
                    <td><%#Eval("sec_qty")%></td>
                    <td><%#Eval("req_return_date")%></td>
                    <td><%#Eval("next_wp_id")%></td>
                    <td><%#Eval("next_dep_name")%></td>
                    <td><%#Eval("goods_id_510")%></td>
                    <td><%#Eval("goods_name_510")%></td>
                    <td><%#Eval("sequence_id")%></td>
                    <td><%#Eval("wp_seq")%></td>
                    <td><%#Eval("order_qty")%></td>
  			     </tr>
  			    </ItemTemplate>
  			</asp:Repeater>
            </tbody>
  			 
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
