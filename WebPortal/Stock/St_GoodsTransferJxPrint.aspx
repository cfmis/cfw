<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="St_GoodsTransferJxPrint.aspx.cs" Inherits="WebPortal.Stock.St_GoodsTransferJxPrint" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <input type="button" value="关闭" onclick="window.close()"/>
    <form id="form1" runat="server">
    <div>
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="false">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server"  Font-Names="Verdana" CssClass="ReportFont"  Width="100%" Height="100%"
            ZoomMode="PageWidth" ShowBackButton="true"  SizeToReportContent="True" Font-Size="8pt" InteractiveDeviceInfos="(Collection)" 
            WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
        </rsweb:ReportViewer>
        
                <%--<rsweb:ReportViewer ID="ReportViewer2" Height="98%" Width="99%" runat="server">
        </rsweb:ReportViewer>--%>

        <%--<rsweb:ReportViewer ID="ReportViewer1" Width="740" Height="550" BackColor="#F2F5F2"
            SizeToReportContent="false" ExportContentDisposition="AlwaysInline" ProcessingMode="Remote"
            ShowToolBar="true" ShowPageNavigationControls="true" ShowZoomControl="false" ShowDocumentMapButton="false"
            ShowFindControls="False" ShowBackButton="false" ShowExportControls="false" ShowPrintButton="false"
            ShowParameterPrompts="false" ToolBarItemBorderStyle="Solid" ShowRefreshButton="false"
            ToolBarItemBorderColor="Black"EnableTheming="false" AsyncRendering="true" Enabled="false" Visible="false" runat="server">

        </rsweb:ReportViewer>--%>


    </ContentTemplate>

        </asp:UpdatePanel>
        
    </div>
    </form>
</body>
</html>
