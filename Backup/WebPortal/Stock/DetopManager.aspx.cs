using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model;
using Leyp.Components.Module.Stock;
using Leyp.Model.View;
using Leyp.Components;

public partial class Stock_DetopManager : ManagerDetop
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Databang();
        }

    }
    protected void updateButton_Click(object sender, EventArgs e)
    {
        string str1 = SubareaName.Text.ToString();
        string str2 = Description.Text.ToString();
         StoreHouseDetail s = new StoreHouseDetail();
         s.SubareaName = str1;
         s.Description = str2;
         s.HouseID = int.Parse(StoreHouseDropDownList.SelectedValue.ToString());
         s.State = DropDownList1.SelectedValue.ToString();

         if (Pageaction.Text.ToString().Equals("edit"))
         {
             int id = int.Parse(editID.Text.ToString());
             s.ID = id;
             

             if (Leyp.SQLServerDAL.Factory.getStoreHouseDetailDAL().updateStoreHouseDetail(s))
             {
                 Panel1.Visible = false;
                 HyperLink1.Visible = true;
             }
             else
             {
                 Panel1.Visible = false;
                 HyperLink1.Text = "操作失败！返回列表";
                 HyperLink1.Visible = true;
             }

         }
         else
         {
             if (Leyp.SQLServerDAL.Factory.getStoreHouseDetailDAL().insertNewNode(s))
             {
                 Panel1.Visible = false;
                 HyperLink1.Visible = true;
             }
             else
             {

                 Panel1.Visible = false;
                 HyperLink1.Text = "操作失败！可能系信息重复！返回列表";
                 HyperLink1.Visible = true;

             }
         
         }

    }

    /// <summary>
    /// 
    /// </summary>

    protected void Databang()
    {
        object action = Request.QueryString["action"];
        if (action != null)
        {
            if (action.ToString().Equals("edit"))
            {
               int ID = Int16.Parse(Request.QueryString["ID"].ToString());
               StoreHouseDetail s = new StoreHouseDetail();
               s = Leyp.SQLServerDAL.Factory.getStoreHouseDetailDAL().getByID(ID);

               SubareaName.Text = s.SubareaName;
              Pageaction.Text = "edit";
              editID.Text = ID.ToString();
              StoreHouseDropDownList.Visible = false;



            }
            else if (action.ToString().Equals("del"))
            {
                //int ID = Int16.Parse(Request.QueryString["ID"].ToString());

                //if (Leyp.SQLServerDAL.Factory.getStoreHouseDetailDAL().deleteNode(ID))
               // {
                    Jscript.AjaxAlert(this, " 等待操作");
                    Response.End();

               // }
               // else
               // {
                   // Jscript.AjaxAlert(this, " 用户已经使用！不能删除!");

                //}


            }
           
        }

        dataBand();
        DropDownListBand();


    }

    public void dataBand()
    {
        CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getVstoreHouseDAL().getAll(); 
        CollectionPager1.BindToControl = listType;
        listType.DataSource = CollectionPager1.DataSourcePaged;
    
    }
       
    /// <summary>
    /// 库房列表
    /// </summary>
    protected void DropDownListBand()
    {
        List<StoreHouse> al = new List<StoreHouse>();
        al = Leyp.SQLServerDAL.Factory.getStoreHouseDAL().getAllStoreHouse();
        StoreHouseDropDownList.DataSource = al;
        StoreHouseDropDownList.DataTextField = "HouseName";
        StoreHouseDropDownList.DataValueField = "HouseID";
        StoreHouseDropDownList.DataBind();

    }
}
