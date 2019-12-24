<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pd_QueryProductStatus.aspx.cs" Inherits="WebPortal.Products.Pd_QueryProductStatus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../css/base.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../css/flexigrid.css"/>
    <link rel="stylesheet" href="/css/form_view_frame.css"/>
   	<script type="text/javascript" src="../js/jq.js"></script>
	<script type="text/javascript" src="../js/AjaxJS.js"></script>
	<script type="text/javascript" src="../js/flexigrid.js"></script>
    <script type="text/javascript" src="../js/My97DatePicker/WdatePicker.js" charset="UTF-8"></script>

    <style type="text/css">
    #addMian_b {width:980px;height:450px;background:#000;-moz-opacity:0.2; filter:alpha(opacity=25);margin:-30px 10 0 10px; position:absolute;}
#addMian_t { z-index:20;border:1px solid #a4d5e3;width:960px;height:450px;background:#FFF;margin:-15px 0 0 5px; position:absolute;}
body {
	margin-left: 10px;
	margin-top: 0px;
}
    
    </style>

    <script type="text/javascript">

        function fixgrid() {

            $('.flexme2').flexigrid();
            ///$('.flexme2').flexigrid({height:'auto',striped:false});
        }

</script>

</head>
<body>
    <div id="container">  
        <div id="content"> 
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" AsyncPostBackTimeout="0" runat="server">
        </asp:ScriptManager>
    
        <asp:UpdatePanel ID="UpdatePanel" UpdateMode="Conditional"  runat="server" >
        <ContentTemplate>

            <table style="width:800px" border="0">
                   <tr style="height:30px">
                       <td style="width:40%">
                           生產部門:
                <asp:DropDownList ID="dlDep" Width="120px" Height="22px"  runat="server" />
                           </td>
                       <td style="width:40%">
                生產日期:
                <input type="text" id="datePrd" name="txtPrdDate" runat="server" style="height:20px;width:120px" class="Wdate" onfocus="WdatePicker({lang:'zh-cn',dateFmt:'yyyy/MM/dd'})"/>
                       </td>
                       <td style="width:20%">
                           <asp:Button ID="Select" Width="120px" runat="server"
              Text="查询" OnClick="Select_Click" /></td>
                       </tr>
                <tr>
                       <td style="width:40%">
                           制單編號:
                           <input type="text" id="txtPrd_mo" style="width:120px" runat="server" />
                       </td>
                       <td style="width:20%">
                           工號:
                           <input type="text" id="txtPrd_worker" style="width:120px" runat="server" />
                       </td>
                       <td style="width:40%">
                           生產機器:
                           <input type="text" id="txtPrd_machine" style="width:120px" runat="server" />
                       </td>
                       
                   </tr>
                  <%-- <tr style="height:30px">
                       <td colspan="3">
        

                           
                           </td>
                       </tr>--%>
               </table>



           <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    AssociatedUpdatePanelID="UpdatePanel" DisplayAfter="0">
                <ProgressTemplate>
                    <div class="show_query_img">
                        <img alt="" src="../images/process3.gif"/>
                        <br />
                        正在查詢,請稍候...
                    </div>
                </ProgressTemplate>
    </asp:UpdateProgress>

            <table id="tableExcel"  class="flexme2">
	<thead>
    		<tr>

            	<th width="60">
                    生產日期</th>
            
            	<th width="100">
                    制單編號</th>
            	<th width="80">
                    物料編號</th>
            	<th width="160">
                    物料描述</th>
            	
            	<th width="80">
                    生產數量</th>
   
                <th width="80">
                    生產重量</th>
                <th width="80">
                    生產工號</th>
    		    <th width="60">
                    姓名</th>
                <th width="60">
                     組別</th>
                <th width="80">
                   生產類型</th>
                <th width="60">
                    開始時間</th>
                <th width="60">
                    結束時間</th>
                <th width="60">
                    正常班</th>
                <th width="60">
                    加班</th>
    		    

                <th width="80">
                    正常+加班</th>
            <th width="80">
                    生產機器</th>
            	<th width="80">
                    機器描述</th>
                <th width="80">
                    錄入人</th>
                <th width="80">
                    錄入日期</th>
                <th width="80">
                    修改人</th>
                <th width="80">
                    修改日期</th>
            	<th width="80">
                    部門</th>


                <th width="30"></th>

    		</tr>
    </thead>
    <tbody>
        <asp:Repeater ID="OrderList" runat="server">
        <ItemTemplate>
           <tr>


            	<td><%#Eval("prd_date")%>
            	
            	</td>
            	<td>
            	<%#Eval("prd_mo")%>
            	
            	</td>
            
            	<td><%#Eval("prd_item")%></td>
            	
                <td><%#Eval("prd_item_cdesc")%></td>
                <td><%#Eval("prd_qty")%> </td>
                <td><%#Eval("prd_weg").ToString()%></td>
                <td><%# Eval("prd_worker")%></td>
                <td><%# Eval("hrm1name")%></td>
                <td><%# Eval("prd_group")%></td>
                <td><%# Eval("work_type_desc")%></td>
                <td><%# Eval("prd_start_time")%></td>
                <td><%# Eval("prd_end_time")%></td>

                <td><%#Eval("prd_normal_time")%>
            	
            	</td>
               <td><%# Eval("prd_ot_time")%></td>
               <td><%# Eval("prd_wt")%></td>
               <td><%# Eval("prd_machine")%></td>
               <td><%# Eval("machine_desc")%></td>
               <td><%# Eval("crusr")%></td>
               <td><%# Eval("crtim")%></td>
               <td><%# Eval("amusr")%></td>
               <td><%# Eval("amtim")%></td>
            	<td>
            	<%#Eval("prd_dep")%>
            	
            	</td>

    		     <td></td>
    		</tr>
        
        </ItemTemplate>
        </asp:Repeater>
      
    		
    </tbody>
</table>


           <table>
        <tr>
            <td align="right" colspan="9">
                第<asp:DropDownList ID="dlCurrentPage" OnSelectedIndexChanged="dlCurrentPage_Click" AutoPostBack="true" Width="50px" Height="22px" runat="server"></asp:DropDownList>页&nbsp;/&nbsp;共
                <asp:Literal id="lTotalPage" runat="server" />页
            <asp:Button ID="firstBtn" runat="server" Text="首页" onclick="firstBtn_Click" />
            <asp:Button ID="prevBtn" runat="server" Text="上页" onclick="prevBtn_Click" />
            <asp:Button ID="nextBtn" runat="server" Text="下页" onclick="nextBtn_Click" />
            <asp:Button ID="lastBtn" runat="server" Text="末页" onclick="lastBtn_Click" />

  			            </td>
  			        </tr> 
            </table>
  			        <input type="button" id="Ajax_Btn" style="display:none;" onclick="Ajax_GetHourse();" />



            </ContentTemplate>
        </asp:UpdatePanel>

        <script type="text/javascript">



     $('.flexme2').flexigrid();
     ///$('.flexme2').flexigrid({height:'auto',striped:false});


</script>

    </form>
            </div>
    </div>
</body>
</html>
