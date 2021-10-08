<%@ Page Language="C#" AutoEventWireup="true" Inherits="Sales_Index" Codebehind="Sales_Index.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>xiaosh</title>
    <link href="css/base.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <br />
        <asp:SiteMapPath ID="SiteMapPath1" runat="server">
        </asp:SiteMapPath>
        <br />
        <br />
        <div style="border-right: #a4d5e3 1px solid; border-top: #a4d5e3 1px solid; background: url(../images/content_bg1.gif) repeat-x 50% bottom;
            float: left; margin-bottom: 8px; border-left: #a4d5e3 1px solid; width: 329px;
            border-bottom: #a4d5e3 1px solid;">
            <h2 style="padding-right: 0px; padding-left: 8px; font-size: 14px; background: #e2f3fa;
                padding-bottom: 0px; margin: 0px; color: #0066a9; line-height: 24px; padding-top: 0px;
                border-bottom: #a4d5e3 1px solid">
                快速导航：</h2>
            
              <table width="200" border="0">
             <asp:Repeater ID="SalesMenu" runat="server">
                                                <ItemTemplate>
                                                    <TR>
                                                        <TH>
                                                            &nbsp;</th>
                                                        <TD>
                                                            <a target="MainFrame" href=" <%# Eval("WebUrl")%>" >
                                                                <%# Eval("AuthorityName")%>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
               </table>
               
            <div style="margin: 5px">
                &nbsp;</div>
        </div>
    
    </div>
    </form>
</body>
</html>

