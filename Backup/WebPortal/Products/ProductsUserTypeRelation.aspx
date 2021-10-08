<%@ Page Language="C#" AutoEventWireup="true" Inherits="Products_ProductsUserTypeRelation" Codebehind="ProductsUserTypeRelation.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
            <style type="text/css">
    body {
	FONT-SIZE: 12px;
	COLOR: #333;
	FONT-FAMILY: 'Lucida Grande', Verdana, Arial, Sans-Serif;
	background-color: #FFFFFF;
	margin-top: 1px;
	text-align: center;
	margin-bottom: 1px;

	}
a:visited,
a:active,
a:link {
 color:#0279CB;
 text-decoration:none;
 }
a:hover {
 color:#00A4E3;
 text-decoration:none;
 BORDER-BOTTOM: 1px dotted;
}
#page{
text-align:left;
padding-left:10px;
padding-top:2px;
	margin-top:1px;
	margin-bottom:1px;

}
.horizBar
{
	background-color:#E5EEF7;
	width:700px;
	height:20px;
	border-bottom: 1px;
	border-top:1px thin;
	padding-left:10px;
	text-align: left;
	padding-top: 5px;
	margin-top:1px;
	margin-bottom:1px;
}
.title{
FONT-WEIGHT: bold; font: "Times New Roman", Times, serif;
font-size:13px;
color:#0279CB;
}
INPUT
{
   margin-top :1px;
	margin-bottom:1px;
	padding-bottom:1px;
	padding-top:1px;
	
}
 .PreView
    {
        width:150px;
        border-style: double;
        border-color: #333;
    }
    
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="horizBar" style="width: 722px">
            <span class="title">
                <fieldset style="padding-bottom: 5px; width: 96%; height: 176px">
                    <legend align="left" class="small" style="font-family: Times New Roman"><b>商品<span>信息</span></b>
                    </legend>&nbsp; &nbsp; &nbsp;&nbsp;
                    <table border="0" cellpadding="2" cellspacing="1" valign="top" width="100%">
                        <tbody>
                            <tr bgcolor="#ffffff">
                                <td align="middle" style="width: 92px; height: 30px">
                                    商品编号：</td>
                                <td style="width: 242px; height: 30px">
                                </td>
                                <td style="width: 65px; height: 30px">
                                </td>
                                <td style="height: 30px">
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td align="middle" style="width: 92px; height: 30px">
                                    商品名称：</td>
                                <td style="width: 242px; height: 30px">
                                    &nbsp;</td>
                                <td style="width: 65px; height: 30px">
                                    商品类型</td>
                                <td style="height: 30px">
                                    &nbsp;</td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td align="middle" style="width: 92px; height: 27px">
                                    商品品牌：</td>
                                <td style="width: 242px; height: 27px">
                                    &nbsp;</td>
                                <td style="width: 65px; height: 27px">
                                    颜 色</td>
                                <td style="height: 27px">
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td align="middle" style="width: 92px; height: 27px">
                                    成 本</td>
                                <td style="width: 242px; height: 27px">
                                    &nbsp;</td>
                                <td style="width: 65px; height: 27px">
                                    <font face="宋体">重 量</font></td>
                                <td style="height: 27px">
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td align="middle" style="width: 92px; height: 30px">
                                    <span style="font-family: 宋体">规 格</span>：</td>
                                <td style="width: 242px; height: 30px">
                                </td>
                                <td style="width: 65px; height: 30px">
                                    材 质</td>
                                <td style="height: 30px">
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff">
                                <td align="middle" style="width: 92px; height: 30px">
                                    库存上限</td>
                                <td style="width: 242px; height: 30px">
                                    &nbsp;</td>
                                <td style="width: 65px; height: 30px">
                                    库存下限</td>
                                <td style="height: 30px">
                                    &nbsp;</td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>
                <br />
                <br />
                <fieldset style="padding-bottom: 5px; width: 96%; height: 176px">
                    <legend align="left" class="small" style="font-family: Times New Roman">价格信息
                    </legend>
                    <br />
                    <br />
                    <asp:GridView ID="RelationGrid" runat="server" AutoGenerateColumns="False"
                        Width="485px" OnRowCancelingEdit="RelationGrid_RowCancelingEdit" OnRowUpdated="RelationGrid_RowUpdated">
                        <Columns>
                            <asp:BoundField HeaderText="编号" />
                            <asp:BoundField HeaderText="用户类型" />
                            <asp:TemplateField HeaderText="价格">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <HeaderStyle Width="180px" />
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server"></asp:Label>
                                </ItemTemplate>
                                <FooterStyle Width="180px" />
                            </asp:TemplateField>
                            <asp:CommandField EditText="&lt;img border=0 src=../images/Edit.gif /&gt;" ShowEditButton="True" />
                        </Columns>
                    </asp:GridView>
                </fieldset>
                &nbsp;<br />
                <br />
                &nbsp; &nbsp; &nbsp; &nbsp;<span style="font-size: 9pt; color: #333333">&nbsp; &nbsp;
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
                    &nbsp;</span><br />
            </span>
        </div>
    
    </div>
    </form>
</body>
</html>
