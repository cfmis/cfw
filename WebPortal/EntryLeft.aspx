﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EntryLeft.aspx.cs" Inherits="EntryLeft" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>CRM-Side</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="JavaScript" src="../js/fromcrm/jquery.js"></script>

<script type="text/javascript">
    $(function () {
        //导航切换
        $(".menuson li").click(function () {
            $(".menuson li.active").removeClass("active")
            $(this).addClass("active");
        });

        $('.title').click(function () {
            var $ul = $(this).next('ul');
            $('dd').find('ul').slideUp();
            if ($ul.is(':visible')) {
                $(this).next('ul').slideUp();
            } else {
                $(this).next('ul').slideDown();
            }
        });
    })	
</script>
</head>
<body style="background:#f0f9fd;">
<div class="lefttop"><span></span>菜單控制</div>
  <dl class="leftmenu">
 
  <asp:Literal ID="Literal2" runat="server"></asp:Literal>
 
  </dl>
</body>
</html>


