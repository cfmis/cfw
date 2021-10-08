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

public partial class Buy_Index : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Databang();
        }
    }

    /// <summary>
    /// 菜单绑定 type=1
    /// </summary>
    //5_1_a_s_p_x源码专家
    protected void Databang()
    {
        AuthorityDAL bAuthority = Leyp.SQLServerDAL.Factory.getAuthorityDAL();
        List<GroupAuthority> AL = new List<GroupAuthority>();
        List<Authority> AL1 = new List<Authority>();//采购的 1

        AL = Leyp.SQLServerDAL.Factory.getGroupAuthorityDAL().getALLGroupAuthorityByGroupID(getGroupID());

        for (int i = 0; i < AL.Count; i++)
        {
            GroupAuthority g = AL[i];
            Authority a = bAuthority.getByID(g.AuthorityID);
            if (a.TypeID == 1)
            {
                AL1.Add(a);

            }

            Menu.DataSource = AL1;
            Menu.DataBind();

        }
    }
}