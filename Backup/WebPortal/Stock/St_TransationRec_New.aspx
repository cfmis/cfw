<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="St_TransationRec_New.aspx.cs" Inherits="WebPortal.Stock.St_TransationRec_New" %>
<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>查詢交易記錄</title>
 
    <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
    <link rel="stylesheet" href="/css/form_view_frame.css"/>
    <%--<link rel="stylesheet" href="/css/bootstrap.min.css"/>  --%>
   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>


    <script language="JavaScript" type="text/javascript">
        function setValue(fobj, tobj) {
            tobj.value = fobj.value;
        }


        //以下導出導EXCEL，是不用安裝ActiveX控件的，也不用降低IE的安全設定

        function getXlsFromTbl(inTblId, inWindow) {

            //判斷表中是否存在記錄
            var tableObj = document.getElementById(inTblId);
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
                var fileName = "查詢交易記錄";
                //                if (office_ver == "office2007" || office_ver == "office2010")
                //                    file_ext = ".xlsx";
                //                var fileName = "每日結存匯總表";

                //                if (inTblId == "tableDetail") {
                //                    fileName = "每日結存明細表";
                //                }
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
            var curTbl = tblDocument.getElementById(inTbl);
            var outStr = "";
            var temp_str = "";
            if (curTbl != null) {
                outStr = "交易單號" + " \t";
                outStr += "轉倉日期" + " \t";
                outStr += "\r\n";
                for (var j = 0; j < curTbl.rows.length; j++) {
                    //alert("j is " + j); 
                    for (var i = 0; i < curTbl.rows[j].cells.length; i++) {
                        //alert("i is " + i); 
                        if (i == 0 && rows > 0) {
                            outStr += " \t";
                            rows -= 1;
                        }
                        if (i == 0 || i == 8 || i == 10 || i == 17)
                            temp_str = "=\"" + curTbl.rows[j].cells[i].innerText + "\"";
                        else
                            temp_str = curTbl.rows[j].cells[i].innerText;
                        outStr += temp_str + "\t";
                        if (curTbl.rows[j].cells[i].colSpan > 1) {
                            for (var k = 0; k < curTbl.rows[j].cells[i].colSpan - 1; k++) {
                                outStr += " \t";
                            }
                        }
                        if (i == 0) {
                            if (rows == 0 && curTbl.rows[j].cells[i].rowSpan > 1) {
                                rows = curTbl.rows[j].cells[i].rowSpan - 1;
                            }
                        }
                    }
                    outStr += "\r\n";
                }
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
                xlsWin = window.open("", "_blank", openPara);
            }
            xlsWin.document.write(inStr);
            xlsWin.document.close();
            xlsWin.document.execCommand('Saveas', true, inName);
            xlsWin.close();
        }


    </script>

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
</head>
<body>
   
  <%-- <div id="container">
   <div id="content"> --%>
   <form id="form2" runat="server" >

   <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
        </asp:ScriptManager>
    
        <asp:UpdatePanel ID="UpdatePanel" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>


    <div align="center" >
        <table style="width: 97%">
            <tr>
                <td align="left" style="width: 810px; height: 20px">
                    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                    </asp:SiteMapPath>
                </td>
            </tr>
        </table>
        <br />
    <%--<div class="bar">--%>
  <table border="2" width="90%">
  <tr>
  <td style="width: 10%" align="right">
          <asp:Button ID="Select" class="btn btn-success" Width="90%" runat="server"
              Text="查询" OnClick="Select_Click" /></td>
      <td style="width: 10%" align="right">
          <input type="button" class="btn btn-success" style="width:90%" onclick="javascript:getXlsFromTbl('tableExcel','');" value="匯出到EXCEL"/> 
          </td>
    <td colspan="6"></td>
  </tr>
    <tr>
     <td style="width:10%" align="right">
         發貨部門:</td>
     <td style="width: 15%">
         <asp:TextBox id="txtDep" Width="90%" Text="" runat="server"/></td>
      <td style="width: 10%" align="right">收貨部門:</td>
      <td style="width: 10%">
          <asp:TextBox id="txtToDep" Width="90%" Text="" runat="server"/></td>
      <td style="width: 10%" align="right">批準日期:</td>
      <td style="width: 10%">
          <asp:TextBox ID="txtDate1" Width="90%" onKeyUp="setValue(this,txtDate2)" runat="server"></asp:TextBox></td>
      <td style="width: 5%" align="right">到:</td>
      <td style="width: 10%">
          <asp:TextBox ID="txtDate2" Width="90%" runat="server"></asp:TextBox></td>
      <td style="width: 20%"></td>
    </tr>
    <tr>
      <td style="width: 10%" align="right">交易單號:</td>
      <td style="width: 15%">
          <asp:TextBox ID="txtId1" Width="90%" onKeyUp="setValue(this,txtId2)" runat="server"></asp:TextBox></td>
      <td style="width: 5%" align="right">到:</td>
      <td style="width:10%">
          <asp:TextBox ID="txtId2" Width="90%" runat="server"></asp:TextBox></td>
      <td colspan="3"></td>
      
    </tr>
  </table>
<%--</div>--%>
<%--<table style="width:97%;" >

<tr>
<td align="center" class="title" style="width: 810px; height: 38px;">
    查詢交易記錄
</td>
</tr>
</table>--%>
    
    <br />

    <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="show_query_img">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
    </asp:UpdateProgress> 
<%--<table style="width:850px" border="2">

<tr>
<td >--%>
<%--<div style="width:100%;overflow:scroll;overflow-y:scroll;margin:0 auto;" class="aadiv_table_scroll">--%>
<div style="width:100%;">
  <table id="tableExcel"  class="flexme2">
	<thead>
    		<tr>
            	<th width="80">
                    交易單號</th>
            
            	<th width="80">
                    轉倉日期</th>
            	<th width="80">
                    批準日期</th>
            	<th width="30">
                    序號</th>
            	
            	<th width="60">
                    轉出倉號</th>
   
                <th width="60">
                    轉入倉號</th>
                <th width="80">
                    制單編號&nbsp;</th>
    		    <th width="120">
                    物料編號</th>
                <th width="200">
                     物料描述</th>
                <th width="80">
                   數量</th>
                <th width="80">
                    重量</th>
                <th width="100">
                    批號</th>
                <th width="30">
                    單據類型</th>
                <th width="30">
                    單據狀態</th>
    		    

                <th width="80">
                    交易單號</th>
            
            	<th width="80">
                    轉倉日期</th>
            	<th width="80">
                    批準日期</th>
            	<th width="30">
                    序號</th>
            	
            	<th width="60">
                    轉出倉號</th>
   
                <th width="60">
                    轉入倉號</th>
                <th width="80">
                    制單編號&nbsp;</th>
    		    <th width="120">
                    物料編號</th>
                <th width="200">
                     物料描述</th>
                <th width="80">
                   數量</th>
                <th width="80">
                    重量</th>
                <th width="100">
                    批號</th>
                <th width="30">
                    單據類型</th>
                <th width="30">
                    單據狀態</th>


                <th width="30"></th>

    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>
            	<td><%#Eval("id")%>
            	
            	</td>
            	<td>
            	<%#Eval("inventory_date")%>
            	
            	</td>
            
            	<td><%#Eval("check_date")%></td>
            	<td><%#Eval("sequence_id")%></td>
                <td><%#Eval("fdep")%></td>
                <td><%#Eval("todep")%> </td>
                <td><%#Eval("mo_id").ToString()%></td>
    		    <td><%# Eval("goods_id")%></td>
                <td><%# Eval("goods_name")%></td>
                <td><%# Eval("qty")%></td>
                <td><%# Eval("weg")%></td>
                <td><%# Eval("lot_no")%></td>
                <td><%# Eval("bill_type_no")%></td>
                <td><%# Eval("state")%></td>

                <td><%#Eval("id")%>
            	
            	</td>
            	<td>
            	<%#Eval("inventory_date")%>
            	
            	</td>
            
            	<td><%#Eval("check_date")%></td>
            	<td><%#Eval("sequence_id")%></td>
                <td><%#Eval("fdep")%></td>
                <td><%#Eval("todep")%> </td>
                <td><%#Eval("mo_id").ToString()%></td>
    		    <td><%# Eval("goods_id")%></td>
                <td><%# Eval("goods_name")%></td>
                <td><%# Eval("qty")%></td>
                <td><%# Eval("weg")%></td>
                <td><%# Eval("lot_no")%></td>
                <td><%# Eval("bill_type_no")%></td>
                <td><%# Eval("state")%></td>


    		     <td></td>
    		</tr>
        
        </ItemTemplate>
        </asp:Repeater>
      
    		
    </tbody>
</table>
</div>
<%--</td>
</tr>
</table>--%>

  <br />
           <div class="pageLink" id="pageLink">
        <cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
            backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
            pagesize="10" showfirstlast="true" showpagenumbers="true"></cc1:collectionpager>
            </div>
          
 <script type="text/javascript">



     $('.flexme2').flexigrid();
     ///$('.flexme2').flexigrid({height:'auto',striped:false});


</script>
    
  
    </div>

    </ContentTemplate>
        </asp:UpdatePanel>

    </form>
    <%--</div>
    </div>--%>

</body>
</html>
