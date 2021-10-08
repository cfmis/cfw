<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sa_Mo_PeriodOver5Day.aspx.cs" Inherits="WebPortal.Sales.Sa_Mo_PeriodOver5Day" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../css/form_view_frame.css" rel="Stylesheet" type="text/css" />
    <script src="../js/util.js" type="text/javascript"></script> 
    <meta http-equiv="Content-Type" content="text/html; charset=big5" /> 
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>
    <%--<link rel="stylesheet" href="../css/bootstrap.min.css"/>  --%>

    <link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>


    <script language="JavaScript" type="text/javascript">
        var new_window;
        function setValue(fobj, tobj) {
            tobj.value = fobj.value;

        }


        </script>

        <style type="text/css"> 
        .divShowQueryImg{ border:1px solid #000; height:80px;overflow:hidden;} 
        .divShowQueryImg img{max-width:60px;_width:expression(this.width > 300 ? "300px" : this.width);} 
    </style> 



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
    <p style="font-size:x-large; color:Blue">�бN�H�U���ץX��Excel</p>
    <%--<asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
    </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional"  runat="server" >

        <triggers>  
            <asp:PostBackTrigger ControlID="Btn_Query_Plan" /> 
        </triggers>

        <ContentTemplate>


        <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="divShowQueryImg" style=" color: Blue; background-color: #FAEBD7; border: 0px solid #FAEBD7;">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        ���b�d��,�еy��...
                    </div>
                </ProgressTemplate>
        </asp:UpdateProgress> 


        </ContentTemplate>
        </asp:UpdatePanel>--%>

    <asp:Label ID="lblDep" Text="����:" runat="server"></asp:Label>
    <asp:TextBox ID="txtDep" Text="" Width="120px" runat="server"></asp:TextBox>
    <asp:Label ID="lblDat" Text="��Ǥ��:" runat="server"></asp:Label>
    <input size="12" type="text" id="dateStart" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})"/>
    <input size="12" type="text" id="dateEnd" style="height:18px;width:120px" runat="server" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd',readOnly:true})"/>
    <br />
    
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Query_Plan" runat="server" onclick="Btn_Query_Plan_Click" Text="�����Ͳ��p����" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_OC" runat="server" onclick="Btn_Exp_OC_Click" Text="�P����Ӫ�" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Plate_Out" runat="server" onclick="Btn_Exp_Plate_Out_Click" Text="�q��[�u��" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Plate_In" runat="server" onclick="Btn_Exp_Plate_In_Click" Text="�q��J�w��" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Plate_Return" runat="server" onclick="Btn_Exp_Plate_Return_Click" Text="�q���q��" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Mo_Redo" runat="server" onclick="Btn_Exp_Mo_Redo_Click" Text="�Ͳ��ɳ�" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Mo_Wait_Color" runat="server" onclick="Btn_Exp_Mo_Wait_Color_Click" Text="�ݧ�⭶��" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_Mo_Color_OK" runat="server" onclick="Btn_Exp_Mo_Color_OK_Click" Text="���OK����" Width="160px" />
    <br />
    <br />
    <asp:Button class="btn btn-success" ID="Btn_Exp_All" runat="server" onclick="Btn_Exp_All_Click" Text="�@��ץX�H�W���" Visible="false" Width="160px" />
    <br />
    <p>���ݭn�����s��:</p>
    <asp:Button class="btn btn-success" id="btnSetBatchMo" Text="�]�w���s��" OnClick="btnSetNoMo_Click" Width="160px"  runat="server"/>
    <br />
    <br />

    </form>
    </div>
    </div>
</body>
</html>
