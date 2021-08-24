<%@ Page Language="C#" AutoEventWireup="True" Inherits="Test" Codebehind="Test.aspx.cs" %>

<%@ Register assembly="Chartlet" namespace="FanG" tagprefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>

</head>
<body>
    <form id="form1" runat="server">

  <cc1:Chartlet ID="Chartlet1" runat="server" ChartType="Pie" />
    

    </form>



<h4 class="moduleHeader" id="module_16_head">
<a class="expand" href="javascript:_resize(16);">
    <img class="icon" id="img_resize_16" title="Fold" src="images/expand_arrow.png">
</a>
<span class="text" id="module_16_text" onclick="_resize(16)";>Hot Sells</span>
<span class="title" id="module_16_title" style="CURSOR: move"></span>
<span class="close" id="module_16_op">
    <a class="PageLinkDisable" id="module_16_link_pre" title="Previous"
      href="javascript:NextPage('16',-1);"><b><</b></a>
    <a id="module_16_link_next" title="Next"
      href="javascript:NextPage('16',1);"><b>></b></a>
    <a href="#">All</a>&nbsp;
    <a title="Setting" href="javascript:_edit(16);"><img 
      src="images/pencil.png"></a>&nbsp;
    <a title="Close" href="javascript:_del(16);"><img src="images/close_x.png"></a> 
</span>
</h4>

<h4 class="moduleHeader" id="module_28_head">
<a class="expand" href="javascript:_resize(28);">
     <img class="icon" id="Img1" title="折叠" src="images/expand_arrow.png">
</a>
<span class="text" id="module_28_text" onclick="_resize(28)";>My Question</span>
<span class="title" id="module_28_title" style="cursor: move"> </span>
<span class="close" id="module_28_op">
    <a class="PageLinkDisable" id="A1" title="上一页"
        href="javascript:NextPage('27',-1);"><b>▲</b></a>
    <a id="A2" title="下一页" href="javascript:NextPage('27',1);"><b>▼</b></a>
    <a href="#">全部</a>
    <a title="设置" href="javascript:_edit(28);"><img src="images/pencil.png"></a>
    <a title="关闭模块" href="javascript:_del(28);"> <img src="images/close_x.png"></a>
</span>
</h4>





</body>
</html>
