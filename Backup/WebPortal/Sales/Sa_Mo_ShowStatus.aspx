<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Mo_ShowStatus.aspx.cs" Inherits="WebPortal.Sales.Sa_Mo_ShowStatus" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>

    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>

</head>
<body>
    <div id="container">

    <table style="width: 98%">
        <tr>
            <td align="left" style="width: 810px; height: 20px">
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
            <fieldset style="border-width: 0px; border-color: #FAEBD7;">
    <table width="1200px" border="1" cellspacing="1" cellpadding="2" align="left"  style="margin:0px;">
    <tr>
    <td>
    <table width="1200px" border="1" cellspacing="1" cellpadding="2" align="left"  style="margin:0px;">
    <tr>
    <td colspan="3">
    <asp:Label id="lblShowInfo" Text="顯示制單的生產狀態：外發收、發貨；回港記錄、發貨記錄、R單資料等。" ForeColor="Blue" runat="server"/>
    </td>
    </tr>
    <tr>
    <td style="width:10%">
    <asp:Label id="lblMo" Text="制單編號" Width ="90%" Font-Size="16px" runat="server"/>
    </td>
    <td style="width:20%">
    <asp:TextBox id="txtMo" Width ="90%" Text="" Font-Size="16px" AutoPostBack ="false"
        runat="server" ontextchanged="txtMo_TextChanged"/>
    </td>
    <td style="width:20%">
    <asp:Button id="btnFind" Text="查找" OnClick="btnFind_Click" Width="90%" Height ="30px"  runat="server"/>
    </td>
    <td style="width:50%">
    
    </td>
    </tr>
    </table>
    </td>
    </tr>
    <tr>
    <td>
    <table width="1200px" border="1" cellspacing="1" cellpadding="2" align="left"  style="margin:0px;">
    <tr>
    <td>
    <table width="1200px" border="1" cellspacing="1" cellpadding="2" align="left"  style="margin:0px;">
    <asp:Label id="lblCustCode" Text="客戶編號" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtCustCode" Width ="80px" Text="" ReadOnly ="true" runat="server"/>
    <asp:TextBox id="txtCustDesc" Width ="180px" Text="" ReadOnly ="true" runat="server"/>
    <asp:Label id="lblOrder_qty" Text="訂單數量" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtOrder_qty" Width ="60px" Text="" ReadOnly ="true" runat="server"/>
    <asp:TextBox id="txtGoods_unit" Width ="40px" Text="" ReadOnly ="true" runat="server"/>
    <asp:Label id="lblBill_date" Text="開單日期" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtBill_date" Width ="80px" Text="" Font-Size="13px" ReadOnly ="true" runat="server"/>
    <asp:Label id="lblRec_hk_date" Text="計劃回港日期" Width ="80px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtRec_hk_date" Width ="80px" Text="" Font-Size="13px" ReadOnly ="true" runat="server"/>
    <asp:Label id="lblCust_req_date" Text="交貨日期" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtCust_req_date" Width ="80px" Text="" Font-Size="13px" ReadOnly ="true" runat="server"/>
    <asp:Label id="lblShowRedo" Text="存在R單資料" Width ="260px" ForeColor="Red" Visible ="false" runat="server"/>
    </td>
    </tr>
    <tr>
    <td>
    <asp:Label id="lblOcNo" Text="Oc編號" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtOcNo" Width ="120px" Text="" Font-Size="13px" ReadOnly ="true" runat="server"/>
    <asp:Label id="lblSales" Text="跟單員" Width ="40px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtSales" Width ="96px" Text="" Font-Size="13px" ReadOnly ="true" runat="server"/>
    <asp:Label id="lblRemark" Text="備註" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtRemark" Width ="400px" Text="" Font-Size="13px" ReadOnly ="true" runat="server"/>
    </td>
    </tr>
    <tr>
    <td>
    <asp:Label id="lblProd_Remark" Text="生產備註" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtProd_Remark" Width ="400px" Text="" Font-Size="13px" ReadOnly ="true" runat="server"/>
    <asp:Label id="lblPlate_Remark" Text="電鍍/噴油備註" Width ="90px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtPlate_Remark" Width ="400px" Text="" Font-Size="13px" ReadOnly ="true" runat="server"/>
    </td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
    <asp:Image ID="imgZp" runat="server" Height="100px" Width="100px"    />
    <%--<asp:Button id="btnShowPic" Text="顯示圖片" OnClick="btnShowPic_Click" Width="100px" Height ="35px"  runat="server"/>--%>
    <asp:Label id="lblPicPath" Text="" Width ="160px" ForeColor="Red" runat="server"/>
    <br />
    <asp:Label id="lblMoStatus" Text="生產狀態瀏覽" Width ="120px" ForeColor="Blue" runat="server"/>
    <asp:Label id="lblRec_tatus" Text="當前部門是指：上部門已交貨，但本部門完成數仍然為零。" Width ="500px" ForeColor="#FF3300" runat="server"/>
    <asp:Label id="lblShowMoOutRec" Text="(點擊狀態瀏覽中某行，則會顯示該行的外發收、發記錄)，如下表:" Width ="500px" ForeColor="Blue" Font-Size="Small" runat="server"/>
    <br />
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

    <asp:GridView ID="gvDetails" runat="server" Height="90px" Width="1400px" 
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
      onrowdatabound="gvDetails_RowDataBound"
      onselectedindexchanged="gvDetails_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="flag" HeaderText="序號" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="mo_state" HeaderText="生產狀態" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="rec_status" HeaderText="當前部門" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="wp_id" HeaderText="負責部門" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="wp_name" HeaderText="負責部門" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="next_wp_id" HeaderText="收貨部門" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="next_wp_name" HeaderText="收貨部門" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="goods_id" HeaderText="物料編號" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="goods_name" HeaderText="物料描述" HeaderStyle-Width="250px" />
            <asp:BoundField DataField="s_qty" HeaderText="應生產數量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="prod_qty" HeaderText="要求生產數量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="obligate_qty" HeaderText="預留數量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="order_qty" HeaderText="訂單數量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="c_qty_ok" HeaderText="完成數量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="t_complete_date" HeaderText="要求日期" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="f_complete_date" HeaderText="最後移交日期" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="ok_qty_u" HeaderText="前部門來貨數" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="vendor_id" HeaderText="外發供應商" HeaderStyle-Width="40px" />
            <asp:BoundField DataField="vendor_name" HeaderText="供應商描述" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="color_name" HeaderText="顏色描述" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="do_color" HeaderText="顏色做法" HeaderStyle-Width="60px" />
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="LightCyan" Font-Bold="True"></HeaderStyle>
        
    </asp:GridView>
    
    
    <br />
    <asp:Label id="lblOutStatus" Text="外發記錄" Width ="80px" ForeColor="Blue" runat="server"/>
    <asp:Label id="lblWipSeq" Text="序號:" Width ="40px" runat="server"/>
    <asp:TextBox id="txtWipSeq" Width ="40px" Text="" ReadOnly ="true" runat="server"/>
    <asp:TextBox id="txtItem" Width ="160px" Text="" ReadOnly ="true" runat="server"/>
    <asp:TextBox id="txtItem_desc" Width ="300px" Text="" ReadOnly ="true" runat="server"/>
    
    <asp:GridView ID="gvMoOut" runat="server" Height="90px" Width="1400px" 
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
      onrowdatabound="gvMoOut_RowDataBound">
        <Columns>
            <asp:BoundField DataField="dep" HeaderText="發貨部門" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="dep_name" HeaderText="發貨部門" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="doc_type_desc" HeaderText="單據類型" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="id" HeaderText="單據編號" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="seq" HeaderText="序號" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="doc_date" HeaderText="單據日期" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="mo_id" HeaderText="制單編號" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="goods_id" HeaderText="物料編號" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="goods_name" HeaderText="物料描述" HeaderStyle-Width="250px" />
            <asp:BoundField DataField="prod_qty" HeaderText="數量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="sec_qty" HeaderText="重量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="color_name" HeaderText="顏色" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="req_date" HeaderText="要求完成日期" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="vendor_id" HeaderText="供應商" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="vendor_name" HeaderText="供應商" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="create_by" HeaderText="建檔人" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="create_date" HeaderText="建檔日期" HeaderStyle-Width="80px" />
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="LightCyan" Font-Bold="True"></HeaderStyle>
        
    </asp:GridView>

    <br />
    
    <asp:Label id="lblMoQc" Text="外發QC結果" Width ="160px" ForeColor="Blue" runat="server"/>
    <asp:GridView ID="gvMoQc" runat="server" Height="90px" Width="800px" 
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
      onrowdatabound="gvMoOut_RowDataBound">
        <Columns>
            <asp:BoundField DataField="mo_id" HeaderText="制單編號" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="id" HeaderText="收貨單號" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="qc_id" HeaderText="檢驗編號" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="qc_date" HeaderText="檢驗日期" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="qc_state_desc" HeaderText="QC狀態" HeaderStyle-Width="50px" />
            <asp:BoundField DataField="qc_result_desc" HeaderText="QC結果" HeaderStyle-Width="50px" />
            <asp:BoundField DataField="check_person" HeaderText="檢驗人" HeaderStyle-Width="160px" />
            <asp:BoundField DataField="check_times" HeaderText="檢驗次數" HeaderStyle-Width="60px" />
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="LightCyan" Font-Bold="True"></HeaderStyle>
        
    </asp:GridView>
    



    <br />
    <asp:Label id="lblReturn" Text="回港記錄" Width ="80px" ForeColor="Blue" runat="server"/>
    <asp:GridView ID="gvMoReturn" runat="server" Height="90px" Width="800px" 
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
      AutoGenerateColumns="False" Font-Names="宋体">
        <Columns>
            <asp:BoundField DataField="doc_date" HeaderText="單據日期" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="id" HeaderText="單據編號" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="seq" HeaderText="序號" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="mo_id" HeaderText="制單編號" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="goods_id" HeaderText="物料編號" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="goods_name" HeaderText="物料描述" HeaderStyle-Width="300px" />
            <asp:BoundField DataField="prod_qty" HeaderText="數量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="sec_qty" HeaderText="重量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="location_id" HeaderText="倉庫" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="check_date" HeaderText="批準日期" HeaderStyle-Width="70px" />
            <asp:BoundField DataField="state" HeaderText="單據狀態" HeaderStyle-Width="40px" />
            <asp:BoundField DataField="type" HeaderText="單據類型" HeaderStyle-Width="40px" />
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="LightCyan" Font-Bold="True"></HeaderStyle>
        
    </asp:GridView>

    <br />
    <asp:Label id="lblShowInv" Text="出貨(發票)記錄" Width ="160px" ForeColor="Blue" runat="server"/>
    <asp:GridView ID="gvMoInv" runat="server" Height="90px" Width="1200px" 
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
      AutoGenerateColumns="False" Font-Names="宋体">
        <Columns>
            <asp:BoundField DataField="seq" HeaderText="序號" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="doc_type_desc" HeaderText="單據類型" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="ship_date" HeaderText="發貨日期(DGD)" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="doc_date" HeaderText="發票日期" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="id" HeaderText="單據編號" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="mo_id" HeaderText="制單編號" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="goods_id" HeaderText="物料編號" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="goods_name" HeaderText="物料描述" HeaderStyle-Width="300px" />
            <asp:BoundField DataField="inv_qty" HeaderText="數量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="goods_unit" HeaderText="數量單位" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="inv_weg" HeaderText="重量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="issues_state" HeaderText="發貨狀態" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="consignment_date" HeaderText="發貨日期" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="transport_style" HeaderText="運輸途徑" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="receipt_person" HeaderText="客人簽收人" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="receipted_date" HeaderText="客人簽收日期" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="return_state" HeaderText="回單狀態" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="inv_state" HeaderText="发票狀態" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="check_by" HeaderText="確認人" HeaderStyle-Width="30px" />
            
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="LightCyan" Font-Bold="True"></HeaderStyle>
        
    </asp:GridView>


    <br />
    <asp:Label id="lblSt" Text="制單庫存記錄" Width ="160px" ForeColor="Blue" runat="server"/>
    <asp:GridView ID="gvSt" runat="server" Height="90px" Width="800px" 
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
      AutoGenerateColumns="False" Font-Names="宋体">
        <Columns>
            <asp:BoundField DataField="mo_id" HeaderText="制單編號" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="goods_id" HeaderText="物料編號" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="goods_name" HeaderText="物料描述" HeaderStyle-Width="300px" />
            <asp:BoundField DataField="location_id" HeaderText="倉庫" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="lot_no" HeaderText="批號" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="qty" HeaderText="數量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="sec_qty" HeaderText="重量" HeaderStyle-Width="30px" />
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="LightCyan" Font-Bold="True"></HeaderStyle>
        
    </asp:GridView>



    <br />
    <asp:Label id="lblRedo" Text="補單資料" Width ="80px" ForeColor="Red" runat="server"/>
    <asp:GridView ID="gvMoRedo" runat="server" Height="90px" Width="800px" 
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
      AutoGenerateColumns="False" Font-Names="宋体">
        <Columns>
            <asp:BoundField DataField="create_date" HeaderText="建檔日期" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="mo_id" HeaderText="R單編號" HeaderStyle-Width="60px" />

            <asp:TemplateField HeaderText="原制單編號" HeaderStyle-Width="60" HeaderStyle-HorizontalAlign="Center">
            <ItemTemplate>


            <a href="mo_ShowStatus.aspx?to_mo_id=<%# Eval("repair_mo_id")%>" target="_blank"><%# Eval("repair_mo_id")%></a>

            </ItemTemplate>

            <HeaderStyle HorizontalAlign="Center" Width="80px"></HeaderStyle>
            </asp:TemplateField>

            <asp:BoundField DataField="repair_mo_id" HeaderText="原制單編號" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="seq" HeaderText="序號" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="goods_id" HeaderText="物料編號" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="goods_name" HeaderText="物料描述" HeaderStyle-Width="300px" />
            <asp:BoundField DataField="order_qty" HeaderText="數量" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="goods_unit" HeaderText="單位" HeaderStyle-Width="30px" />
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="LightCyan" Font-Bold="True"></HeaderStyle>
        
    </asp:GridView>

    </fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>


    </form>

    </div>
    </div>

</body>
</html>
