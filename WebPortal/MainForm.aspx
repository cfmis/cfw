<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainForm.aspx.cs" Inherits="MainForm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>CFOA-Side</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.min.js"></script>   

    <%--<script type="text/javascript" src="../js/jquery-easyui-1.5/easyloader.js"></script>--%>   

    <script type="text/javascript" src="../js/jquery-easyui-1.5/jquery.easyui.min.js"></script>   

    <%--<script type="text/javascript" src="../js/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script> --%>  

    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/default/easyui.css" />   

    <link rel="stylesheet" type="text/css" href="../js/jquery-easyui-1.5/themes/icon.css"/>  

    
    <link href="../css/style_new.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">

        //function addTab(title, href, icon) {
        //    var tt = $('#tabs');
        //    if (tt.tabs('exists', title)) {//如果tab已经存在,则选中并刷新该tab          
        //        tt.tabs('select', title);
        //        refreshTab({ tabTitle: title, url: href });
        //    } else {
        //        if (href) {
        //            var content = '<iframe scrolling="no" frameborder="0"  src="' + href + '" style="width:100%;height:100%;"></iframe>';
        //        } else {
        //            var content = '未实现';
        //        }
        //        tt.tabs('add', {
        //            title: title,
        //            closable: true,
        //            content: content,
        //            iconCls: icon || 'icon-default'
        //        });
        //    }
        //}


        function addTab(title, url) {

            if (!$('#tt').tabs('exists', title)) {

                $('#tt').tabs('add', {

                    title: title,

                    content: '<iframe src="' + url + '" frameBorder="0" border="0"  style="width: 100%; height: 100%;"/>',

                    closable: true

                });

            } else {

                $('#tt').tabs('select', title);
                //refreshTab({ tabTitle: title, url: url });
            }

        }
        /**     
  * 刷新tab 
  * @cfg  
  *example: {tabTitle:'tabTitle',url:'refreshUrl'} 
  *如果tabTitle为空，则默认刷新当前选中的tab 
  *如果url为空，则默认以原来的url进行reload 
  */
        function refreshTab(cfg) {
            var refresh_tab = cfg.tabTitle ? $('#tabs').tabs('getTab', cfg.tabTitle) : $('#tabs').tabs('getSelected');
            if (refresh_tab && refresh_tab.find('iframe').length > 0) {
                var _refresh_ifram = refresh_tab.find('iframe')[0];
                var refresh_url = cfg.url ? cfg.url : _refresh_ifram.src;
                //_refresh_ifram.src = refresh_url;  
                _refresh_ifram.contentWindow.location.href = refresh_url;
            }
        }

    </script>

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

    <style type="text/css">
        #tabs .tabs-panels>.panel>.panel-body {  
overflow: hidden;  
}  
        </style>


    <%--<script type="text/javascript">
        $(function(){
            cover(); 
            $(window).resize(function(){ //浏览器窗口变更 
                cover();
            });
        });
        function cover(){
        var win_width = $(window).width();
        $("#subWrap").layout("panel","east").panel("resize",{width:win_width/3});
        $("＃subWrap").layout("resize");
        }
    </script>--%>

    <script type="text/javascript">  
    $(document).ready(function(){  
        var height1 = $(window).height()-20;  
        $("#main_layout").attr("style","width:100%;height:"+height1+"px");  
        $("#main_layout").layout("resize",{  
            width:"100%",  
            height:height1+"px"  
        });  
    });  
      
      
    $(window).resize(function(){  
        var height1 = $(window).height()-30;  
        $("#main_layout").attr("style","width:100%;height:"+height1+"px");  
        $("#main_layout").layout("resize",{  
            width:"100%",  
            height:height1+"px"  
        });  
    });   
</script>


</head>
<%--<body class="easyui-layout" data-options="fit:'true'">--%>
<body>
    <div style="margin-top:5px;margin-left:5px;margin-right:5px;margin-bottom:5px;">  
    <div id="main_layout" class="easyui-layout"  style="width:100%; height:680px;">  
    <%--<div id="subWrap" class="easyui-layout" fit="true">--%>
    <%--<div class="easyui-layout"data-options="fit:true">--%>
    <%--<script type="text/javascript">
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
</script>--%>

    
    <%--<div data-options="region:'north',title:'North Title',split:false" style="height:0px;"></div>--%>   

    <div data-options="region:'north'" style="height: 50px;background-color:#3366CC;">  
           <div class="logintop">    
    <span>CF辦公輔助系統</span>    
    <ul>
    <li><a href="Logout.aspx">退出</a></li>
    <li><a href="#">帮助</a></li>
    <li><a href="#">关于</a></li>
    </ul>    
    </div>
       </div>

    <div data-options="region:'south',title:'South Title',split:false,noheader:true" style="height:30px;" >

        <iframe class="Noprint"  src="ButtomPage.aspx" scrolling="no"   style="width: 100%; height:25px" frameborder="0"> </iframe>
        <%--<ul>
            <li>1</li>
            <li>2</li>
            <li>3</li>
        </ul>--%>
    </div>   

    <%--<div data-options="region:'east',title:'East',split:false,noheader:true" style="width:2px;"></div> --%>  

    <div data-options="region:'west',title:'菜單控制',split:false,iconCls:'icon-left-ico'" style="width:170px;">
        
    <%--<ul id="tt1" class="easyui-tree">   

    <li>   

        <span>Folder</span>   

        <ul>   

            <li>   

                <span>Sub Folder 1</span>   

                <ul>   

                    <li><span><a href="javascript:void(0)" onclick="addTab('頁數匯總','Sales/Sa_Oc_ShowStatus.aspx')">頁數匯總</a></span></li>   

                    <li><span><a href="javascript:void(0)" onclick="addTab('洋行代號','Sales/Sa_LoadInvByAgent.aspx')">訂單跟蹤表</a></span></li>   

                    <li><span><a href="javascript:void(0)" onclick="addTab('報價單','Sales/Sa_QuotationFind.aspx')">報價單</a></span></li>   

                </ul>   

            </li>   

            <li><span><a href="javascript:void(0)" onclick="addPanel('tab1.jsp','tab4')">File 11</a></span></li>   

            <li><span><a href="javascript:void(0)" onclick="addPanel('tab1.jsp','tab5')">File 11</a></span></li>   

        </ul>   

    </li>   

    <li><span><a href="javascript:void(0)" onclick="addPanel('tab1.jsp','tab6')">File 11</a></span></li>   

</ul>--%>    

            

        <%--<div class="lefttop"><span></span>菜單控制</div>--%>
  <dl class="leftmenu">
 
  <asp:Literal ID="Literal2" runat="server"></asp:Literal>
 
  </dl>


    </div>   

        <%--<div id="tt" data-options="region:'center',title:'center title'"  class="easyui-tabs" style="padding:0px;background:#eee;">--%>
    <%--fit:true --頁面自動適應大小--%>
 
            <%--<div id="tt" data-options="region:'center',title:'center title',noheader:true"  class="easyui-tabs" style="padding:0px;background:#eee;border-width:0px;right:0px">--%>
 <div data-options="region:'center',title:'CCCCCCC',iconCls:'icon-ok',noheader:true">  
            <div id="tt" class="easyui-tabs" data-options="fit:true,border:false,plain:true">  

    <div title="Home" style="padding:0px;display:none;">   

        <%--tab1   --%>
        <iframe scrolling="no" src="Desk.aspx" frameBorder="0" border="0"  style="width: 100%; height: 100%;"/>
    </div>   

    </div>
     </div>
        <%--</div>--%>
       <%-- </div>--%>
        </div>
        </div>
</body>
</html>


