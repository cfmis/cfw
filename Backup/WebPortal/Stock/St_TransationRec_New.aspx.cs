using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Leyp.Model;
using Leyp.Components;
using Leyp.Components.Module.Stock;
using Leyp.Model.Stock;

namespace WebPortal.Stock
{
    public partial class St_TransationRec_New : System.Web.UI.Page//StockViewModule//
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
            txtDep.Text = "805";
            txtDate1.Text = System.DateTime.Now.AddDays(-1).ToString("yyyy/MM/dd");
            txtDate2.Text = txtDate1.Text;

            // StoreHouseInit();
            //DataSet ds = Leyp.SQLServerDAL.Factory.getProductsStockDAL().getDataSetByHouseDetailID(0);
        }
        protected void Select_Click(object sender, EventArgs e)
        {
            DataSetBand();
        }

        protected void DataSetBand()
        {
            string fdep = txtDep.Text;
            string tdep = txtToDep.Text;

            string date1, date2;

            date1 = txtDate1.Text;
            date2 = txtDate2.Text;
            string id1, id2;
            id1 = txtId1.Text;
            id2 = txtId2.Text;
            if (date2.Trim() != "" && date2.Trim() != "/  /")
                date2 = Convert.ToDateTime(date2).AddDays(1).ToString("yyyy/MM/dd");

            //DataSet ds = new DataSet();

            //ds = Leyp.SQLServerDAL.Factory_New.getProductsStockDAL().getDataSetByHouseDetailID(date1,date2,fdep,tdep,id1,id2);
            //OrderList.DataSource = ds.Tables["dd"].DefaultView;
            //OrderList.DataBind();


            List<StTransationRec> list = new List<StTransationRec>();
            list = Leyp.SQLServerDAL.Factory_New.getProductsStockDAL().getDataSetByHouseDetailIDList(date1, date2, fdep, tdep, id1, id2);

            CollectionPager1.DataSource = list;
            CollectionPager1.BindToControl = OrderList;
            OrderList.DataSource = CollectionPager1.DataSourcePaged;
            



            //如果有UpdatePanel就用如下代码调用前台js
            ScriptManager.RegisterStartupScript(UpdatePanel, this.Page.GetType(), "", "fixgrid();", true);

        }

    }
}