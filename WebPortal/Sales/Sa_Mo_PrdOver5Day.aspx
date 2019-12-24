<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Mo_PrdOver5Day.aspx.cs" Inherits="WebPortal.Sales.Sa_Mo_PrdOver5Day" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>匯出過期5日的制單</title>
    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
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

    <br />
    <p style="font-size:x-large; color:Blue">請將以下文件匯出到Excel</p>
    <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
    </asp:ScriptManager>


        <%--<script type="text/javascript">  

        
    var prm = Sys.WebForms.PageRequestManager.getInstance();  
    prm.add_initializeRequest(InitializeRequest);  
    prm.add_endRequest(EndRequest);  
    var postBackElement;  
    function InitializeRequest(sender, args) {
        if (prm.get_isInAsyncPostBack()) {
            args.set_cancel(true);
        }
        postBackElement = args.get_postBackElement();

        if (postBackElement.id = 'Btn_Query_Plan') {

            $get('UpdateProgress1').style.display = 'block';

        }
    }
    function EndRequest(sender, args) {
        if (postBackElement.id = 'Btn_Query_Plan') {
            $get('UpdateProgress1').style.display = 'none';
        }

    }
    </script> --%>

   


        


       

    <asp:Label ID="lblDep" Text="部門:" runat="server"></asp:Label>
    <asp:TextBox ID="txtDep" Text="" Width="120px" runat="server"></asp:TextBox>
    <asp:Label ID="lblDat" Text="批準日期:" runat="server"></asp:Label>
    <input size="12" type="text" id="dateStart" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})"/>
    <input size="12" type="text" id="dateEnd" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})"/>
    <br />
    
    <br />

     <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"  runat="server" >


            <%--<Triggers>  
                <asp:AsyncPostBackTrigger ControlID="Btn_Query_Plan" EventName="Click" />  
            </Triggers>--%>
        <ContentTemplate>
        
         </ContentTemplate>
        </asp:UpdatePanel>

    
        <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                <ProgressTemplate>
                    <div style="font-size: 12px; color: Blue; background-color: #FAEBD7; border: 0px solid #FAEBD7;">
                        <img alt="" src="../images/process3.gif" width ="80px" height ="60px"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
        </asp:UpdateProgress> 
    <asp:Button class="btn btn-success" ID="Btn_Query_Plan" runat="server" onclick="Btn_Query_Plan_Click" Text="部門生產計劃單" Width="160px" />
        <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_OC" runat="server" onclick="Btn_Exp_OC_Click" Text="銷售明細表" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Plate_Out" runat="server" onclick="Btn_Exp_Plate_Out_Click" Text="電鍍加工單" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Plate_In" runat="server" onclick="Btn_Exp_Plate_In_Click" Text="電鍍入庫單" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Plate_Return" runat="server" onclick="Btn_Exp_Plate_Return_Click" Text="電鍍返電單" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Mo_Redo" runat="server" onclick="Btn_Exp_Mo_Redo_Click" Text="生產補單" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Mo_Wait_Color" runat="server" onclick="Btn_Exp_Mo_Wait_Color_Click" Text="待批色頁數" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Mo_Color_OK" runat="server" onclick="Btn_Exp_Mo_Color_OK_Click" Text="批色OK頁數" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_All" runat="server" onclick="Btn_Exp_All_Click" Text="一鍵匯出以上文件" Visible="false" Width="160px" />
    <br />
    <p>不需要的制單編號:</p>
    <asp:Button class="btn btn-success" id="btnSetBatchMo" Text="設定制單編號" OnClick="btnSetNoMo_Click" Width="160px"  runat="server"/>
    <br />
    <br />

    </form>
    </div>
    </div>
</body>
</html>
