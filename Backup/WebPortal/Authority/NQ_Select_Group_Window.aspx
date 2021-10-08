<%@ Page Language="C#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>选择群组</title>
    <style type="text/css">
<!--

.lbg2 {
	BACKGROUND-IMAGE: url(../images/line.gif); BACKGROUND-REPEAT: repeat-x
}
.mc {
	PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 0px; WORD-BREAK: break-all; LINE-HEIGHT: 20px; PADDING-TOP: 0px
}
.t3 {
	FONT-WEIGHT: bolder; FONT-SIZE: 12px; MARGIN-LEFT: 15px; COLOR: #003473; margin-down: -20px
}
.mc1 {	PADDING-RIGHT: 10px; PADDING-LEFT: 10px; PADDING-BOTTOM: 0px; WORD-BREAK: break-all; LINE-HEIGHT: 20px; PADDING-TOP: 0px
}
-->
</style>
<script language="javascript" type="text/javascript">
// <!CDATA[

function Submit1_onclick() {

    var str = "";
	for (i = 0; i < document.all.sel.length; i++) {
		if (document.all.sel[i].checked) {
			str = document.all.sel[i].value;
		}
	}
	if (str == "") {
	    alert("请选择一个群组");
		return;
	}
	   window.returnValue=str;
       this.window.close();

}

  

// ]]>
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <TABLE cellSpacing=1 cellPadding=0 bgColor=#9bc8ff border=0 style="width: 547px">
        <TBODY>
        <TR>
          <TD bgColor=#f7fdff style="width: 546px">
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD class=lbg2 width=354 height=27><SPAN 
                  class=t3>选择群组</SPAN></TD>
                <TD class=lbg2 width=23><IMG height=17 
                  src="../images/bot2.gif" width=17 
            border=0></TD>
              </TR></TBODY></TABLE>
            <TABLE height="202" border=0 cellPadding=0 cellSpacing=0 style="width: 538px">
              
              <TR>
                
                <TD height="202" 
                  vAlign=top class=mc><input type="submit" name="Submit" value="选择所选" id="Submit1" onclick="return Submit1_onclick()" />&nbsp;
                  
                  <table height="48" border="0" style="width: 515px">
  <tr>
    <td style="height: 35px; width: 44px;">选择</td>
    <td style="height: 35px; width: 181px;">群名</td>
    <td style="height: 35px; width: 167px;">描述信息</td>
  </tr>
                     <asp:Repeater ID="Repeater1" runat="server" DataSourceID="ObjectDataSource1">
                   <ItemTemplate>
                    <tr>
    <td><input type="radio" name="sel" value="<%# Eval("GroupName")%>$$$<%# Eval("GroupID") %>"></td>
    <td><%# Eval("GroupName")%></td>
    <td><%# Eval("Description")%></td>
  </tr>
                   
                   </ItemTemplate>
                    </asp:Repeater>
                    
                    </table>
                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="getAllGroup" TypeName="Leyp.SQLServerDAL.GroupDAL"></asp:ObjectDataSource>
                  

                  
              
                    
                    
                    </TD>
    </TR></TABLE></TD></TR></TBODY></TABLE>
    
    </div>
    </form>
</body>
</html>