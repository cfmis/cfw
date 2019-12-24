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
using Leyp.Model.View;
using Leyp.Components;
using Leyp.Components.Module;

public partial class Products_ProductsNoPhoto : PhotoFlowModule
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        List<VProducts> list = Leyp.SQLServerDAL.Factory.getVProductsDAL().searchProducts(0, 0, "");//的得到所有的商品

        List<VProducts> list0 = new List<VProducts>();
        for (int i = 0; i < list.Count; i++)
        {
            VProducts v = list[i];
            if (v.PhotoUrl.Equals("nophoto.jpg"))
            {
                list0.Add(v);
            }
         
        }

        CreateExcel(list0, DateTime.Now.ToString("yyyy-MM-dd")+ ".xls");

    }



    /// <summary>
    /// 建立Excel
    /// </summary>
    /// <param name="ds"></param>
    /// <param name="FileName"></param>
    public void CreateExcel(List<VProducts> list, string FileName)
    {
        HttpResponse resp;
        resp = Page.Response;
        resp.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
        resp.AppendHeader("Content-Disposition", "attachment;filename=" + FileName);
        string colHeaders = "", ls_item = "";

        //定义表对象与行对象，
        DataTable dt = ConvertToDataTable(list);
        DataRow[] myRow = dt.Select();//可以类似dt.Select("id>10")之形式达到数据筛选目的
        int i = 0;
        int cl = dt.Columns.Count;


        //取得数据表各列标题，各标题之间以\t分割，最后一个列标题后加回车符 
        for (i = 0; i < cl; i++)
        {
            if (i == (cl - 1))//最后一列，加\n
            {
                colHeaders += dt.Columns[i].Caption.ToString() + "\n";
            }
            else
            {
                    colHeaders += dt.Columns[i].Caption.ToString() + "\t";

            }

        }
        resp.Write(colHeaders);
        //向HTTP输出流中写入取得的数据信息 

        //逐行处理数据   
        foreach (DataRow row in myRow)
        {
            //当前行数据写入HTTP输出流，并且置空ls_item以便下行数据     
            for (i = 0; i < cl; i++)
            {
                if (i == (cl - 1))//最后一列，加\n
                {
                    ls_item += row[i].ToString() + "\n";
                }
                else
                {
                    ls_item += row[i].ToString() + "\t";
                }

            }
            resp.Write(ls_item);
            ls_item = "";

        }
        resp.End();
    
    }



   
    /// <summary>
    /// Ilist<T> 转换成 DataTable
    /// </summary>
    /// <param name="list"></param>
    /// <returns></returns>
    public static DataTable ConvertToDataTable<T>(IList<T> i_objlist)
    {
        if (i_objlist == null || i_objlist.Count <= 0)
        {
            return null;
        }
        DataTable dt = new DataTable(typeof(T).Name);
        DataColumn column;
        DataRow row;

        System.Reflection.PropertyInfo[] myPropertyInfo = typeof(T).GetProperties(System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);

        foreach (T t in i_objlist)
        {
            if (t == null)
            {
                continue;
            }

            row = dt.NewRow();

            for (int i = 0, j = myPropertyInfo.Length; i < j; i++)
            {
                System.Reflection.PropertyInfo pi = myPropertyInfo[i];

                string name = pi.Name;

                if (dt.Columns[name] == null)
                {
                    column = new DataColumn(name, pi.PropertyType);
                    dt.Columns.Add(column);
                }

                row[name] = pi.GetValue(t, null);
            }

            dt.Rows.Add(row);
        }
        return dt;
    }
    
   
}
