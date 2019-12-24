<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_MoMoveStatus_Spec.aspx.cs" Inherits="WebPortal.Sales.Sa_MoMoveStatus_Spec" EnableEventValidation="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <%--當使用bootstrap格式時，建議配對使用：ScriptManager，不然出現兼容性錯誤。--%>

    <style type="text/css"> 
        .divShowQueryImg{ border:1px solid #000; height:80px;overflow:hidden;} 
        .divShowQueryImg img{max-width:60px;_width:expression(this.width > 300 ? "300px" : this.width);} 
    </style> 



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

    <table style="width: 97%">
        <tr>
            <td align="left" style="width: 810px; height: 20px">
                <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                </asp:SiteMapPath>
            </td>
        </tr>
    </table>

    <form id="form1" runat="server">
    <div>
    
    <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
    </asp:ScriptManager>

    <asp:Button id="btnExpExcelNew" Text="匯出到Excel" OnClick="btnExpExcelNew_Click" Width="100px"  Height ="30px"  runat="server"/>
    <asp:Button id="btnSetBatchMo" Text="設定制單編號" OnClick="btnSetBatchMo_Click" Width="100px" Height ="30px" Visible ="false"  runat="server"/>
    
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>

    <fieldset style="border-width: 0px; border-color: #FAEBD7;">
    </fieldset>

    <asp:Button id="btnFind" Text="查找" OnClick="btnFind_Click" Width="100px" Height ="30px"  runat="server"/>
    <a href="../Sales/Sa_MoMoveStatus_Set.aspx">設定制單編號</a>
    <br />

    <asp:UpdatePanel ID="UpdatePanel2"  runat="server" >
    <ContentTemplate>

    <fieldset style="border-width: 0px; border-color: #FAEBD7;">


    

    <asp:Label id="lblDate1" Text="統計日期" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtDate1" Width ="80px" Text="" onKeyUp="setValue(this,txtDate2)" runat="server"/>
    <%--<asp:TextBox id="txtDate1" Width ="80px" Text="" AutoPostBack="true" ontextchanged="txtDate1_TextChanged" runat="server"/>--%>
    <asp:Label id="lblTo1" Text="To" Width ="20px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtDate2" Text="" Width ="80px" runat="server"/>
    <asp:Label id="lblDep" Text="發貨部門" Width ="60px" Font-Size="13px" runat="server"/>
    <asp:TextBox id="txtDep" Width ="100px" Text="" runat="server"/>

    <br />


    </fieldset>

    </ContentTemplate>
    </asp:UpdatePanel>

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

    <asp:GridView ID="gvDetails" runat="server" Height="90px" Width="1000px" 
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
            <asp:BoundField DataField="cust_req_date" HeaderText="客人要求日期" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="out_id" HeaderText="外發單號" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="out_date" HeaderText="外發日期" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="req_in_date" HeaderText="要求交回日期" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="in_date" HeaderText="實際收貨日期" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="out_days" HeaderText="外發天數" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="next_dep" HeaderText="下部門" HeaderStyle-Width="40px" />
            <asp:BoundField DataField="next_dep_date" HeaderText="交下部門日期" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="next_dep_qty" HeaderText="交下部門數量" HeaderStyle-Width="80px" />
            <asp:BoundField DataField="to_loc" HeaderText="入倉" HeaderStyle-Width="30px" />
            <asp:BoundField DataField="to_loc_date" HeaderText="入倉日期" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="to_loc_qty" HeaderText="入倉數量" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ret_hk_date" HeaderText="回港日期" HeaderStyle-Width="100px" />
            <asp:BoundField DataField="ret_hk_qty" HeaderText="回港數量" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ret_hk_mo" HeaderText="回港制單" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="ret_hk_id" HeaderText="回港單號" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="seq" HeaderText="序號" HeaderStyle-Width="40px" />
            <asp:BoundField DataField="prod_qty" HeaderText="外發數量" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="in_qty" HeaderText="收貨數量" HeaderStyle-Width="60px" />
            <asp:BoundField DataField="goods_id" HeaderText="物料編號" HeaderStyle-Width="160px" />
            <asp:BoundField DataField="goods_name" HeaderText="物料描述" HeaderStyle-Width="240px" />
            <asp:BoundField DataField="vendor_id" HeaderText="供應商" HeaderStyle-Width="40px" />
            <asp:BoundField DataField="production_remark" HeaderText="生產備註" HeaderStyle-Width="120px" />
            <asp:BoundField DataField="plate_remark" HeaderText="外發備註" HeaderStyle-Width="120px" />
        </Columns>


<HeaderStyle HorizontalAlign="Center" BackColor="LightCyan" Font-Bold="True"></HeaderStyle>
        
    </asp:GridView>

    <asp:Label id="lblShowInfo" Text="外發加工之移交狀態記錄。" Width ="628px" ForeColor="Blue" Font-Size="13px" runat="server"/>

    </ContentTemplate>

    </asp:UpdatePanel>


    </div>
    </form>
</body>
</html>
