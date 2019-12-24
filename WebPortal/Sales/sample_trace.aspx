<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sample_trace.aspx.cs" Inherits="WebPortal.Sales.sample_trace" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link rel="stylesheet" href="\css\bootstrap.min.css"/>--%>
    <script language="javascript" type="text/javascript" src="\js\LodopFuncs.js"></script> 
    <object  id="Object1" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0">  
       <embed id="LODOP_EM1" type="application/x-print-lodop" width=0 height=0></embed> 
    </object>



    <script language="javascript" type="text/javascript">
        var LODOP; //声明为全局变量   

//        var LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
//        var LODOP = getLodop();

        function prn1_preview(is_merge) {
            //            debugger;
            
            CreateOneFormPage(is_merge);
            LODOP.PREVIEW();
        };
        function prn1_print(is_merge) {
            CreateOneFormPage(is_merge);
            LODOP.PRINT();
        };
        function prn1_printA(is_merge) {
            CreateOneFormPage(is_merge);
            LODOP.PRINTA();
        };
        function CreateOneFormPage(is_merge) {
            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));

            LODOP.PRINT_INIT("列印標籤卡");
            LODOP.SET_PRINT_STYLE("FontSize", 9);
            LODOP.SET_PRINT_STYLE("Bold", 1);

            var DropDownList1_Value="";
            var DropDownList1_Text="";

            var DropDownList1 = document.getElementById("dlPrd_item");
            if (DropDownList1 != null) {
                var DropDownList1_Index = DropDownList1.selectedIndex;                 //获取选择项的索引

                if (DropDownList1_Index >= 0) {
                    DropDownList1_Value = DropDownList1.options[DropDownList1_Index].value;   //获取选择项的值
                    DropDownList1_Text = DropDownList1.options[DropDownList1_Index].text;     //获取选择项的文本
                }
                else
                    DropDownList1_Text = "";
            }
            var txtSample = "";
            if (document.getElementById("chkTypeSample").checked)
                txtSample = "樣板";
            if (document.getElementById("chkColorSample").checked) {
                if(txtSample !="")
                    txtSample = txtSample + "/" + "色板";
                else
                    txtSample = "色板";
            }
            if (document.getElementById("chkDrawSample").checked) {
                if (txtSample != "")
                    txtSample = txtSample + "/" + "圖紙";
                else
                    txtSample = "圖紙";
            }

            var dlObj;
            var WaitSample = "";
            var s_Index;
            dlObj = document.getElementById("dlWaitSample");
            if (dlObj != null) {
                s_Index = dlObj.selectedIndex;                 //获取选择项的索引
                if (s_Index > 0) {
                    WaitSample = dlObj.options[s_Index].text;   //获取选择项的值
                }
            }

            if (txtSample != "")
                txtSample = txtSample + "/" + WaitSample;
            else
                txtSample = WaitSample;

            if (document.getElementById("chkOthSample").checked) {
                if (txtSample != "")
                    txtSample = txtSample + "/" + "其它";
                else
                    txtSample = "其它";
            }
            //            LODOP.ADD_PRINT_TEXT(60, 20, 80, 20, "文件類別:");

            var card_id = "";
            var own_dep = "";
            if (is_merge == "1") {
                card_id = document.getElementById("<%=txtCard_id.ClientID %>").value;
                dlObj = document.getElementById("dlOwnType");
                if (dlObj != null) {
                    s_Index = dlObj.selectedIndex;                 //获取选择项的索引
                    if (s_Index > 0) {
                        own_dep = dlObj.options[s_Index].text;   //获取选择项的值
                    }
                    else
                        own_dep = "";
                }
            }
            else {
                card_id = document.getElementById("<%=txtCard_id_print.ClientID %>").value;
                own_dep = document.getElementById("<%=txtOwn_dep_print.ClientID %>").value;
            }

            LODOP.ADD_PRINT_TEXT(20, 20, 100, 20, txtSample);//樣辦類型
            //條碼
            LODOP.ADD_PRINT_BARCODE(20, 180, 138, 40, "EAN128B", card_id);

            LODOP.ADD_PRINT_TEXT(30, 320, 80, 20, own_dep); //所屬部門

            //將同卡多號的合併輸出
            var txtMergeCard_id = "--";
            var gdview = document.getElementById("<%=gvMerge.ClientID %>");
            if (gdview != null) {
                if (is_merge == "1")
                    txtMergeCard_id = ""; // document.getElementById("<%=txtCard_id.ClientID %>").value + "/";
                else
                    txtMergeCard_id = document.getElementById("<%=txtCard_id.ClientID %>").value + "/";
                var rows = gdview.rows.length;
                for (var i = 1; i < rows; i++) {
                    if (card_id != gdview.rows(i).cells(0).innerText) {
                        txtMergeCard_id = txtMergeCard_id + gdview.rows(i).cells(0).innerText; //弹出指定行单元格的值
                        if (i + 1 < rows)
                            txtMergeCard_id = txtMergeCard_id + "/";
                    }
                }
            }

            LODOP.ADD_PRINT_TEXT(40, 20, 80, 20, "原辦編號:"); //原辦編號
            LODOP.ADD_PRINT_TEXT(40, 100, 320, 20, document.getElementById("<%=txtCard_id_org.ClientID %>").value); //原辦編號

            LODOP.ADD_PRINT_TEXT(60, 20, 80, 20, "孿生樣板:"); //孿生樣瓣
            LODOP.ADD_PRINT_TEXT(60, 100, 320, 20, txtMergeCard_id); //孿生樣瓣


            var remark = "";
            remark = document.getElementById("<%=txtRemark_head.ClientID %>").value;
            if (document.getElementById("<%=txtColorDesc.ClientID %>").value != "") {
                if (remark != "") {
                    remark = remark + "/" + document.getElementById("<%=txtColorDesc.ClientID %>").value;
                }
                else
                    remark = document.getElementById("<%=txtColorDesc.ClientID %>").value;
            }
            var custitem = document.getElementById("<%=txtCustitem.ClientID %>").value + " / " + document.getElementById("<%=txtCustclr.ClientID %>").value
            //document.getElementById("lblPrd_item").innerText
            LODOP.ADD_PRINT_TEXT(80, 20, 90, 20, "說明/顏色:"); //說明/顏色
            LODOP.ADD_PRINT_TEXT(80, 100, 320, 20, remark); //說明/顏色
            LODOP.ADD_PRINT_TEXT(100, 20, 80, 20, "交辦流程:"); //交瓣流程
            LODOP.ADD_PRINT_TEXT(100, 100, 420, 20, document.getElementById("<%=txtRouteDep.ClientID %>").value); //交瓣流程
            LODOP.ADD_PRINT_TEXT(120, 20, 80, 20, "相關制單:"); //相關制單
            LODOP.ADD_PRINT_TEXT(120, 100, 320, 20, document.getElementById("<%=txtCorrMo.ClientID %>").value); //相關制單
            LODOP.ADD_PRINT_TEXT(140, 20, 90, 20, "日期/提供:"); //資料提供
            LODOP.ADD_PRINT_TEXT(140, 100, 120, 20, document.getElementById("<%=txtDoc_date.ClientID %>").value); //日期
            LODOP.ADD_PRINT_TEXT(140, 220, 320, 20, document.getElementById("<%=txtDataProvide.ClientID %>").value); //資料提供
            LODOP.ADD_PRINT_TEXT(160, 20, 90, 20, "客人款號:"); //客人款號
            LODOP.ADD_PRINT_TEXT(160, 100, 520, 20, custitem); //客人款號
            LODOP.ADD_PRINT_TEXT(180, 20, 90, 20, "新制單:"); //新制單
            LODOP.ADD_PRINT_TEXT(180, 100, 520, 20, document.getElementById("<%=txtNewMo.ClientID %>").value); //新制單
//            LODOP.ADD_PRINT_TEXT(160, 200, 80, 20, "所屬部門:"); //所屬部門
            
            
            LODOP.SET_PRINT_PAGESIZE(1, 1000, 500, "");
            //            LODOP.ADD_PRINT_BARCODE(200, 132, 338, 62, "Code39", "123456789012");
            //            LODOP.ADD_PRINT_BARCODE(300, 132, 338, 62, "Code39", "ABCde6789012");
            //            LODOP.ADD_PRINT_BARCODE(400, 132, 438, 82, "128B", "YBY008104BRCC83SDSTD115NEP0105501");
            //            LODOP.ADD_PRINT_BARCODE(500, 132, 438, 82, "128C", "GBE017038BRSTPOLO050150NEP0601801");
            //            LODOP.ADD_PRINT_BARCODE(600, 132, 438, 82, "EAN128B", "GBE017031BRW1W1SDSRT135NEP0510801");
            //            if (txtmo != "") {
            //                LODOP.ADD_PRINT_BARCODE(700, 132, 438, 82, "EAN128C", txtmo);
            //            }

            //            LODOP.ADD_PRINT_HTM(88, 200, 350, 600, document.getElementById("divprint").innerHTML);
        };    
    </script> 

</head>
<body style="background-color:#FAEBD7">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <asp:Label id="lblCard_id" Text="ID卡號" Width="68px" Height ="20px"  runat="server"/>
    <asp:Textbox id="txtCard_id" Text="" Width="120px" Height ="20px" AutoPostBack ="true" ontextchanged="txtCard_id_TextChanged"  runat="server"/>
    &nbsp;&nbsp;&nbsp;&nbsp
    <asp:Button id="btnFind" Text="查找" OnClick="btnFind_Click" Width="90px" Height ="30px"  runat="server"/>
    <asp:Button ID="btnPrv" runat="server" OnClientClick="prn1_preview('1')" Text="預覽" Width="80px" Height ="30px" />
    <asp:Button ID="btnPrn" runat="server" OnClientClick="prn1_print(1)" Text="直接列印" Width="80px" Height ="30px" />
    <asp:Button ID="btnNewPrint" runat="server" Text="新列印" OnClick ="btnNewPrint_Click" Width="80px" Height ="30px" />
    <asp:Button ID="btnShowTrace" runat="server" Text="查看追蹤" OnClick ="btnShowTrace_Click" Width="80px" Height ="30px" />
    <p style="background-color: #C0C0C0; line-height: 32px;">
    <asp:Label id="lblShowNew" Text="發卡部門填寫：" Width="120px" Height ="20px" ForeColor="Blue"  runat="server"/>
    <asp:Label ID="lblAction_type" runat="server" Text="操作方式" Width="68px" />
    <asp:DropDownList ID="dlAction_type" runat="server" Height ="25px" Width="124px" 
                 onselectedindexchanged="dlAction_type_SelectedIndexChanged" 
        AutoPostBack ="true" />
    &nbsp;&nbsp;&nbsp;&nbsp
    <asp:Button id="btnSave" Text="確認" OnClick="btnSave_Click" Width="80px" Height ="30px" Enabled="false"  runat="server"/>
    <asp:Button id="btnDel" Text="刪除" OnClick="btnDel_Click" Width="80px" Height ="30px" Enabled="false"  runat="server"/>
    <input id="txtCard_id_print" type="hidden" runat="server"/> 
    <input id="txtOwn_dep_print" type="hidden" runat="server"/> 
    </p>

    <asp:Label id="lblDoc_id" Text="單據編號" Width="68px" Height ="20px"  runat="server"/>
    <asp:Textbox id="txtDoc_id" Text="" Width="120px" Height ="20px" BackColor="Gainsboro" ReadOnly ="true"  runat="server"/>
    <asp:Label ID="lblDoc_date" runat="server" Text="建立日期" Width="68px" />
    <asp:TextBox ID="txtDoc_date" runat="server" Text="" Height ="20px" Width="118px" />

    <asp:Label ID="lblSample" Text="文件類別" Width="80px" Height="20px" runat="server" />
    <asp:CheckBox ID="chkTypeSample" Text="樣板" Width="60px" runat="server" />
    <asp:CheckBox ID="chkColorSample" Text="色板" Width="60px" runat="server" />
    <asp:CheckBox ID="chkDrawSample" Text="圖紙" Width="60px" runat="server" />
    <asp:CheckBox ID="chkOthSample" Text="其它" Width="60px" runat="server" />
    
    <br />

    

    <asp:Label ID="lblCorrMo" runat="server" Text="相關制單" Width ="68px" />
    <asp:TextBox ID="txtCorrMo" runat="server" Text="" Height ="20px" Width="250px" AutoPostBack="false" />
    <asp:Button ID="btnMoRemark" runat="server" Text="查看制單" OnClick ="btnMoRemark_Click" Width="66px" Height ="30px" />
    <asp:Label ID="lblColorDesc" runat="server" Text="顏色" Width ="80px" />
    <asp:TextBox ID="txtColorDesc" runat="server" Text="" Height ="20px" Width="320px" />
    <br />
    
    <asp:Label ID="lblRemark_head" runat="server" Text="詳細說明" Width ="68px" />
    <asp:TextBox ID="txtRemark_head" runat="server" Text="" Height ="20px" Width="320px" />
    <asp:Label ID="lblDataProvide" runat="server" Text="資料提供人" Width ="80px" />
    <asp:TextBox ID="txtDataProvide" runat="server" Text="" Height ="20px" Width="320px" />
    
    <br />
    <asp:Label ID="lblRouteDep1" runat="server" Text="交辦流程" Width ="68px" />
    <asp:DropDownList ID="dlRouteDep" runat="server" Height ="25px" Width="260px" />
    <asp:Button id="btnAddRoute" Text="+" OnClick="btnAddRoute_Click" Width="60px" Height ="25px"  runat="server"/>
    <asp:Label ID="lblOwnType" runat="server" Text="所屬部門" Width ="82px" />
    <asp:DropDownList ID="dlOwnType" runat="server" Height ="25px" Width="126px" onselectedindexchanged="dlOwnType_SelectedIndexChanged" AutoPostBack ="false" />
    <asp:Label ID="lblWaitSample" runat="server" Text="批色狀況" Width ="68px" />
    <asp:DropDownList ID="dlWaitSample" runat="server" Height ="25px" Width="126px" AutoPostBack ="false" />
    <br />
    <asp:Label ID="lblRouteDep2" runat="server" Text="交辦流程" Width ="68px" />
    <asp:TextBox ID="txtRouteDep" runat="server" Text="" Height ="20px" Width="320px" />
    <asp:Label ID="lblCard_id_org" runat="server" Text="原辦編號" Width ="80px" />
    <asp:TextBox ID="txtCard_id_org" runat="server" Text="" Height ="20px" Width="320px" />
    <br />
    

    <div id="dvMo" runat="server">
    <asp:Label id="lblPrd_mo" Text="制單編號" Width="68px" Height ="20px" Visible ="false" runat="server"/>
    <asp:Textbox id="txtPrd_mo" Text="" Width="120px" Height ="20px" Visible ="false" ontextchanged="txtPrd_mo_TextChanged"
        MaxLength ="10" AutoPostBack ="true"  runat="server"/>
    <asp:Label ID="lblPrd_item" runat="server" Text="物料編號" Width="68px" />
    <asp:DropDownList ID="dlPrd_item" runat="server" Height ="25px" Width="326px" 
                 onselectedindexchanged="dlPrd_item_SelectedIndexChanged" 
        AutoPostBack ="true" />
    <asp:Label ID="lblSale" runat="server" Text="營業員" Width ="80px" />
    <asp:TextBox ID="txtSale" runat="server" Text="" Height ="20px" Width="320px" ReadOnly ="true" BackColor="LightGray" />
    <br />
    <asp:Label ID="lblCustclr" runat="server" Text="客人顏色" Width ="68px" />
    <asp:TextBox ID="txtCustclr" runat="server" Text="" Height ="20px" Width="320px" />
    <asp:Label ID="lblCustitem" runat="server" Text="客人款號" Width ="80px" />
    <asp:TextBox ID="txtCustitem" runat="server" Text="" Height ="20px" Width="320px" />
    <br />
    <asp:Label ID="lblItem_cdesc" runat="server" Text="物料描述" Width ="68px" />
    <asp:TextBox ID="txtItem_cdesc" runat="server" Text="" Height ="20px" 
        Width="320px" ReadOnly ="true" BackColor="Gainsboro" />
    <asp:TextBox ID="txtPrd_item" runat="server" Text="" Height ="20px" Width="124px" ReadOnly="True" Visible ="false" />
    <asp:Label ID="lblDoColor" runat="server" Text="顏色做法" Width ="80px" />
    <asp:Textbox id="txtDoColor" Text="" Width="320px" Height ="20px" ReadOnly ="true" BackColor="LightGray"  runat="server"/>
    <br />
    <asp:Label ID="lblMoRemark" runat="server" Text="制單備註" Width ="68px" />
    <asp:TextBox ID="txtMoRemark" runat="server" Text="" Height ="20px" Width="320px" ReadOnly ="true" BackColor="LightGray" />
    <asp:Label ID="lblNewMo" runat="server" Text="新制單" Width ="80px" />
    <asp:TextBox ID="txtNewMo" runat="server" Text="" Height ="20px" Width="320px" />
    
    </div>

    <div id="dvMerge" visible ="true" runat ="server" 
        style="background-color: #FAF0E6"  >
    <%--<p style="background-color: #FAF0E6; line-height: 32px;">
    </p>--%>
    <asp:Label ID="lblCard_id_merge" runat="server" Text="登記多卡編號:  ID編號" Width ="168px" />
    <asp:TextBox ID="txtCard_id_merge" runat="server" Text="" Height ="20px" Width="220px"  />
    <asp:Label ID="lblOwnDep" runat="server" Text="所屬部門" Width ="80px" />
    <asp:DropDownList ID="dlOwnDep" runat="server" Height ="25px" Width="246px" />

    <asp:Button id="btnMerge" Text="加入" OnClick="btnMerge_Click" Width="80px" Height ="30px" Enabled="false"  runat="server"/>

    <asp:GridView ID="gvMerge" runat="server" Height="90px" Width="600px" 
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
      onrowdeleting="gvDetails_RowDeleting" onrowcommand="gvMerge_RowCommand">
        <Columns>
            <asp:BoundField DataField="card_id" HeaderText="ID編號" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="own_dep" HeaderText="所屬部門" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="dep_cdesc" HeaderText="所屬部門" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="sign_user" HeaderText="簽收人" >
            <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="sign_tim" HeaderText="簽收日期" >
            <ItemStyle Width="120px" />
            </asp:BoundField>
            <asp:ButtonField Text="簽收" CommandName="Sign" HeaderStyle-Width="40px" />
            <asp:CommandField ShowDeleteButton="True" >
            <HeaderStyle Width="40px" />
            </asp:CommandField>
            <asp:ButtonField Text="列印(舊)" CommandName="Print_old" HeaderStyle-Width="60px" />
            <asp:ButtonField Text="列印(新)" CommandName="Print_new" HeaderStyle-Width="60px" />
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="ActiveBorder" Font-Bold="True"></HeaderStyle>
        
<RowStyle Height="20px"></RowStyle>
        
    </asp:GridView>

        

    </div>

    <p style="background-color: #C0C0C0; line-height: 32px;">
    <asp:Label id="lblShowTrace" Text="跟進部門填寫：" Width="120px" Height ="20px" ForeColor="Blue"  runat="server"/>
    <asp:Label ID="lblAction_type1" runat="server" Text="操作方式" Width="68px" />
    <asp:DropDownList ID="dlAction_type1" runat="server" Height ="25px" Width="124px" 
                 onselectedindexchanged="dlAction_type1_SelectedIndexChanged" 
        AutoPostBack ="true" />
    &nbsp;&nbsp;&nbsp;&nbsp
    <asp:Button id="btnConf" Text="確認" OnClick="btnConf_Click" Width="80px" Height ="30px" Enabled="false"  runat="server"/>
    
    </p>

    <asp:Label ID="lblDep" runat="server" Text="本部門" Width="68px" />
    <asp:DropDownList ID="dlDep" runat="server" Height ="25px" Width="124px" />
    <br />
    <div id="dvToDep" runat ="server" >
    <asp:Label ID="lblToDep" runat="server" Text="下一部門" Width="68px" />
    <asp:DropDownList ID="dlToDep" runat="server" Height ="25px" Width="124px" />
    <asp:Label ID="lblOutDate" runat="server" Text="發出日期" Width ="68px" />
    <asp:TextBox ID="txtOutDate" runat="server" Text="" Height ="20px" Width="120px" />
    </div>
    
    <asp:Label ID="lblRemark" runat="server" Text="說明" Width ="68px" />
    <asp:TextBox ID="txtRemark" runat="server" Text="" Height ="20px" Width="386px" />
    
    <div id="dvTrace" runat ="server" >

    <p style="background-color: #C0C0C0; line-height: 32px;">
    

    <asp:Label ID="lblShowInfo" runat="server" Text="本單跟蹤：" Width ="80px" ForeColor="Blue" />
    
    </p>
    <asp:TreeView ID="treeTrace" runat="server" ForeColor="InfoText" Font-Bold="False" 
            Font-Italic="False" Font-Size="14px" Font-Strikeout="False" ShowLines="True" 
            Height="385px" Width="1006px">

        <NodeStyle BorderStyle="None" Height="30px" />

    <RootNodeStyle Font-Size="12pt" BorderStyle="None" />
    </asp:TreeView>
    
    </div>

    <div id="dvPrint" visible ="false" runat ="server" >
    <%--<rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana"
            Font-Size="8pt" InteractiveDeviceInfos="(集合)" WaitMessageFont-Names="Verdana" 
            WaitMessageFont-Size="14pt" Width="1400px" Height ="600px">
        </rsweb:ReportViewer>--%>
    </div>
    </form>
</body>
</html>
