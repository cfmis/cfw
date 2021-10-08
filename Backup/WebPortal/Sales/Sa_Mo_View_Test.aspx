<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Mo_View_Test.aspx.cs" Inherits="WebPortal.Sales.Sa_Mo_View_Test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>查看制單檢驗分類編號</title>

    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>

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

    <table style="table-layout:fixed;word-wrap:break-word;word-break:break-all;" border="2" width="1000px">
    <tr>
    <td>
    制單編號
    </td>
    <td>
    <input type="text" id="txtMo" style="width:90%" runat="server"/>
    </td>
    <td colspan="3">
    <asp:Button class="btn btn-success" id="btnFind" Text="查找" OnClick="btnFind_Click" Width="120px" Height ="30px"  runat="server"/>
    </td>
    </tr>

    <tr>
    <td>
    檢驗分類編號
    </td>
    <td>
    <input type="text" id="txtId" style="width:90%" runat="server"/>
    </td>
    <td>
    牌子類別
    </td>
    <td>
    <input type="text" id="txtBrand" style="width:90%" runat="server"/>
    </td>
    <td>
    客戶產品編號
    </td>
    <td>
    <input type="text" id="txtCust_goods" style="width:90%" runat="server"/>
    </td>
    <td>
    客戶顏色編號
    </td>
    <td>
    <input type="text" id="txtCust_color" style="width:90%" runat="server"/>
    </td>
    </tr>

    <tr>
    <td>
    顏色類別
    </td>
    <td>
    <input type="text" id="txtColor_cdesc" style="width:90%" runat="server"/>
    </td>
    <td>
    原材料
    </td>
    <td>
    <input type="text" id="txtDatum_cdesc" style="width:90%" runat="server"/>
    </td>
    <td>
    產品類別
    </td>
    <td>
    <input type="text" id="txtPrd_cdesc" style="width:90%" runat="server"/>
    </td>
    <td>
    圖樣代號
    </td>
    <td>
    <input type="text" id="txtArt" style="width:90%" runat="server"/>
    </td>
    </tr>


    <tr>
    <td>
    尺寸
    </td>
    <td>
    <input type="text" id="txtSize" style="width:90%" runat="server"/>
    </td>
    <td>
    CF顏色
    </td>
    <td>
    <input type="text" id="txtColor" style="width:90%" runat="server"/>
    </td>
    <td>
    
    </td>

    <td>
    備註
    </td>
    <td colspan="2">
    <input type="text" id="txtRemark" style="width:90%" runat="server"/>
    </td>
    </tr>


    </table>

    

    <div id="Div1" class="div_table_scroll" runat="server">
        
        <table id="tableExcel" border="2" width="1000px">
  			 <thead>
             <tr class="a1" style="color:#ffffff;height:30px">
   				        <th style="width:8%">測試項目</th>
				        <th style="width:10%">項目描述</th>
                        <th style="width:10%">英文描述</th>
                        <th style="width:10%">條件分類</th>
                        <th style="width:10%">測試報告</th>
                        <th style="width:10%">有效期</th>
                        <th style="width:10%">參考制單</th>
                        <th style="width:10%">送測編號</th>
                        <th style="width:22%">備註</th>
  			 </tr>  
  			</thead>
            <tbody>
  			<asp:Repeater ID="rpMoTestDetail" runat="server">
  			    <ItemTemplate>
  			     <tr> 
                    
      			    <td><%#Eval("test_item_id")%></td>
                    <td><%#Eval("test_item_cdesc")%></td>
      			    <td><%#Eval("test_item_desc")%></td>
                    <td></td>
                    <td><%#Eval("test_report_no")%></td>
                    <td><%#Eval("effect")%></td>
                    <td><%#Eval("ref_mo")%></td>
                    <td></td>
                    <td><%#Eval("remark")%></td>
                    
  			     </tr>
  			    </ItemTemplate>
  			</asp:Repeater>
            </tbody>
            
  			 
		</table>
        </div>




    </form>

    </div>
    </div>
</body>
</html>
