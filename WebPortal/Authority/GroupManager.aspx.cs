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
using Leyp.SQLServerDAL;
using Leyp.Components;
using Leyp.Components.Module;



public partial class Authority_GroupManager : GroupManager
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Databang();
        }

    }

    protected void Databang()
    {
        object action = Request.QueryString["action"];
        int groupid;

        if (action == null)
        {
            action = "view";
        }
        if (action.ToString().Equals("view"))
        {
            editPanel.Visible = false;
            viewPanel.Visible = true;

            CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getGroupDAL().getAllGroup();
                //项目中List数据源
            CollectionPager1.BindToControl = GridView1;
            GridView1.DataSource = CollectionPager1.DataSourcePaged;

        }
        else if (action.ToString().Equals("edit"))//若是编辑
        {
            Group gr = new Group();
            editPanel.Visible = true;
            viewPanel.Visible = false;
            groupid = Int16.Parse(Request.QueryString["GroupID"].ToString());
            GroupID.Text = groupid.ToString();
            AuthorityBand();
            EditGroupBang(groupid);
            gr = Leyp.SQLServerDAL.Factory.getGroupDAL().getByGroupID(groupid);

            GroupName_edit.Text = gr.GroupName.ToString();
            Description_edit.Text = gr.Description.ToString();


        }
        else if (action.ToString().Equals("del"))//若是删除
        {
            groupid = Int16.Parse(Request.QueryString["GroupID"].ToString());

            if (Leyp.SQLServerDAL.Factory.getGroupDAL().deleteNode(groupid))
            {
                addSystemLog("群组ID:" + groupid+" 被删除");
                Response.Write("删除成功！");
                Response.End();

            }
            else
            {

                Response.Write("失败！可能该群组已经在使用中");
                Response.End();

            }


            
        }
        else
        {
            Response.Write("操作错误！");
        }



    
    }
       
    /// <summary>
    /// 绑定所有权限
    /// </summary>
    private void AuthorityBand()
    {
        List<Authority> list = new List<Authority>();
        list = Leyp.SQLServerDAL.Factory.getAuthorityDAL().getAllAuthority();
        AuthorityList.DataSource = list;
        AuthorityList.DataBind();
    
    
    }

    /// <summary>
    /// 绑定已经有的权限
    /// </summary>
    /// <param name="groupid"></param>
    private void EditGroupBang(int groupid)
    {

        GroupAuthorityDAL bga = Leyp.SQLServerDAL.Factory.getGroupAuthorityDAL();
        List<GroupAuthority> list = bga.getALLGroupAuthorityByGroupID(groupid);
       
        for (int i = 0; i <= AuthorityList.Rows.Count - 1; i++)
        {
            int id = Convert.ToInt32(AuthorityList.DataKeys[i].Value.ToString());
            for(int j = 0; j < list.Count; j++)
            {
              if(id==list[j].AuthorityID)
                {
                    CheckBox cbox = (CheckBox)AuthorityList.Rows[i].FindControl("CheckBox1");

                    cbox.Checked = true;
                }
              
            }
           
        }



        
    
    }

    /// <summary>
    /// 提交新群组
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void submit_Click(object sender, EventArgs e)
    {

        string strName = GroupName_New.Text.ToString();
        string strDesc = Description_new.Text.ToString();
        if (strName.Length < 2)
        {
            Jscript.AjaxAlert(this, "群名称不能为空");
            return;
        }
        else
        {  
            Group gp=new Group();
            gp.GroupName=strName;
            gp.Description=strDesc;

            if (Leyp.SQLServerDAL.Factory.getGroupDAL().insertNewGroup(gp))
            {
                HyperLink1.Visible = true;
                viewPanel.Visible = false;
                addSystemLog("新添群组" + strName);
            }
            else
            {   

                HyperLink1.Text = "添加失败！可能是名称重复了!你可以返回重新试试";
                HyperLink1.Visible = true;
                viewPanel.Visible = false;
            }
        }


      





    }


    /// <summary>
    /// 重选
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ResetSelect_Click(object sender, EventArgs e)
    {
        for (int i = 0; i <= AuthorityList.Rows.Count - 1; i++)
        {
            CheckBox cbox = (CheckBox)AuthorityList.Rows[i].FindControl("CheckBox1");
            
            cbox.Checked = false;
           
        }
    }

 
     

    /// <summary>
    /// //更新权限
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void updateButton_Click(object sender, EventArgs e)
    {   
        int groupid = Int16.Parse(GroupID.Text.ToString());
        string str1=GroupName_edit.Text.ToString();
        string str2=Description_edit.Text.ToString();
        if(str1.Length<1)
        {
            Jscript.AjaxAlert(this, "群名称不能为空");
            return;
          
        }
        Group g=new Group();
        g.GroupID=groupid;
        g.GroupName=str1;
        g.Description=str2;
        ArrayList AL = new ArrayList();

        for (int i = 0; i <= AuthorityList.Rows.Count - 1; i++)//查看权限选了没有
        {
            CheckBox cbox = (CheckBox)AuthorityList.Rows[i].FindControl("CheckBox1");
            if (cbox.Checked == true)
            {
            
                AL.Add(i);
            }

        }

        int[] a = new int[AL.Count];//保存权限ID
        for (int i = 0; i < AL.Count; i++)
        {

            int id = Convert.ToInt32(AuthorityList.DataKeys[(int)AL[i]].Value.ToString());
            //AR.Add(id);
            a[i] = id;

        }

        if (Leyp.SQLServerDAL.Factory.getGroupDAL().updateGroup(g, a))
        {
            editPanel.Visible = false;
            HyperLink1.Visible = true;
            addSystemLog("群组ID" + groupid .ToString()+ " 被修改");
            return;
        }


    }



    protected void AuthorityList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label le = (Label)e.Row.FindControl("Label1");
            
            if (int.Parse(le.Text.ToString()) % 2 == 0)
                e.Row.CssClass = "bga";
            else 
                e.Row.CssClass = "bgb";

            
            
        } 

    }
}
