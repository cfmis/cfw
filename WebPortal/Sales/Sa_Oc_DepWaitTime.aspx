<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Oc_DepWaitTime.aspx.cs" Inherits="WebPortal.Sales.Sa_Oc_DepWaitTime" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <%--<link rel="stylesheet" href="/css/bootstrap.min.css"/>  --%>
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>

    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>


    <%--以下這些語句為測試日期格式，也可以使用(bootstrap格式)--%>
    <%--<link href="../bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen"/>
    <script type="text/javascript" src="../bootstrap/js/jquery-1.8.3.min.js" charset="UTF-8"></script>
    <%--<script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>--%>
   <%-- <script type="text/javascript" src="../bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>--%>
    
   <%-- <style type="text/css"> 
        .show_query_img1{ border:1px solid #000; height:80px;overflow:hidden;width:98%} 
        .show_query_img1 img1{max-width:60px;_width:expression(this.width > 300 ? "300px" : this.width);}
        
    </style> --%>
    


    <script language="JavaScript" type="text/javascript">
        var new_window;
    function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }


        //以下導出到EXCEL，是不用安裝ActiveX控件的，也不用降低IE的安全設定

        function getXlsFromTbl(objWin, inTblId, inWindow) {
            new_window = objWin;
            //判斷表中是否存在記錄
            var tableObj = document.getElementById("tableDetail");

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
                var fileName = "部門貨品滯留表";

                fileName = fileName + file_ext;
                doFileExport(fileName, allStr);
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
            var curTbl = document.getElementById("tableDetail");//tblDocument.getElementById("tableDetail");  2018/09/27日改，出錯
            var outStr = "";
            outStr += "<table borderColor='black' border='1' >";
            //sb.Append("<thead><tr><th colSpan='14' bgColor='#FF99CC'>营销报表</th></tr>");

            outStr += "<tbody>";
            if (curTbl != null) {
                for (var j = 0; j < curTbl.rows.length; j++) {
                    outStr += "<tr class='firstTR'>";
                    for (var i = 0; i < curTbl.rows[j].cells.length; i++) {

                        if (i == 0 || i == 8 || i == 10 || i == 17)
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
//                var width = 6;
//                var height = 4;
//                var openPara = "left=" + (window.screen.width / 2 - width / 2)
//                 + ",top=" + (window.screen.height / 2 - height / 2)
//                 + ",scrollbars=no,width=" + width + ",height=" + height;
//                xlsWin = window.open("", "_blank", openPara);

                xlsWin = new_window;
            }
            xlsWin.document.write(inStr);
            xlsWin.document.close();
            xlsWin.document.execCommand('Saveas', true, inName);
            xlsWin.close();
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

    

    <form id="form1" runat="server">
        
        <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>

        <table width="98%" border="1" cellspacing="1" cellpadding="2" align="center"  style="margin:0px;"> 
	 		<tr>
				<td colspan="9">  
                <asp:Button class="btn btn-success" ID="Btn_Query" runat="server" onclick="Btn_Query_Click" Text="查询" Width="160px" />
                    <button class="btn btn-success" onclick ="javascript:getXlsFromTbl(window.open(),'tableDetail','divDetail');" style="width:160px">Excel Export</button> 
                     </td>
                
  			</tr>

  		</table>
        <div class="div_search_frame">
        <table width="600px" border="0" cellspacing="1" cellpadding="2" align="left"  style="margin:0px;"> 
	 		<tr>
				<td style="width:10%">  
				    部門:
                </td>
                <td style="width:15%">
				    <asp:TextBox id="txtDep" Width ="90%" Text="" runat="server"/>
                </td>
                <td style="width:15%">
                    計劃單日期:
                </td>
                <td style="width:25%">
                    <input size="10" type="text" id="dateStart" style="height:14px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                </td>
                <td style="width:10%">
	  				到
                </td>
                <td style="width:25%">
                    <input size="10" type="text" id="dateEnd" style="height:14px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
	  			</td>

  			</tr>

  		</table>
        </div>


        <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                <ProgressTemplate>
                    <%--<div class="divShowQueryImg" style=" color: Blue; background-color: #FAEBD7; border: 0px solid #FAEBD7;">--%>
                    <div class="show_query_img">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
        </asp:UpdateProgress> 


        <div id="divDetail" class="div_table_scroll" runat="server">
        <table  class="table-responsive table-hover" id="tableDetail" width="100%" border="1" cellspacing="1" cellpadding="2" align="center" style="margin:0px;">
  			 <thead class="fixedThead">
             <tr class="a1" style="color:#ffffff;font-size:12px;">
   				        <th height="30">計劃單日期</th>
				        <th>制單編號</th>
                        <th>本部門滯留日期</th>
    			        <th>物料編號</th>
				        <th>物料描述</th>
				        <th>部門</th>
				        <th>收貨部門</th>
				        <th>計劃數量</th>
                        <th>要求日期</th>
                        <th>完成數量</th>
                        <th>完成日期</th>
                        <th>序號</th>
                        <th>上部門</th>
                        <th>上部門物料編號</th>
                        <th>上部門物料描述</th>
                        <th>上部門計劃數</th>
                        <th>上部門完成數</th>
                        <th>上部門交貨日期</th>
                        
  			 </tr>  
  			</thead>

            <tbody>
  			<asp:Repeater ID="wpDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    <td id='bill_date_<%#Eval("mo_id") %>'><%#Eval("bill_date")%></td>
      			    <td id='mo_id_<%#Eval("mo_id") %>'><%#Eval("mo_id")%></td>
                    <td id='days_stay_<%#Eval("mo_id") %>'><%#Eval("days_stay")%></td>
      			    <td id='goods_id_<%#Eval("mo_id") %>'><%#Eval("goods_id")%></td>
      			    <td id='goods_cdesc_<%#Eval("mo_id") %>'><%#Eval("goods_name")%></td>
      			    <td id='wp_id_<%#Eval("mo_id") %>'><%#Eval("wp_id")%></td>
      			    <td id='next_wp_id_<%#Eval("mo_id") %>'><%#Eval("next_wp_id")%></td>
      			    <td id='prod_qty_<%#Eval("mo_id") %>'><%#Eval("prod_qty")%></td>
                    <td id='t_date_<%#Eval("mo_id") %>'><%#Eval("t_complete_date")%></td>
                    <td id='c_qty_ok_<%#Eval("mo_id") %>'><%#Eval("c_qty_ok")%></td>
                    <td id='f_date_<%#Eval("mo_id") %>'><%#Eval("to_date")%></td>
                    <td id='pre_seq_<%#Eval("mo_id") %>'><%#Eval("pre_seq")%></td>
                    <td id='pre_dep_<%#Eval("mo_id") %>'><%#Eval("pre_dep")%></td>
                    <td id='pre_goods_id_<%#Eval("mo_id") %>'><%#Eval("pre_goods_id")%></td>
                    <td id='pre_goods_name_<%#Eval("mo_id") %>'><%#Eval("pre_goods_name")%></td>
                    <td id='pre_prod_qty_<%#Eval("mo_id") %>'><%#Eval("pre_prod_qty")%></td>
                    <td id='pre_c_qty_ok_<%#Eval("mo_id") %>'><%#Eval("pre_c_qty_ok")%></td>
                    <td id='pre_to_date_<%#Eval("mo_id") %>'><%#Eval("pre_to_date")%></td>
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
    

   <%-- <script type="text/javascript">
        $('.form_datetime').datetimepicker({
            //language:  'fr',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            forceParse: 0,
            showMeridian: 1
        });
        $('.form_date').datetimepicker({
            language: 'zh-CN',
            format: 'yyyy/mm/dd',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        });
        $('.form_time').datetimepicker({
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 1,
            minView: 0,
            maxView: 1,
            forceParse: 0
        });

        
    </script>--%>

</body>
</html>
