<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_MyEditSalesOrder_PayInfo" Codebehind="MyEditSalesOrder_PayInfo.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
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
        <table style="width: 642px">
            <tr>
                <td colspan="3" style="height: 39px">
                    <asp:SiteMapPath ID="SiteMapPath1" runat="server">
                    </asp:SiteMapPath>
                </td>
            </tr>
            <tr>
                <td colspan="3">
      
        <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
            float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 603px;
            border-bottom: #a4d5e3 1px solid; ">
            <h2 style="padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;
                padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;
                border-bottom: #a4d5e3 1px solid">
                付款处理</h2>
            <p>
                &nbsp;<asp:Label ID="Label1" runat="server" Text="销售单号" Width="52px"></asp:Label>：
                &nbsp;&nbsp;
                <asp:Label ID="SalesOrderID" runat="server"></asp:Label></p>
            <p>
                &nbsp;</p>
            <p>
                &nbsp; 付款说明：<asp:TextBox ID="info"  CssClass="txt_left" runat="server" Width="407px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="info"
                    ErrorMessage="不能为空"></asp:RequiredFieldValidator></p>
            <p>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp;
        &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp;
        <asp:Button ID="Button1" runat="server"  Text="提交处理" Width="109px" OnClick="Button1_Click" />
        </p>
            <div style="margin: 5px">
                &nbsp;</div>
        </div>
                </td>
            </tr>
        </table>
        <br />
        <br />
    </div>
    </form>
</body>
</html>

