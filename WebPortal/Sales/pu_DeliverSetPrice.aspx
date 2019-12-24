<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pu_DeliverSetPrice.aspx.cs" Inherits="WebPortal.Sales.pu_DeliverSetPrice" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>設置外發加工單價</title>

    <script language="JavaScript" type="text/javascript">
        // EnableEventValidation="false" 設置這個gridview才可以按行選擇
        //by ahuinan 2009-4-10 
        function clearNoNum(event, obj) {
            //响应鼠标事件，允许左右方向键移动 
            event = window.event || event;
            if (event.keyCode == 37 | event.keyCode == 39) {
                return;
            }
            //先把非数字的都替换掉，除了数字和. 
            obj.value = obj.value.replace(/[^\d.]/g, "");
            //必须保证第一个为数字而不是. 
            obj.value = obj.value.replace(/^\./g, "");
            //保证只有出现一个.而没有多个. 
            obj.value = obj.value.replace(/\.{2,}/g, ".");
            //保证.只出现一次，而不能出现两次以上 
            obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
        }
        function checkNum(obj) {
            //为了去除最后一个. 
            obj.value = obj.value.replace(/\.$/g, "");
        }
        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }
    </script> 



</head>
<body style="background-color:#FAEBD7">
    <form id="form1" runat="server">
    <div>
    
    </div>


    <asp:Button id="btnFind" Text="查找" OnClick="btnFind_Click" Width="100px" Height ="35px"  runat="server"/>
    <asp:Button id="btnExpExcelNew" Text="匯出到Excel" OnClick="btnExpExcelNew_Click" Width="100px"  Height ="30px"  runat="server"/>
    <asp:Label id="lblForm1" Text="設置外發加工單價" Width ="300px" ForeColor="#0000CC" runat="server"/>
    <br />
    
    <asp:Label id="lblDoc_id1" Text="加工單號" Width ="80px" runat="server"/>
    <asp:TextBox id="txtDoc_id1" Text="" Width ="100px " onKeyUp="setValue(this,txtDoc_id2)" runat="server"/>
    <asp:Label id="lblTo1" Text="To" Width ="20px" runat="server"/>
    <asp:TextBox id="txtDoc_id2" Text="" Width ="100px" runat="server"/>

    <asp:Label id="lblDoc_date1" Text="加工單日期" Width ="80px" runat="server"/>
    <asp:TextBox id="txtDoc_date1" Width ="100px" Text="" onKeyUp="setValue(this,txtDoc_date2)" runat="server"/>
    <asp:Label id="lblTo2" Text="To" Width ="20px" runat="server"/>
    <asp:TextBox id="txtDoc_date2" Text="" Width ="100px" runat="server"/>
    <asp:Label id="lblDateFormat1" Text="(日期格式：YYYY/MM/DD)" Width ="200px" ForeColor="#0000CC" Font-Size="Small" runat="server"/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br />
    <asp:Label id="lblMo" Text="制單編號" Width ="80px" runat="server"/>
    <asp:TextBox id="txtMo1" Width ="100px" Text="" onKeyUp="setValue(this,txtMo2)" runat="server"/>
    <asp:Label id="lblTo3" Text="To" Width ="20px" runat="server"/>
    <asp:TextBox id="txtMo2" Text="" Width ="100px" runat="server"/>
    <asp:Label id="lblVend_id" Text="供應商編號" Width ="80px" runat="server"/>
    <asp:DropDownList ID="dlVend_id" Width ="106px" runat="server" />
    <br />
    <asp:Label id="lblSetPrice" Text="單價狀態" Width ="80px" runat="server"/>
    <asp:DropDownList ID="dlSetPrice" Width ="240px" runat="server" 
        AutoPostBack ="false" 
        onselectedindexchanged="dlDeliverFlag_SelectedIndexChanged" />
    <asp:Label id="lblDep" Text="外發部門" Width ="80px" runat="server"/>
    <asp:TextBox id="txtDep" Text="" Width ="100px" runat="server"/>
    <asp:CheckBox ID="chkShowSum" Text="顯示匯總表" runat="server"/>

    <div style="border-width: 0px; width:800px">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
        <ContentTemplate>
            <fieldset style="border-width: 0px; border-color: #FAEBD7;">
                <%--<asp:Label ID="Label1" runat="server" Text="Initial page rendered."></asp:Label>--%><br />
                
                <asp:Button id="btnSave" Text="確認更新" OnClick="btnSave_Click" Width="100px" Height ="35px" runat="server"/>
                <asp:CheckBox ID="chkSelectAll" Text="選中所有" runat="server" AutoPostBack="True" 
                oncheckedchanged="chkSelectAll_CheckedChanged"/>

                <asp:Label id="lblTotalRec" Text="記錄數:" Width ="280px" ForeColor="Blue" runat="server"/>

                   <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
                    AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                <ProgressTemplate>
                    <div style="font-size: 12px; color: Blue; background-color: #FAEBD7; border: 0px solid #FAEBD7;">
                        <img src="../images/process3.gif" width ="80px" height ="60px"/>
                        <br />
                        正在更新單價...
                    </div>
                </ProgressTemplate>
                </asp:UpdateProgress>
    
    <br />
    <asp:GridView ID="gvDetails" runat="server" Height="90px" Width="1600px" 
      BackColor="AntiqueWhite"
      BorderColor="Black" 
      CellPadding=3
      Font-Name="宋体"
      Font-Size="9pt"
      HeaderStyle-BackColor=ActiveBorder
      HeaderStyle-Font-Bold=true
      EnableViewState="False"
      HeaderStyle-HorizontalAlign=Center
      HeaderStyle-Height="20px"
      RowStyle-Height="20px"
      AutoGenerateColumns="False" Font-Names="宋体" 
        onpageindexchanging="gvDetails_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="選取" HeaderStyle-Width="60" ItemStyle-HorizontalAlign="Center">
            <ItemTemplate>
            <asp:CheckBox ID="chkRec"  runat="server" />
            </ItemTemplate>

            <HeaderStyle Width="40px"></HeaderStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="id" HeaderText="加工單號" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="sequence_id" HeaderText="序號" HeaderStyle-Width="40px" />
            <asp:BoundField DataField="mo_id" HeaderText="制單編號" HeaderStyle-Width="80px" />
            
            
            <asp:BoundField DataField="do_color" HeaderText="顏色做法" HeaderStyle-Width="180px" />
            <asp:TemplateField HeaderText="價格" HeaderStyle-Width="60" HeaderStyle-HorizontalAlign="Center">
            <ItemTemplate>
            <asp:TextBox ID="txtPrice" Text='<%# Bind("price") %>' Width ="60"  runat="server" />
            </ItemTemplate>

<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
            <ItemStyle Width="60px" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="單價單位" HeaderStyle-Width="60" HeaderStyle-HorizontalAlign="Center">
            <ItemTemplate>
            <asp:DropDownList ID="dlP_unit" Width ="60" DataSource='<%# ddlBindPunit() %>'  DataValueField="p_unit" DataTextField="p_unit" Text='<%# Bind("p_unit") %>' runat="server" />
            </ItemTemplate>

<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
            </asp:TemplateField>


            <asp:TemplateField HeaderText="重量價格" HeaderStyle-Width="60" HeaderStyle-HorizontalAlign="Center">
            <ItemTemplate>
            <asp:TextBox ID="txtSec_price" Text='<%# Bind("sec_price") %>' Width ="60"  runat="server" />
            </ItemTemplate>

<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
            <ItemStyle Width="60px" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="單價單位" HeaderStyle-Width="60" HeaderStyle-HorizontalAlign="Center">
            <ItemTemplate>
            <asp:DropDownList ID="dlSec_p_unit" Width ="60" DataSource='<%# ddlBindPunit() %>'  DataValueField="p_unit" DataTextField="p_unit" Text='<%# Bind("sec_p_unit") %>' runat="server" />
            </ItemTemplate>

<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
            <ItemStyle Width="60px" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="價格備註" HeaderStyle-Width="60" HeaderStyle-HorizontalAlign="Center">
            <ItemTemplate>
            <asp:TextBox ID="txtProcess_request" Text='<%# Bind("process_request") %>' Width ="60"  runat="server" />
            </ItemTemplate>

<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
            <ItemStyle Width="60px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="最低消費金額" HeaderStyle-Width="60" HeaderStyle-HorizontalAlign="Center">
            <ItemTemplate>
            <asp:TextBox ID="txtMould_fee" Text='<%# Bind("mould_fee") %>' Width ="60"  runat="server" />
            </ItemTemplate>

<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
            <ItemStyle Width="60px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="版費" HeaderStyle-Width="60" HeaderStyle-HorizontalAlign="Center">
            <ItemTemplate>
            <asp:TextBox ID="txtFormer_free" Text='<%# Bind("former_free") %>' Width ="60"  runat="server" />
            </ItemTemplate>

<HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
            <ItemStyle Width="60px" />
            </asp:TemplateField>
            <asp:BoundField DataField="goods_id" HeaderText="物料編號" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="goods_name" HeaderText="物料描述" HeaderStyle-Width="280px" />
            <asp:BoundField DataField="prod_qty" HeaderText="數量" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="sec_qty" HeaderText="重量" HeaderStyle-Width="80px" />
            
            <asp:BoundField DataField="issue_date" HeaderText="加工單日期" HeaderStyle-Width="80px" />
            
            <asp:BoundField DataField="vendor_id" HeaderText="供應商" HeaderStyle-Width="120px" />
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="ActiveBorder" Font-Bold="True"></HeaderStyle>
        
    </asp:GridView>




    <asp:GridView ID="gvSum" runat="server" Height="90px" Width="600px" 
      BackColor="AntiqueWhite"
      BorderColor="Black" 
      CellPadding=3
      Font-Name="宋体"
      Font-Size="9pt"
      HeaderStyle-BackColor=ActiveBorder
      HeaderStyle-Font-Bold=true
      EnableViewState="False"
      HeaderStyle-HorizontalAlign=Center
      HeaderStyle-Height="20px"
      RowStyle-Height="20px"
      AutoGenerateColumns="False" Font-Names="宋体" 
        onpageindexchanging="gvDetails_PageIndexChanging">
        <Columns>
            <asp:BoundField DataField="rep_type" HeaderText="報表類別" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="issue_date" HeaderText="加工單日期" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="vend_type" HeaderText="供應商" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="tot_rec" HeaderText="單數" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="is_price" HeaderText="有單價" HeaderStyle-Width="80px" />
        </Columns>
        
<HeaderStyle HorizontalAlign="Center" BackColor="ActiveBorder" Font-Bold="True"></HeaderStyle>
        
    </asp:GridView>






            </fieldset>
        </ContentTemplate>
        
    </asp:UpdatePanel>
    </div>



    </form>
</body>
</html>
