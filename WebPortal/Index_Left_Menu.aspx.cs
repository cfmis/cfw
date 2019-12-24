using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Leyp.Model;
using Leyp.Components;
using Leyp.Components.Module;
using Leyp.SQLServerDAL;

public partial class Index_Left_Menu : BasePage
{
  


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Databang();
        }
    }

    /// <summary>
    /// 根据权限初始化用户菜单
    /// </summary>
    protected void Databang()
    {
        AuthorityDAL bAuthority = Leyp.SQLServerDAL.Factory.getAuthorityDAL();

        List<GroupAuthority> AL = new List<GroupAuthority>();
        List<Authority> AL0 = new List<Authority>();//系统设置 0
        List<Authority> AL1 = new List<Authority>();//采购开单 1
        List<Authority> AL2 = new List<Authority>();//销售开单 2
        List<Authority> AL3 = new List<Authority>();//库存开单 3
        List<Authority> AL4 = new List<Authority>();//管理流程模块 4
        List<Authority> AL5 = new List<Authority>();//系統設置

        AL = Leyp.SQLServerDAL.Factory.getGroupAuthorityDAL().getALLGroupAuthorityByGroupID(getGroupID());

        for (int i = 0; i < AL.Count; i++)
        {
            GroupAuthority g = AL[i];
            Authority a = bAuthority.getByID(g.AuthorityID);
            if (a.TypeID == 0)
            {
                AL0.Add(a);
            }

            if (a.TypeID == 1)
            {
                AL1.Add(a);
            }
            else if (a.TypeID == 2)
            {
                AL2.Add(a);
            
            }
            else if (a.TypeID == 3)
            {
                AL3.Add(a);
            }
            else if (a.TypeID == 4)//工作流
            {
                AL4.Add(a);
            }
            else if (a.TypeID == 5)//工作流
            {
                AL5.Add(a);
            }
            // if(g.

            Hidden1.Value = AL0.Count.ToString();//系统
            Hidden2.Value = AL1.Count.ToString();//
            Hidden3.Value = AL2.Count.ToString();//销售开单
            Hidden4.Value = AL3.Count.ToString();//库存
            Hidden5.Value = AL4.Count.ToString();//管理 
            Hidden6.Value = AL5.Count.ToString();//管理 

            SystemSet.DataSource = AL0;
            SystemSet.DataBind();

            purchaseMenu.DataSource = AL1;
            purchaseMenu.DataBind();


            SalesMenu.DataSource = AL2;
            SalesMenu.DataBind();


            StockMenu.DataSource = AL3;
            StockMenu.DataBind();


            FlowRepeater.DataSource = AL4;
            FlowRepeater.DataBind();

            FlowRepeater.DataSource = AL5;
            FlowRepeater.DataBind();

        }



      

    
    }
}
