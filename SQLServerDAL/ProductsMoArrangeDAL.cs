using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace Leyp.SQLServerDAL
{
    public class ProductsMoArrangeDAL
    {



        public DataTable getDataMoArrange(string now_date, string prd_dep, string prd_mo)
        {

            //mo_id = "102";
            bool is_val = false;
            SQLHelp sh = new SQLHelp();
            //string strfaca = "select top " + pagesize + " * from student where " + code + " id not in( select top " + frist + " id from student ) ";
            string strSql = "";
            strSql = "Select arrange_id,now_date, prd_dep, prd_mo, prd_item, mo_urgent, arrange_machine, arrange_date, arrange_seq, order_qty" +
                    ", order_date, req_f_date, req_qty, cpl_qty, arrange_qty, prd_cpl_qty, dep_rep_date,cust_o_date,dep_group " +
                    ",dgcf_pad.dbo.fn_getArrangeWorker(arrange_id) AS worker_gp " +
                    " From dgcf_pad.dbo.product_arrange Where arrange_seq>0 ";
            if (prd_dep != "" && prd_dep != null)
            {
                strSql += " And prd_dep='" + prd_dep + "'";
                is_val = true;
            }
            if (now_date != "" && now_date != null)
            {
                strSql += " And now_date='" + now_date + "'";
                is_val = true;
            }
            if (prd_mo != "" && prd_mo != null)
            {
                strSql += " And prd_mo='" + prd_mo + "'";
                is_val = true;
            }
            if (is_val == false)
                strSql += " And prd_dep=''";
            //strSql += " And arrange_id Not In(select top " + frist + " arrange_id from product_arrange )";
            strSql += " Order By prd_dep,arrange_seq,arrange_date";

            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            //if (dt.Rows.Count == 0)
            //dt.Rows.Add();
            return dt;

        }

        public DataTable queryProductStatus(string prd_date, string prd_dep, string prd_mo, string prd_machine, string prd_worker)
        {

            SqlParameter[] parameters = { new SqlParameter("@prd_date", prd_date)
                                        ,new SqlParameter("@prd_dep", prd_dep)
                                        ,new SqlParameter("@prd_mo", prd_mo)
                                        ,new SqlParameter("@prd_machine", prd_machine)
                                        ,new SqlParameter("@prd_worker", prd_worker)
                                        };

            DataTable dtPrd = SQLHelper.ExecuteProcedureRetrunDataTable("dgcf_pad.dbo.p_QueryProductStatus", parameters);
            return dtPrd;
        }
    }
}
