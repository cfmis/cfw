<%@ Page Language="C#" AutoEventWireup="true" Inherits="User_SysUserSearch" Codebehind="SysUserSearch.aspx.cs" %>


<%@ Register Assembly="Components" Namespace="Controls" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>系统用户管理</title>
    
<link href="../css/base.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
function openwindow(url)
{
  window.open("SysUserDetail.aspx?UserName=" +url,null,"height=100%,width=840,status=yes,toolbar=yes,menubar=yes,location=yes,resizable=yes,scroll=yes");
}


function Button2_onclick() {

}

</script>
</head>
<body>
    <form id="form1" runat="server">
    <div align=left>
        <asp:SiteMapPath ID="SiteMapPath1" runat="server">
        </asp:SiteMapPath>
        <br />
      <table width="100%" border="0">
          <tr>
              <td class="title" align="center">
                  用户基本维护</td>
          </tr>
          <tr>
              <td>
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                  &nbsp; &nbsp;
                  <input id="Button1" type="button" onclick="window.location.replace('SysUserManager.aspx')"  value="添加用户" /></td>
          </tr>
  <tr>
    <td>&nbsp; &nbsp;
    &nbsp;<asp:GridView ID="SearchResult" runat="server" AutoGenerateColumns="False" BackColor="White"
            BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="988px" DataKeyNames="UserName"   >
            <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="UserName" DataNavigateUrlFormatString="SysUserDetail.aspx?UserName={0}"
                    HeaderText="查看" Text="&lt;img border=0 src=../images/View.gif /&gt;" />
                <asp:BoundField DataField="UserName" HeaderText="帐号" SortExpression="UserName" />
                <asp:BoundField DataField="RealName" HeaderText="姓名" SortExpression="RealName" />
                <asp:BoundField DataField="Tel" HeaderText="电话" />
                <asp:BoundField DataField="GroupName" HeaderText="权限组" />
                <asp:BoundField DataField="TypeName" HeaderText="一级类型" />
                <asp:BoundField DataField="SubClassName" HeaderText="二级类型" SortExpression="SubClassName" />
                <asp:BoundField DataField="State" HeaderText="状态" />
                <asp:HyperLinkField DataNavigateUrlFields="UserName" DataNavigateUrlFormatString="SysUserManagerEdit.aspx?UserName={0}"
                    HeaderText="编辑" Text="&lt;img border=0 src=../images/Edit.gif /&gt;">
                    <ItemStyle Width="30px" />
                </asp:HyperLinkField>
                <asp:HyperLinkField DataNavigateUrlFields="UserName" DataNavigateUrlFormatString="SysUserSearch.aspx?action=del&amp;UserName={0}"
                    HeaderText="停用" Text="&lt;img border=0 src=../images/Close.gif /&gt;">
                    <ItemStyle Width="30px" />
                </asp:HyperLinkField>
            </Columns>
            <RowStyle BackColor="White" ForeColor="#003399" />
            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#E2F3FA" Font-Bold="True" ForeColor="Black" />
        </asp:GridView>
        <div class="pageLink" id="pageLink">
        <cc1:collectionpager id="CollectionPager1" runat="server" backnextlinkseparator=" "
            backtext="上一页" firsttext="第一页" labeltext="第" lasttext="最后一页" nexttext="下一页" pagenumbersseparator="-"
            pagesize="10" showfirstlast="true" showpagenumbers="true"></cc1:collectionpager>
            </div>
    </td>
  </tr>
  <tr>
    <td style="height: 17px" align="center">&nbsp;
    </td>
  </tr>
</table>
    
    </div>
    </form>
</body>
</html>
