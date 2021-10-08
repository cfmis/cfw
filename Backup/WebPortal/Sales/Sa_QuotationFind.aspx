<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_QuotationFind.aspx.cs" Inherits="WebPortal.Sales.Sa_QuotationFind" EnableEventValidation = "false" %>

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

    <script type="text/javascript" >
function PopMat() 
{
    var result = showModalDialog('ShowMatCode.aspx', 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no'); //打开模态子窗体,并获取返回值
    document.getElementById("txtMaterial").value = result.split("'")[0]; //返回值分别赋值给相关文本框


}

function PopSize() {
    var result = showModalDialog('ShowSizeCode.aspx', 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no'); //打开模态子窗体,并获取返回值
    document.getElementById("txtSize").value = result.split("'")[0]; //返回值分别赋值给相关文本框


}
function PopSeason() {
    var result = showModalDialog('ShowSeasonCode.aspx', 'subpage', 'dialogWidth:800px;dialogHeight:600px;center:yes;help:no;resizable:no;status:no'); //打开模态子窗体,并获取返回值
    document.getElementById("txtSeason").value = result.split("'")[0]; //返回值分别赋值给相关文本框


}

function setValue(fobj, tobj) {
    tobj.value = fobj.value;

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

    <div class="div_search_frame">
    <table style="table-layout:fixed;word-wrap:break-word;word-break:break-all;" border="2" width="1200px">
    <tr>
    <td colspan="2">
    <asp:Button id="btnFind" Text="Find" OnClick="btnFind_Click" Width="120px" Height ="30px"  runat="server"/>
    </td>
    <td colspan="2">
    <asp:Button id="btnExpExcelNew" Text="Export To Excel" OnClick="btnExpExcelNew_Click" Width="120px" Height ="30px"  runat="server"/>
    </td>
    </tr>
    <tr>
    <td>
    <asp:Label id="lblSales_group" Text="Sales Group(組別)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:DropDownList id="dlSales_group" Width="124px" Height ="24px" Font-Size="12px"  runat="server"/>
    </td>
    <td>
    <asp:Label id="lblMaterial" Text="Material(材質)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtMaterial" Text="" Width="80px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Button ID="btnPopMat" runat="server" Text="..." Width="40px" OnClientClick="PopMat()" />
    </td>
    <td>
    <asp:Label id="lblCust_code" Text="Cust. Code(客產品編號)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtCust_code" Text="" Width="120px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Label id="lblCf_code" Text="CF  Code(CF產品編號)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtCf_code" Text="" Width="120px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Label id="lblMo_id" Text="MO(頁數)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtMo_id" Text="" Width="120px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    </tr>

    <tr>
    <td>
    <asp:Label id="lblBrand" Text="Brand(牌子)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtBrand" Text="" Width="120px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Label id="lblSeason" Text="Season(季度)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtSeason" Text="" Width="80px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Button ID="txtPopSeason" runat="server" Text="..." Width="40px" OnClientClick="PopSeason()" />
    </td>
    <td>
    <asp:Label id="lblCust_color" Text="Cust. Color(客產品顏色)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtCust_color" Text="" Width="120px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Label id="lblCf_color" Text="CF Color(CF顏色)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtCf_color" Text="" Width="120px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Label id="lblSubMo" Text="Sub Mo(子Mo)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtSubMo" Text="" Width="120px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    </tr>

    <tr>
    <td>
    <asp:Label id="lblTemp_code" Text="Seq No.(序號)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtTemp_code" Text="" Width="120px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Label id="lblSize" Text="Size(尺碼)" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Textbox id="txtSize" Text="" Width="80px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Button ID="btnPopSize" runat="server" Text="..." Width="40px" OnClientClick="PopSize()" />
    </td>
    <td>
    <asp:Label id="lblDate1" Text="Date (日期) From" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <input type="text" id="dateStart" style="height:18px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>
    <td>
    <asp:Label id="lblDate2" Text="Date (日期) To" Width="72px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    
    <input type="text" id="dateEnd" style="height:18px;width:90%" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
    </td>

    </tr>


    <tr>
    <td>
    <asp:Label id="lblGood_desc" Text="Goods Desc (物料描述)" Width="120px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td colspan="3">
    <asp:Textbox id="txtGood_desc" Text="" Width="300px" Height ="20px" Font-Size="11px"  runat="server"/>
    </td>
    <td>
    <asp:Label id="lblPriceLel" Text="Price Level(價格水平)" Width="120px" Height ="20px" Font-Size="11px" Visible="false"  runat="server"/>
    </td>
    <td colspan="2">
    <asp:Textbox id="txtPriceLel" Text="" Width="100px" Height ="20px" Font-Size="11px" Visible="false"  runat="server"/>
    </td>
    </tr>

    </table>
    </div>

    <div id="divDetail" class="div_table_scroll" runat="server">
    <asp:GridView ID="gvDetails" runat="server" Height="90px" Width="1200px" 
      BackColor="BlanchedAlmond"
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
      AllowPaging="True" PageSize ="50"
      onpageindexchanging="gvDetails_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="ver" HeaderText="Ver" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="sales_group" HeaderText="Sales Group" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="salesman" HeaderText="Salesman" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="date" HeaderText="Date" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="brand" HeaderText="Brand" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="brand_desc" HeaderText="Brand Desc" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            
            <asp:BoundField DataField="formula_id" HeaderText="Formula" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="season" HeaderText="Season" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="season_desc" HeaderText="Season Desc" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="material" HeaderText="Material" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="size" HeaderText="Size" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="product_desc" HeaderText="Product Desc." >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="cust_code" HeaderText="Customer Code" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="cf_code" HeaderText="CF Code" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="cust_color" HeaderText="Customer Color" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="cf_color" HeaderText="CF Color" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="number_enter" HeaderText="BP" >
            <ItemStyle Width="80px" />
            </asp:BoundField>

            <asp:BoundField DataField="price_usd" HeaderText="USD$" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="price_hkd" HeaderText="HKD$" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="price_rmb" HeaderText="RMB(17%VAT TAX)" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="hkd_ex_fty" HeaderText="HKD EX-FTY" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="price_unit" HeaderText="Price Unit" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="moq" HeaderText="MOQ" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="moq_desc" HeaderText="Moq Desc" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="moq_unit" HeaderText="MOQ Unit" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="mwq" HeaderText="MWQ" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="mwq_unit" HeaderText="MWQ Unit" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="account_code" HeaderText="Account  Code" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            

            <asp:BoundField DataField="lead_time_min" HeaderText="Lead Time(Min)" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="lead_time_max" HeaderText="Lead Time(Max)" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="lead_time_unit" HeaderText="Lead Time Unit" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="md_charge" HeaderText="Mould Charge in" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="md_charge_cny" HeaderText="MD Charge Cny" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="md_charge_unit" HeaderText="MD Charge Unit" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="die_mould_usd" HeaderText="Die Mould USD" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="valid_date" HeaderText="Valid Date" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="date_req" HeaderText="Date Req Rcvd" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="aw" HeaderText="AW" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="status" HeaderText="Status" >
            <ItemStyle Width="80px" />
            </asp:BoundField>


            <asp:BoundField DataField="sample_request" HeaderText="Sample Request" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="needle_test" HeaderText="Needle Test" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="comment" HeaderText="Comment" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="remark" HeaderText="Remark" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="remark_other" HeaderText="Remark Other" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="remark_pdd" HeaderText="Remark PDD" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="division" HeaderText="Division" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="contact" HeaderText="Contact" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="mo_id" HeaderText="MO No." >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="crusr" HeaderText="Create by" >
            <ItemStyle Width="80px" />
            </asp:BoundField>


            <asp:BoundField DataField="crtim" HeaderText="Create Date" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="amusr" HeaderText="Update by" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="amtim" HeaderText="Update Date" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="flag_del" HeaderText="Flag_Del" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="id" HeaderText="id" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="sub_mo" HeaderText="Sub Mo" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="temp_code" HeaderText="Quote Code" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <%--<asp:BoundField DataField="temp_ver" HeaderText="temp_ver" >
            <ItemStyle Width="80px" />
            </asp:BoundField>--%>
            <asp:BoundField DataField="flag_select" HeaderText="Flag_Select" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="ActiveBorder" Font-Bold="True"></HeaderStyle>
        
<RowStyle Height="20px"></RowStyle>
        
    </asp:GridView>
    </div>
    <br />
    <asp:Label id="lblShowInfo" Text="報價單查詢：請在上面輸入所需條件，進行查找。(Please enter a query conditions in the above. )" Width="1200px" Height ="20px" Font-Size="14px" ForeColor="Blue" runat="server"/>

    </form>
    </div>
    </div>
</body>
</html>
