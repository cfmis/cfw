<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_ShowProductsInfo" Codebehind="ShowProductsInfo.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>商品浏览页面</title>

           <link rel="stylesheet" href="../css/box.css" type="text/css" media="screen" />
          <link rel="stylesheet" href="../css/base.css" type="text/css" media="screen" />
    <script type="text/javascript" src="../js/jquery.js"></script>
<script type="text/javascript" src="../js/thickbox.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
        &nbsp;
    <div>
        &nbsp;<br />
        &nbsp;商品编号:<asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        商品名称:
        <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label><br />
        <br />
    <TABLE class="cbor mu12"  cellSpacing=0 cellPadding=0 border=0 style="width: 902px; background-color:#84aa5a; ">
            <TBODY>
                <TR>
                    <TD style="width: 665px; height: 314px;" align="center">
                        <table >
                            <tr>
                                <td style="width: 446px; height: 21px" align=left valign=top>
                                                     <DIV 
style="FLOAT: left; WIDTH: 239px; BACKGROUND-COLOR: #fff; TEXT-ALIGN: right; height: 279px;">
  <DIV class=clearit style="HEIGHT: 7px; width: 304px;"><BR></DIV>
<DIV></DIV>
<DIV style="WIDTH: 302px; TEXT-ALIGN: center">
 <asp:Image ID="Image1" runat="server" Height="236px" Width="324px" />
</DIV>
<DIV><IMG src="../images/newblogimg52.gif" style="height: 27px; width: 326px;"></DIV></DIV>
                                </td>
                                <td style="height: 21px; width: 473px;">
                                    <table height="303" border="0" style="width: 250px">
      <tr>
        <td align="center" style="width: 124px">品牌：</td>
        <td style="width: 374px">&nbsp;<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td align="center" style="width: 124px">类型：</td>
        <td style="width: 374px">&nbsp;<asp:Label ID="Label2" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td align="center" style="width: 124px">单位：</td>
        <td style="width: 374px">&nbsp;<asp:Label ID="Label3" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td align="center" style="width: 124px">颜色</td>
        <td style="width: 374px">&nbsp;<asp:Label ID="Label4" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td align="center" style="width: 124px">规格</td>
        <td style="width: 374px">&nbsp;<asp:Label ID="Label5" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td align="center" style="width: 124px">重量</td>
        <td style="width: 374px">&nbsp;<asp:Label ID="Label6" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td align="center" style="width: 124px; height: 35px;">材 质</td>
        <td style="width: 374px; height: 35px;">&nbsp;<asp:Label ID="Label7" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td align="center" style="width: 124px; height: 32px;">
            销售价&nbsp;</td>
        <td style="width: 374px; height: 32px;">
            <asp:Label ID="Label10" runat="server" Text="Label"></asp:Label>&nbsp;</td>
      </tr>

    </table>
                                </td>
                            </tr>
                        </table>
                   
  
                        
                       
                    </td>
                </tr>
            </tbody>
        </table>
    <br />
    更多图片
        <br />
        <br />
        <br />

                   <asp:DataList ID="DataList1" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" Width="900px">
              <ItemTemplate>
              <DIV class="example"
style="BACKGROUND: url(../images/runtannew16.jpg) no-repeat; FLOAT: left; WIDTH: 155px; HEIGHT: 138px; TEXT-ALIGN: center"> 
<table style="width: 136px">
                  <tr>
                    <td style="height: 107px; "  valign=bottom>                         
<A href="..\UploadFiles\Images\<%#Eval("PhotoUrl")  %>" title="大图" class="thickbox">
<img  src="..\UploadFiles\Images\<%#Eval("PhotoUrl")  %>" border=0 width=136 style="height: 94px" /></A></td>
                  </tr>
    <tr>
        <td valign=top>
            </td>
    </tr>
                    </table>

</DIV>
              
              </ItemTemplate>
              </asp:DataList>
             
    
    </div>
        <br />
        
       </div> 
    </form>

</body>
</html>