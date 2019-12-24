namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using Leyp.Model.View;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;
    using Leyp.Model.Stock;

    public class ProductsStockDAL_New
    {
        

        public DataSet getDataSetByHouseDetailID(string date1,string date2,string fdep,string todep,string id1,string id2)
        {
            DataSet set = new DataSet();
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@date1", date1), new SqlParameter("@date2", date2)
                ,new SqlParameter("@fdep", fdep)
                ,new SqlParameter("@todep", todep)
                ,new SqlParameter("@id1", id1), new SqlParameter("@id2", id2)
            };
            //parameters[0].Value = date1;
            //parameters[1].Value = date2;
            return SQLHelper.RunProcedure("usp_st_TransationRec", parameters, "dd");
        }
        public List<StTransationRec> getDataSetByHouseDetailIDList(string date1, string date2, string fdep, string todep, string id1, string id2)
        {
            List<StTransationRec> list = new List<StTransationRec>();
            DataSet ds = new DataSet();
            SqlParameter[] parameters = new SqlParameter[] {
                new SqlParameter("@date1", date1), new SqlParameter("@date2", date2)
                ,new SqlParameter("@fdep", fdep)
                ,new SqlParameter("@todep", todep)
                ,new SqlParameter("@id1", id1), new SqlParameter("@id2", id2)
            };
            //parameters[0].Value = date1;
            //parameters[1].Value = date2;
            DataTable dt = SQLHelper.RunProcedure("usp_st_TransationRec", parameters, "dd").Tables["dd"];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow dr=dt.Rows[i];
                StTransationRec item = new StTransationRec();
                item.id = dr["id"].ToString();
                list.Add(item);
            }
            return list;
        }
    }
}

