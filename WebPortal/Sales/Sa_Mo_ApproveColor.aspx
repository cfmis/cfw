<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Mo_ApproveColor.aspx.cs" Inherits="WebPortal.Sales.Sa_Mo_ApproveColor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>制單批色登記</title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <%--<meta http-equiv="Content-Type" content="text/html; charset=big5" /> --%>
   <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <%--<link href="../css/bootstrap.min.css" rel="stylesheet" media="screen"/>--%>
    <%--當使用bootstrap格式時，建議配對使用：ScriptManager，不然出現兼容性錯誤。--%>

    <style type="text/css"> 
        .divShowQueryImg{ border:1px solid #000; height:80px;overflow:hidden;} 
        .divShowQueryImg img{max-width:60px;_width:expression(this.width > 300 ? "300px" : this.width);} 
    </style> 
    
</head>
<body>



    <div id="container">

<%--    <table class="table_SiteMapPath">
    <tr>
    <td>
    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
          </asp:SiteMapPath>
    </td>
    </tr>
    </table>--%>

    <div id="content"> 
    <form id="form1" runat="server">

    <%--<asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
    </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"  runat="server" >

        <triggers>  
            <asp:PostBackTrigger ControlID="btnExcel" /> 
        </triggers>

        <ContentTemplate>--%>

    <%--如果是用到ScriptManager / UpdatePanel，當匯出Excel時，要類似上面，加入<triggers></triggers>，不然會出錯。--%>
    <!--btnExcel就是下面那个需要在Button2_Click事件里使用Response.Write()的按钮ID-->  


    <table width="1000px" border="0">

    <tr style="height:20px">
    <td style="width:25%">
    <asp:Label id="lblMo" Text="制單編號" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtMo" Width ="120px" Text="" runat="server"/>
    </td>
    <td style="width:70%">
    <asp:Label id="lblRmk" Text="備註" Width ="40px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtRmk" Width ="300px" Text="" AutoPostBack="false" runat="server"/>
    <asp:Button class="btn btn-success" id="btnSave" Text="儲存" OnClick="btnSave_Click" Width="100px"  Height ="30px"  runat="server"/>
    </td>
    </tr>
    
    <tr>
    <td colspan="2">
    <asp:Label id="lblApproveColor" Text="批色狀態" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:DropDownList ID="dlApproveColor" Width ="140px" Height="20px" runat="server" ><%-- AutoPostBack="true"--%>
        <asp:ListItem>顯示全部</asp:ListItem>
        <asp:ListItem>未批色</asp:ListItem>
        <asp:ListItem>已批色</asp:ListItem>
        </asp:DropDownList>
    <asp:Button class="btn btn-success" id="btnFind" Text="查找" OnClick="btnFind_Click" Width="100px"  Height ="30px"  runat="server"/>

    <asp:Button class="btn btn-success" id="btnExcel" Text="匯出到Excel" OnClick="btnExcel_Click" Width="100px"  Height ="30px"  runat="server"/>
    </td>
    
    <%--<td><script type="text/javascript">            writeSpaces(5);</script></td>--%>
    <%--<td><script type="text/javascript">            writeSpaces(5);</script></td>--%>
    </tr>
    <tr>
        <td colspan="3">
        當要批色時，請輸入批色日期:
        <input size="10" type="text" id="txtAppClrDate" style="height:20px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})"/>
        批色備註:
        <asp:TextBox id="txtAppMark" Width ="200px" Text="" AutoPostBack="false" runat="server"/>
      </td>
    </tr>
    </table>


    <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="divShowQueryImg" style=" color: Blue; background-color: #FAEBD7; border: 0px solid #FAEBD7;">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
        </asp:UpdateProgress> --%>


    <%--<table width="100%" border="0">
    <tr>
    <td>--%>
    <asp:GridView ID="gvMo" runat="server" Height="90px" Width="1200px"
      BackColor="AntiqueWhite"
      BorderColor="Black" 
      CellPadding="3"
      Font-Name="宋体"
      Font-Size="9pt"
      HeaderStyle-BackColor="ActiveBorder"
      HeaderStyle-Font-Bold="true"
      EnableViewState="False"
      HeaderStyle-HorizontalAlign="Center"
      HeaderStyle-Height="20px"
      RowStyle-Height="20px"
      AutoGenerateColumns="False" Font-Names="宋体"
      onrowdeleting="gvDetails_RowDeleting"
       onrowcommand="gvMo_RowCommand">
        <Columns>
                    <asp:BoundField DataField="id" HeaderText="序號" HeaderStyle-Width="40px" >
<HeaderStyle Width="40px"></HeaderStyle>
            </asp:BoundField>
                    <asp:BoundField DataField="prd_mo" HeaderText="制單編號" HeaderStyle-Width="100px" >
<HeaderStyle Width="100px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="prd_rmk" HeaderText="備註" HeaderStyle-Width="240px" >
<HeaderStyle Width="240px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="crusr" HeaderText="建立人" HeaderStyle-Width="80px" >
<HeaderStyle Width="80px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="crtim" HeaderText="建立日期" HeaderStyle-Width="80px" >
<HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="approve_flag" HeaderText="審批狀態" HeaderStyle-Width="60px" >
<HeaderStyle Width="60px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="approve_usr" HeaderText="審批人" HeaderStyle-Width="80px" >
<HeaderStyle Width="80px"></HeaderStyle>
            </asp:BoundField>
            <asp:BoundField DataField="approve_tim" HeaderText="審批日期" HeaderStyle-Width="120px" >
<HeaderStyle Width="120px"></HeaderStyle>
            </asp:BoundField>
            <asp:CommandField ShowDeleteButton="True" CancelText="刪除" >
            <HeaderStyle Width="40px" />
            </asp:CommandField>
            <asp:ButtonField Text="批色舊制單" HeaderText="批色舊制單" CommandName="Approve_color_old" HeaderStyle-Width="100px" />
            <asp:ButtonField Text="批色並更新Geo" HeaderText="批色並更新Geo" CommandName="Approve_color" HeaderStyle-Width="100px" />
        </Columns>
        <HeaderStyle HorizontalAlign="Center" BackColor="ActiveBorder" Font-Bold="True"></HeaderStyle>

<RowStyle Height="20px"></RowStyle>
    </asp:GridView>
   <%-- </td>
    </tr>
    </table>--%>
    
   <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>

    </form>
    </div>
    </div>
</body>
</html>
