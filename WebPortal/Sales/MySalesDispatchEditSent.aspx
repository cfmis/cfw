<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_MySalesDispatchEditSent" Codebehind="MySalesDispatchEditSent.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    
    <link href="../css/base.css" rel="stylesheet" type="text/css" />
  	<script type="text/javascript" src="../js/AjaxJS.js"></script>
   <script type="text/javascript">
   function checkDate()
   {
     var oStartDate=document.getElementById("SentDate")
    var a=/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2})/;
      if (!a.test(oStartDate.value)){
      alert("日期输入有误");
      return false
      }
      if(oStartDate.value=="")
      {
        alert("发货日期不能为空");
         return false
      }
   }
   
   
   </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      
        <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
            float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 494px;
            border-bottom: #a4d5e3 1px solid; ">
            <h2 style="padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;
                padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;
                border-bottom: #a4d5e3 1px solid">
                发货处理</h2>
            <p>
        <asp:Label ID="Label1" runat="server" Text="发货单号" Width="65px"></asp:Label>：<asp:Label
            ID="Label2" runat="server"></asp:Label>&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Visible="False"></asp:Label></p>
            <p>
                发货日期<asp:TextBox ID="SentDate" runat="server" CssClass="txt_left" Width="90px"></asp:TextBox><img
            alt="弹出日历下拉菜单" height="16" onclick="fPopUpCalendarDlg(SentDate);return false;"
            src="../images/calendar.gif" style="cursor: hand" width="16" />&nbsp;</p>
            <p>
                发单状态：&nbsp;
                <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem Value="1">正常发货</asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;
                <asp:HyperLink ID="HyperLink1" runat="server">进入问题处理</asp:HyperLink></p>
            <p>
                &nbsp;</p>
            <p>
                发单单号：<asp:TextBox ID="SentNum" runat="server" Width="128px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="SentNum"
                    ErrorMessage="不能为空"></asp:RequiredFieldValidator>
                快件金额：<asp:TextBox ID="Postage" runat="server" Width="43px"></asp:TextBox>
                
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Postage"
                        ErrorMessage="输入有误" ValidationExpression="^[0-9]*\.?[0-9]{0,2}$"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Postage"
                    ErrorMessage="不能为空"></asp:RequiredFieldValidator></p>
            <p>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp;
        &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
        <asp:Button ID="Button1" runat="server" OnClientClick="javascript:if(!confirm('您确定要提交吗！提交后不能修改'))return  false;checkDate()" Text="提交处理" Width="109px" OnClick="Button1_Click" />
        <asp:Label ID="Label4" runat="server" Visible="False"></asp:Label></p>
            <div style="margin: 5px">
                &nbsp;</div>
        </div>
    </div>
    </form>
</body>
</html>
