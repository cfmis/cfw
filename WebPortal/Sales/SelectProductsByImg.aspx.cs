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
using Leyp.Model.Sales;

public partial class Sales_SelectProductsByImg : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
        }

    }


    private void init()
    {
        string checkDate = Request.QueryString["Data"].ToString();
        List<VSalesOut> list = Leyp.SQLServerDAL.Sales.Factory.getSalesOutDAL().selectProductsByImg(checkDate,2);//等待发货

        List<VSalesOutDetail> list0 = new List<VSalesOutDetail>();//临时所有数据
        List<VSalesOutDetail> listlist = new List<VSalesOutDetail>();//存放最后数据

        Leyp.SQLServerDAL.Sales.SalesOutDetailDAL dl=new Leyp.SQLServerDAL.Sales.SalesOutDetailDAL();

        for (int i = 0; i < list.Count; i++)
        { 
           List<VSalesOutDetail> lists=dl.getBySalesOutID(list[i].SalesOutID);
           for (int j = 0; j < lists.Count; j++)
           {
               list0.Add(lists[j]);
           }
        }

        for (int k = 0; k < list0.Count; k++)
        {
            bool reslut = false;
            VSalesOutDetail v = list0[k];
            if (listlist.Count == 0)
            {
                listlist.Add(v);
            }
            else
            {
                for (int h = 0; h < listlist.Count; h++)
                {
                    VSalesOutDetail vi = listlist[h];
                    if (v.ProductsID == vi.ProductsID)//如果重复
                    {
                        listlist[h].Quantity = listlist[h].Quantity + v.Quantity;
                        reslut = true;
                        break;
                    }
                   
                 }

                 if (!reslut)
                 {
                     listlist.Add(v);
                 }
            
            }

            
          
        }


        DataList1.DataSource = listlist;
        DataList1.DataBind();



    
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
       
    }
}
