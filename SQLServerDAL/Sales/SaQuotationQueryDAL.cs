using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace Leyp.SQLServerDAL.Sales
{
    public class SaQuotationQueryDAL
    {

        private string within_code = "0000";
        private string remote_db = "dgerp2.cferp.dbo.";
        public DataTable getOcByMo(string mo_id)
        {
            string strSql;
            strSql = "select a.season,b.mo_id,b.goods_id,b.customer_goods AS cust_item,b.customer_color_id AS cust_color,b.customer_size AS cust_size" +
                ",b.add_remark,b.brand_id AS division,d.english_name AS mat_desc " +
                " From " + remote_db + "so_order_manage a" +
                " Inner Join " + remote_db + "so_order_details b On a.within_code=b.within_code AND a.id=b.id AND a.ver=b.ver" +
                " Inner Join " + remote_db + "it_goods c On b.within_code=c.within_code AND b.goods_id=c.id" +
                " Left Join " + remote_db + "cd_datum d On c.within_code=d.within_code AND c.datum=d.id" +
                " Where b.within_code='" + within_code + "' AND b.mo_id='" + mo_id + "'";
            DataTable dtOc = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtOc;
        }
        public DataTable getColor(int select_type, string select_val)
        {
            SqlParameter[] parameters = { new SqlParameter("@select_type", select_type)
                                        ,new SqlParameter("@queryStr", select_val)
            };
            DataTable dtColor = SQLHelper.ExecuteProcedureRetrunDataTable("usp_ColorGroupFind", parameters);
            return dtColor;
        }
        public DataTable getQuotation(string prd_item,string clr,string size)
        {
            SqlParameter[] parameters = { new SqlParameter("@prd_item", prd_item)
                                        ,new SqlParameter("@clr", clr)
                                        ,new SqlParameter("@size", size)
            };
            DataTable dtColor = SQLHelper.ExecuteProcedureRetrunDataTable("usp_quotation_query", parameters);
            return dtColor;
        }

    }
}
