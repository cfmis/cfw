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
using Leyp.Components;
using Leyp.Components.Module.Stock;

public partial class Stock_StoreHouseManager : ManagerDetop
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
        }

    }

    protected void init()
    {
        object action = Request.QueryString["action"];
        if (action != null)
        {
            if (action.ToString().Equals("edit"))
            {
                int ID = Int16.Parse(Request.QueryString["ID"].ToString());
                StoreHouse s = new StoreHouse();
                s = Leyp.SQLServerDAL.Factory.getStoreHouseDAL().getByHouseID(ID);

                SubareaName.Text = s.HouseName;
                Pageaction.Text = "edit";
                editID.Text = ID.ToString();
                Description.Text = s.Description;



            }
            else if (action.ToString().Equals("del"))
            {
                int ID = Int16.Parse(Request.QueryString["ID"].ToString());


                if (!Leyp.SQLServerDAL.Factory.getStoreHouseDAL().deleteEitity(ID))
                {
                    Jscript.AjaxAlert(this, "删除失败！可能记录正在使用");

                    Response.Redirect("StoreHouseManager.aspx", true);
                   
                }


            }

        }


        DataBand();
 


    }
    /// <summary>
    /// 
    /// </summary>

    protected void DataBand() {

        List<StoreHouse> list = new List<StoreHouse>();
        list = Leyp.SQLServerDAL.Factory.getStoreHouseDAL().getAllStoreHouse();
        listType.DataSource = list;
        listType.DataBind();

    
    }




    protected void updateButton_Click(object sender, EventArgs e)
    {
        string str1 = SubareaName.Text.ToString();
        string str2 = Description.Text.ToString();
        StoreHouse s = new StoreHouse();
        s.HouseName = str1;
        s.Description = str2;

        if (Pageaction.Text.ToString().Equals("edit"))
        {
            int id = int.Parse(editID.Text.ToString());
            s.HouseID = id;


            if (Leyp.SQLServerDAL.Factory.getStoreHouseDAL().updateStoreHouse(s))
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
            if (Leyp.SQLServerDAL.Factory.getStoreHouseDAL().insertEitity(s))
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
}
