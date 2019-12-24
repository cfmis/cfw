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
using Leyp.Components;
using Leyp.Components.Module.Buy;
using Leyp.Model.Buy;

public partial class Buy_BuyOrder_Add : ModuleBuyOrder
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            init();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
        }
       

    }
    //该源码首发自www.51aspx.com(５１ａｓｐｘ．ｃｏｍ)

    protected void init()
    {

        BuyOrderID.Text ="BY"+ StrHelper.GetRamCode();
        BuyOrderDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
       
    }
   
    protected void AddButton_Click(object sender, EventArgs e)
    {

        if (side.Text.ToString().Equals("old"))
        {
            return;
        }
        else
        {
            string str0 = getStringText(BuyOrderID.Text.ToString());
            string str1 = getStringText(BuyOrderDate.Text.ToString());
            string str2 = getStringText(Delegate.Text.ToString());
            int storeHouseID = int.Parse(StoreHouseID.Text.ToString());
            int houseDetailID = int.Parse(HouseDetailID.Text.ToString());
            string str3 = getStringText(SignDate.Text.ToString());
            string str4 = getStringText(TradeDate.Text.ToString());
            string str5 = getStringText(TradeAddress.Text.ToString());
            float totalPrice = float.Parse(TotalPrice.Text.ToString());
            string str6 = getStringText(Description.Text.ToString());

            BuyOrder b = new BuyOrder();
            b.BuyOrderID = str0;
            b.BuyOrderDate = str1;
            b.Delegate = str2;
            b.Description = str6;
            b.HouseDetailID = houseDetailID;
            b.Identitys = 0;//采购订单
            b.SignDate = str3;
            b.State = 0;//未审核
            b.StoreHouseID = storeHouseID;
            b.TotalPrice = totalPrice;
            b.TradeAddress = str5;
            b.TradeDate = str4;
            b.UserName = getUserName();

            if (Leyp.SQLServerDAL.Buy.Factory.getBuyOrderDAL().insertNewEntity(b))
            {
                side.Text = "old";
                Button1.Visible = true;
                Image1.ImageUrl = "../images/Good.gif";
                Label1.Text = "表头已经保存";
                AddButton.Visible = false;
                Jscript.AjaxAlert(this, "添加成功！");
                return;

            }
            else
            {

                Jscript.AjaxAlert(this, "添加失败！");
                return;
            
            }
          
        }

    }



    public string getStringText(string str)
    {
        if (str == null)
        {
            return "";
        }
        else
        {
            return str;
        
        }
    
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string BuyID = BuyOrderID.Text.ToString();

        Response.Redirect("BuyOrder_Detail.aspx?BuyOrderID=" + BuyID + "", true);
    }
}
